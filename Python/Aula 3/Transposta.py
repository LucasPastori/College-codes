# -*- coding: utf-8 -*-
"""
Created on Mon Aug 24 16:47:29 2020

@author: Pastori
"""

A = [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],
          [16,17,18,19,20],[21,22,23,24,25]]
At = []
for i in range(5):
    At.append ( [A[0][i],A[1][i],A[2][i],A[3][i],A[4][i]] )

print(At)