#!/bin/sh

## num_variable
#0 = T2
#1 = PREC2
#2 = SWDOWN
#3 = RH
#4 = GLW
#5 = QFX
#6 = PBLH
#7 = MAGNITUD_VIENTO

################################## Mensuales ################################
# ncl num_variable=0 num_titulos=0 num_archivo=0 n_mes=0 genera_mapa_7.ncl
# ncl num_variable=1 num_titulos=0 num_archivo=0 n_mes=0 genera_mapa_7.ncl
# ncl num_variable=2 num_titulos=0 num_archivo=0 n_mes=0 genera_mapa_7.ncl
# ncl num_variable=3 num_titulos=0 num_archivo=0 n_mes=0 genera_mapa_7.ncl
# ncl num_variable=4 num_titulos=0 num_archivo=0 n_mes=0 genera_mapa_7.ncl
# ncl num_variable=5 num_titulos=0 num_archivo=0 n_mes=0 genera_mapa_7.ncl
# ncl num_variable=6 num_titulos=0 num_archivo=0 n_mes=0 genera_mapa_7.ncl
ncl num_variable=7 num_titulos=0 num_archivo=1 n_mes=0 genera_vientos_barbas_mens.ncl
#
################################# Maximas absolutas mes ####################
# ncl num_variable=0 num_titulos=2 num_archivo=5 n_mes=0  genera_mapa_7.ncl
# ncl num_variable=1 num_titulos=2 num_archivo=5 n_mes=0  genera_mapa_7.ncl
#ncl num_variable=2 num_titulos=2 num_archivo=5 n_mes=0  genera_mapa_7.ncl
# ncl num_variable=3 num_titulos=2 num_archivo=5 n_mes=0  genera_mapa_7.ncl
#ncl num_variable=4 num_titulos=2 num_archivo=5 n_mes=0  genera_mapa_7.ncl
# ncl num_variable=5 num_titulos=2 num_archivo=5 n_mes=0  genera_mapa_7.ncl
# ncl num_variable=6 num_titulos=2 num_archivo=5 n_mes=0  genera_mapa_7.ncl
#ncl num_variable=7 num_titulos=2 num_archivo=6 n_mes=0 genera_vientos.ncl
#
#
################################# Promedios maximo mes ####################
 #ncl num_variable=0 num_titulos=3 num_archivo=7 n_mes=0  genera_mapa_7.ncl
#ncl num_variable=1 num_titulos=3 num_archivo=7 n_mes=0  genera_mapa_7.ncl
#ncl num_variable=7 num_titulos=3 num_archivo=8 n_mes=0 genera_vientos.ncl
#
################################# Minimimo absolutas mes ####################
# ncl num_variable=0 num_titulos=4 num_archivo=9 n_mes=0 genera_mapa_7.ncl
#
################################# Minimo promedio mes ####################
# ncl num_variable=0 num_titulos=5 num_archivo=10 n_mes=0 genera_mapa_7.ncl
#

