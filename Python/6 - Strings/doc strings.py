def sum(a, b):
    '''Function takes two values and return the sum of these values'''
    return a + b

print(sum(1,2))
print(sum.__doc__)

sum.__doc__ = '''ok i got this'''
print(sum.__doc__) # you can even update docString