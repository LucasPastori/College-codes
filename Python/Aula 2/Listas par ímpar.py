# -*- coding: utf-8 -*-
"""
Created on Mon Aug 17 16:56:02 2020

@author: Pastori
"""
Lista_impar = []
Lista_par = []
Lista = []
for i in range(20):
    Lista.append(int(input("insira o %d º número" % i)))
    if Lista[i]%2 == 0 :
        Lista_par.append(Lista[i])
    else:
        Lista_impar.append(Lista[i])

print(Lista)
print(Lista_par)
print(Lista_impar)