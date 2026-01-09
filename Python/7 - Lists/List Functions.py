# Using the list() constructor to make a List
thislist = list(("apple", "banana", "cherry")) # note the double round-brackets
print(thislist)

# If you insert more items than you replace, the new items will be inserted where you specified, and the remaining items will move accordingly

thislist = ["apple", "banana", "cherry"]
thislist[0:100] = ["blackcurrant", "watermelon"] # Does not throw an error even if list index not in range
print(thislist)

# Here the value get inserted multiple times
thislist = ["apple", "banana", "cherry"]
thislist[1:3] = ["watermelon"]
print(thislist)

thislist = [1,2,3,4,5,6]
thislist[1:4] = [100, 200]
print(thislist)

# The entire specified range was replaced by the assigned values even though the elements were fewer compared to the range provided. The remaining elements were deleted.

# The insert() method inserts an item at the specified index
thislist = ["apple", "banana", "cherry"]
thislist.insert(2, "watermelon")
print(thislist)

# Using the append() method to append an item
thislist = ["apple", "banana", "cherry"]
thislist.append("orange")
print(thislist)

# To append elements from another list to the current list, use the extend() method
thislist = ["apple", "banana", "cherry"]
tropical = ["mango", "pineapple", "papaya"]
thislist.extend(tropical)
print(thislist)

# Add Any Iterable
thislist = ["apple", "banana", "cherry"]
thistuple = ("kiwi", "orange")
thislist.extend(thistuple) # Implicit type casting from tuple to list
print(thislist)

# The remove() method removes the specified item
thislist = ["apple", "banana", "cherry"]
thislist.remove("banana")
print(thislist)

# If there are more than one item with the specified value, the remove() method removes the first occurrence:

# Remove Specified Index
thislist = ["apple", "banana", "cherry"]
thislist.pop(1)
print(thislist)

# If you do not specify the index, the pop() method removes the last item.

thislist = ["apple", "banana", "cherry"]
thislist.clear()
print(thislist)

# List Comprehensions
fruits = ["apple", "banana", "cherry", "kiwi", "mango"]
newlist = [x if x != "banana" else "orange" for x in fruits if True] # The 1st block till for is a ternary operator not like a sequence of list comphrensions are changed
newlist

thislist = ["orange", "mango", "kiwi", "pineapple", "banana"]
thislist.sort()
print(thislist)

thislist = [100, 50, 65, 82, 23]
thislist.sort()
print(thislist)

thislist = ["orange", "mango", "kiwi", "pineapple", "banana"]
thislist.sort(reverse = True)
print(thislist)

# you can also customize your own function by using the keyword argument key = function.
def myfunc(n):
  return abs(n - 50)

thislist = [100, 50, 65, 82, 23]
thislist.sort(key = myfunc)
print(thislist)

# By default the sort() method is case sensitive, resulting in all capital letters being sorted before lower case letters
thislist = ["banana", "Orange", "Kiwi", "cherry"]
thislist.sort()
print(thislist)

# Copy Lists
thislist = ["apple", "banana", "cherry"]
mylist = thislist[:]
mylist[1] = "1234"
print(thislist)
print(mylist)

# another way
a, *arr = thislist
print(arr)

thislist.reverse() # Inplace Change
thislist