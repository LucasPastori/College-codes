# -*- coding: utf-8 -*-

def media (lista) :
    n = len(lista)
    soma = 0
    for i in range(n):       
        soma = soma + lista[i]
    return soma/n
L = [5, 12, 15, 8] # Lista a ser inserida na função

print (media(L))    