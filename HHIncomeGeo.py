#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug 21 18:18:16 2017

@author: NNK

Household Income and Geo Stats - Kaggle competition


"""

#%%
import pandas as pd
import numpy as np
import folium as f
from folium.plugins import MarkerCluster

#%% Data
hhgeo = pd.read_csv('household_income_kaggle.csv', encoding='ISO-8859-1')
hhgeo.head()


#%% General explore


hhgeo_small = hhgeo.iloc[0:1001,:]

#%% Define map elements
#-------------------------------------------------------------
lon = hhgeo_small.Lon
lat = hhgeo_small.Lat

coordinates = list(zip(lon,lat))
popups = [format(i) for i in hhgeo_small.Place]



#%% Render Leaflet Map 

m = f.Map(location = [np.mean(lat), np.mean(lon)], zoom_start=1)
m.add_child(MarkerCluster(locations=coordinates, popups=popups))
m