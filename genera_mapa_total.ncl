load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
load "datosEntrada.ncl"

;------------------------------------------------------------------
; --- funcion que devuelve el dia y mes del año ---
function get_day_year(num_dia)
begin
    ;Arreglo de Meses
    meses = (/"enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"/)
    diasXmes = (/31,28,31,30,31,30,31,31,30,31,30,31/)
    mes = 0
    i = 0
    do while(num_dia .gt. diasXmes(i))
        num_dia = num_dia - diasXmes(i)
        mes = mes + 1
        i = i + 1
    end do
    cadena = sprintf("%02g", num_dia) + " de " + meses(i)
    return cadena
end

;--- Funcion que devuelve un arreglo de tipo string con
;--- las etiquetas del dia y mes
function create_array_string_day_month()
begin
    ;Se crea el arreglo que se devolvera
    labels_day_month = new (365, string, "")
    do k = 1, 365
        dia := k
        labels_day_month(k-1) = get_day_year(dia)
    end do
    return labels_day_month
end

;=========================================================================================
function get_number(number)
begin
    if (number .lt. 10) then
        return "0" + number
    else
        return number
    end if
end

function get_number_t(number)
begin
    if (number .lt. 100) then
        return "00" + number
    else
        return number
    end if
end
;==========================================================================================
begin

;Arreglo de Meses
meses = (/"enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"/)
;Arreglos de horas
horas_24 = (/"00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00"/)

horas_8 = (/"00:00", "03:00", "06:00", "09:00", "12:00", "15:00", "18:00", "21:00"/)


;variables para poner acentos
oacute  = "o~H-13V2F35~B~FV-2H3~"
aacute  = "a~H-13V2F35~B~FV-2H3~"
iacute  = "i~H-08V2F35~B~FV-2~"



ruta_salida = ruta_prefijo + carpeta_salida + "/"
carpeta_png = "png/"
carpeta_jpg = "jpg/" + nombre_ruta
;system("rm -rf " + ruta_salida)
;system("mkdir " + ruta_salida)
system("mkdir " + ruta_salida + carpeta_png + " & mkdir " + ruta_salida + carpeta_jpg)

;Archivo de donde se tomara la variable a graficar
f = addfile(ruta_archivo, "r")

shp1 = "isobatas/Isobatas.shp"
lsf_name = "isobatas/Rio.shp"

;Se obtiene la variable
ARR_VARIABLE =f->$nombre_variable$

;Inicializamos la variable dim_tiempo en 1 para que al menos se ejecute una vez
;en caso de que no se tenga la coordenada "time"
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
    arreglo_nombres = create_array_string_day_month()
else if(dim_tiempo .eq. 24) then
    arreglo_nombres = horas_24
    mes = mes_str
else if(dim_tiempo .eq. 8) then
    arreglo_nombres = horas_8
end if
end if
end if
end if

;Obtenemos las latitud y la longitud
LATITUD     =f->Latitude
LONGITUD    =f->Longitude


