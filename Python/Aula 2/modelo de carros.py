# -*- coding: utf-8 -*-
"""
Created on Mon Aug 17 17:29:06 2020

@author: Pastori
"""
modelos = []
consumo = []
litros = []
economico = 0
aux = 0

for i in range(5):
        modelos.append(input("insira o modelo do carro"))
for i in range(5):
        consumo.append(float(input("Qual é o consumo dos carros listados em Km/L, respectivamente?")))
        litros.append(round((1000/consumo[i])))
        if consumo[i] > aux:
            aux = consumo[i]
            economico = modelos[i]
print("O consumo dos modelos para percorrer 1000Km é de respectivamente {l} litros".format(l = litros))
print("O modelo mais econômico é o {e}".format(e = economico))


