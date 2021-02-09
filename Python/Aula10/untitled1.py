# -*- coding: utf-8 -*-
"""
Created on Sat Nov 14 17:36:25 2020

@author: Pastori
"""

import matplotlib.pyplot as plt
import pandas as pd
   
def data(data):
    data = data[1548:]
    return data

Dados = pd.read_csv("SP500_prices_montly.csv")

tempo = []
media = []
date = Dados["Date"].apply(data)
price = Dados["Price"]
print(date)


x = 0
soma = 0
while x != len(date):
    for y in range(12):
        soma = soma + price[x]
        x +=1
    if y == 11 :
        media.append(soma/12)    
        soma = 0
        
