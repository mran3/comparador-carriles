;Valores por defecto:
;velocidad-carros  ;http://www.eltiempo.com/bogota/trancones-en-bogota-hora-y-media-para-desplazarse-en-la-ciudad/15188055 Vel. media: 19,3 Km/h
;velocidad-ciclas 1.4 ; http://www.ehowenespanol.com/velocidad-media-bicicleta-info_37212/ ; vel. media: 14Km/h
;velocidad-buses 0.95 ; http://www.eltiempo.com/bogota/resultados-de-la-eliminacion-del-reversible-en-la-carrera-septima/15063575 ; Haciendo ajuste a esta velocidad para modelar tiempo de paradas asumiendo un gasto de 2min / Km. recorrido resulta velocidad de 9.5Km/h

globals [pasajeros-ciclas
  pasajeros-carros
  pasajeros-buses]
  ;velocidad-carros
  ;velocidad-ciclas
  ;velocidad-buses]

breed [carros carro]
breed [ciclas cicla]
breed [ciclas2 cicla2]
breed [buses bus]

turtles-own [
  distancia-recorrida
]

to configurar
  ca
  reset-ticks
 
  
  ask patches [set pcolor green
    if (pycor > 4) and (pycor < 10) [ set pcolor gray ]
    if (pycor > -3) and (pycor < 3) [ set pcolor gray + 3 ]
    if (pycor > -10) and (pycor < -4) [ set pcolor gray ]
    ]
;  set-current-plot "pasajeros-movilizados"
  create-carros numero-carros [set shape "car side" set size 3.8 set ycor 7 set heading 90 set xcor random-xcor]
  create-ciclas numero-ciclas-carril [set shape "bike" set size 1.9 set ycor 1.5 set heading 90 set xcor random-xcor]
  create-ciclas2 numero-ciclas-carril [set shape "bike2" set size 1.9 set ycor -1 set heading 90 set xcor random-xcor]
  create-buses numero-buses [set shape "bus" set size 6 set ycor -7 set heading 90 set xcor random-xcor]
  ask carros [ separarVehiculos 3.7 ]
  ask ciclas [ separarVehiculos 1.8 ]
  ask ciclas2 [ separarVehiculos 1.8 ]
  ask buses [ separarVehiculos 6 ]

end
to inicializar

end
to comenzar
  tick
  ask turtles [ set heading 90 ]  

  ask ciclas [
      if incrementar-distancia velocidad-ciclas
        [set pasajeros-ciclas pasajeros-ciclas + 1]
     ] 
   ask ciclas2 [
      if incrementar-distancia (velocidad-ciclas * -1)
        [set pasajeros-ciclas pasajeros-ciclas + 1]
     ] 
  ask carros [
    if incrementar-distancia velocidad-carros
      [set pasajeros-carros pasajeros-carros + pasajeros-x-carro]
  ] 
  ask buses [
      if incrementar-distancia velocidad-buses
        [set pasajeros-buses pasajeros-buses + pasajeros-x-bus]
    ]
  
 update-plots
 wait .1
end

to-report incrementar-distancia[velocidad]
  fd ( velocidad / 10 )
  if velocidad < 0 [
    set velocidad (velocidad * -1)]
  set distancia-recorrida distancia-recorrida + velocidad
    ifelse distancia-recorrida >= distancia-viaje-km[ ;http://www.movilidadbogota.gov.co/hiwebx_archivos/ideofolio/02-MovilidadyDesarrolloSostenible_14_53_49.pdf Distancia promedio bogotano al trabajo ida y vuelta es alrededor de 20Km
      set distancia-recorrida 0
      report true
    ] [report false]
end  

to separarVehiculos [separacion]
    if any? other turtles in-radius separacion
    [ fd separacion
      separarVehiculos separacion ]
end
@#$#@#$#@
GRAPHICS-WINDOW
206
10
983
366
29
12
13.0
1
10
1
1
1
0
1
1
1
-29
29
-12
12
0
0
1
horas
30.0

BUTTON
13
10
101
43
NIL
configurar
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
114
10
199
43
NIL
comenzar
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
13
53
185
86
numero-carros
numero-carros
0
10
10
1
1
NIL
HORIZONTAL

SLIDER
13
137
185
170
numero-buses
numero-buses
0
6
6
1
1
NIL
HORIZONTAL

SLIDER
13
95
185
128
numero-ciclas-carril
numero-ciclas-carril
0
20
18
1
1
NIL
HORIZONTAL

