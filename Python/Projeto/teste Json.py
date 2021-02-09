# -*- coding: utf-8 -*-
"""
Created on Mon Oct 19 17:40:41 2020

@author: Pastori
"""
#bibliotecas usadas
###############################################################################
import json
from json import dump
from datetime import datetime

# Funções do sistema
###############################################################################
def NovoCliente(nome, CPF, conta, senha, saldo):
    Clientes[CPF] = {"Nome":nome,"Conta":conta,"Senha":senha,"Saldo":saldo}
    with open("novoJson.json","w") as dados:
        dump(Clientes,dados)
    pass
def ApagaCliente(CPF):
    del Clientes[CPF]
    with open("novoJson.json","w") as dados:
        dump(Clientes,dados)
def Debita():
    pass
def Deposita():
    pass
def Saldo(CPF):
    print(Clientes[CPF]["Saldo"])
    pass
def Extrato():
    data_e_hora_atuais = datetime.now()
    data_e_hora_em_texto = data_e_hora_atuais.strftime("%d/%m/%Y %H:%M")
    print(data_e_hora_em_texto)
    pass

#Inicialização do sistema
###############################################################################

Clientes = {}
with open("novoJson.json","r") as dados:
        Clientes = json.load(dados)
print(Clientes)

print("Bem-vindo ao sistema do banco QuemPoupaTem")

#Loop de funcionamento do sistema
###############################################################################

while True :
    escolha = input("""Selecione a função que deseja acessar: \n
1 - Novo Cliente
2 - Apaga Cliente
3 - Debita
4 - Deposita
5 - Saldo
6 - Extrato
0 - Sai do sistema

R: """)
    if escolha == "0":
        print("Encerrando sistema ")
        break
    elif escolha == "1":
        print("Para realizar o cadastro do novo cliente digite as informações abaixo")
        nome = input("Digite o nome do novo cliente :")
        CPF = input("Digite o CPF do novo cliente :")
        conta = input("Qual será o tipo da conta :")
        senha = input("Digite a senha do novo cliente :")
        saldo = input("Digite o valor inicial da conta :")
        NovoCliente(nome, CPF, conta, senha, saldo)
        
    elif escolha == "2":
        CPF = input("Para realizar a remoção do cliente do sistema digite o CPF :")
        ApagaCliente(CPF)
        
    elif escolha == "3":
        
        Debita()
        
    elif escolha == "4":
        
        Deposita()
        
    elif escolha == "5":        
        CPF = input() 
        Saldo(CPF)
        
    elif escolha == "6":
        
        Extrato()
        
    else:
        print("Opção inválida, tente novamente")
        pass