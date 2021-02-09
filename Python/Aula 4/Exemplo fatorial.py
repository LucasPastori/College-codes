# -*- coding: utf-8 -*-
"""
Created on Mon Aug 31 18:09:33 2020

@author: Pastori
"""

def fatorial(n):
    if n == 0 or n == 1:
        return 1
    else:
        return n * fatorial(n-1)
print(fatorial (5))