PLOT
992
10
1318
213
pasajeros-movilizados-todos
tiempo
numero
0.0
10.0
0.0
200.0
true
true
"" ""
PENS
"carros" 1.0 0 -2674135 true "" "plot pasajeros-carros"
"ciclas" 1.0 0 -10899396 true "" "plot pasajeros-ciclas"
"buses" 1.0 0 -13345367 true "" "plot pasajeros-buses"

MONITOR
204
394
310
439
NIL
pasajeros-carros
2
1
11

MONITOR
326
394
427
439
NIL
pasajeros-ciclas
2
1
11

INPUTBOX
16
178
106
238
pasajeros-x-carro
1.4
1
0
Number

INPUTBOX
108
178
197
238
pasajeros-x-bus
16
1
0
Number

PLOT
991
226
1319
443
pasajeros-movilizados-ciclas-carros
tiempo
numero
0.0
500.0
0.0
500.0
true
true
"" ""
PENS
"ciclas" 1.0 0 -10899396 true "" "plot pasajeros-ciclas"
"carros" 1.0 0 -5298144 true "" "plot pasajeros-carros"

SLIDER
17
247
189
280
distancia-viaje-km
distancia-viaje-km
0
100
20
1
1
NIL
HORIZONTAL

SLIDER
19
297
191
330
velocidad-carros
velocidad-carros
0
100
36
1
1
NIL
HORIZONTAL

SLIDER
20
338
192
371
velocidad-ciclas
velocidad-ciclas
0
40
14
1
1
NIL
HORIZONTAL

SLIDER
20
378
192
411
velocidad-buses
velocidad-buses
0
80
8
1
1
NIL
HORIZONTAL

MONITOR
441
395
545
440
NIL
pasajeros-buses
2
1
11

@#$#@#$#@
## ¿QUÉ ES?

Este modelo compara la capacidad de transportar pasajeros a través de bicicleta, auto o bus. Cada uno de estos medios de transporte tiene a su disposición un carril de vía de
las mismas dimensions.

## ¿CÓMO FUNCIONA?

Se pueden configurar diferentes parámetros para cada medio de transporte a través de
los deslizadores, y ver el impacto que esto tiene en el número de pasajeros transportados.

## ¿CÓMO USARLO?

No puede haber más del doble de carros que de ciclas, puesto que longitud promedio de carro es de más de 4.0 metros y de bicicleta 1.8 metros. No cabrían esa cantidad de carros en la vía.

No puede haber más del doble de buses que de carros, puesto que longitud promedio de bus es de más de 12.0 metros y de carro 4 metros. No cabrían esa cantidad de buses en la vía.

-Largo promedio carro:
http://en.wikipedia.org/wiki/Family_car
-Largo promedio bicicleta:
http://pccsc.net/bicycle-parking-info/ 

## TENER EN CUENTA

El modelo funciona con velocidades promedio, sin embargo, bajo diferentes situaciones
como una vía despejada, un medio de transporte específico en la realidad puede tener una velocidad considerablemente diferente a la velocidad promedio.

## CREDITOS

Modelo realizado en el marco de la materia Modelos y Simulación - 2015-I de la Universidad Nacional de Colombia.
-Andrés Acevedo
-Oscar Dussan
-Nestor Daniel Moncada
-Fernando Villanueva

## LICENCIA

Este modelo y su código fuente se distribuye bajo los términos de la licencia LGPL.
http://www.gnu.org/licenses/lgpl-3.0.en.html
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

b1
false
2
Circle -7500403 true false 45 165 88
Circle -7500403 true false 180 165 88
Line -7500403 false 225 195 180 135
Line -7500403 false 135 165 195 150
Line -7500403 false 135 210 135 165
Line -7500403 false 60 210 135 165
Line -7500403 false 165 135 210 135
Line -7500403 false 135 210 195 150
Rectangle -7500403 true false 120 150 150 165
Rectangle -7500403 true false 135 195 150 210

