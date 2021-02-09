# -*- coding: utf-8 -*-
"""
Created on Mon Sep 14 17:36:39 2020

@author: Pastori
"""

def maiorPalavra (frase) :
    lista = []
    maior = 0
    frase = frase.replace(",", "")
    frase = frase.split()
    for palavra in frase :
        tamanho = len(palavra)
        if tamanho > maior :
            maior = tamanho
    for palavra in frase :
        if len(palavra) == maior :
            if palavra not in lista :
                lista.append(palavra)
        
    return (maior, lista )

        