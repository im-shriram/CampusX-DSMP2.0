# Tuples
'''
A tuple in Python is similar to a list. The difference between the two is that we cannot change the elements of a tuple once it is assigned whereas we can change the elements of a list.

In short, a tuple is an immutable list. A tuple can not be changed in any way once it is created.
'''

# Characterstics
'''
- Ordered
- Unchangeble
- Allows duplicate
'''

### Creating Tuples

# empty
t1 = ()
print(t1)

# create a tuple with a single item
t2 = ('hello',)
print(t2)
print(type(t2))

# homo
t3 = (1,2,3,4)
print(t3)

# hetro
t4 = (1,2.5,True,[1,2,3])
print(t4)

# tuple
t5 = (1,2,3,(4,5))
print(t5)

# using type conversion
t6 = tuple('hello')
print(t6)

# Accessing Items
'''
- Indexing
- Slicing
'''
print(t3)
print(t3[0])
print(t3[-1])

t5[-1][0]

# Editing items

print(t3)
t3[0] = 100
# immutable just like strings

# Adding items are not possible
print(t3)

# Deleting items

print(t3)
del t3
print(t3)

t = (1,2,3,4,5)

t[-1:-4:-1]

print(t5)
del t5[-1]

# Operations on Tuples

# + and *
t1 = (1,2,3,4)
t2 = (5,6,7,8)

print(t1 + t2)

print(t1 * 3)

# membership
1 in t1
# iteration
for i in t1:
  print(i)

# Tuple Functions

# len/sum/min/max/sorted
t = (1,2,3,4)
len(t)
sum(t)
min(t)
max(t)

sorted(t, reverse=True)

# count

t = (1,2,3,4,5)

t.count(50)

# index
t.index(50)

# Difference between Lists and Tuples
'''
- Syntax
- Mutability
- Speed - immutable typed containers are faster than mutable
- Memory - immutable typed containers are less memory condumable than mutable
- Built in functionality
- Error prone - lists are hard to debug than tuple
- Usability - tuples are used when we require a security
'''

import time

L = list(range(100000000))
T = tuple(range(100000000))

start = time.time()
for i in L:
  i*5
print('List time',time.time()-start)

start = time.time()
for i in T:
  i*5
print('Tuple time',time.time()-start)

import sys

L = list(range(1000))
T = tuple(range(1000))

print('List size',sys.getsizeof(L))
print('Tuple size',sys.getsizeof(T))

a = [1,2,3]
b = a

a.append(4)
print(a)
print(b)

a = (1,2,3)
b = a

a = a + (4,)
print(a)
print(b)

# Special Syntax
# tuple unpacking
a,b,c = (1,2,3)
print(a,b,c)

a,b = (1,2,3) # Too many values to unpack
print(a,b)

a = 1
b = 2
a,b = b,a # Originated from tuple unpacking

print(a,b)

a,b,*others = (1,2,3,4)
print(a,b)
print(others)

# zipping tuples
a = (1,2,3,4)
b = (5,6,7,8)

tuple(zip(a,b))

# Sets
'''
A set is an unordered collection of items. Every set element is unique (no duplicates) and must be immutable (cannot be changed).

However, a set itself is mutable. We can add or remove items from it.

Sets can also be used to perform mathematical set operations like union, intersection, symmetric difference, etc.

Characterstics:
- Unordered
- Mutable
- No Duplicates
- Can't contain mutable data types
'''

# Creating Sets

s = {} # This is a dictonary and not a set

# empty
s = set()
print(s)
print(type(s))

# 1D and 2D
s1 = {1,2,3}
print(s1)

s2 = {1,2,3,{4,5}}
print(s2) # Throws an error

# Hetrogeneous set
s3 = {1,'hello',4.5,(1,2,3)}
print(s3)

# using type conversion
s4 = set([1,2,3])
print(s4)

# duplicates not allowed
s5 = {1,1,2,2,3,3}
print(s5)

# set can't have mutable items
s6 = {1,2,[3,4]}
print(s6)

# Comparison
s1 = {1,2,3}
s2 = {3,2,1}
print(s1 == s2) # True - sets are unordered so only the content inside the set matters

# Accessing Items - does not work for sets (both indexing and slicing)
s1 = {1,2,3,4}
s1[3] # Error
s1[0:3] # Error

# Editing Items
s1 = {1,2,3,4}
s1[0] = 100 # Error

# Adding Items

S = {1,2,3,4}
# add
S.add(5) # Add one item at a time
print(S)

# update # Add multiple items at a time
S.update([5,6,7])
print(S)

# Deleting Items

# del
s = {1,2,3,4,5}
print(s)

del s[0] # Error
print(s)

# discard - item wise deletion - does not throws an error if the element is not present in the set
s.discard(50)
print(s)

# remove - item wise deletion - throws an error if the element is not present in the set
s.remove(50)
print(s)

# pop - delete any item at random
s.pop()

# clear - removes all the items
s.clear()
print(s)

# Set Operation

s1 = {1,2,3,4,5}
s2 = {4,5,6,7,8}

# Union(|)
s1 | s2
# Intersection(&)
s1 & s2
# Difference(-)
s1 - s2
s2 - s1
# Symmetric Difference(^)
s1 ^ s2

# Membership Test
1 not in s1

# Iteration
for i in s1:
  print(i)

# Set Functions

# len/sum/min/max/sorted
s = {3,1,4,5,2,7}
len(s)
sum(s)
min(s)
max(s)
sorted(s,reverse=True)