################################# Promedios horarios mes ####################
# ncl num_variable=0 num_titulos=1 num_archivo=2 n_mes=0 genera_mapa_total.ncl
# ncl num_variable=0 num_titulos=1 num_archivo=2 n_mes=1 genera_mapa_total.ncl
# ncl num_variable=0 num_titulos=1 num_archivo=2 n_mes=2 genera_mapa_total.ncl
# ncl num_variable=0 num_titulos=1 num_archivo=2 n_mes=3 genera_mapa_total.ncl
# ncl num_variable=0 num_titulos=1 num_archivo=2 n_mes=4 genera_mapa_total.ncl
# ncl num_variable=0 num_titulos=1 num_archivo=2 n_mes=5 genera_mapa_total.ncl
# ncl num_variable=0 num_titulos=1 num_archivo=2 n_mes=6 genera_mapa_total.ncl
# ncl num_variable=0 num_titulos=1 num_archivo=2 n_mes=7 genera_mapa_total.ncl
# ncl num_variable=0 num_titulos=1 num_archivo=2 n_mes=8 genera_mapa_total.ncl
# ncl num_variable=0 num_titulos=1 num_archivo=2 n_mes=9 genera_mapa_total.ncl
# ncl num_variable=0 num_titulos=1 num_archivo=2 n_mes=10 genera_mapa_total.ncl
# ncl num_variable=0 num_titulos=1 num_archivo=2 n_mes=11 genera_mapa_total.ncl
###
# ncl num_variable=1 num_titulos=1 num_archivo=2 n_mes=0 genera_mapa_total.ncl
# ncl num_variable=1 num_titulos=1 num_archivo=2 n_mes=1 genera_mapa_total.ncl
# ncl num_variable=1 num_titulos=1 num_archivo=2 n_mes=2 genera_mapa_total.ncl
# ncl num_variable=1 num_titulos=1 num_archivo=2 n_mes=3 genera_mapa_total.ncl
# ncl num_variable=1 num_titulos=1 num_archivo=2 n_mes=4 genera_mapa_total.ncl
# ncl num_variable=1 num_titulos=1 num_archivo=2 n_mes=5 genera_mapa_total.ncl
# ncl num_variable=1 num_titulos=1 num_archivo=2 n_mes=6 genera_mapa_total.ncl
# ncl num_variable=1 num_titulos=1 num_archivo=2 n_mes=7 genera_mapa_total.ncl
# ncl num_variable=1 num_titulos=1 num_archivo=2 n_mes=8 genera_mapa_total.ncl
# ncl num_variable=1 num_titulos=1 num_archivo=2 n_mes=9 genera_mapa_total.ncl
# ncl num_variable=1 num_titulos=1 num_archivo=2 n_mes=10 genera_mapa_total.ncl
# ncl num_variable=1 num_titulos=1 num_archivo=2 n_mes=11 genera_mapa_total.ncl
# ###
# ncl num_variable=2 num_titulos=1 num_archivo=2 n_mes=0 genera_mapa_total.ncl
# ncl num_variable=2 num_titulos=1 num_archivo=2 n_mes=1 genera_mapa_total.ncl
# ncl num_variable=2 num_titulos=1 num_archivo=2 n_mes=2 genera_mapa_total.ncl
# ncl num_variable=2 num_titulos=1 num_archivo=2 n_mes=3 genera_mapa_total.ncl
# ncl num_variable=2 num_titulos=1 num_archivo=2 n_mes=4 genera_mapa_total.ncl
# ncl num_variable=2 num_titulos=1 num_archivo=2 n_mes=5 genera_mapa_total.ncl
# ncl num_variable=2 num_titulos=1 num_archivo=2 n_mes=6 genera_mapa_total.ncl
# ncl num_variable=2 num_titulos=1 num_archivo=2 n_mes=7 genera_mapa_total.ncl
# ncl num_variable=2 num_titulos=1 num_archivo=2 n_mes=8 genera_mapa_total.ncl
# ncl num_variable=2 num_titulos=1 num_archivo=2 n_mes=9 genera_mapa_total.ncl
# ncl num_variable=2 num_titulos=1 num_archivo=2 n_mes=10 genera_mapa_total.ncl
# ncl num_variable=2 num_titulos=1 num_archivo=2 n_mes=11 genera_mapa_total.ncl
# # # #
# ncl num_variable=3 num_titulos=1 num_archivo=3 n_mes=0 genera_mapa_total.ncl
# ncl num_variable=3 num_titulos=1 num_archivo=3 n_mes=1 genera_mapa_total.ncl
# ncl num_variable=3 num_titulos=1 num_archivo=3 n_mes=2 genera_mapa_total.ncl
# ncl num_variable=3 num_titulos=1 num_archivo=3 n_mes=3 genera_mapa_total.ncl
# ncl num_variable=3 num_titulos=1 num_archivo=3 n_mes=4 genera_mapa_total.ncl
# ncl num_variable=3 num_titulos=1 num_archivo=3 n_mes=5 genera_mapa_total.ncl
# ncl num_variable=3 num_titulos=1 num_archivo=3 n_mes=6 genera_mapa_total.ncl
# ncl num_variable=3 num_titulos=1 num_archivo=3 n_mes=7 genera_mapa_total.ncl
# ncl num_variable=3 num_titulos=1 num_archivo=3 n_mes=8 genera_mapa_total.ncl
# ncl num_variable=3 num_titulos=1 num_archivo=3 n_mes=9 genera_mapa_total.ncl
# ncl num_variable=3 num_titulos=1 num_archivo=3 n_mes=10 genera_mapa_total.ncl
# ncl num_variable=3 num_titulos=1 num_archivo=3 n_mes=11 genera_mapa_total.ncl
# # #
# ncl num_variable=4 num_titulos=1 num_archivo=2 n_mes=0 genera_mapa_total.ncl
# ncl num_variable=4 num_titulos=1 num_archivo=2 n_mes=1 genera_mapa_total.ncl
# ncl num_variable=4 num_titulos=1 num_archivo=2 n_mes=2 genera_mapa_total.ncl
# ncl num_variable=4 num_titulos=1 num_archivo=2 n_mes=3 genera_mapa_total.ncl
# ncl num_variable=4 num_titulos=1 num_archivo=2 n_mes=4 genera_mapa_total.ncl
# ncl num_variable=4 num_titulos=1 num_archivo=2 n_mes=5 genera_mapa_total.ncl
# ncl num_variable=4 num_titulos=1 num_archivo=2 n_mes=6 genera_mapa_total.ncl
# ncl num_variable=4 num_titulos=1 num_archivo=2 n_mes=7 genera_mapa_total.ncl
# ncl num_variable=4 num_titulos=1 num_archivo=2 n_mes=8 genera_mapa_total.ncl
# ncl num_variable=4 num_titulos=1 num_archivo=2 n_mes=9 genera_mapa_total.ncl
# ncl num_variable=4 num_titulos=1 num_archivo=2 n_mes=10 genera_mapa_total.ncl
# ncl num_variable=4 num_titulos=1 num_archivo=2 n_mes=11 genera_mapa_total.ncl
# # #
# ncl num_variable=5 num_titulos=1 num_archivo=2 n_mes=0 genera_mapa_total.ncl
# ncl num_variable=5 num_titulos=1 num_archivo=2 n_mes=1 genera_mapa_total.ncl
# ncl num_variable=5 num_titulos=1 num_archivo=2 n_mes=2 genera_mapa_total.ncl
# ncl num_variable=5 num_titulos=1 num_archivo=2 n_mes=3 genera_mapa_total.ncl
# ncl num_variable=5 num_titulos=1 num_archivo=2 n_mes=4 genera_mapa_total.ncl
# ncl num_variable=5 num_titulos=1 num_archivo=2 n_mes=5 genera_mapa_total.ncl
# ncl num_variable=5 num_titulos=1 num_archivo=2 n_mes=6 genera_mapa_total.ncl
# ncl num_variable=5 num_titulos=1 num_archivo=2 n_mes=7 genera_mapa_total.ncl
# ncl num_variable=5 num_titulos=1 num_archivo=2 n_mes=8 genera_mapa_total.ncl
# ncl num_variable=5 num_titulos=1 num_archivo=2 n_mes=9 genera_mapa_total.ncl
# ncl num_variable=5 num_titulos=1 num_archivo=2 n_mes=10 genera_mapa_total.ncl
# ncl num_variable=5 num_titulos=1 num_archivo=2 n_mes=11 genera_mapa_total.ncl
# # #
# ncl num_variable=6 num_titulos=1 num_archivo=2 n_mes=0 genera_mapa_total.ncl
# ncl num_variable=6 num_titulos=1 num_archivo=2 n_mes=1 genera_mapa_total.ncl
# ncl num_variable=6 num_titulos=1 num_archivo=2 n_mes=2 genera_mapa_total.ncl
# ncl num_variable=6 num_titulos=1 num_archivo=2 n_mes=3 genera_mapa_total.ncl
# ncl num_variable=6 num_titulos=1 num_archivo=2 n_mes=4 genera_mapa_total.ncl
# ncl num_variable=6 num_titulos=1 num_archivo=2 n_mes=5 genera_mapa_total.ncl
# ncl num_variable=6 num_titulos=1 num_archivo=2 n_mes=6 genera_mapa_total.ncl
# ncl num_variable=6 num_titulos=1 num_archivo=2 n_mes=7 genera_mapa_total.ncl
# ncl num_variable=6 num_titulos=1 num_archivo=2 n_mes=8 genera_mapa_total.ncl
# ncl num_variable=6 num_titulos=1 num_archivo=2 n_mes=9 genera_mapa_total.ncl
# ncl num_variable=6 num_titulos=1 num_archivo=2 n_mes=10 genera_mapa_total.ncl
# ncl num_variable=6 num_titulos=1 num_archivo=2 n_mes=11 genera_mapa_total.ncl
# #
# ncl num_variable=7 num_titulos=1 num_archivo=4 n_mes=0 genera_vientos_barbas.ncl
# ncl num_variable=7 num_titulos=1 num_archivo=4 n_mes=1 genera_vientos_barbas.ncl
# ncl num_variable=7 num_titulos=1 num_archivo=4 n_mes=2 genera_vientos_barbas.ncl
# ncl num_variable=7 num_titulos=1 num_archivo=4 n_mes=3 genera_vientos_barbas.ncl
# ncl num_variable=7 num_titulos=1 num_archivo=4 n_mes=4 genera_vientos_barbas.ncl
# ncl num_variable=7 num_titulos=1 num_archivo=4 n_mes=5 genera_vientos_barbas.ncl
# ncl num_variable=7 num_titulos=1 num_archivo=4 n_mes=6 genera_vientos_barbas.ncl
# ncl num_variable=7 num_titulos=1 num_archivo=4 n_mes=7 genera_vientos_barbas.ncl
# ncl num_variable=7 num_titulos=1 num_archivo=4 n_mes=8 genera_vientos_barbas.ncl
# ncl num_variable=7 num_titulos=1 num_archivo=4 n_mes=9 genera_vientos_barbas.ncl
# ncl num_variable=7 num_titulos=1 num_archivo=4 n_mes=10 genera_vientos_barbas.ncl
# ncl num_variable=7 num_titulos=1 num_archivo=4 n_mes=11 genera_vientos_barbas.ncl
