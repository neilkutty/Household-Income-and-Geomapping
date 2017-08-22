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



#%% Render Leaflet Map 
#-------------------------------------------------------------
lon = hhgeo.Lon
lat = hhgeo.Lat

coordinates = list(zip(lon,lat))
popups = [format(i) for i in hhgeo.Place]



m = f.Map(location = [np.mean(lat), np.mean(lon)], zoom_start=1)
m.add_child(MarkerCluster(locations=coordinates, popups=popups))
m