# union/update
s1 = {1,2,3,4,5}
s2 = {4,5,6,7,8}

# s1 | s2
s1.union(s1)

s1.update(s2) # s1 will get updated
print(s1)
print(s2)

# intersection/intersection_update
s1 = {1,2,3,4,5}
s2 = {4,5,6,7,8}

s1.intersection(s2)

s1.intersection_update(s2)
print(s1)
print(s2)

# difference/difference_update
s1 = {1,2,3,4,5}
s2 = {4,5,6,7,8}

s1.difference(s2)

s1.difference_update(s2)
print(s1)
print(s2)

# symmetric_difference/symmetric_difference_update
s1 = {1,2,3,4,5}
s2 = {4,5,6,7,8}

s1.symmetric_difference(s2)

s1.symmetric_difference_update(s2)
print(s1)
print(s2)

# isdisjoint/issubset/issuperset
s1 = {1,2,3,4}
s2 = {7,8,5,6}

s1.isdisjoint(s2) # No any similar elements in both sets

s1 = {1,2,3,4,5}
s2 = {3,4,5}

s1.issuperset(s2)

# copy
s1 = {1,2,3}
s2 = s1.copy()

print(s1)
print(s2)

# Frozenset - Frozen set is just an immutable version of a Python set object

# create frozenset
fs1 = frozenset([1,2,3])
fs2 = frozenset([3,4,5])

fs1 | fs2 # update functions will not work on frozen sets

# what works and what does not
# works -> all read functions
# does't work -> write operations

# When to use - read only application

# 2D sets - possible
fs = frozenset([1,2,frozenset([3,4])])
fs

# Set Comprehension
{i**2 for i in range(1,11) if i>5}



# Dictionary - associative arrays
'''
Dictionary in Python is a collection of keys values, used to store data values like a map, which, unlike other data types which hold only a single value as an element.

In some languages it is known as map or assosiative arrays.

dict = { 'name' : 'nitish' , 'age' : 33 , 'gender' : 'male' }

Characterstics:

- Mutable
- Indexing has no meaning - values only assicable through keys
- keys can't be duplicated - duplicate keys are possible (The last occurance will be considered for each unique key)
- keys can't be mutable items
'''

# Create Dictionary

# empty dictionary
d = {}
print(d)

# 1D dictionary
d1 = { 'name' : 'nitish' ,'gender' : 'male' }
print(d1)

# with mixed keys
d2 = {(1,2,3):1,'hello':'world'}
print(d2)

# 2D dictionary -> JSON
s = {
    'name':'nitish',
     'college':'bit',
     'sem':4,
     'subjects':{
         'dsa':50,
         'maths':67,
         'english':34
     }
}
print(s)

# using sequence and dict function
d4 = dict([('name','nitish'),('age',32),(3,3)])
d4 = dict([['name','nitish'],['age',32],[3,3]]) # Both are possible
print(d4)

# duplicate keys
d5 = {'name':'nitish','name':'rahul'}
print(d5)

# mutable items as keys
d6 = {'name':'nitish', [1,2,3]: 2} # Error
print(d6)

# Accessing items
my_dict = {'name': 'Jack', 'age': 26}

# []
my_dict['age']
# get
my_dict.get('age')

s['subjects']['maths']

# Adding key-value pair

d4['gender'] = 'male'
print(d4)

d4['weight'] = 72
print(d4)

s['subjects']['ds'] = 75
print(s)

# Remove key-value pair

d = {'name': 'nitish', 'age': 32, 3: 3, 'gender': 'male', 'weight': 72}
# pop
d.pop(3) # Provide key
print(d)

# popitem
d.popitem() # Popping last element
d.popitem()
print(d)

# del
del d['name']
print(d)

# clear
d.clear()
print(d)

del s['subjects']['maths']
s

# Editing key-value pair

s['subjects']['dsa'] = 80
print(s)

# Dictionary Operations
'''
- Membership
- Iteration
'''

'name' in s # Default search in keys

d = {'name':'nitish','gender':'male','age':33}

for i in d:
  print(i,d[i])

# Dictionary Functions

# len/sorted
len(d)
print(d)
sorted(d,reverse=True) # Sorts the keys only and return ans into list
max(d)

# items/keys/values
print(d)

print(d.items())
print(d.keys())
print(d.values())

# update
d1 = {1:2,3:4,4:5}
d2 = {4:7,6:8}

d1.update(d2) # The keys which are present in d1 the values of those keys will be updated by values of d2
print(d1)

# Dictionary Comprehension

# print 1st 10 numbers and their squares
{i:i**2 for i in range(1,11)}

distances = {'delhi':1000,'mumbai':2000,'bangalore':3000}
print(distances.items())

# using existing dict
distances = {'delhi':1000,'mumbai':2000,'bangalore':3000}
{key:value*0.62 for (key,value) in distances.items()}

# using zip
days = ["Sunday", "Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
temp_C = [30.5,32.6,31.8,33.4,29.8,30.2,29.9]

{i:j for (i,j) in zip(days,temp_C)}

# using if condition
products = {'phone':10,'laptop':0,'charger':32,'tablet':0}

{key:value for (key,value) in products.items() if value>0}

# Nested Comprehension
# print tables of number from 2 to 4
{i:{j:i*j for j in range(1,11)} for i in range(2,5)}

{
    2:{1:2,2:4,3:6,4:8},
    3:{1:3,2:6,3:9,4:12},
    4:{1:4,2:8,3:12,4:16}
}