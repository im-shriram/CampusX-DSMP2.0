# using format method
name = "Dexter"
country = "India"
str = "My name is {} and I am from {}"
print(str.format(name, country))
"""
    name refered as [0th] index
    country referred as [1st] index
"""
str = "My name is {1} and I am from {0}" #indexing
print(str.format(country, name))

# using f_strings method
print(f"My name is {name} and I am from {country}")

# Floation point precision -> If you want to round up a number in required floating point precision

a = round(1.7342734687162374)
print(a) # It directly gives 2

a = (f"{1.29348203493:.5}")
print(type(a), ' ', a)
a = float(a)

# Another way - OP
a = ('{0:.4}'.format(231.734628743)) # First value represents total number after decimal point and second value represents the total number of digits.
print(a)