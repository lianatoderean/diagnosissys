import pandas as pd
import sklearn
from sklearn.model_selection import train_test_split
from sklearn.neural_network import MLPClassifier
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import KBinsDiscretizer, OneHotEncoder, StandardScaler

from get_data import df_cols


def decision_tree(df, results):
    df.dropna().values.all()
    train, test = train_test_split(df, test_size=0.4, random_state=43)

    if df.isna().values.any():
        print("x_df has nan")

    x_test = test.iloc[:, 0:17]
    test_values = open("test_val_dtree_svm.txt", "w")
    for i in x_test.values:
        idx = 0
        for j in i:
            test_values.write(df_cols[idx] + " " + str(j) + " ")
            idx = idx + 1
        test_values.write("\n")
    test_values.close()

    clf = sklearn.tree.DecisionTreeClassifier(random_state=0)
    clf.fit(train.iloc[:, 0:17], train.iloc[:, 18])
    print("decision tree score: ", clf.score(test.iloc[:, 0:17], test.iloc[:, 18]))
    return clf


def neural_network(df, results, neurons, **kwargs):
    df = df.sample(frac=0.7).reset_index(drop=True)

    train, test = train_test_split(df, test_size=0.4, random_state=43)
    x_train = train.iloc[:, 0:17]
    y_train = train.iloc[:, 18]
    x_test = test.iloc[:, 0:17]
    y_test = test.iloc[:, 18]
    scaler = StandardScaler()
    scaler.fit(x_train)
    x_train = scaler.transform(x_train)
    x_test = scaler.transform(x_test)
    test_values = open("scaled_test_val_nn.txt", "w")
    k = 0
    for i in x_train:

        idx = 0
        k=k+1
        for j in i:
            test_values.write(df_cols[idx] + " " + str(j) + " ")
            idx = idx + 1
        test_values.write(str(results[k]) + "\n")
    test_values.close()

    is_categorical = df.get('is_categorical', None)
    model = MLPClassifier(hidden_layer_sizes=neurons, alpha=1e-5, solver='lbfgs', max_iter=500, warm_start=True,
                          **kwargs)
    if is_categorical is not None:
        model = Pipeline([
            ('one_hot', OneHotEncoder()),
            ('mlp', model)
        ])
    model.fit(x_train, y_train)
    y_pred = model.predict(x_test)
    train_score = model.score(x_train, y_train)
    test_score = model.score(x_test, y_test)
    print("NN score: ", test_score)
    return test_score, model, x_train


def SVM(rows, results):
    df = pd.DataFrame(rows, columns=df_cols)
    df_normalized = sklearn.preprocessing.normalize(df, norm='l2')

    est = KBinsDiscretizer(n_bins=3, encode='ordinal', strategy='uniform')
    df_dis = est.fit_transform(df_normalized)
    train, test = train_test_split(df, test_size=0.4, random_state=43)
    x_train = train.iloc[:, 0:17]
    y_train = train.iloc[:, 18]
    x_test = test.iloc[:, 0:17]
    y_test = test.iloc[:, 18]
    clf = sklearn.svm.LinearSVC(random_state=7, tol=1e-5)
    clf.fit(x_train, y_train)
    rbf_svc = sklearn.svm.SVC(gamma='scale', kernel='linear')
    rbf_svc.fit(x_train, y_train)
    rasp = rbf_svc.predict(x_test)
    print("SVM score: ", clf.score(x_test, y_test))
    test_score = clf.score(x_test, y_test)
    return test_score, clf, x_train
