number = int(input('enter the number'))

digits = '0123456789'
result = ''
while number != 0:
  result = digits[number % 10] + result
  number = number // 10

print(result) # The time complexity -> O(log(n))


L = [1,2,3,4]

sum = 0
for i in L:
  sum = sum + i

product = 1
for i in L:
  product = product*i

print(sum,product) # The time complexity -> O(n) for both


A = [1,2,3,4] # Length - n
B = [5,6,7,8] # Length - m
for i in A:
  for j in B:
    print(i,j) # O(n^2)


A = [1,2,3,4]
B = [5,6,7,8]

for i in A:
  for j in B:
    for k in range(1000000):
      print(i,j) # O(n^2)


L = [1,2,3,4,5]

for i in range(0,len(L)//2):
  other = len(L) - i -1
  temp = L[i]
  L[i] = L[other]
  L[other] = temp

print(L) # O(n)


n = 10
k = 0;
for i in range(n//2,n):
  for j in range(2,n,pow(2,2)):
    print('j = ', j)
    k = k + n / 2; 

print(k) # O(n * log(n))


a = 10
b = 3

if b <= 0:
  print(-1)
div = a // b 

print(a-div-b) # O(1)

n = 345

sum = 0
while n>0:
  sum = sum + n%10
  n = n // 10

print(sum) # O(log10(n))

def fib(n):
  if n == 1 or n == 0:
    return 1
  else:
    return fib(n-1) + fib(n-2) # How the time complexity is measured here - Basically you have to count the number of function calls for a giver input - Here for each function call two sub function calls are executing from n to 0 (roughly) and for those 2 sub-calls next two sub-calls are running for each - TC - O(2 ^ n) - meaning for each fn calls how many sub fn calls are running.   
  
# How to imporve the fibonacchi recursion
def fib(n, d: dict):
  if n == 1 or n == 0:
    return 1
  if n in d:
    return d[n]
  else:
    val = fib(n-1) + fib(n-2)
    d[n] = val
    return val

print(fib(5))