# -*- coding: utf-8 -*-
"""
Created on Sat Oct 31 19:50:41 2020

@author: Pastori
"""

import pandas as pd

def Trata_Municipio (coluna):
    coluna = coluna.replace("–","-")
    coluna = coluna.split("-")
    coluna = coluna[-1]
    return (coluna)

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
Municipio = Dados["Município"].apply(Trata_Municipio)

Dados_Atualizados = pd.DataFrame({"Municipio":Municipio,"Estado":Dados["Estado"],
"Area territorial":Dados["Área territorial"],"Populacao":Dados["População (IBGE/2007)"],
"Densidade demografica":DD,"PIB":PIB,"PIB per capita":PIB_c,"IDH":IDH})

print (Dados_Atualizados)