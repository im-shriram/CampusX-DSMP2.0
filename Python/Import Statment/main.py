# This is possible because of the dependencis already mentioned in __init__.py
from models import User
from models import Product

"""
    If you do not mention required imports in __init__.py then the imports should specified like this
        from models.user import User
        from models.product import Product
"""

print(User("Alice"))
print(Product("Book"))