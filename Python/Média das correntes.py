# -*- coding: utf-8 -*-
"""
Created on Wed Dec  2 19:03:17 2020

@author: Pastori
"""
def mediaCorrente(arquivo):
    soma = 0
    i = 0
    corrente = open (arquivo,"r",encoding= "utf-8")
    for numero in corrente.readlines():
        i +=1
        if numero != "nan":
            numero = float(numero)
            soma = soma + numero       
    media = soma/i
    return (media)

print(mediaCorrente("corrente.txt"))