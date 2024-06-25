#!/usr/bin/env sage

import sys
from sage.all import *

def trapezoid_rule(f, a, b, N):
    delta_x = (b-a)/N
    chunks = []
    for i in range(N):
        x0 = a + i*delta_x
        x1 = a + (i+1)*delta_x
        chunks.append((1/2) * delta_x * (f(x0) + f(x1)))
    return sum(chunks)

def simpsons_rule(f, a, b, N):
    if N%2 != 0:
        raise ValueError('N needs to be even')
    delta_x = (b-a)/N
    chunks = []
    for i in range(0, N, 2): # increment by 2 to run interpolation on each pair of delta x's
        x0 = a+i*delta_x
        x1 = a + (i+1)*delta_x
        x2 = a + (i+2)*delta_x
        chunks.append((1/3)*delta_x*(f(x0)+4*f(x1)+f(x0)))
    return sum(chunks)

f(x)=(e^sin(x)) # function to integrate
R = RealField(25) # specifies accuracy
N=200
a = 0
b = pi

T = trapezoid_rule(f,a,b,N)
S = simpsons_rule(f,a,b,N)

print("trapezoid_rule: " + str(R(T)))
print("simpsons_rule: " + str(R(S)))
