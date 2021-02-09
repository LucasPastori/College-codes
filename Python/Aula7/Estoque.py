# -*- coding: utf-8 -*-
"""
Created on Sun Oct  4 17:24:51 2020

@author: Pastori
"""
def inserir(item,preço,quant):
    estoque_quitanda[item] = {"preço":preço, "quantidade": quant}
    print(item," inserido")
def remover(item):
    del estoque_quitanda[item]
    print(item," removido")
def imprimir():
    print(estoque_quitanda)

estoque_quitanda = {}
encerrar = "sim"
while encerrar == "sim":
    print("Bem-vindo ao estoque da quitanda")
    escolha = input("""Para inserir um item digite: inserir
Para remover um item digite: remover
Para modificar preços ou quantidades digite: modificar
Para imprimir o estoque digite: imprimir
Resposta: """)
    if escolha == "inserir" or escolha == "modificar":
        item = input("Insira o nome do item: ")
        preço = int(input("Insira o preço do item: "))
        quant = int(input("Insira a quantidade do item: "))
        inserir(item,preço,quant)
    elif escolha == "remover":
        item = input("Insira o nome do item a ser removido: ")
        remover(item)
    else :
        imprimir()
    encerrar = input("""Para realizar outra ação digite: sim
Para encerrar o acesso ao estoque digite: não
Resposta: """)

