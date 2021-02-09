# -*- coding: utf-8 -*-
"""
Created on Mon Aug 31 17:00:46 2020

@author: Pastori
"""

def multiplo (x,y):
    if x % y == 0:
        print(True)
    else:
        print(False)
        
x = int(input())
y = int(input())
multiplo(x,y)