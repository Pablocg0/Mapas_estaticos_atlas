load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "datosEntrada_pet.ncl"



function get_number(number)
begin
    if (number .lt. 10) then
        return "0" + number
    else
        return number
    end if
end



begin
horas_4 = (/"00:00", "04:00", "08:00", "12:00", "16:00", "20:00", "24:00", "28:00","32:00","36:00","40:00","44:00","48:00"/)
alturas = (/"1500","1000","500","100","10"/)
;puntos = (/"Punto 1","Punto 2","Punto 3","Punto 4","Punto 5","Punto 6"/)
meses = (/"enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"/)
;variables para poner acentos
oacute  = "o~H-13V2F35~B~FV-2H3~"
aacute  = "a~H-13V2F35~B~FV-2H3~"
iacute  = "i~H-08V2F35~B~FV-2~"
ruta_salida = ruta_prefijo + carpeta_salida + "/"
carpeta_png = "png/"
carpeta_jpg = "jpg/P2/"
;system("rm -rf " + ruta_salida)
;system("mkdir " + ruta_salida)
system("mkdir " + ruta_salida + carpeta_png + " & mkdir " + ruta_salida + carpeta_jpg)
;Archivo de donde se tomara la variable a graficar
f = addfile(ruta_archivos, "r")

shp1 = "isobatas/Isobatas.shp"
lsf_name = "isobatas/Rio.shp"
;Se obtiene la variable
ARR_VARIABLE =f->$nombre_variable$
dim_tiempo = 1

;Checaremos si tiene la variable time el archivo netCDF
x = ind(getfilevarnames(f).eq."/time")
print(ismissing(x))
if(ismissing(x))then
    print("aqui")
    ;Se obtiene el tiempo en que encuentran las lecturas de la variable
    tiempo = f->time
    ;Obtenemos las dimensiones del tiempo
    dim_tiempo = dimsizes(tiempo)
end if

;arreglo_nombres = (/""/)

;Decidimos que arreglo tomar
if(dim_tiempo .eq. 12) then
    arreglo_nombres = meses
else if(dim_tiempo .eq. 365) then
    rreglo_nombres = horas_4
else if(dim_tiempo .eq. 24) then
    arreglo_nombres = horas_24
else if(dim_tiempo .eq. 13) then
    arreglo_nombres = horas_4
end if
end if
end if
end if

dim_vars = dimsizes(nombre_variable)
dim_alt = 5

