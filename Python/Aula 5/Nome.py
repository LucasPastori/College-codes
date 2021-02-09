# -*- coding: utf-8 -*-
"""
Created on Sun Sep 20 17:59:20 2020

@author: Pastori
"""

def nomeCitacao (nome) :
    nome = nome.split()
    return(nome[-1] + ", " + nome[0])