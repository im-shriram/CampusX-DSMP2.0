class Product:
    def __init__(self, title):
        self.title = title

    def __repr__(self):
        return f"<Product {self.title}>"