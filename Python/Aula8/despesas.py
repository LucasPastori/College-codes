# -*- coding: utf-8 -*-
"""
Created on Fri Oct 23 17:07:13 2020

@author: Pastori
"""


class despesas:
    def __init__(self,CPF):   
        self.despesas_mes = []
        self.despesas_dia = []
        self.CPF = CPF
    
    def Construtor (CPF):
        Pessoas[CPF] = despesas(CPF)
    
    def getCPF (self):
        print(self.CPF)
        
    def totalizaMes (self,mes):
        gastos = 30 * self.despesas_dia[mes] + self.despesas_mes[mes]
        print("No mes {0} sua despesa diária foi de {1:.2f} e sua despesa mensal foi de {2:.2f}".format(mes + 1,self.despesas_dia[mes],self.despesas_mes[mes]))       
        print("O seu total de gastos foi de {0:.2f}".format(gastos))

Pessoas = {}
CPF = "41561735850"
despesas.Construtor(CPF)
Pessoas[CPF].despesas_dia = [60,50]
Pessoas[CPF].despesas_mes = [4000,5600]
Pessoas[CPF].getCPF()
Pessoas[CPF].totalizaMes(0)
Pessoas[CPF].totalizaMes(1)
