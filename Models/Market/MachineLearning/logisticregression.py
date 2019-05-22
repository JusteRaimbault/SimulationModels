
from sklearn.linear_model import LogisticRegression
import pandas

d = pandas.read_csv('data/training.csv')
dp = pandas.read_csv('data/predict.csv')
X = d[['density','resistance']]
y = d['burnt']


clf = LogisticRegression(random_state=0, solver='lbfgs').fit(X, y)

clf.predict(Xp,yp)

clf.score(Xp,yp)



