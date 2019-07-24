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


function get_magnitud(U, V)
begin
    MAGNITUD = sqrt(U^2 + V^2)
    return MAGNITUD
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
carpeta_png = "/png/"
;carpeta_jpg = "/jpg/Promedio_maximo_mes/viento/"
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
else if(dim_tiempo .eq. 8) then
    arreglo_nombres = horas_8
end if
end if
end if
end if


dim_vars = dimsizes(nombre_variable)
print(dimsizes(nombre_variable))

    do var =0, (dim_vars -1)

        paleta := asciiread(RUTA_PALETAS + PALETAS(var),-1,"string")
        dim_paleta := dimsizes(paleta)

        do i =0, (dim_tiempo -1)

            nombre = ruta_salida + carpeta_png + NOMBRE_FIGURA(var) + i
            wks_type = "png"
            wks_type@wkWidth = 1024
            wks_type@wkHeight = 1024
            wks := gsn_open_wks(wks_type,nombre)

            ;Obtenemos las latitud y la longitud
            LATITUD     =f->Latitude
            LONGITUD    =f->Longitude
            U_aux = f->U10(i,:,:)                 ;Enero
            U = (/U_aux/)
            V_aux = f->V10(i,:,:)
            V = (/V_aux/)

            VARIABLE := ARR_VARIABLE(i,:,:)


            ; dimensiones = dimsizes(U)
            ; MAGNITUD = new ((/dimensiones(0), dimensiones(1)/), float)
            ; MAGNITUD(:,:) = 0.0
            ;
            ; MAGNITUD@time  = 0
            ; MAGNITUD@units         = "m s-1"
            ; MAGNITUD@standard_name = "wind_speed"
            ; MAGNITUD@long_name     = "wind velocity"
            ; MAGNITUD@description   = "Velocidad del viento"
            ;
            ; MAGNITUD!0="Latitude"
            ; MAGNITUD&Latitude = (/LATITUD/)
            ; MAGNITUD&Latitude@units = "degrees_north"
            ; MAGNITUD&Latitude@standard_name =  "latitude"
            ;
            ; MAGNITUD!1="Longitude"
            ; MAGNITUD&Longitude = (/LONGITUD/)
            ; MAGNITUD&Longitude@units = "degrees_east"
            ; MAGNITUD&Longitude@standard_name =  "longitude"
            ;
            ; MAGNITUD = sqrt(U^2 + V^2)

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

            ;Titulo del mapa
            res@tiMainString        :=  TITULO_MAPA(var) + arreglo_nombres(i) + " (1980-2016)"
            ;res@tiMainString        :=  TITULO_MAPA(var) +arreglo_nombres(i) +" GMT para " + mes_str +  " (1980-2016)"
            res@tiMainOffsetYF      := 0.0            ; Mueve el titutlo hacia arriba o hacia abajo
            res@tiMainPosition      :="Center"        ;Posicion del titulo
            ;res@tiMainOffsetXF      := -0.20           ; Mueve el titutlo hacia izquierda o derecha
            res@tiMainFontHeightF   := .010            ;Tamaño del titulo

            ;Limites del mapa
            limits :=(/min(LONGITUD), max(LONGITUD), min(LATITUD), max(LATITUD)/)

            res@mpLimitMode := "LatLon"
            res@mpMinLonF   := limits(0)
            res@mpMaxLonF   := limits(1)
            res@mpMinLatF   := limits(2)
            res@mpMaxLatF   := limits(3)


            VARIABLE@long_name := ""
            VARIABLE@units := ""

            ; MAGNITUD@long_name := ""
            ; MAGNITUD@units = ""
            ; unidad = MAGNITUD@units

            res@cnFillOn                    := True         ; turn on color
            res@cnFillPalette               := paleta  ;set color map
            res@cnLinesOn                    := False                      ; turn off contour lines
            res@lbTitleString                := TITULO_BARRA(var)   ;nombre_variable_barra + " (" + unidad + ")"
            res@lbTitleFontHeightF           := .009                ; Tamaño del titulo de la barra
            ;res@lbTitlePosition              := "top"
            ;res@lbTitleDirection            := "Across"
            ;res@lbLabelAlignment             := "BoxCenters"       ; Centra la etiqueta de la barra
            res@cnLabelBarEndStyle           := "IncludeMinMaxLabels"
            res@pmLabelBarWidthF             := 0.52               ; Ancho de barra de color
            res@pmLabelBarHeightF            := 0.04               ; Alto de barra de color
            res@cnLevelSelectionMode         := "ManualLevels"      ; manually set cn levels
            res@cnMinLevelValF               := VALOR_MIN(var)                 ; min level
            res@cnMaxLevelValF               := VALOR_MAX(var)                 ; max level
            res@lbLabelFontHeightF           := .009      ; El tamaño fuente de las etiquetas de la barra de colores
            res@cnLevelSpacingF              := 1.0               ; contour level spacing
            res@lbLabelStrings               = (/"0","","","","","","","","","","10","","","","","","","","","","20","","","","","","","","","","30","31","","","","","","","","","40","","","","","","","","","","50","","","","","","","","","","60","","","","","","","","","","70"/)
            ;v = ""
            ;do n = 0, 83
            ;    valor = (255/83)*n
            ;    v = v + "~C~ " +valor
            ;    ;print(valor)
            ;end do
            ;print(v)
            ;print("_____________________")

            ; vec_res                    := True
            ; vec_res@gsnDraw         = False
            ; vec_res@gsnFrame        = False
            ; vec_res@tfDoNDCOverlay  = True
            ; vec_res@vcGlyphStyle = "WindBarb"
            ; vec_res@vcRefLengthF = 0.025;0.09
            ; vec_res@vcMinDistanceF          = 0.020               ; distance between ticks
            ; vec_res@vcVectorDrawOrder         = "PostDraw"
            ; vec_res@vcLineArrowColor        = "dodgerblue4"
            ;
            mapa := gsn_csm_contour_map(wks,VARIABLE,res)
            ;mapa = gsn_csm_contour_map(wks,MAGNITUD,res)
            ; vector = gsn_csm_vector(wks,U,V,vec_res)


            ; Agregamos el shapefile de los rios
            lnres1                   := True
            lnres1@gsLineThicknessF  := 1.0
            ;lnres1@gsLineColor         := "lightskyblue3"
            lnres1@gsLineColor         := "steelblue2"


            dumstr0 = unique_string("poly0")
            mapa@$dumstr0$ := gsn_add_shapefile_polylines(wks, mapa, lsf_name, lnres1)

            ; Agregamos el shapefile de la batimetría
            lnres                   := True
            lnres@gsLineThicknessF  := 1.0
            lnres@gsLineColor       := "grey58"
            ;lnres@gsLineColor       := "slategray"


            dumstr1 = unique_string("poly")
            mapa@$dumstr1$ := gsn_add_shapefile_polylines(wks, mapa, shp1, lnres)

            ;overlay(mapa,vector)
            draw(mapa)
            frame(wks)

            ;fname_jpg := ruta_salida + carpeta_jpg + NOMBRE_FIGURA(var) +nombre_arc(n_mes)+ get_number(i)
            fname_jpg := ruta_salida + carpeta_jpg + NOMBRE_FIGURA(var) + get_number(i+1)
            fname_png := ruta_salida + carpeta_png + NOMBRE_FIGURA(var) + i + ".000002"

            convierte := "convert " + fname_png + ".png " +fname_jpg + ".jpg"
            system(convierte)
            recorta := "convert -quiet -crop 1024x910+0+50 +repage " +fname_jpg +".jpg " +fname_jpg+".jpg"
            system(recorta)
        end do
    end do
end
