# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""
soma = 0
Matriz = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],
          [16,17,18,19,20],[21,22,23,24,25]]

for i in range(5):
    soma = soma + Matriz[i][i]

print(soma)