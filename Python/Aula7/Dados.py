# -*- coding: utf-8 -*-
"""
Created on Sun Oct  4 18:28:51 2020

@author: Pastori
"""
from random import randrange

def lancamento ():
    y = 0
    for i in range(2):
        x = randrange(1,7)
        y = y + x
    return (y)

tabela = {2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0,10:0,11:0,12:0}

for i in range (1000):
    x = lancamento()
    tabela[x] += 1

for soma in tabela:
    tabela[soma] = round(((tabela[soma]/1000)*100) ,1 )

print("Ocorrências em porcentagem da soma de dois dados em mil lançamentos \n\n",tabela)