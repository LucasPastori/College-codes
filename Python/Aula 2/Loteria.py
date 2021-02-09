# -*- coding: utf-8 -*-
"""
Created on Mon Aug 17 18:12:32 2020

@author: Pastori
"""
from random import randrange

num = 0
premio = []

for i in range(6):
    num = randrange(1,49)
    
    for x in range (len(premio)):
        while num == premio[x]:
            num = randrange(1,49)
    premio.append(num)        
list.sort(premio)
print(premio)