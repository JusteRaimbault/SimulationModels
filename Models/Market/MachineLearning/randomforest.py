import pandas
from sklearn import tree
#from sklearn.tree.export import export_text

d = pandas.read_csv('data/training.csv')

X = d[['density','resistance']]
y = d['binaryburnt']

decision_tree = tree.DecisionTreeClassifier(random_state=0, max_depth=2)
fit = decision_tree.fit(X, y)

print(tree.export.export_graphviz(fit,out_file='data/res_tree.svg'))

#tree.plot_tree(fit)
#r = export_text(decision_tree)

