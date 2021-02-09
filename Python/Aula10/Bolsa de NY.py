# -*- coding: utf-8 -*-
"""
Created on Sat Nov 14 19:56:47 2020

@author: Pastori
"""
import matplotlib.pyplot as plt
import pandas as pd
   
medias = {2000:0, 2001:0, 2002:0, 2003:0, 2004:0, 2005:0, 2006:0, 2007:0, 2008:0, 2009:0, 2010:0}
Dados = pd.read_csv("SP500_prices_montly.csv")
price = Dados["Price"]
price = price[1548:1680]

x = 1548
soma = 0
ano = 2000
while x != 1680:
    for i in range(12):
        soma = soma + price[x]
        x +=1
    if i == 11:
        medias[ano] = soma/12
        ano +=1
        soma = 0
anos = medias.keys()
valores = medias.values()


plt.bar(range(len(medias)), list(valores), align='center')
plt.xticks(range(len(medias)), list(anos))
plt.title("Preço médio da bolsa NY 2000-2010")
plt.xlabel("Ano")
plt.ylabel("Preço")