
oacute  = "o~H-13V2F35~B~FV-2H3~"
aacute  = "a~H-13V2F35~B~FV-2H3~"
iacute  = "i~H-08V2F35~B~FV-2~"


;Titulo del mapa   ***VARIABLE***
titulos1 = (/"Climatolog"+iacute+"a de la temperatura a 2 m para ", "Climatolog"+iacute+"a de la precipitaci"+oacute+"n para ", "Climatolog"+iacute+"a de la radiaci"+oacute+"n de onda corta para ", "Climatolog"+iacute+"a de la humedad relativa para ", "Climatolog"+iacute+"a de la radiaci"+oacute+"n neta de onda larga para ", "Climatolog"+iacute+"a de la evaporaci"+oacute+"n para ", "Climatolog"+iacute+"a de la altura de la capa l"+iacute+"mite para ","Climatolog"+iacute+"a del viento a 10 m para "/)
titulos2 = (/"Climatolog"+iacute+"a de la temperatura a 2 m a las ", "Climatolog"+iacute+"a de la precipitaci"+oacute+"n acumulada de las ", "Climatolog"+iacute+"a de la radiaci"+oacute+"n de onda corta a las ", "Climatolog"+iacute+"a de la humedad relativa a las ", "Climatolog"+iacute+"a de la radiaci"+oacute+"n neta de onda larga a las ", "Climatolog"+iacute+"a de la evaporaci"+oacute+"n a las ", "Climatolog"+iacute+"a de la altura de capa l"+iacute+"mite a las ","Climatolog"+iacute+"a del viento a 10 m a las "/)
titulos3 = (/"Temperatura m"+aacute+"xima absoluta para ", "Precipitaci"+oacute+"n m"+aacute+"xima absoluta para ","Radiaci"+oacute+"n de onda corta m"+aacute+"xima absoluta para ","Humedad relativa m"+aacute+"xima absoluta para ","Radiaci"+oacute+"n de onda larga m"+aacute+"xima absoluta para ","Evaporaci"+oacute+"n m"+aacute+"xima absoluta para ","Altura de capa l"+iacute+"mite m"+aacute+"xima absoluta para ","Viento m"+aacute+"ximo absoluto para "/)
titulos4 = (/"Promedio mensual de temperatura m"+aacute+"xima para ", "Promedio mensual de precipitaci"+oacute+"n m"+aacute+"xima para ","Radiaci"+oacute+"n de onda corta m"+aacute+"xima absoluta de ","Humedad relativa m"+aacute+"xima absoluta de ","Radiaci"+oacute+"n de onda larga m"+aacute+"xima absoluta de ","Evaporaci"+oacute+"n m"+aacute+"xima absoluta de ","Altura de capa l"+iacute+"mite m"+aacute+"xima absoluta de ","Promedio mensual de viento m"+aacute+"ximo para "/)
titulos5 = (/"Temperatura m"+iacute+"nima absoluta para ", "Precipitaci"+oacute+"n m"+aacute+"xima promedio de ","Radiaci"+oacute+"n de onda corta m"+aacute+"xima absoluta de ","Humedad relativa m"+aacute+"xima absoluta de ","Radiaci"+oacute+"n de onda larga m"+aacute+"xima absoluta de ","Evaporaci"+oacute+"n m"+aacute+"xima absoluta de ","Altura de capa l"+iacute+"mite m"+aacute+"xima absoluta de ","Viento m"+aacute+"ximo promedio de "/)
titulos6 = (/"Temperatura m"+iacute+"nima promedio para ", "Precipitaci"+oacute+"n m"+aacute+"xima promedio de ","Radiaci"+oacute+"n de onda corta m"+aacute+"xima absoluta de ","Humedad relativa m"+aacute+"xima absoluta de ","Radiaci"+oacute+"n de onda larga m"+aacute+"xima absoluta de ","Evaporaci"+oacute+"n m"+aacute+"xima absoluta de ","Altura de capa l"+iacute+"mite m"+aacute+"xima absoluta de ","Viento m"+aacute+"ximo promedio de "/)

titulos_nom = (/titulos1,titulos2,titulos3,titulos4,titulos5,titulos6/)

ruta = (/"mensuales/","Promedio_horarios_mes/","Maximas_absolutas_mes/","Promedio_maximo_mes/","Minimos_absolutas_mes/","Minima_promedio_mes/"/)


;Titulo de la barra de colores
;barras = (/"(~S~o~N~C)", "(mm mes~S~-1~N~)","(W m~S~-2~N~ )" ,"(%)","(W m~S~-2~N~ )","(mm mes~S~-1~N~)","(m)","(m s~S~-1~N~)"/)
;barras = (/"(~S~o~N~C)", "(mm d"+iacute+"a~S~-1~N~)","(W m~S~-2~N~ )" ,"(%)","(W m~S~-2~N~ )","(mm d"+iacute+"a~S~-1~N~)","(m)","(m s~S~-1~N~)"/)
barras = (/"(~S~o~N~C)", "(mm hr~S~-1~N~)","(W m~S~-2~N~)" ,"(%)","(W m~S~-2~N~)","(mm hr~S~-1~N~)","(m)","(m s~S~-1~N~)"/)


