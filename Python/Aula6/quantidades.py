# -*- coding: utf-8 -*-
"""
Created on Mon Sep 21 17:35:19 2020

@author: Pastori
"""

def file_info(texto):

    texto = open (texto,"r",encoding= "utf-8")
    palavras_separadas = []
    quant_palavras = 0
    quant_letras = 0

    for linha in texto.readlines() :
        quant_letras += len(linha)
        linha_separada  = linha.split(" ")
        palavras_separadas.append(linha_separada)

    for i in range(len(palavras_separadas)) :
        for palavras in palavras_separadas[i] :
            quant_palavras += 1
    return (len(palavras_separadas),quant_palavras,quant_letras)





