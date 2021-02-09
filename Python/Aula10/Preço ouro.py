# -*- coding: utf-8 -*-
"""
Created on Thu Nov 12 16:49:33 2020

@author: Pastori
"""

import matplotlib.pyplot as plt
import pandas as pd
   
Dados = pd.read_csv("gold_prices_monthly.csv")

date = Dados["Date"]
price = Dados["Price"]

fig, ax = plt.subplots()
ax.plot(date, price)
ax.set_title("Preço do Ouro")
ax.set_xlabel("Data")
ax.set_ylabel("Preço")
ax.legend(['Evolução do preço']) 