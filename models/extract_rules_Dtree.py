from sklearn.model_selection import train_test_split
from sklearn.tree import _tree
from get_data import df_cols

count = 0
rules = []
diags = []


def getPaths(df, tree, file):
    train, test = train_test_split(df, test_size=0.4, random_state=43)
    feature_names = df_cols
    aslf = open(file, "w")
    tree_ = tree.tree_
    feature_name = [
        feature_names[i] if i != _tree.TREE_UNDEFINED else "undefined!"
        for i in tree_.feature
    ]
    score = tree.score(test.iloc[:, 0:17], test.iloc[:, 18])
    aslf.write("score({:.2f}).\n".format(score))
    aslf.write("!learnRules.\n")
    aslf.write("+diagnose\n    ")
    aslf.write("<-.print(\"Received diagnose command\");\n")
    aslf.write("   .send(agentMaster, tell, myScore({:.2f}));\n".format(score))

    def goPath(node, path):
        global diags
        global count
        global rules
        if tree_.feature[node] != _tree.TREE_UNDEFINED:
            name = feature_name[node]
            threshold = tree_.threshold[node]
            goPath(tree_.children_left[node], path + [(name, threshold, 0)])  # 0 => less or equal
            goPath(tree_.children_right[node], path + [(name, threshold, 1)])  # 1 => more
        else:
            paramList = []
            paramListUpp = []
            for cond in path:
                name = cond[0]
                exist = False
                for param in paramList:
                    if param == name.lower():
                        exist = True
                if not exist:
                    paramList.append(name.lower())
                    paramListUpp.append(name)
            aslf.write("      .send(agentMaster, tell, needs([")
            first = True
            for param in paramList:
                if not first:
                    aslf.write(", ")
                else:
                    first = False
                aslf.write(param)
            aslf.write("], ")
            aslf.write(str(count))
            aslf.write(")).")

            aslf.write("\n+diagnose([")
            first = True
            for param in paramListUpp:
                if not first:
                    aslf.write(", ")
                else:
                    first = False
                aslf.write(param)
            aslf.write("]," + str(count) + " ): ")
            aslf.write("\n    true")

            for cond in path:
                if (cond[2] == 0):

                    aslf.write("\n  & {}<={:.2f}".format(cond[0], cond[1]))

                else:

                    aslf.write("\n  & {}>{:.2f}".format(cond[0], cond[1]))

            prob_dmlv = tree_.value[node][0][2]
            prob_normal = tree_.value[node][0][0]
            prob_rd = tree_.value[node][0][1]
            sum = prob_dmlv + prob_normal + prob_rd
            prob_dmlv = (prob_dmlv * 100) / sum
            prob_rd = (prob_rd * 100) / sum
            prob_normal = (prob_normal * 100) / sum

            aslf.write("\n   <- ")
            rule = []
            for cond in path:
                if (cond[2] == 0):
                    clause = (cond[0], (-1000), cond[1])
                else:
                    clause = [cond[0], cond[1], 1000]
                rule.append(clause)

            if prob_dmlv > prob_normal and prob_dmlv > prob_rd:
                aslf.write("\n    .send(agentMaster, tell, newDiagnosis(2, {:.2f}, [\n".format(prob_dmlv))
                diags.append(2)
            else:
                if prob_rd > prob_normal:
                    aslf.write(
                        "\n    .send(agentMaster, tell, newDiagnosis(1, {:.2f}, [\n".format(prob_rd))
                    diags.append(1)
                else:
                    aslf.write(
                        "\n    .send(agentMaster, tell, newDiagnosis(0, {:.2f}, [ \n".format(prob_normal))
                    diags.append(0)
            if rule:
                rules.append(rule)

            first = True
            for clause in rule:
                if not first:
                    aslf.write(", ")
                else:
                    first = False
                n = clause[0].lower()
                min = clause[1]
                max = clause[2]
                aslf.write("[{}, {:.2f}, {:.2f}]".format(n, min, max))

            aslf.write("])).\n")

            aslf.write("\n+diagnose([")
            first = True
            for param in paramListUpp:
                if not first:
                    aslf.write(", ")
                else:
                    first = False
                aslf.write(param)
            aslf.write("]," + str(count) + ")")
            aslf.write("\n  <-\n")
            count = count + 1

    goPath(0, [])
    aslf.write("    .print(\"Not enough data\"). \n");
    aslf.write("+!learnRules    <- ")

    aslf.write("+rules([ \n")
    first1 = True
    for rule in rules:
        if not first1:
            aslf.write(", ")
        else:
            first1 = False
        aslf.write("[")
        first2 = True
        for clause in rule:
            if not first2:

                aslf.write(", ")
            else:
                first2 = False
            n = clause[0].lower()
            min = clause[1]
            max = clause[2]

            aslf.write("[{}, {:.2f}, {:.2f}]".format(n, min, max))
        aslf.write("]\n")

    aslf.write("]); ")
    aslf.write("\n+diagnoses({})".format(diags))
    aslf.write(".")

    aslf.write("\n+convince(DiagP, DiagC, ArgsC, NamesP, ValuesP):\n   rules(X) & diagnoses(Y) &\n ")
    aslf.write(
        "    myLib.checkArguments(X, Y, DiagP, DiagC, ArgsC, NamesP, ValuesP, 0, NewDiag, ProListP, ContraListC)\n")
    aslf.write("    <- \n ")
    aslf.write("    .send(agentMaster, tell,  notChangedDiagnosis(ProListP, ContraListC, DiagP)).")

    aslf.write("\n+convince(DiagP, DiagC, ArgsC, NamesP, ValuesP):\n rules(X) & diagnoses(Y) &\n ")
    aslf.write(
        "    myLib.checkArguments(X, Y, DiagP, DiagC, ArgsC, NamesP, ValuesP, 1, NewDiag, ContraListP, ProListC)\n")
    aslf.write("    <- \n ")
    aslf.write("    .send(agentMaster, tell, changedDiagnosis(ContraListP, ProListC, DiagC));.")

    aslf.close()
