# -*- coding: utf-8 -*-
"""
Created on Thu Oct 22 18:12:31 2020

@author: Pastori
"""
#------------------------------------------------------------------------------
#    Script do sistema do banco QuemPoupaTem, realizado por Lucas Toledo Pastori e Carlos Henrique para 
# o projeto do curso de Programação Avançada. 
#    Cada parte feita foi devidamente comentada e contém a especificação do autor.
#------------------------------------------------------------------------------

# Parte feita pelo Lucas ------------------------------------------------------

#(bibliotecas usadas)
###############################################################################
import json                    #Importando a bilioteca Json para manipulação de dados em arquivos
from json import dump          #Importando a função de escrita do Json
from datetime import datetime  #Importando a Biblioteca DateTime para obter informações de data e hora

#(Funções do sistema)
###############################################################################
def Datahora():                                                           # Define a função que retorna a data e hora 
    data_e_hora_atuais = datetime.now()                                   # A variável data_e_hora_atuais recebe as inofrmações de data e hora
    data_e_hora_em_texto = data_e_hora_atuais.strftime("%d/%m/%Y %H:%M")  # A variável data_e_hora_em_texto recebe as informações formatadas em texto
    return(data_e_hora_em_texto)                                          # Retorna os valores de data e hora formatados

# Fim da parte feita pelo Lucas -----------------------------------------------

# Parte feita em conjunto pelo Carlos e lucas---------------------------------- 

def verifica(CPF,senha,escolha):                            # Define a função que verifica o CPF e a senha
    if escolha == "2" or escolha == "4":                    # Caso o cliente escolha excluir cadastro ou depositar algum valor
        while CPF not in Clientes:                          # Se o CPF não for encontrado no dicionário Clientes.
            print("\nCPF incorreto. Digite novamente \n")   # Irá falar que o CPF está incorreto
            CPF = input("Digite o CPF cadastrado :")        # Irá solicitar para que digite o CPF novamente.
        else:
            print("\nCredenciais aprovadas \n")                 # CPF encontrado, poderá prosseguir com a operação
            return(CPF)                                         # Retorna o CPF atualizado
    elif escolha == "1" :                                       # Escolha de cadastrar novo cliente
        while CPF in Clientes:                                  # Se o CPF já estiver no dicionário Clientes, irá informar que o CPF já está cadastrado.     
            print("\nCPF já cadastrado. Digite novamente \n")   # Irá falar que o CPF está incorreto
            CPF = input("Digite o CPF :")                       # Solicita que digite um CPF válido para essa operação.
        else:
            print("\nCPF aprovado \n")                          # CPF aprovado, ira fazer o cadastro.
            return(CPF)                                         # Retorna o CPF atualizado
    else:
        while CPF not in Clientes or Clientes[CPF]["Senha"] != senha:             # Laço para verificar se a senha E CPF estão corretas.
            print("\nCPF e/ou senha estão incorretos. Digite novamente \n")       # Caso CPF e/ou senha estiverem incorretos, irá digitar novamente
            CPF = input("Digite o CPF cadastrado :")            #Irá solicitar para que digite o CPF novamente.
            senha = input("Digite a senha cadastrada :")        #Irá solicitar para que digite a senha novamente.
        else:
            print("\nCredenciais aprovadas \n")                 # CPF e senha corretos, irá iniciar operação
            return(CPF)                                         # Retorna o CPF atualizado

# Fim da parte feita em conjunto pelo Carlos e lucas---------------------------

# Parte feita pelo Lucas ------------------------------------------------------

def NovoCliente(nome, cpf, conta, senha, saldo):        # Define a função NovoCliente
    CPF = verifica(cpf,senha,escolha)                   # A variável CPF recebe o valor atualizado da função verifica
    Clientes[CPF] = {"Nome":nome,"Conta":conta,"Senha":senha,"Saldo":saldo} # Cria uma chave com o CPF do novo cliente contendo um dicionário com suas inofrmações
    with open("Clientes.json","w") as dados:            # Abre o arquivo Clientes para escrita
        dump(Clientes,dados)                            # Escreve o dicionário Clientes no arquivo
    print("Cadastro efetuado com sucesso")              # Confirma o cadastro da conta
    Transacoes[CPF] = []                                # Cria uma lista no dicionário Transacoes usando o CPF como chave
    with open("Transações.json","w") as dados:          # Abre o arquivo Transações para escrita
                dump(Transacoes,dados)                  # Escreve o dicionário Transacoes no arquivo
    
