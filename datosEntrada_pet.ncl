
oacute  = "o~H-13V2F35~B~FV-2H3~"
aacute  = "a~H-13V2F35~B~FV-2H3~"
iacute  = "i~H-08V2F35~B~FV-2~"

titulos = (/"Concentraci"+oacute+"n de "/)
nombre_puntos = (/"P1","P2","P3","P4","P5","P6"/)
puntos_mes = (/"01","02","03","04","05","06","07","08","09","10","11","12"/)


;Titulo de la barra de colores ***Posible arreglo de rangos***
barras = (/"% de part"+iacute+"culas / km~S~2~N"/)



figuras = (/"conc_"/) ;dis_pet_pos_mes_hora
variable = (/"oilSpill"/)



;Paleta de colores     ***VARIABLE***
RUTA_PALETAS = "Paletas/"
paletas = (/"oilspill(4).pal"/)
;Rangos de variable ***Posible arreglo de rangos***


Vmin = (/0.0/)

Vmax = (/100.0/)


meses = (/"enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"/)
mesesM = (/"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"/)
nombre_arc = (/"01_","02_","03_","04_","05_","06_","07_","08_","09_","10_","11_","12_"/)

num_variable = 0
;pos_mes = 2 ;posicion del punto inicial
;n_mes = 0 ;mes de la simulacion



TITULO_MAPA = (/titulos(num_variable)/)
TITULO_BARRA = (/barras(num_variable)/)
NOMBRE_FIGURA = (/figuras(num_variable)/)
nombre_variable = (/variable(num_variable)/)
PALETAS = (/paletas(num_variable)/)
VALOR_MIN = (/Vmin(num_variable)/)
VALOR_MAX = (/Vmax(num_variable)/)


;La ruta de salida para los archivos ***VARIABLE***
ruta_prefijo = "out_mapas/"
carpeta_salida = "mapas_pet"


mes_str = meses(n_mes)
int_mes = puntos_mes(n_mes)
ruta_archivo = ""
;ruta_archivo = "/home/pablo/Descargas/atmosoilspill_"+punto_str+"p1.nc"
;ruta_archivo = "/home/pablo/Documentos/Scripts_Raul/mapas_estaticos/in/atmosoilspill_01_P2.nc"
ruta_archivos = "Datos/atmosoilspill_"+int_mes+"_"+nombre_puntos(pos_mes)+".nc"
