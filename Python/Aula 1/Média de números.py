# -*- coding: utf-8 -*-
"""
Created on Mon Aug 10 17:49:20 2020

@author: Pastori
"""
num = 1
soma = 0
quant = 0
while num != 0 :
    num = int(input("Digite um número"))
    soma = soma + num
    if num != 0 :
        quant = quant + 1

media = soma/quant
print("Foram digitados %d números" % quant)
print("A soma é de %d " % soma)
print("A média é de %d " % media)