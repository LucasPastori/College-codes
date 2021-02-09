# -*- coding: utf-8 -*-
"""
Created on Mon Sep 21 18:16:49 2020

@author: Pastori
"""
import os
import sys

texto,resposta = input("Digite o nome do arquivo a ser aberto e em seguida espaçado o nome do arquivo a ser escrito:  ").split(" ")
exists = os.path.isfile(texto)
exists = os.path.isfile(resposta)

while exists == False or resposta == False:
    texto,resposta = input("Houve um erro na procura dos arquivos, insira os nomes novamente :  ").split(" ")
    exists = os.path.isfile(texto)
    exists = os.path.isfile(resposta)
    
texto = open (texto,"r",encoding= "utf-8")
resposta = open (resposta,"w",encoding= "utf-8")
linhas = texto.readlines()

for linha in linhas :
    for palavra in linha:
        if palavra == "#":
            escrever_linha = False
            break
        else:
            escrever_linha = True
    if escrever_linha == True :
        resposta.write(linha)
            
            
 
            
        