def ApagaCliente(cpf):                                  # Define a função Apaga Clientes
    senha = 0                                           # inicializa a variável senha para a função verifica
    CPF = verifica(cpf,senha,escolha)                   # A variável CPF recebe o valor atualizado da função verifica
    del Clientes[CPF]                                   # Deleta do dicionário Clientes os valores associados a chave CPF 
    with open("Clientes.json","w") as dados:            # Abre o arquivo Clientes para escrita
        dump(Clientes,dados)                            # Escreve o dicionário Clientes no arquivo
    del Transacoes[CPF]                                 # Deleta do dicionário Transacoes os valores associados a chave CPF
    with open("Transações.json","w") as dados:          # Abre o arquivo Transações para escrita
        dump(Transacoes,dados)                          # Escreve o dicionário Transacoes no arquivo
    print("Cadastro removido com sucesso")              # Confirma a remoção da conta

# Fim da arte feita pelo Lucas ------------------------------------------------

# Parte feita pelo Carlos------------------------------------------------------   

def Debita(cpf,senha,valor):                  # Define a função Debita
    CPF = verifica(cpf,senha,escolha)         # A variável CPF recebe o valor atualizado da função verifica
    tipo=Clientes[CPF]["Conta"]               # Armazena qual é o tipo de conta do cliente
    if tipo =="Salário":                      # Verifica o tipo de conta.                        
        tarifa = round(valor*0.05,2)          # Tarifa cobrada na conta salário
        novovalor=round(Clientes[CPF]["Saldo"]-valor-tarifa,2)    #Novo saldo na conta do cliente, descontando o valor e a tarifa (Se for realizada a transação).
        
        if novovalor>=0:                                          # Verificando a condição
            print("Seu débito foi realizado com sucesso!")        # Condição aprovada
            Clientes[CPF]["Saldo"]=novovalor                      # Novo saldo é colocado no dicionário Clientes
            with open("Clientes.json","w") as dados:              # Abre o arquivo Json para escrita
                dump(Clientes,dados)                              # Armazena o dicionário Clientes atualizado na mesma. 
        else:
            print("Essa operação não está disponível para você!")   # Condição não aprovada, tipo de conta do cliente não pode ter esse tipo de saldo.
    
    elif tipo == "Comum":                                           # Verifica o tipo de conta.
        tarifa = round(valor*0.03,2)                                # Tarifa cobrada na conta salário
        novovalor=round(Clientes[CPF]["Saldo"]-valor-tarifa,2)      # Novo saldo na conta do cliente, descontando o valor e a tarifa (Se for realizada a transação).
        
        if novovalor>=-500:                                         # Verificando a condição
            Clientes[CPF]["Saldo"]=novovalor                        # Novo saldo é colocado no dicionário Clientes.
        
            with open("Clientes.json","w") as dados:                # Abre o arquivo Json
                dump(Clientes,dados)                                # Armazena o dicionário Clientes atualizado na mesma. 
            print("Seu débito foi realizado com sucesso!")          # Condição aprovada
        else:
            print("Essa operação não está disponível para você!")   # Condição não aprovada, tipo de conta do cliente não pode ter esse tipo de saldo.
   
    elif tipo== "Plus":                                             # Verifica o tipo de conta.
        tarifa = round(valor*0.01,2)                                # Tarifa cobrada na conta salário
        novovalor= round(Clientes[CPF]["Saldo"]-valor-tarifa,2)     # Novo saldo na conta do cliente, descontando o valor e a tarifa (Se for realizada a transação).     
        
        if novovalor>=-5000:                                        # Verificando condição
            print("Seu débito foi realizado com sucesso!")          # Condição aprovada   
            Clientes[CPF]["Saldo"]=novovalor                        # Novo saldo é colocado no dicionário Clientes
            
            with open("Clientes.json","w") as dados:                # Abre o arquivo Json
                dump(Clientes,dados)                                # Armazena o dicionário Clientes atualizado na mesma. 
        else:
            print("Essa operação não está disponível para você!")   # Condição não aprovada, tipo de conta do cliente não pode ter esse tipo de saldo.

    transacao = Transacoes[CPF]                                     # Coloca a lista de transações do cliente na variável transacao
    operacao = {"Data":Datahora(),"Valor":valor,"Tarifa":tarifa,"Saldo":Clientes[CPF]["Saldo"]} # Guarda as informações importantes da operação num dicionário
    transacao.append(operacao)                      # Adiciona a nova operação (operacao) na lista
    Transacoes[CPF] = transacao                     # Devolve o valor atualizado para o dicionário Transacoes
    with open("Transações.json","w") as dados:      # Abre o arquivo Json
                dump(Transacoes,dados)              # Armazena o dicionário Transacoes atualizado na mesma. 
    