bee
true
0
Polygon -1184463 true false 152 149 77 163 67 195 67 211 74 234 85 252 100 264 116 276 134 286 151 300 167 285 182 278 206 260 220 242 226 218 226 195 222 166
Polygon -16777216 true false 150 149 128 151 114 151 98 145 80 122 80 103 81 83 95 67 117 58 141 54 151 53 177 55 195 66 207 82 211 94 211 116 204 139 189 149 171 152
Polygon -7500403 true true 151 54 119 59 96 60 81 50 78 39 87 25 103 18 115 23 121 13 150 1 180 14 189 23 197 17 210 19 222 30 222 44 212 57 192 58
Polygon -16777216 true false 70 185 74 171 223 172 224 186
Polygon -16777216 true false 67 211 71 226 224 226 225 211 67 211
Polygon -16777216 true false 91 257 106 269 195 269 211 255
Line -1 false 144 100 70 87
Line -1 false 70 87 45 87
Line -1 false 45 86 26 97
Line -1 false 26 96 22 115
Line -1 false 22 115 25 130
Line -1 false 26 131 37 141
Line -1 false 37 141 55 144
Line -1 false 55 143 143 101
Line -1 false 141 100 227 138
Line -1 false 227 138 241 137
Line -1 false 241 137 249 129
Line -1 false 249 129 254 110
Line -1 false 253 108 248 97
Line -1 false 249 95 235 82
Line -1 false 235 82 144 100

bike
false
1
Line -7500403 false 137 183 72 184
Circle -7500403 false false 65 184 22
Circle -7500403 false false 128 187 16
Circle -16777216 false false 177 148 95
Circle -16777216 false false 174 144 102
Circle -16777216 false false 24 144 102
Circle -16777216 false false 28 148 95
Polygon -2674135 true true 225 195 210 90 202 92 203 107 108 122 93 83 85 85 98 123 89 133 75 195 135 195 136 188 86 188 98 133 206 116 218 195
Polygon -2674135 true true 92 83 136 193 129 196 83 85
Polygon -2674135 true true 135 188 209 120 210 131 136 196
Line -7500403 false 141 173 130 219
Line -7500403 false 145 172 134 172
Line -7500403 false 134 219 123 219
Polygon -16777216 true false 113 92 102 92 92 97 83 100 69 93 69 84 84 82 99 83 116 85
Polygon -7500403 true false 229 86 202 93 199 85 226 81
Rectangle -16777216 true false 225 75 225 90
Polygon -16777216 true false 230 87 230 72 222 71 222 89
Circle -7500403 false false 125 184 22
Line -7500403 false 141 206 72 205

bike2
false
1
Line -7500403 false 163 183 228 184
Circle -7500403 false false 213 184 22
Circle -7500403 false false 156 187 16
Circle -16777216 false false 28 148 95
Circle -16777216 false false 24 144 102
Circle -16777216 false false 174 144 102
Circle -16777216 false false 177 148 95
Polygon -2674135 true true 75 195 90 90 98 92 97 107 192 122 207 83 215 85 202 123 211 133 225 195 165 195 164 188 214 188 202 133 94 116 82 195
Polygon -2674135 true true 208 83 164 193 171 196 217 85
Polygon -2674135 true true 165 188 91 120 90 131 164 196
Line -7500403 false 159 173 170 219
Line -7500403 false 155 172 166 172
Line -7500403 false 166 219 177 219
Polygon -16777216 true false 187 92 198 92 208 97 217 100 231 93 231 84 216 82 201 83 184 85
Polygon -7500403 true false 71 86 98 93 101 85 74 81
Rectangle -16777216 true false 75 75 75 90
Polygon -16777216 true false 70 87 70 72 78 71 78 89
Circle -7500403 false false 153 184 22
Line -7500403 false 159 206 228 205

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

bus
false
0
Polygon -7500403 true true 15 206 15 150 15 120 30 105 270 105 285 120 285 135 285 206 270 210 30 210
Rectangle -16777216 true false 36 126 231 159
Line -7500403 false 60 135 60 165
Line -7500403 false 60 120 60 165
Line -7500403 false 90 120 90 165
Line -7500403 false 120 120 120 165
Line -7500403 false 150 120 150 165
Line -7500403 false 180 120 180 165
Line -7500403 false 210 120 210 165
Line -7500403 false 240 135 240 165
Rectangle -16777216 true false 15 174 285 182
Circle -16777216 true false 48 187 42
Rectangle -16777216 true false 240 127 276 205
Circle -16777216 true false 195 187 42
Line -7500403 false 257 120 257 207

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

car side
false
0
Polygon -7500403 true true 19 147 11 125 16 105 63 105 99 79 155 79 180 105 243 111 266 129 253 149
Circle -16777216 true false 43 123 42
Circle -16777216 true false 194 124 42
Polygon -16777216 true false 101 87 73 108 171 108 151 87
Line -8630108 false 121 82 120 108
Polygon -1 true false 242 121 248 128 266 129 247 115
Rectangle -16777216 true false 12 131 28 143

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
