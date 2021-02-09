# -*- coding: utf-8 -*-
"""
Created on Mon Aug 10 17:43:45 2020

@author: Pastori
"""

N1 = int(input("nota N1"))
N2 = int(input("nota N2"))
N3 = int(input("nota N3"))
media = (N1 + N2*2 + N3*3)/6
if media >5:
    print("Aluno aprovado")
else: 
    print("Aluno reprovado")
    