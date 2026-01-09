if __name__ == "__main__":
    # Define example strings
    s = "hello world"
    s2 = "HELLO World"
    s3 = "   python programming   "
    s4 = "hello world, hello universe"
    s5 = "hello world"

    # 1. capitalize() - Only the first letter will get capitalized, rest become small
    print("1. capitalize():", s.capitalize())

    # 2. casefold() - everything becomes small
    print("2. casefold():", s2.casefold())

    # 3. center(width, fillchar)
    print("3. center(20, '*'):", s.center(20, '*'))

    # 4. count(substring, begin, end)
    print("4. count('hello'):", s4.count('hello'))
    print("4. count('hello', 0, 12):", s4.count('hello', 0, 12))

    # 5. decode(encoding='UTF8', errors='strict')
    # Note: decode() is used with byte objects. Example:
    b = b'hello'
    print("5. decode('utf-8'):", b.decode('utf-8'))

    # 6. encode()
    print("6. encode():", s.encode('utf-8'))

    # 7. endswith(suffix, begin, end)
    print("7. endswith('world'):", s.endswith('world'))
    print("7. endswith('world', 0, 10):", s.endswith('world', 0, 10))

    # 8. expandtabs(tabsize=8)
    s6 = "hello\tworld"
    print("8. expandtabs(4):", s6.expandtabs(4))

    # 9. find(substring, beginIndex, endIndex)
    print("9. find('world'):", s.find('world'))
    print("9. find('world', 0, 10):", s.find('world', 0, 10))

    # 10. format(value)
    print("10. format('Python {}!').format('rocks'):", "Python {}!".format('rocks'))

    # 11. index(substring, beginIndex, endIndex)
    print("11. index('world'):", s.index('world'))
    # print("11. index('universe'):", s.index('universe'))  # Uncomment to see exception

    # 12. isalnum()
    print("12. isalnum():", s.isalnum())  # False (contains space)

    # 13. isalpha()
    print("13. isalpha():", s.replace(' ', '').isalpha())  # True (spaces are removed)

    # 14. isdecimal()
    print("14. isdecimal():", '12345'.isdecimal())  # True

    # 15. isdigit()
    print("15. isdigit():", '12345'.isdigit())  # True

    # 16. isidentifier()
    print("16. isidentifier():", 'my_variable'.isidentifier())  # True

    # 17. islower()
    print("17. islower():", s.islower())  # False

    # 18. isnumeric()
    print("18. isnumeric():", '12345'.isnumeric())  # True

    # 19. isprintable()
    print("19. isprintable():", s.isprintable())  # True

    # 20. isupper()
    print("20. isupper():", s.isupper())  # False

    # 21. isspace()
    print("21. isspace():", '   '.isspace())  # True

    # 22. istitle()
    print("22. istitle():", s.istitle())  # False

    # 23. join(seq)
    print("23. join(['a', 'b', 'c']):", ', '.join(['a', 'b', 'c']))

    # 24. len(string)
    print("24. len(s):", len(s))

    # 25. ljust(width, fillchar)
    print("25. ljust(20, '*'):", s.ljust(20, '*'))

    # 26. lower()
    print("26. lower():", s2.lower())

    # 27. lstrip()
    print("27. lstrip():", s3.lstrip())

    # 28. partition(sep)
    print("28. partition('world'):", s.partition('world'))
    # Difference between split and partitin -> split returns list, partition returns tuple

    # 29. maketrans()
    trans_table = str.maketrans('aeiou', '12345')
    print("29. translate using maketrans:", s.translate(trans_table))

    # 30. replace(old, new, count)
    print("30. replace('hello', 'hi'):", s.replace('hello', 'hi'))

    # 31. rfind(substring, beg, end)
    print("31. rfind('hello'):", s4.rfind('hello'))

    # 32. rindex(substring, beg, end)
    print("32. rindex('hello'):", s4.rindex('hello'))

    # 33. rjust(width, fillchar)
    print("33. rjust(20, '*'):", s.rjust(20, '*'))

    # 34. rstrip()
    print("34. rstrip():", s3.rstrip())

    # 35. rsplit(sep, maxsplit)
    print("35. rsplit(', ', 1):", s4.rsplit(', ', 1))

    # 36. split(str, num)
    print("36. split(', '):", s4.split(', '))

    # 37. splitlines(num)
    s7 = "line1\nline2\nline3"
    print("37. splitlines():", s7.splitlines())

    # 38. startswith(str, beg, end)
    print("38. startswith('hello'):", s.startswith('hello'))

    # 39. strip(chars)
    print("39. strip():", s3.strip())

    # 40. swapcase()
    print("40. swapcase():", s2.swapcase())

    # 41. title()
    print("41. title():", s.title())

    # 42. translate(table, deletechars)
    print("42. translate(table, deletechars):", s.translate(trans_table))

    # 43. upper()
    print("43. upper():", s.upper())

    # 44. zfill(width)
    print("44. zfill(10):", '42'.zfill(10))

    # 45. rpartition(sep)
    print("45. rpartition('world'):", s.rpartition('world'))