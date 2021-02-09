# -*- coding: utf-8 -*-
"""
Created on Mon Sep 14 17:25:47 2020

@author: Pastori
"""

def contaPalavras (frase) :
    contador = 0
    for i in range (len(frase)) :
        if frase[i] == " " :
            contador = contador + 1 

    if contador == 0 :
        return contador #print (contador)
    else : 
        return contador + 1 #print (contador + 1)

