# -*- coding: utf-8 -*-
"""
Created on Sat Oct 31 19:22:09 2020

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

print ("\nA média populacional dos munícipios é: {0}\n".format(str(Dados_Atualizados["Populacao"].mean())))

Dados_Atualizados = Dados_Atualizados.sort_values(by="Area territorial",ascending=False)

print ("O município com MAIOR área é: {0}\n".format(Dados_Atualizados.iloc[0]))

Dados_Atualizados = Dados_Atualizados.sort_values(by="Area territorial")

print ("O município com MENOR área é: {0}\n".format(Dados_Atualizados.iloc[0]))

Dados_Atualizados = Dados_Atualizados.sort_values(by="IDH")

print ("O municipio com MENOR IDH é: {0}\n".format(Dados_Atualizados.iloc[0]))

Dados_Atualizados = Dados_Atualizados.sort_values(by="PIB per capita", ascending=False)

print ("O municipio com o MAIOR PIB per capita é: {0}\n".format(Dados_Atualizados.iloc[0]))