# Walrus Operator - Used to assign the values inside the expressions

print(a := "Hello Python") # It assigns the value to the variable and returns the assigner value and it will be accessable in current namespace
print(a)

# Using with if - else
if(a:= int(input("Enter The Value : "))) >= 18:
    print("You can Drive")
else:
    print("No you can not drive")

# Using with loops
lst = [1,2,3,4,5]
while (length := len(lst)) > 0:
    print(lst.pop())