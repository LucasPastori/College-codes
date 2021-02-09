# -*- coding: utf-8 -*-
"""
Created on Mon Sep 21 17:18:17 2020

@author: Pastori
"""
import os
import sys
def verifica(texto) :
    exists = os.path.isfile(texto)
    return exists