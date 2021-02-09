# -*- coding: utf-8 -*-
"""
Created on Sun Sep 20 17:37:29 2020

@author: Pastori
"""

def contaPalavras (frase) :
    frase = frase.replace("!","")
    frase = frase.replace("?","")
    frase = frase.replace(",","")
    frase = frase.lower()
    frase = frase.split()
    palavras = []
    incidencia = []
    for palavra in frase :
        if len(palavra) >= 2 :
            if palavra not in palavras :
                palavras.append(palavra)
                incidencia.append(1)
            else: 
                indice = palavras.index(palavra)
                incidencia[indice] += 1
    return(palavras , incidencia)