# -*- coding: utf-8 -*-
"""
Created on Mon Oct 26 11:18:35 2020

@author: Pastori
"""

class Funcionario:
     def __init__(self,CPF,nome,idade,salario,departamento):
         self.CPF = CPF
         self.Nome = nome
         self.Idade = idade
         self.Salario = salario
         self.Departamento = departamento

class Professores:
    def __init__(self,CPF,nome,idade,salario,departamento,disciplinas):
        Funcionario.__init__(self,CPF,nome,idade,salario,departamento)
        self.Disciplinas = disciplinas

#Funcionário
Lucas = Funcionario("41561735850","Lucas Toledo Pastori","22","R$5000.00","Elétrica")
print(Lucas.CPF,Lucas.Nome,Lucas.Idade,Lucas.Salario,Lucas.Departamento)
#Professor e Funcionário
Lucas = Professores("41561735850","Lucas Toledo Pastori","22","R$10000.00","Elétrica","Programação Avançada 1 e Inteligência Artificial")
print(Lucas.CPF,Lucas.Nome,Lucas.Idade,Lucas.Salario,Lucas.Departamento,Lucas.Disciplinas)
