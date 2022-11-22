""" This is an
example
of multiple
lines of comment
adding another line """

# Variables & Data Types
"""
a = -456788765
b = 4567.8765
c = "Mithran 123 !@#"
d = False

# print() => python standard function
print(a)
print(b)
print(c)
print(d)
print(a,b,c,d)
"""

# type casting - one data type can be converted to another data type.
# type() => python standard function
"""
a = float(100)
print(a, type(a))

a = int(4.5649999)
print(a, type(a))

a = str(100)        # a = "100"
print(a, type(a))

a = float("56765")
print(a, type(a))

a = bool(0)
print(a, type(a))
"""

# input() => python standard function
"""
print("Enter a number")
a = input()
x = int(a)
print("The value is", x, type(x))

print("Enter a number")
b = int(input())
print("The value is", b, type(b))

c = x + b
print("The total is", c, type(c))
"""

# Operators
# arithmetic operator
"""
print(10 + 10)
print(10 - 10)
print(10 * 10)
print(10 ** 3)  # exponent
print(10 / 3)
print(10 // 3)   #quotient
print(10 % 3)    #remainder
"""

# assignment operator
# while loop
"""
a = 10
print(a)     # 10

a += 5       # a = a + 5
print(a)     # a = 15

a *= 2       # a = a * 2
print(a)     # a = 30
"""

# comparision operator  -  returns True/False
# if else, while loop
"""
print(10 == 10)  # T
print(10 != 10)  # F
print(10 >= 10)  # T
print(10 > 10)   # F
print(10 <= 10)  # T
print(10 < 10)   # F
"""

# logical Operator

"""
and table:
T and T = T
T and F = F
F and T = F
F and F = F

or table:
T or T = T
T or F = T
F or T = T
F or F = F

not True = False
not False = True
"""

# example
"""
print(10 == 10 and 4 < 6)  # T and T = T
print(10 == 10 and 4 > 6)  # T and F = F
print(10 == 10 or 4 > 6)   # T or F  = T
print(not 10==10)          #   not T = F 
"""

# Collections
# List
"""
#    0    1    2   3  4   5   6 - indexes
a = [1,"HEllo",3,4.66,5,False,7,1,1,1,1] # allows duplicates
print(a, type(a))

print(a[1]) # ordered

a[1] = 9000 # changeable
print(a)
"""

# Tuple
"""
#    0    1    2   3  4   5   6 - indexes
a = (1,"HEllo",3,4.66,5,False,7,1,1,1,1) # allows duplicates
print(a, type(a))

print(a[1]) # ordered

a[1] = 9000 # unchangeable
"""

# Set
"""
a = {"a","a","a","b","b","c","c"} # no duplicates, unorderd, no index
print(a, type(a))
"""

# if else
# Syntax
"""
if <condition T/F>:     (Compulsary)
elif <condition T/F>:   (Optional)
else:                   (Optional)
"""

"""
a = 1007
if a>100:
    print(a, "is bigger than 100")
    print("code inside if condition")
elif a==100:
    print(a, "is equal to 100")
else:
    print(a, "is smaller than 100")
    print("Code inside else condition")

print("Hello world")
"""

# while loop - numbers
# syntax
"""
while <condition T/F>:
"""

"""
a = 50          # Initilization
while a<=100:   # Condition
    print(a)
    a = a + 5   # Incrementation
print("Loop over !")
"""


# for loop - str/list/tuple/set
# syntax
"""
for <variable> in <str/list/tuple/set>:
"""

# str - fetches char by char
"""
for x in "hello":
    print(x)
"""

# list - fetches item by item
"""
for x in ["hello",55.55,False,69]:
    print(x)
"""

# Python Standard Library
"""
import math
x = math.sqrt(24)
print(x)
"""

# Python Internet Library
"""
Mon - Fri
8am EC2 Start
10pm EC2 Stop
"""

"""
CloudWatch Event Bridge 0 8 * * 1-5 => AWS Lambda python boto3
CloudWatch Event Bridge 0 22 * * 1-5 => AWS Lambda python boto3
"""

# Python Internet Library
"""
import boto3
ec2 = boto3.resource('ec2')
ec2.create_instances(ImageId='ami-01216e7612243e0ef',MinCount=1,MaxCount=1,InstanceType='t2.micro',KeyName='Mithran-Key')
"""

























