# -*- coding: utf-8 -*-
"""
Created on Sat Oct 31 16:58:18 2020

@author: Pastori
"""

import pandas as pd

def Replace_1 (coluna):
    coluna = coluna.replace(",",".")
    coluna = coluna.replace("ni","0")
    return (float(coluna))

def Replace_2 (coluna):
    coluna = coluna.replace(".","")
    coluna = coluna.replace(" ","")
    coluna = coluna.replace("ni","0")
    return (float(coluna))

Dados = pd.read_csv("municipios_fronteiricos.csv")
    
DD = Dados["Densidade demográfica (hab/km2)"].apply(Replace_1)
IDH = Dados["IDH/2000"].apply(Replace_1)
PIB = Dados["PIB (IBGE/2005"].apply(Replace_2)
PIB_c = Dados["PIB per capita (R$)"].apply(Replace_2)

Dados_Atualizados = pd.DataFrame({"Municipio":Dados["Município"],"Estado":Dados["Estado"],
"Area territorial":Dados["Área territorial"],"Populacao":Dados["População (IBGE/2007)"],
"Densidade demografica":DD,"PIB":PIB,"PIB per capita":PIB_c,"IDH":IDH})

print ("\nVerificando os dados de entrada: \n")
print(Dados.info())
print("\nVerificando os dados tratados: \n")
print (Dados_Atualizados)
print (Dados_Atualizados.info())