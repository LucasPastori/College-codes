# -*- coding: utf-8 -*-
"""
Created on Sun Nov 15 18:27:33 2020

@author: Pastori
"""

import matplotlib.pyplot as plt
import pandas as pd

Datas=[]
Ouro_lista=[]
NY_lista=[]

NY = pd.read_csv("SP500_prices_montly.csv")
Ouro = pd.read_csv("gold_prices_monthly.csv")

Date_Ouro=Ouro["Date"].loc[600:791]      
Price_Ouro=Ouro["Price"].loc[600:791]

Date_NY=NY["Date"].loc[1548:1739]     
Price_NY=NY["Price"].loc[1548:1739]

for i in range(600,792):
    Datas.append(Date_Ouro[i])
    Ouro_lista.append(round(Price_Ouro[i],2))

for i in range(1548,1740):
    NY_lista.append(round(Price_NY[i],2))    

fig, ax= plt.subplots()
ax.plot(Datas,Ouro_lista)
ax.plot(Datas,NY_lista)
ax.legend(["Ouro","Bolsa de NY"])
plt.title("Comparação entre o Ouro e a Bolsa de NY nos anos 2000 e 2015")
ax.set_xlabel("Datas")
ax.set_ylabel("Preço")



