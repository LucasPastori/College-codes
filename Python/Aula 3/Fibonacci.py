# -*- coding: utf-8 -*-
"""
Created on Mon Aug 24 18:07:20 2020

@author: Pastori
"""
aux=[]
Fibonacci=[]
y=0
z=1

aux.append(y)
Fibonacci.append(aux [:])
aux.append(z)
Fibonacci.append([y , z])

for i in range (3):
    if y <= z:
        x=y
        y=z
        z=y+x
    aux.append(z)
    Fibonacci.append(aux [:])
print(Fibonacci)