dim_vars = dimsizes(nombre_variable)
print(dimsizes(nombre_variable))


    do var = 0, (dim_vars - 1)

        ; Se extrae la paleta de colores
        paleta := asciiread(RUTA_PALETAS + PALETAS(var),-1,"string")
        dim_paleta := dimsizes(paleta)

        ;determina el espaciado en la paleta de colores
        ;espaciado = ceil(((VALOR_MAX(var) - VALOR_MIN(var)) / dim_paleta) * 10.0) / 10.0

        ;print(espaciado)

        do i = 0 , (dim_tiempo - 1)

            nombre = ruta_salida + carpeta_png + NOMBRE_FIGURA(var) + i
            wks_type = "png"
            ;wks_type@wkWidth = 1024
            ;wks_type@wkHeight = 1024
            wks := gsn_open_wks(wks_type,nombre)

            ;Tomamos la variable correspondiente
            VARIABLE := ARR_VARIABLE(i,:,:)
            VARIABLE(0,0) = 50.0



            a_c = 1

            res                             := True
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
            res@tiMainString        :=  TITULO_MAPA(var) +arreglo_nombres(i) +" GMT para " + mes_str +  " (1980-2016)"
            ;Titulo del mapa
            ;res@tiMainString        :=  TITULO_MAPA(var) +arreglo_nombres(i) +" de " + mes +  " (1980-2016)"
            ; if (i .eq. 23) then
            ;     res@tiMainString        :=  TITULO_MAPA(var) +arreglo_nombres(i)+" a las 00:00 GMT para " + mes_str +  " (1980-2016)"
            ; else
            ;     res@tiMainString        :=  TITULO_MAPA(var) +arreglo_nombres(i)+" a las "+arreglo_nombres(i + 1) +" GMT para " + mes_str +  " (1980-2016)"
            ; end if
            ;res@tiMainString        :=  TITULO_MAPA(var) +arreglo_nombres(i) + " (1980-2016)"
            res@tiMainOffsetYF      := 0.0            ; Mueve el titutlo hacia arriba o hacia abajo
            res@tiMainPosition      :="Center"        ;Posicion del titulo
            ;res@tiMainOffsetXF      := -0.20           ; Mueve el titutlo hacia izquierda o derecha
            res@tiMainFontHeightF   := .009           ;Tamaño del titulo

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


            if ((NOMBRE_FIGURA(var) .eq. "cm_prec_").or.(NOMBRE_FIGURA(var) .eq. "maxam_prec_").or.(NOMBRE_FIGURA(var) .eq. "maxpm_prec_").or.(NOMBRE_FIGURA(var) .eq. "ch_prec_")) then
                ;Barra de colores
                res@cnFillOn                    := True         ; turn on color
                res@cnFillPalette               := paleta  ;set color map

                ;Codigo a prueba
                res@cnLinesOn                    := False                      ; turn off contour lines
                res@lbTitleString                := TITULO_BARRA(var)   ;nombre_variable_barra + " (" + unidad + ")"
                res@lbTitleFontHeightF           := .009                ; Tamaño del titulo de la barra
                ;res@lbTitlePosition              := "top"
                ;res@lbTitleDirection            := "Across"
                ;res@lbLabelAlignment             := "BoxCenters"       ; Centra la etiqueta de la barra
                res@cnLabelBarEndStyle           := "IncludeMinMaxLabels"
                res@pmLabelBarWidthF             := 0.52               ; Ancho de barra de color
                res@pmLabelBarHeightF            := 0.04               ; Alto de barra de color
                print("cm_prec_")
                res@cnLevelSelectionMode         := "ExplicitLevels"    ; Permite poner los valores de los contornos de forma explicita
                                                                        ;que estan relacionados directamente con las divisiones de la
                                                                        ;barra de colores
                ;res@cnLevels                     := (/1,3,5,10,15,20,30,40,45,50,100,150,175,200,300,400,500/)   ; Definimos el numero de niveles y el número de elementos de
                ;res@cnExplicitLabelBarLabelsOn   := True                ; Habilitamos la opcion para poner las etiquetas de forma manual
                                                                        ;en la barra de colores
                ;res@lbLabelStrings               := (/"1","","3","5","10","15","20","30","40","50","100","150","200","300","400","500"/)    ; Se define el arreglo con las etiquetas
                res@cnLevels                     := (/1,2,3,4,5,10,15,20,30,40,50,100,150,200,300,400/)   ; Definimos el numero de niveles y el número de elementos de
                                                                                                         ;la barra de colores
                ;res@cnExplicitLabelBarLabelsOn   := True                ; Habilitamos la opcion para poner las etiquetas de forma manual
                                                                        ;en la barra de colores
                res@lbLabelStrings               := (/"0","1","2","3","4","5","10","15","20","30","40","50","100","150","200","300","400","500"/)    ; Se define el arreglo con las etiquetas
                res@lbLabelFontHeightF           := .0058
                res@lgTitleOn                   := True
                res@lgLabelFontHeightF           := .07
                res@cnLineThicknessF             := 4.


                ;Crea mapa
                mapa := gsn_csm_contour_map(wks,VARIABLE,res)           ; El tamaño fuente de las etiquetas de la barra de colores
            end if
            if ((NOMBRE_FIGURA(var) .eq. "cm_temp_").or.(NOMBRE_FIGURA(var) .eq. "maxam_temp_").or.(NOMBRE_FIGURA(var) .eq. "maxpm_temp_").or.(NOMBRE_FIGURA(var) .eq. "minam_temp_").or.(NOMBRE_FIGURA(var) .eq. "minpm_temp_").or.(NOMBRE_FIGURA(var) .eq. "ch_temp_")) then
                ;Barra de colores
                res@cnFillOn                    := True         ; turn on color
                res@cnFillPalette               := paleta  ;set color map

                ;Codigo a prueba
                res@cnLinesOn                    := False                      ; turn off contour lines
                res@lbTitleString                := TITULO_BARRA(var)   ;nombre_variable_barra + " (" + unidad + ")"
                res@lbTitleFontHeightF           := .009                ; Tamaño del titulo de la barra
                ;res@lbTitlePosition              := "top"
                ;res@lbTitleDirection            := "Across"
                ;res@lbLabelAlignment             := "BoxCenters"       ; Centra la etiqueta de la barra
                ;res@cnLabelBarEndStyle    = "IncludeMinMaxLabels"  ; turn on end labels
                res@pmLabelBarWidthF             := 0.52               ; Ancho de barra de color
                res@pmLabelBarHeightF            := 0.04               ; Alto de barra de color
                res@cnLevelSelectionMode         := "ManualLevels"      ; manually set cn levels
                res@cnMinLevelValF               := VALOR_MIN(var)                 ; min level
                res@cnMaxLevelValF               := VALOR_MAX(var)                 ; max level
                res@lbLabelFontHeightF           := .009      ; El tamaño fuente de las etiquetas de la barra de colores
                res@cnLevelSpacingF              := 1.0               ; contour level spacing
                res@cnExplicitLabelBarLabelsOn   := True                ; Habilitamos la opcion para poner las etiquetas de forma manual
                                                                        ; en la barra de colores
                ;res@lbLabelStrings               := (/"","","","","-10","","","","","","","","","","0","","","","","","","","","","10","","","","","","","","","","20","","","","","","","","","","30","","","","","","","","","","40","","","","","","","","","","","","","",""/)    ; Se define el arreglo con las etiquetas
                res@lbLabelStrings               := (/"","","","","-10","-10","","","","","","","","","0","","","","","","","","","","10","","","","","","","","","","20","","","","","","","","","","30","","","","","","","","","","40","","","","","","","","","","","","","",""/)    ; Se define el arreglo con las etiquetas
                res@lgTitleOn                   := True
                res@lgLabelFontHeightF           := .07
                res@cnLineThicknessF             := 4.


                ;Crea mapa
                mapa := gsn_csm_contour_map(wks,VARIABLE,res)
            end if
            if ((NOMBRE_FIGURA(var) .eq. "cm_rcorta_") .or. (NOMBRE_FIGURA(var) .eq. "maxam_rcorta_").or. (NOMBRE_FIGURA(var) .eq. "ch_rcorta_") ) then
                ;Barra de colores
                VARIABLE(0,0) = 100.0
                res@cnFillOn                    := True         ; turn on color
                res@cnFillPalette               := paleta  ;set color map
                ;res@cnConstFEnableFill           = True
                ;res@cnConstFLabelBackgroundColor = "transparent"         ; Default is white
                ;res@cnConstFLabelOn  = False

                ;Codigo a prueba
                res@cnLinesOn                    := False                      ; turn off contour lines
                res@lbTitleString                := TITULO_BARRA(var)   ;nombre_variable_barra + " (" + unidad + ")"
                res@lbTitleFontHeightF           := .009                ; Tamaño del titulo de la barra
                ;res@lbTitlePosition              := "top"
                ;res@lbTitleDirection            := "Across"
                ;res@lbLabelAlignment             := "BoxCenters"       ; Centra la etiqueta de la barra
                res@cnLabelBarEndStyle           := "IncludeMinMaxLabels"
                res@pmLabelBarWidthF             := 0.52               ; Ancho de barra de color
                res@pmLabelBarHeightF            := 0.04               ; Alto de barra de color
                print("cm_rcorta_")
                res@cnLevelSelectionMode         := "ManualLevels"      ; manually set cn levels
                res@cnMinLevelValF               := VALOR_MIN(var)                 ; min level
                res@cnMaxLevelValF               := VALOR_MAX(var)                 ; max level
                res@lbLabelFontHeightF           := .009      ; El tamaño fuente de las etiquetas de la barra de colores
                res@cnLevelSpacingF              := 50.0               ; contour level spacing
                ;res@cnLevelSpacingF              := 1.0               ; contour level spacing
                ;res@cnLevelSelectionMode         = "ExplicitLevels"    ; Permite poner los valores de los contornos de forma explicita
                                                                        ; que estan relacionados directamente con las divisiones de la
                                                                        ; barra de colores
                ;res@cnLevels                     = (/0,100,200,400,600,800,1000,1200/)   ; Definimos el numero de niveles y el número de elementos de
                                                                        ; la barra de colores
                res@cnExplicitLabelBarLabelsOn   = True                ; Habilitamos la opcion para poner las etiquetas de forma manual
                                                                        ; en la barra de colores
                res@lbLabelStrings               = (/"0","","","","200","","","","400","","","","600","","","","800","","","","1000","","","","1200","","","","",""/)
                res@lgTitleOn                   := True
                res@lgLabelFontHeightF           := .07
                res@cnLineThicknessF             := 4.


                ;Crea mapa
                mapa := gsn_csm_contour_map(wks,VARIABLE,res)
            end if
            if ((NOMBRE_FIGURA(var) .eq. "cm_hum_").or.(NOMBRE_FIGURA(var) .eq. "maxam_hum_").or.(NOMBRE_FIGURA(var) .eq. "ch_hum_")) then
                ;Barra de colores
                res@cnFillOn                    := True         ; turn on color
                res@cnFillPalette               := paleta  ;set color map

                ;Codigo a prueba
                res@cnLinesOn                    := False                      ; turn off contour lines
                res@lbTitleString                := TITULO_BARRA(var)   ;nombre_variable_barra + " (" + unidad + ")"
                res@lbTitleFontHeightF           := .009                ; Tamaño del titulo de la barra
                ;res@lbTitlePosition              := "top"
                ;res@lbTitleDirection            := "Across"
                ;res@lbLabelAlignment             := "BoxCenters"       ; Centra la etiqueta de la barra
                res@cnLabelBarEndStyle           := "IncludeMinMaxLabels"
                res@pmLabelBarWidthF             := 0.52               ; Ancho de barra de color
                res@pmLabelBarHeightF            := 0.04               ; Alto de barra de color
                print("cm_hum")
                res@cnLevelSelectionMode         := "ManualLevels"      ; manually set cn levels
                res@cnMinLevelValF               := VALOR_MIN(var)                 ; min level
                res@cnMaxLevelValF               := VALOR_MAX(var)                 ; max level
                res@lbLabelFontHeightF           := .009      ; El tamaño fuente de las etiquetas de la barra de colores
                ;res@cnLevelSpacingF              := 10.0
                ;res@cnLevelSpacingF              := 4.90
                res@cnLevelSpacingF              := 5.0
                ;res@cnExplicitLabelBarLabelsOn   = True                ; Habilitamos la opcion para poner las etiquetas de forma manual
                                                                        ; en la barra de colores
                res@lbLabelStrings               = (/"","30","","40","","50","","60","","70","","80","","90","","100"/)    ; Se define el arreglo con las etiquetas
                res@lgTitleOn                   := True
                res@lgLabelFontHeightF           := .07
                res@cnLineThicknessF             := 4.



                ;Crea mapa
                mapa := gsn_csm_contour_map(wks,VARIABLE,res)
            end if
            if ((NOMBRE_FIGURA(var) .eq. "cm_rlarga_").or.(NOMBRE_FIGURA(var) .eq. "maxam_rlarga_").or.(NOMBRE_FIGURA(var) .eq. "ch_rlarga_")) then
                ;Barra de colores
                res@cnFillOn                    := True         ; turn on color
                res@cnFillPalette               := paleta  ;set color map

                ;Codigo a prueba
                res@cnLinesOn                    := False                      ; turn off contour lines
                res@lbTitleString                := TITULO_BARRA(var)   ;nombre_variable_barra + " (" + unidad + ")"
                res@lbTitleFontHeightF           := .009                ; Tamaño del titulo de la barra
                ;res@lbTitlePosition              := "top"
                ;res@lbTitleDirection            := "Across"
                ;res@lbLabelAlignment             := "BoxCenters"       ; Centra la etiqueta de la barra
                ;res@cnLabelBarEndStyle           := "IncludeMinMaxLabels"
                res@pmLabelBarWidthF             := 0.52               ; Ancho de barra de color
                res@pmLabelBarHeightF            := 0.04               ; Alto de barra de color
                print("cm_rlarga")
                res@cnLevelSelectionMode         := "ManualLevels"      ; manually set cn levels
                ;res@cnLevels                     := (/-105,-100,-90,-80,-70,-60,-50,-40,-30,-20,-10,0,10,20,30,40,45/)
                res@cnMinLevelValF               := VALOR_MIN(var)                 ; min level
                res@cnMaxLevelValF               := VALOR_MAX(var)                 ; max level
                ;res@lbLabelFontHeightF           := .009      ; El tamaño fuente de las etiquetas de la barra de colores
                ;res@cnLevelSpacingF              := 10.0
                res@cnLevelSpacingF              := 10.0
                ;res@cnExplicitLabelBarLabelsOn   = True                ; Habilitamos la opcion para poner las etiquetas de forma manual
                                                                        ; en la barra de colores
                res@lbLabelStrings               = (/"-100","","-80","","-60","","-40","","-20","","0","","20","","40"/)
                res@lgTitleOn                   := True
                res@lgLabelFontHeightF           := .07
                res@cnLineThicknessF             := 4.


                ;Crea mapa
                mapa := gsn_csm_contour_map(wks,VARIABLE,res)
            end if
            if ((NOMBRE_FIGURA(var) .eq. "cm_evap_").or.(NOMBRE_FIGURA(var) .eq. "maxam_evap_").or.(NOMBRE_FIGURA(var) .eq. "ch_evap_")) then
                ;Barra de colores
                res@cnFillOn                    := True         ; turn on color
                res@cnFillPalette               := paleta  ;set color map

                ;Codigo a prueba
                res@cnLinesOn                    := False                      ; turn off contour lines
                res@lbTitleString                := TITULO_BARRA(var)   ;nombre_variable_barra + " (" + unidad + ")"
                res@lbTitleFontHeightF           := .009                ; Tamaño del titulo de la barra
                ;res@lbTitlePosition              := "top"
                ;res@lbTitleDirection            := "Across"
                ;res@lbLabelAlignment             := "BoxCenters"       ; Centra la etiqueta de la barra
                res@cnLabelBarEndStyle           := "IncludeMinMaxLabels"
                res@pmLabelBarWidthF             := 0.52               ; Ancho de barra de color
                res@pmLabelBarHeightF            := 0.04               ; Alto de barra de color
                print("cm_evap_")
                res@cnLevelSelectionMode         := "ExplicitLevels"    ; Permite poner los valores de los contornos de forma explicita
                                                                        ;que estan relacionados directamente con las divisiones de la
                                                                        ;barra de colores
                res@cnLevels                     := (/1,2,3,4,5,10,15,20,30,40,50,100,150,200,300,400/)   ; Definimos el numero de niveles y el número de elementos de
                                                                                                                                                                 ;la barra de colores
                ;res@cnExplicitLabelBarLabelsOn   := True                ; Habilitamos la opcion para poner las etiquetas de forma manual
                                                                                                                                ;en la barra de colores
                res@lbLabelStrings               := (/"0","1","2","3","4","5","10","15","20","30","40","50","100","150","200","300","400","500"/)    ; Se define el arreglo con las etiquetas
                res@lbLabelFontHeightF           := .0058
                res@lgTitleOn                   := True
                res@lgLabelFontHeightF           := .07
                res@cnLineThicknessF             := 4.


                ;Crea mapa
                mapa := gsn_csm_contour_map(wks,VARIABLE,res)           ; El tamaño fuente de las etiquetas de la barra de colores
            end if
            if ((NOMBRE_FIGURA(var) .eq. "cm_acl_").or.(NOMBRE_FIGURA(var) .eq. "maxam_acl_").or.(NOMBRE_FIGURA(var) .eq. "ch_acl_")) then
                ;Barra de colores
                res@cnFillOn                    := True         ; turn on color
                res@cnFillPalette               := paleta  ;set color map

                ;Codigo a prueba
                res@cnLinesOn                    := False                      ; turn off contour lines
                res@lbTitleString                := TITULO_BARRA(var)   ;nombre_variable_barra + " (" + unidad + ")"
                res@lbTitleFontHeightF           := .009                ; Tamaño del titulo de la barra
                ;res@lbTitlePosition              := "top"
                ;res@lbTitleDirection            := "Across"
                ;res@lbLabelAlignment             := "BoxCenters"       ; Centra la etiqueta de la barra
                ;res@cnLabelBarEndStyle           := "IncludeMinMaxLabels"
                res@pmLabelBarWidthF             := 0.52               ; Ancho de barra de color
                res@pmLabelBarHeightF            := 0.04               ; Alto de barra de color
                print("cm_acl")
                res@cnLevelSelectionMode         := "ManualLevels"      ; manually set cn levels
                res@cnMinLevelValF               := VALOR_MIN(var)                 ; min level
                res@cnMaxLevelValF               := VALOR_MAX(var)                 ; max level
                res@lbLabelFontHeightF           := .009      ; El tamaño fuente de las etiquetas de la barra de colores
                ;res@cnLevelSpacingF              := 350.0               ; contour level spacing
                res@cnLevelSpacingF              := 100.0               ; contour level spacing
                res@cnExplicitLabelBarLabelsOn   := True                ; Habilitamos la opcion para poner las etiquetas de forma manual
                                                                        ; en la barra de colores
                res@lbLabelStrings               := (/"","","","","500","","","","","1000","","","","","1500","","","","","2000","","","","","2500","","",""/)
                ;res@lbLabelFontHeightF           = .0058
                res@lgTitleOn                   := True
                res@lgLabelFontHeightF           := .07
                res@cnLineThicknessF             := 4.


                ;Crea mapa
                mapa := gsn_csm_contour_map(wks,VARIABLE,res)
            end if

            ; ;***********************************************
            ; lgres                    = True
            ; lgres@lgLineColors       = (/"black","blue"/)    ; colors for legend lines
            ; lgres@lgLineThicknessF   = (/res@cnLineThicknessF,res@cnLineThicknessF-2/)
            ; lgres@lgItemType         = "Lines"
            ; lgres@vpWidthF           = 0.07                   ; width of legend (NDC)
            ; lgres@lgLabelFontHeightF = .10            ;
            ; lgres@vpHeightF          = 0.06                   ; height of legend (NDC)
            ; lgres@lgPerimOn          = False                 ; turn off perimeter
            ; lgres@LineLengthPercent = 5
            ; lgres@lgDashIndexes      = (/0,0/)              ; dash indexes
            ;
            ; gsn_legend_ndc(wks,2,(/"  Pa"+iacute+"s","  Rio"/),0.30,0.050,lgres)
            ;setvalues wks
            ;    "wkBackgroundColor" : "azure2"
            ;end setvalues

            ; Agregamos el shapefile de los rios
            lnres1                   := True
            lnres1@gsLineThicknessF  := 1.0
            lnres1@gsLineColor         := "blue"


            dumstr0 = unique_string("poly0")
            mapa@$dumstr0$ := gsn_add_shapefile_polylines(wks, mapa, lsf_name, lnres1)

            ; Agregamos el shapefile de la batimetría
            lnres                   := True
            lnres@gsLineThicknessF  := 1.0
            lnres@gsLineColor       := "grey18"


            dumstr1 = unique_string("poly")
            mapa@$dumstr1$ := gsn_add_shapefile_polylines(wks, mapa, shp1, lnres)
            draw(mapa)
            frame(wks)



            fname_jpg := ruta_salida + carpeta_jpg + NOMBRE_FIGURA(var) +nombre_arc(n_mes)+ get_number(i)
            ;fname_jpg := ruta_salida + carpeta_jpg + NOMBRE_FIGURA(var) + get_number(i+1)
            fname_png := ruta_salida + carpeta_png + NOMBRE_FIGURA(var) + i + ".000002"

            convierte := "convert " + fname_png + ".png " +fname_jpg + ".jpg"
            system(convierte)
            recorta := "convert -quiet -crop 1024x910+0+50 +repage " +fname_jpg +".jpg " +fname_jpg+".jpg"
            system(recorta)

            ; cmd1 := "composite -compose atop -geometry 100x75+50+1025 logo_CIGoM_600px_negro.png "+fname_jpg+".jpg "+fname_jpg+".jpg"
            ; cmd2 := "composite -compose atop -geometry 75x75+150+1025 unam_negro.png "+fname_jpg+".jpg "+fname_jpg+".jpg"
            ; cmd3 := "composite -compose atop -geometry 75x75+825+1025 cca-negro.png "+fname_jpg+".jpg "+fname_jpg+".jpg"
            ; cmd4 := "composite -compose atop -geometry 75x75+915+1025 ioa-negro.png "+fname_jpg+".jpg "+fname_jpg+".jpg"
            ; cmd5 := " composite -compose atop -geometry 45x45+265+1035 fecha_n.png "+fname_jpg+".jpg "+fname_jpg+".jpg"
            ; system(cmd1)
            ; system(cmd2)
            ; system(cmd3)
            ; system(cmd4)
            ; system(cmd5)

        end do

    end do

end
