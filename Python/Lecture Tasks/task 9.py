# `Problem-1:` Class inheritence
"""
Create a **Bus** child class that inherits from the Vehicle class. The default fare charge of any vehicle is seating capacity * 100. If Vehicle is Bus instance, we need to add an extra 10% on full fare as a maintenance charge. So total fare for bus instance will become the final amount = total fare + 10% of the total fare.

Note: The bus seating capacity is 50. so the final fare amount should be 5500. You need to override the fare() method of a Vehicle class in Bus class.
"""
class Vehicle:

    def __init__(self,type,capacity):
        self.type = type
        self.capacity = capacity

    def fare(self):
        return 100*self.capacity

class Bus(Vehicle):

    def fare(self):
        base_fare = super().fare()
        bus_fare = base_fare + 0.1*base_fare
        return bus_fare

bus = Bus('school bus',50)
print(bus.fare())

# `Problem-3:` 
"""
Write a program that has a class Point. Define another class Location which has two objects (Location & Destination) of class Point. Also define a function in Location that prints the reflection of Destination on the x axis.
"""
class Point:

    def __init__(self,x,y):
        self.x = x
        self.y = y

    def show_point(self):
        return '{},{}'.format(self.x,self.y)
class Location:

    def __init__(self,x1,y1,x2,y2):
        self.source = Point(x1,y1)
        self.destination = Point(x2,y2)

    def show(self):
        print('source is',self.source.show_point())
        print('destination is',self.destination.show_point())

    def reflection(self):
        self.destination.y = -self.destination.y
        print('Relection is',self.destination.show_point())

L = Location(0,0,1,1)
L.show()
L.reflection()

# `Problem-4:` Write a program that has an abstract class Polygon. Derive two classes Rectangle and Triamgle from Polygon and write methods to get the details of their dimensions and hence calculate the area."""
from abc import ABC, abstractmethod

class Polygon(ABC):
    @abstractmethod
    def area(self):
        pass

class Rectangle(Polygon):
    def __init__(self, length, bredth):
        self.length = length
        self.bredth = bredth
    
    def area(self):
        return self.length * self.bredth

class Triangle(Polygon):
    def __init__(self, side_1, side_2, side_3):
        self.s1 = side_1
        self.s2 = side_2
        self.s3 = side_3
    
    def area(self):
        import math
        s = math.sqrt((self.s1 ** 2) + (self.s2 ** 2) + (self.s3 ** 2))
        area = math.sqrt(s * (s - self.s1) * (s - self.s2) * (s - self.s3))
        return area

r = Rectangle(12, 13)
print(r.area())

t = Triangle(12, 13, 14)
print(t.area())

# `Problem-5:` 
""" 
Write a program with class Bill. The users have the option to pay the bill either by cheque or by cash. Use the inheritance to model this situation.
"""
# Write code here
class Bill:

  def __init__(self,items,price):
    self.total = 0
    self.items = items
    self.price = price

    for i in self.price:
      self.total = self.total + i

  def display(self):
    print('Item \t\t\t Price')
    for i in range(len(self.items)):
      print(self.items[i],'\t',self.price[i])
    print("*"*10)

    print("Total",self.total)

class CashPayment(Bill):

  def __init__(self,items,price,deno,value):
    super().__init__(items,price)

    self.deno = deno
    self.value = value

  def show_cash_payment(self):
    super().display()
    for i in range(len(self.deno)):
      print(self.deno[i],"*",self.value[i],"=",self.deno[i]*self.value[i])

class ChequePayment(Bill):

  def __init__(self,items,price,cno,name):
    super().__init__(items,price)

    self.cno = cno
    self.name = name

  def show_cheque_payment(self):
    super().display()
    print('Cheque no',self.cno)
    print('Bank name',self.name)

items = ["External Hard Disk", "RAM", "Printer", "Pen Drive"]
price = [5000, 2000, 6000, 800]

deno = [10, 20, 50, 100, 500, 2000]
value = [1, 1, 1, 20, 4, 5]
cash = CashPayment(items, price, deno, value)
cash.show_cash_payment()

# `Q-6:` FlexibleDict
"""
As of now we are accessing values from dictionary with exact keys. Now we want to amend accessing values functionality. if a dict have key `1` (int) the even if we try to access values by giving `'1'` (1 as str) as key, we should get the same result and vice versa.

Write a class `FlexibleDict` upon builtin `dict` class with above required functionality.

Hint- `dict[key] => dict.__getitem__(key)`

Ex.
```
fd = FlexibleDict()
fd['a'] = 100
print(fd['a']) # Like regular dict

fd[5] = 500
print(fd[5]) # Like regular dict

fd[1] = 100
print(fd['1']) # actual Key is int but still trying to access through str key.
fd['1'] = 100
print(fd[1])

```
`Output:`
```
100
500
100
100

```
"""
class FlexibleDict(dict):
    def __getitem__(self, key):
        if isinstance(key, str) and key.isdigit():
            key = int(key)
        elif isinstance(key, int):
            key = str(key) if str(key) in self else key
        return super().__getitem__(key)

fd = FlexibleDict()
fd['a'] = 100
print(fd['a'])  # Like regular dict

fd[5] = 500
print(fd[5])  # Like regular dict

fd[1] = 100
print(fd['1'])  # actual Key is int but still trying to access through str key.
fd['1'] = 100
print(fd[1])