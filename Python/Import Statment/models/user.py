class User:
    def __init__(self, name):
        self.name = name

    def __repr__(self):
        return f"<User {self.name}>"