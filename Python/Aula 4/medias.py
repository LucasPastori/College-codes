# -*- coding: utf-8 -*-
"""
Created on Mon Aug 31 17:12:54 2020

@author: Pastori
"""

def medias (x,y,z,tipo_media):
    if tipo_media == "A":
        print((x+y+z)/3)
    else:
        print((5*x+3*y+2*z)/10)

nota1 = int(input())
nota2 = int(input())
nota3 = int(input())
Tipo = input()

medias(nota1,nota2,nota3,Tipo)