def Deposita(cpf,valor):                                        
    senha = 0
    CPF = verifica(cpf,senha,escolha)               #Irá verificar se o CPF foi digitado corretamente
    Clientes[CPF]["Saldo"]= round(Clientes[CPF]["Saldo"]+valor,2)   # Atualiza o dicionário clientes, soma do valor anterior com o valor que se deseja depositar
    print("Depósito realizado com sucesso!")        # Depósito feito com sucesso.
    with open("Clientes.json","w") as dados:        # Apre o arquivo Json de Clientes e armazena o dicionário Clientes no mesmo.
        dump(Clientes,dados)
    
    transacao = Transacoes[CPF]                     # Coloca a lista de transações do cliente na variável transacao
    operacao = {"Data":Datahora(),"Valor":valor,"Tarifa":0,"Saldo":Clientes[CPF]["Saldo"]} # Guarda as informações importantes da operação num dicionário
    transacao.append(operacao)                      # Adiciona a nova operação (operacao) na lista
    Transacoes[CPF] = transacao                     # Devolve o valor atualizado para o dicionário Transacoes
    with open("Transações.json","w") as dados:      # Abre o arquivo Json
                dump(Transacoes,dados)              # Armazena o dicionário Transacoes atualizado na mesma. 

                
def Saldo(cpf,senha):                                               # Define a função Saldo
    CPF = verifica(cpf,senha,escolha)                               # Irá verificar se o CPF E senha estão corretos
    print("Saldo: R${0:.2f}".format(round(Clientes[CPF]["Saldo"],2)))   # Saldo na conta do cliente

# Fim da parte feita pelo Carlos-----------------------------------------------  

# Parte feita pelo Lucas ------------------------------------------------------
def Extrato(cpf,senha):             # Define a função Extrato
    verifica(cpf,senha,escolha)     # A variável CPF recebe o valor atualizado da função verifica
    print("""Nome: {0}
CPF: {1}
Conta: {2}""".format(Clientes[CPF]["Nome"], CPF, Clientes[CPF]["Conta"])) # Imprime as informações da conta

    with open("Transações.json","r") as dados:   # Abre o arquivo Transações.json para leitura
        Transacoes = json.load(dados)            # A variável Transacoes recebe o valor contido no arquivo 
    for i in range(len(Transacoes[CPF])) :       # Loop contando de 0 até o comprimento da lista Transacoes[CPF]
        print("""Data: {0}  R${1:.2f}  Tarifa: R${2:.2f}  Saldo: R${3:.2f} """.format(Transacoes[CPF][i]["Data"],Transacoes[CPF][i]["Valor"],
              Transacoes[CPF][i]["Tarifa"],Transacoes[CPF][i]["Saldo"]))  # Imprime os respectivos valores da transação formatados

#(Inicialização do sistema)
###############################################################################
Transacoes = {}                                 # Inicia o dicionário Transacoes
with open("Transações.json","r") as dados:      # Abre o arquivo Transações.json para leitura
        Transacoes = json.load(dados)           # A variável Transacoes recebe o valor contido no arquivo 
transacao = []                                  # Inicia a lista transacao
Clientes = {}                                   # Inicia o dicionario Clientes
with open("Clientes.json","r") as dados:        # Abre o arquivo Clientes.json para leitura
        Clientes = json.load(dados)             # A variável Clientes recebe o valor contido no arquivo

print("Bem-vindo ao sistema do banco QuemPoupaTem") # Imprime boas vindas ao usuário

#(Loop de funcionamento do sistema)
###############################################################################

