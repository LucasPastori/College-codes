# -*- coding: utf-8 -*-
"""
Created on Mon Aug 10 18:08:39 2020

@author: Pastori
"""

from random import randrange 
numero = 0
maior = 0
quant = 0
for x in range (100):
    numero = randrange(1,100)
    if x > 0:
        if numero > maior:
             maior = numero
             quant = quant + 1      
    else :
        maior = numero    

print("O maoir número gerado foi %d e foi atualizado %d vezes" % (maior,quant))
    