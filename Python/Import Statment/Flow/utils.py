print(">>> utils.py is being executed")

import config  # a dependency of utils

def greet(name):
    return f"Hello, {name}! DB={config.DB_URL}"

print(">>> utils.py finished executing")


"""
    Whenever you import a class, function or variable from other python files the entire file gets executed once and when you call a function, it actually get performed in that file executed space (since that function dependencies were mentioned in that python file) 
"""