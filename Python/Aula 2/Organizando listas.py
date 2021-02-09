# -*- coding: utf-8 -*-
"""
Created on Mon Aug 17 18:32:58 2020

@author: Pastori
"""
num = 0
numeros = []
negativos = []
positivos = []
zeros = []
aux = 0

while True:
    aux = input("Insira um número inteiro: ")
    if aux == "" :
        break
    else:
        num = int(aux)
    if num < 0 :
        negativos.append(num)
    elif num == 0 :
        zeros.append(num)
    else :
        positivos.append(num)

numeros.extend(negativos)
numeros.extend(zeros)
numeros.extend(positivos)

print(numeros)
print(negativos)
print(zeros)
print(positivos)