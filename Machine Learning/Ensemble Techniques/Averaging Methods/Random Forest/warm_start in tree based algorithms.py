from sklearn.datasets import make_moons
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier

def retrain(model: RandomForestClassifier, X_train, y_train):
    '''
        You explcitely need to increase the values of n_estimators, if not then it does noting.
        Visit `Theory.ipynb` for more details
    '''
    model.n_estimators = 5

    model.fit(X_train, y_train) # Retraining
    print(model.n_estimators)

def train(model: RandomForestClassifier, X_train, y_train):
    model.fit(X_train, y_train)
    print(model.n_estimators)

def main():
    X, y = make_moons(
        n_samples=500,
        noise=0.3,
        random_state=42
    
    )
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    model = RandomForestClassifier(n_estimators=2, warm_start=True)

    train(model, X_train, y_train)
    retrain(model, X_train, y_train)

if __name__ == "__main__":
    main()