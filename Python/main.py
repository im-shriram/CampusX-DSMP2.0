# Error or not
l = [1,2,3,4,5]
for i in l:
    print(i)
    l.pop()

def man():
    return ("""
    1. Add a new student
    2. Search for a student
    3. Display all students
    4. Exit
    """)
d = {
    man: 78, # Since, man (function) is immutable
    32: 90,
}
print(d[man])

print(10 and 20)

a = [5,4,3,2,1]
a.sort(key=lambda x: x % 5)
print(a)

thislist = ["apple", "banana", "cherry"]
mylist = thislist[:]
mylist[1] = "1234"
print(thislist)
print(mylist)

# Interview Question
def add_element(element, lst: list = []):
    lst.append(element)
    return lst

print(add_element(1))
print(add_element(2))


# Interview Question
def add_element(element, lst: list = [], a = 10):
    print(id(a))
    lst.append(element)
    return lst

print(add_element(1))
print(add_element(2))