while True :        # Loop infinito do sistema
    escolha = input("""\nSelecione a função que deseja acessar: \n
1 - Novo Cliente
2 - Apaga Cliente
3 - Debita
4 - Deposita
5 - Saldo
6 - Extrato
0 - Sai do sistema

R: """)                                 # recebe na variável escolha a opção que o usuário deseja
    if escolha == "0":                  # Entra se o usuário deseja sair do sistema
        print("Encerrando sistema ")    # Confirma o encerramento
        break                           # Para o loop do sistema e termina a execução do programa
    elif escolha == "1":                                                                 # Entra se o usuário deseja cadastrar uma conta
        print("Para realizar o cadastro do novo cliente digite as informações abaixo")   # Imprime as instruções para o cadastro
        nome = input("Digite o nome do novo cliente :")                                  # Recebe o nome do novo cliente
        CPF = input("Digite o CPF do novo cliente :")                                    # Recebe o CPF do novo cliente
        tipo_conta = input("""\nSelecione o tipo de conta: \n
1 - Conta Salário
2 - Conta Comum
3 - Conta Plus


R: """)                            # Recebe o tipo de conta do novo cliente
        while True:                # Loop infinito para a confirmação do tipo de conta
            
            if tipo_conta=="1":    # Entra se o tipo é Salário
                conta="Salário"    # conta recebe a string Salário
                break              # Encerra o loop
            elif tipo_conta=="2":  # Entra se o tipo é Salário
                conta="Comum"      # conta recebe a string Comum
                break              # Encerra o loop
            elif tipo_conta=="3":  # Entra se o tipo é Salário
                conta="Plus"       # conta recebe a string Plus
                break              # Encerra o loop
            else:
                print("Nenhuma opção válida, tente novamente")    # Imprime o erro e pede para retornar a tentativa
        senha = input("Digite a senha do novo cliente :")         # Recebe a senha do novo cliente
        saldo = float(input("Digite o valor inicial da conta :")) # Recebe o saldo inicial do novo cliente
        NovoCliente(nome, CPF, conta, senha, saldo)               # Chama a função NovoCliente
        
    elif escolha == "2":                                                              # Entra se o usuário deseja apagar uma conta
        CPF = input("Para realizar a remoção do cliente do sistema digite o CPF :")   # Recebe o CPF do cliente
        ApagaCliente(CPF)                                                             # Chama a função ApagaCliente
        
# Parte feita pelo Carlos------------------------------------------------------
       
    elif escolha == "3":                                  #Escolheu debitar
        print("Para realizar essa operação, digite as informações solicitadas abaixo")   # Solicita algumas informações
        CPF = input("Digite o CPF do cliente :")                                         # Solicita CPF do cliente
        senha = input("Digite a senha do cliente :")                                     # Solicita senha do cliente
        valor = round(float(input("Digite o valor a ser debitado :")),2)                 # Valor do débito desejado      
        Debita(CPF,senha,valor)                                                          # Chama a função Debita
        
    elif escolha == "4":                                                                 #Escolheu depositar
        print("Para depositar em alguma conta, digite as informações abaixo")            # Solicita algumas informações
        CPF = input("Digite o CPF do cliente :")                                         # Solicita CPF do Cliente
        valor = round(float(input("Digite o valor a ser depositado:")),2)                # Valor que deseja depositar na conta do cliente
        Deposita(CPF,valor)                                                              # Chama função Deposita   
        
    elif escolha == "5":                                                                 # Escolheu ver o Saldo
        print("Para verificar o saldo digite as informações abaixo")                     # Solicita algumas informações 
        CPF= input("Digite o CPF do cliente :")                                          # Solicita o CPF
        senha= input("Digite a senha do cliente :")                                      # Solicita a senha
        Saldo(CPF,senha)                                                                 # Chama função Saldo

# Fim da parte feita pelo Carlos-----------------------------------------------  

# Parte feita pelo Lucas-------------------------------------------------------
    
    elif escolha == "6":                                # Entra se o usuário deseja ver o extrato da conta
        CPF= input("Digite o CPF do cliente :")         # Recebe o CPF do cliente
        senha= input("Digite a senha do cliente :")     # Recebe a senha do cliente
        Extrato(CPF,senha)                              # Chama a função Extrato
        
    else:
        print("Opção inválida, tente novamente")        # Imprime o erro e pede para retornar a tentativa
        pass                                            # Passa para o início do loop principal
        
# Fim da parte feita pelo Lucas------------------------------------------------

#----------------------------Fim do código-------------------------------------