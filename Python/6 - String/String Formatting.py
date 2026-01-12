# Using % operator - just like c language
print("Geeks : %d, Portal : %.2f" % (1000, 5.333)) # Its a formating so round off of numbers will not take place
print("Total students : %10d, Boys : %2d" % (240, 120)) # print integer value with `n` spaces from `%nd` - for `%10d` the formatting will be 7 spaces and 240 number
print("%o" % (25)) # print octal value
print("%E" % (356.08977)) # print exponential value

# format method
print("Hello {1:2.3f}, ok {0:3d}".format(134, 6.83274))
# {1:2.3f} -> 1: index in format function and 2.3f is formating pattern

# f-strings
a = 34
b = 5.9384
print(f"Hello {a:2d}, ok {b:.7f}")