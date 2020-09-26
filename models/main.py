from extract_rules_Dtree import getPaths
from extract_rules_matrix import make_file
from get_data import citire_date, df_cols
from train import decision_tree, SVM, neural_network
from sklearn.tree import _tree

df, results = citire_date()

clf = decision_tree(df, results)
getPaths(df, clf, "../src/asl/agent1.asl")

test_score, nn_model, x_train = neural_network(df, results, (18, 3), random_state=50)
make_file(test_score, df, x_train, nn_model, "../src/asl/agent3.asl")

test_score, svm_model, x_train = SVM(df, results)
make_file(test_score, df, x_train, svm_model, "../src/asl/agent2.asl")
