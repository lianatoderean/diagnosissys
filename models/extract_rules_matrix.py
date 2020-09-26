import math

from rulematrix.surrogate import rule_surrogate
from sklearn.model_selection import train_test_split

from get_data import df_cols
from train import neural_network


def train_surrogate(model, is_continuous, is_categorical, is_integer, x_train, sampling_rate=2.0, **kwargs):
    surrogate = rule_surrogate(model.predict, x_train, sampling_rate=sampling_rate,
                               is_continuous=is_continuous,
                               is_categorical=is_categorical,
                               is_integer=is_integer,
                               rlargs={'feature_names': df_cols, 'verbose': 18},
                               **kwargs)

    train_fidelity = surrogate.score(x_train)
    return surrogate


def make_file(test_score, df, x_train, model, file_name):
    train, test = train_test_split(df, test_size=0.4, random_state=43)
    x_test = test.iloc[:, 0:17]
    y_test = test.iloc[:, 18]

    is_continuous = df.get('is_continuous', None)
    is_categorical = df.get('is_categorical', None)
    is_integer = df.get('is_integer', None)
    target_names = df.get('target_names', None)
    surrogate = train_surrogate(model, is_continuous, is_categorical, is_integer, x_train, 3, seed=44)

    rl = surrogate.student
    categories = rl.category_names
    features = rl.feature_names
    rule_list = rl._rule_list
    aslf = open(file_name, "w")

    aslf.write("score({:.2f}).\n".format(test_score))
    aslf.write("!learnRules.\n")
    aslf.write("+diagnose\n    ")
    aslf.write("<-.print(\"Received diagnose command\");\n")
    aslf.write("   .send(agentMaster, tell, myScore({:.2f}));\n".format(test_score))
    count = 0
    write = True
    rules1=[]
    diagnosis=[]
    for rule in rl._rule_list:
        rule1=[]
        paramList = []
        paramListUpp = []
        for feature_idx, c in rule.clauses:
            paramList.append(features[feature_idx].lower())
            paramListUpp.append(features[feature_idx])
        if not paramList:
            write = False
        if write:
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
            aslf.write("], " + str(count) + " ): ")
            aslf.write("\n    true")

            for feature_idx, category in rule.clauses:

                _category_names = categories[feature_idx]
                feature = features[feature_idx]
                _interval = _category_names[category]
                _minf = "-inf"
                _inf = "inf"
                if (_interval[0] == -math.inf):
                    aslf.write("\n  & {}<=({:.2f})".format(feature, _interval[1]))
                    clause1 = [feature, -1000, _interval[1]]

                else:
                    if (_interval[1] == math.inf):
                        aslf.write("\n  & {}>=({:.2f})".format(feature, _interval[0]))
                        clause1 = [feature, _interval[0], 1000]

                    else:
                        aslf.write("\n  & {}>({:.2f}) & {}<({:.2f}) \n".format(feature, _interval[0], feature, _interval[1]))
                        clause1 = [feature, _interval[0], _interval[1]]
                rule1.append(clause1)
            aslf.write("\n   <- ")

            prob_dmlv = rule.output[2]
            prob_normal = rule.output[0]
            prob_rd = rule.output[1]
            prob_dmlv = (prob_dmlv * 100)
            prob_rd = (prob_rd * 100)
            prob_normal = (prob_normal * 100)

            if prob_dmlv > prob_normal and prob_dmlv > prob_rd:
                aslf.write("\n    .send(agentMaster, tell, newDiagnosis(2, {:.2f}, [\n".format(prob_dmlv))
                diagnosis.append(2)
            else:
                if prob_rd > prob_normal:
                    aslf.write(
                        "\n   .send(agentMaster, tell, newDiagnosis(1, {:.2f}, [\n".format(prob_rd))
                    diagnosis.append(1)
                else:
                    aslf.write(
                        "\n    .send(agentMaster, tell, newDiagnosis(0, {:.2f}, [\n".format(prob_normal))
                    diagnosis.append(0)

            first = True
            for clause in rule1:
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
            aslf.write("], " + str(count) + ")")
            aslf.write("\n  <-\n")
            count = count + 1
        else:
            prob_dmlv = rule.output[2]
            prob_normal = rule.output[0]
            prob_rd = rule.output[1]
            if prob_dmlv > prob_normal and prob_dmlv > prob_rd:
                aslf.write("\n    .send(agentMaster, tell, newDiagnosis(2, {:.2f}, [])).\n".format(prob_dmlv))
            else:
                if prob_rd > prob_normal:
                    aslf.write(
                        "\n   .send(agentMaster, tell, newDiagnosis(1, {:.2f}, [])).\n".format(prob_rd))
                else:
                    aslf.write(
                        "\n    .send(agentMaster, tell, newDiagnosis(0, {:.2f}), [])).\n".format(prob_normal))
        if rule1:
            rules1.append(rule1)

    aslf.write("+!learnRules    <- ")

    aslf.write("+rules([ \n")
    first1 = True
    for rule in rules1:
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
    aslf.write("\n+diagnoses({})".format(diagnosis))
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