LATITUD     =f->lat
LONGITUD    =f->lon

    do var =0, (dim_vars -1)
        paleta := asciiread(RUTA_PALETAS + PALETAS(var),-1,"string")
        dim_paleta := dimsizes(paleta)

        do i =0, (dim_tiempo -1)
            do j=0, (dim_alt-1)


                ruta_completa = ""
                system("mkdir " + ruta_salida + carpeta_jpg + alturas(j) + "/" + int_mes + "/")
                ruta_completa = ruta_salida + carpeta_jpg + alturas(j) + "/" + int_mes + "/"

                nombre = ruta_salida + carpeta_png + NOMBRE_FIGURA(var) + int_mes +"_"+ get_number(i*4) +"_"+ alturas(j)
                ;nombre = ruta_completa + NOMBRE_FIGURA(var) + int_mes +"_"+ get_number(i*4) +"_"+ alturas(j)
                wks_type = "png"
                ;wks_type@wkWidth = 1024
                ;wks_type@wkHeight = 1024
                wks := gsn_open_wks(wks_type,nombre)

                setvalues NhlGetWorkspaceObjectId()
                    "wsMaximumSize" : 300000000
                end setvalues


                ;VARIABLE := ARR_VARIABLE(i,j,:,:)
                VARIABLE := ARR_VARIABLE(i,j,:,:)

                a_c = 1

                res                             := True
                res@gsnPaperOrientation         := "auto"
                res@gsnMaximize                 := True
                res@cnHighLabelsOn              := False
                res@cnLowLabelsOn               := False
                res@mpGridAndLimbOn             := True
                res@mpGridSpacingF              := 5             ;El espaciado del grid
                res@mpGridLineColor             := (/0.70,0.70,0.70/)   ; toma el color del arreglo de colores en la posicion "i"
                res@mpGridLineThicknessF        := 1.1
                res@tmXBTickSpacingF            := 5
                res@tmYLTickSpacingF            := 5




                res@cnLineLabelsOn              := False        ; no contour line labels
                res@cnInfoLabelOn               := False        ; no info label
                res@gsnAddCyclic                := False            ; regional data, don't add pt
                res@mpGeophysicalLineColor      := "Black"
                res@mpNationalLineColor         := "Black"
                res@mpUSStateLineColor          := "Black"
                res@mpLimbLineColor             := "Black"
                res@mpPerimLineColor            := "Black"
                res@mpGeophysicalLineThicknessF := 4.0 + a_c
                res@mpDataSetName               := "Earth..4"   ; This new database contains
                res@mpDataBaseVersion           := "MediumRes"  ; Medium resolution database
                res@mpOutlineOn                 := True         ; Turn on map outlines
                res@mpOutlineSpecifiers         := (/"Mexico:states","Cuba:Provinces", "United States:states"/)

                res@tmXBLabelFontHeightF        := 0.008
                res@tmYLLabelFontHeightF        := 0.008
                res@mpLimbLineThicknessF        := 2. + a_c
                res@mpNationalLineThicknessF    := 2. + a_c
                res@mpUSStateLineThicknessF     := 2. + a_c
                res@mpGridLineDashPattern       := 5                  ; lat/lon lines dashed
                res@mpGridLatSpacingF           := 5
                res@mpGridLonSpacingF           := 5
                res@tmXBMajorOutwardLengthF     := -9	; set tickmarks
                res@tmYLMajorOutwardLengthF     := -9; set tickmarks
                res@tmXBMinorOutwardLengthF     := -9
                res@tmYLMinorOutwardLengthF     := -9
                res@cnExplicitLabelBarLabelsOn   := True
                ;res@lbTitleFontHeightF           := .005                 ; make title smaller
                res@tmXBLabelDeltaF              := -2.3   ;Posicion de las etiquetas de eje x
                res@tmYLLabelDeltaF              := -3.5   ;Posicion de las estiquetas de eje y
                res@pmLabelBarOrthogonalPosF     := .010           ; move whole thing down

                res@gsnLeftStringOrthogonalPosF  := 0.005
                res@gsnRightStringOrthogonalPosF := 0.015

                res@lbLabelFontHeightF           := .009              ; default is HUGE
                res@gsnStringFontHeightF         :=  0.011
                res@tmXBLabelFont                := "Helvetica-Bold"
                res@tmYLLabelFont                := "Helvetica-Bold"


                ;Se quitan los contornos de los colores
                res@cnLinesOn                    = False

                ;Titulo del mapa
                ;res@tiMainString        :=  TITULO_MAPA(var) +arreglo_nombres(i) +" de " + mes +  " (1980-2016)"
                res@tiMainString        :=  TITULO_MAPA(var) + mes_str + " a  "  + alturas(j)+" m de 0:00 a "+arreglo_nombres(i) + " hrs"
                res@tiMainOffsetYF      := 0.0            ; Mueve el titutlo hacia arriba o hacia abajo
                res@tiMainPosition      :="Center"        ;Posicion del titulo
                ;res@tiMainOffsetXF      := -0.20           ; Mueve el titutlo hacia izquierda o derecha
                res@tiMainFontHeightF   := .012           ;Tamaño del titulo

                ;Limites del mapa
                limits :=(/min(LONGITUD), max(LONGITUD), min(LATITUD), max(LATITUD)/)

                res@mpLimitMode := "LatLon"
                res@mpMinLonF   := limits(0)
                res@mpMaxLonF   := limits(1)
                res@mpMinLatF   := limits(2)
                res@mpMaxLatF   := limits(3)

                ; --- TITULO DE BARRA DE COLOR
                ;unidad = VARIABLE@units
                ;nombre_variable_barra = VARIABLE@long_name
                VARIABLE@long_name := ""
                VARIABLE@units := ""

                res@cnFillOn                    := True         ; turn on color
                res@cnFillPalette               := paleta  ;set color map
                res@cnLinesOn                    := False                      ; turn off contour lines
                res@lbTitleString                := TITULO_BARRA(var)   ;nombre_variable_barra + " (" + unidad + ")"
                res@lbTitleFontHeightF           := .009                ; Tamaño del titulo de la barra
                ;res@lbTitlePosition              := "top"
                ;res@lbTitleDirection            := "Across"
                res@lbLabelAlignment             := "BoxCenters"       ; Centra la etiqueta de la barra
                res@pmLabelBarWidthF             := 0.52               ; Ancho de barra de color
                res@pmLabelBarHeightF            := 0.04               ; Alto de barra de color
                ;res@cnLevelSelectionMode         := "ManualLevels"      ; manually set cn levels
                ;res@cnMinLevelValF               := VALOR_MIN(var)                 ; min level
                ;res@cnMaxLevelValF               := VALOR_MAX(var)                 ; max level
                res@cnLevelSelectionMode         := "ExplicitLevels"    ; Permite poner los valores de los contornos de forma explicita
                                                                        ;que estan relacionados directamente con las divisiones de la
                                                                        ;barra de colores
                ;pows = ispan(0,3,0.5)
                ;levs = 10^pows
                ;res@cnLevels                     := (/0,5,10,20,30,40,50,60,70,80,90,100,200,300,500,800,1000/)
                ;res@cnLevels                     := (/0,1,2,3,4,5,10,15,20,40,80,100,200,400,600,800,1000/)
                ;res@cnLevels                     := (/1,3,5,10,15,20,30,35,40,50,100,150,200,300,400,500/)
                ;pres@cnLevels                     := (/1,2,4,6,8,10,15,20,30,40,50,60,70,80,90,100/)
                ;res@cnLevels                     := (/0.01,0.02,0.04,0.06,0.08,0.10,0.15,0.20,0.30,0.40,0.50,0.60,0.70,0.80,0.90,1.00,2.00,3.00,4.00,5.00,6.00,7.00,8.00,9.00,10.00,20.00,30.00,40.00,50.00,60,00,70.00,80.00,90.00,100.00/)
                ;res@cnLevels                     := (/0.001,0.002,0.004,0.006,0.008,0.010,0.015,0.020,0.030,0.040,0.050,0.060,0.070,0.080,0.090,0.100,0.200,0.300,0.400,0.500,0.600,0.700,0.800,0.900,1.000,2.000,3.000,4.000,5.000,6.000,7.000,8.000,9.000,10.000,20,30,40,50,60,70,80,90,100/)
                ;res@cnLevels                     := (/0.00001,0.00002,0.00004,0.00006,0.00008,0.00010,0.00015,0.00020,0.00030,0.00040,0.00050,0.00060,0.00070,0.00080,0.00090,0.00100,0.00200,0.00300,0.00400,0.00500,0.00600,0.00700,0.00800,0.00900,0.01000,0.02000,0.03000,0.04000,0.05000,0.06000,0.07000,0.08000,0.09000,1.000,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,20,30,40,50,60,70,80,90,100/)
                res@cnLevels                      :=(/0.0001,0.0002,0.0003,0.0004,0.0005,0.0006,0.0007,0.0008,0.0009,0.001,0.002,0.003,0.0035,0.004,0.005,0.006,0.0065,0.007,0.0075,0.008,0.0085,0.009,0.0095,0.010,0.015,0.02,0.25,0.03,0.035,0.04,0.05,0.06,0.7,0.8,0.9,1,2,3,4,5,6,7,8,9,10,20,50,60,80,100/)
                ;res@lbLabelStrings               := (/"","2","","6","","10","","20","","40","","50","80","","100","400"/)    ; Se define el arreglo con las etiquetas
                ;res@cnLevels                     := levs
                res@lbLabelFontHeightF           := .009      ; El tamaño fuente de las etiquetas de la barra de colores
                res@cnLevelSpacingF              := 0.5               ; contour level spacing


                mapa := gsn_csm_contour_map(wks,VARIABLE,res)

                ; setvalues wks
                ;     "wkBackgroundColor" : "blue"
                ; end setvalues

                ;Agregamos el shapefile de los rios
                lnres1                   := True
                lnres1@gsLineThicknessF  := 1.0
                lnres1@gsLineColor         := "blue"


                dumstr0 = unique_string("poly0")
                mapa@$dumstr0$ := gsn_add_shapefile_polylines(wks, mapa, lsf_name, lnres1)

                ; Agregamos el shapefile de la batimetría
                lnres                   := True
                lnres@gsLineThicknessF  := 1.0
                lnres@gsLineColor       := "grey58"


                dumstr1 = unique_string("poly")
                mapa@$dumstr1$ := gsn_add_shapefile_polylines(wks, mapa, shp1, lnres)

                draw(mapa)
                frame(wks)
                fname_jpg := ruta_completa + NOMBRE_FIGURA(var) + int_mes +"_"+ get_number(i*4) +"_"+ alturas(j)
                fname_png := ruta_salida + carpeta_png + NOMBRE_FIGURA(var) + int_mes +"_"+ get_number(i*4) +"_"+ alturas(j) + ".000002"


                convierte := "convert " + fname_png + ".png " +fname_jpg + ".jpg"
                system(convierte)
                recorta := "convert -quiet -crop 1024x910+0+50 +repage " +fname_jpg +".jpg " +fname_jpg+".jpg"
                system(recorta)
            end do
        end do
    end do
end
