# -*- coding: utf-8 -*-
"""
Created on Mon Aug 10 17:15:05 2020

@author: Pastori
"""

pagamento = int( input("Quanto você ganha por hora trabalhada"))
horas = int( input("Quantas horas você trabalhou no mês"))
Salario_Bruto = pagamento*horas
INSS = 0.08*Salario_Bruto
Imposto_Renda = 0.11*Salario_Bruto
Sindicato = 0.05*Salario_Bruto
liquido = Salario_Bruto - INSS - Imposto_Renda - Sindicato
print("Salário Bruto é de R$ %.2f" % Salario_Bruto)
print("INSS é de R$ %.2f" % INSS)
print("Imposto de renda é de R$ %.2f" % Imposto_Renda)
print("Salário líquido é de R$ %.2f" % liquido)