;Nombre del archivo jpg   ***VARIABLE*** ***Posible arreglo de rangos***
figuras1 = (/"cm_temp_", "cm_prec_","cm_rcorta_","cm_hum_", "cm_rlarga_","cm_evap_","cm_acl_","cm_viento_"/)
figuras2 = (/"ch_temp_", "ch_prec_","ch_rcorta_","ch_hum_", "ch_rlarga_","ch_evap_","ch_acl_","ch_viento_"/)
figuras3 = (/"maxam_temp_", "maxam_prec_","maxam_rcorta_","maxam_hum_", "maxam_rlarga_","maxam_evap_","maxam_acl_","maxam_viento_"/)
figuras4 = (/"maxpm_temp_", "maxpm_prec_","maxpm_rcorta_","maxpm_hum_", "maxpm_rlarga_","maxpm_evap_","maxpm_acl_","maxpm_viento_"/)
figuras5 = (/"minam_temp_", "maxpm_prec_","maxpm_rcorta_","maxpm_hum_", "maxpm_rlarga_","maxpm_evap_","maxpm_acl_","maxpm_viento_"/)
figuras6 = (/"minpm_temp_", "maxpm_prec_","maxpm_rcorta_","maxpm_hum_", "maxpm_rlarga_","maxpm_evap_","maxpm_acl_","maxpm_viento_"/)

figuras_array = (/figuras1, figuras2, figuras3,figuras4,figuras5,figuras6/)


;Variable que se quiere graficar   ***VARIABLE*** ***Posible arreglo de rangos***
variable = (/"T2", "PREC2", "SWDOWN","RH","GLW","QFX","PBLH","MAGNITUD_VIENTO"/)
nombre_variable = (/"temp","prec","rcorta","hum","rlarga","evap","acl","viento"/)



;Paleta de colores     ***VARIABLE***
RUTA_PALETAS = "Paletas/"
paletas = (/"temp_cigom.pal", "preci_cigom.pal", "rcorta_cigom.pal","humedad_cigom.pal","rlarga_cigom.pal","preci_cigom.pal","acl_cigom.pal","vientos_cigom.pal"/)
;Rangos de variable ***Posible arreglo de rangos***


Vmin = (/-15.0, 0.0, 50.0, 30.0,-100,0.0,100.0,1.0/)

Vmax = (/48.0, 400.0, 1150, 95.0, 40.0, 400.0,2700.0,69.0/)


meses = (/"enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"/)
mesesM = (/"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"/)
nombre_arc = (/"01_","02_","03_","04_","05_","06_","07_","08_","09_","10_","11_","12_"/)


print(figuras_array(num_titulos,num_variable))
print(titulos_nom(num_titulos,num_variable))

;num_variable =1
;n_mes = 0
;num_titulos = 0
;num_archivo = 0
nombre_ruta = ruta(num_titulos) + nombre_variable(num_variable) + "/"
;figuras = (/figuras_array(num_titulos)/)
;titulos=(/titulos_nom(num_titulos)/)
TITULO_MAPA = (/titulos_nom(num_titulos,num_variable)/)
TITULO_BARRA = (/barras(num_variable)/)
NOMBRE_FIGURA = (/figuras_array(num_titulos,num_variable)/)
nombre_variable = (/variable(num_variable)/)
PALETAS = (/paletas(num_variable)/)
VALOR_MIN = (/Vmin(num_variable)/)
VALOR_MAX = (/Vmax(num_variable)/)


;La ruta de salida para los archivos ***VARIABLE***
ruta_prefijo = "out_mapas/"
carpeta_salida = "mapas_est"

;La ruta del archivo que se va a graficar        ***VARIABLE***
ruta_archivo1 = "Datos/PromediosMensuales/Promedios_Mes.nc"
ruta_archivo2 = "Datos/viento/Promedios_Mes.nc"
ruta_archivo3 = "Datos/PromediosHorariosMes/Promedios_Horarios_Mes_"+mesesM(n_mes)+".nc"
ruta_archivo4 = "Datos/PromediosHorariosMes/PromediosHorariosMesRH/Promedios_Horarios_RH_Mes_"+mesesM(n_mes)+".nc"
ruta_archivo5 = "Datos/viento/PromediosHorariosMes/Promedios_Horarios_Mes_"+mesesM(n_mes)+".nc"
ruta_archivo6 = "Datos/MaximasAbsolutosMensuales/Maximas_Mes.nc"
ruta_archivo7 = "Datos/viento/Maximas_Mes.nc"
ruta_archivo8 = "Datos/PromediosMaximosAbsolutosMensuales/Promedios_Maximas_Mes.nc"
ruta_archivo9 = "Datos/viento/Promedios_Maximas_Mes.nc"
ruta_archivo10 = "Datos/MinimasAbsolutasMensuales/Minimas_Mes.nc"
ruta_archivo11 = "Datos/PromediosMinimosMensuales/Promedios_Minimas_Mes.nc"
ruta_archivo_arr = (/ruta_archivo1,ruta_archivo2,ruta_archivo3,ruta_archivo4,ruta_archivo5,ruta_archivo6,ruta_archivo7,ruta_archivo8,ruta_archivo9,ruta_archivo10,ruta_archivo11/)
ruta_archivo = ruta_archivo_arr(num_archivo)
mes_str = meses(n_mes)
;mes_str = "enero"
int_mes = nombre_arc(n_mes)
