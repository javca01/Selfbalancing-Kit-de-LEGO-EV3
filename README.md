
Universidad Nacional de Colombia

Fundamentos de Robótica Móvil

Autores:
- Javier Caicedo Pedrozo
- Santiago Hernandez Lamprea
- Diego Fabian Osorio Fonseca

 # Selfbalancing con LEGO EV3 

## Objetivos:

* Definir el modelo matemático de un sistema selfbalancing a partir de la descripción física de un péndulo invertido.

* Diseñar un controlador PID que permita mantener el cuerpo del robot de forma vertical apoyado sobre las dos ruedas.

* Validar experimentalmente el controlador diseñado para comprobar el funcionamiento del sistema selfbalancing sobre un LEGO EV3.
  
* Complementar el selfbalancing con módulos adicionales que le permitan al robot ser comandado por control remoto, seguir una línea blanca sobre fondo negro y subir por una pendiente no mayor al 2%.


## Construcción del robot:
Para la construcción del robot se siguió la guía original de Lego para armar el Gyro Boy [1], aunque se hicieron algunas variantes, donde no se le dió movimiento a las extremidades superiores, y a una de ellas se le quitó uno de los sensores. Además, se creó un soporte inferior para colocar el sensor de color, que nos permite sensar el suelo para hacer el seguidor de línea.

La configuración del robot es la siguiente: se cuenta con dos ruedas que comparten eje, pero cada una tiene su propia tracción (segway). Sobre estas ruedas se debe sostener el robot, por lo que se debe programar un sistema de control que mantenga el equilibrio del robot. Este no lo puede hacer por sí solo, debido a que su apoyo será únicamente los puntos de las ruedas que hacen contacto sobre el suelo, y además estas ruedas van a tender a girar. Para hacer el movimiento de este robot, se usa un control remoto que envía señales infrarrojas a un receptor conectado al robot. Con este mando remoto se varía la orientación y velocidad del robot.

De esta manera, se usan los siguientes actuadores y sensores:

* 2 Motores grandes (con encoders incluidos)
* Control remoto infrarrojo
* Sensor Infrarrojo
* Gyro Sensor
* Sensor de color

## Modelo del sistema

Para realizar el modelamiento de este robot se hizo un análisis que resulta muy aproximado y conveniente correspondiente al de un péndulo invertido, como se muestra en la siguiente figura: 

<p align="center"><img src="https://i.postimg.cc/j5dFZvFX/Pendulo-invertido.png"></p>

Para hacer el análisis más simple, podemos dividir el cuerpo en dos partes de donde se obtienen los diagramas de cuerpo libre a continuación. Allí aparecen dos fuerzas de reacción, una en cada dirección. Así, se obtienen las ecuaciones de movimiento que se muestran:

<p align="center"><img src="https://i.postimg.cc/ZR7Dgpkh/DCL-Cuerpo.png"></p>

<p align="center"><img src="https://i.postimg.cc/FzYnQzmk/DCL-Base.png"></p>


Como podemos observar, las ecuaciones diferenciales obtenidas no son lineales, lo que hace más complejo el sistema. Para esto, vamos a hacer una linealización teniendo en cuenta que como el robot se debe mantener vertical, el ángulo  siempre va a estar en valores cercanos a 0. De esta manera,
<p align="center"><img src="https://i.postimg.cc/wMqSrfKB/linealizadas-2.png"></p>

Ahora tenemos que eliminar las fuerzas V y H reemplazando (2) en (4) y (3), (2) en (1). Luego de simplificar obtenemos:
<p align="center"><img src="https://i.postimg.cc/s2G6vPc2/ecuaciones-simple.png"></p>

## Espacio de estados

Para crear el modelo del sistema en Matlab, vamos a usar el espacio de estado. Para hacer esto, vamos a usar las ecuaciones diferenciales (5) y (6) y las vamos a reescribir para que nos sea más fácil definir las matrices. Además vamos a hacer otra simplificación, como el robot es pequeño, y por tanto su masa y longitud son pequeñas, entonces vamos a asumir el momento de Inercia del péndulo con respecto a su centro de masa como 0 (I=0). De esta manera, obtenemos la siguientes ecuaciones:

Simplificando:

<p align="center"><img src="https://i.postimg.cc/sfmcf0rc/ecuaciones-finales.png"></p>

Por otro lado, en el modelo pusimos la entrada como una fuerza aplicada en el centro de la rueda, pero lo que queremos controlar es el torque del motor, por lo que nuestra entrada la tenemos que dividir por el radio, por eso ponemos un factor 1/r en la matriz B que multiplica la entrada. De esta manera, si definimos los estados como se muestra en la imagen de abajo, y escogemos las salidas como la posición del robot y el ángulo de péndulo, obtenemos el siguiente sistema:

<p align="center"><img src="https://i.postimg.cc/XvDLWsyJ/espacio-de-estados-2.png"></p>

## Diseño del controlador
Se propone un lazo cerrado de control el cual incluye en el lazo directo inmediatamente después del restador el bloque PID, el cual incluye las constantes proporcional, integral y derivativa que ponderan la acción de control resultante, dicho bloque fue sintonizado con la ayuda de las herramientas del Control System Toolbox, posteriormente, se tiene el bloque de la planta y es designado con el nombre de EV3 Balancer, este recibe como entrada el torque y arroja como salida la posición lineal y angular, las cuales son retroalimentadas, luego de obtener la velocidad y angular por medio de los bloques derivativos y compensados a a través de las ganancias Gain_motor_position, Gain_Motor_Speed, Gain_Angle, Gain_Angular_Velocity, las cuales fueron obtenidas experimentalmente. El lazo de control previamente comentado se observa abajo.

<p align="center"><img src="https://i.postimg.cc/25n4vqNm/control-PID.png"></p>

## Simulaciones

El controlador fue puesto a prueba a través de una referencia definida como un perfil trapezoidal, encontrando que el controlador permite seguir de manera eficiente la referencia y manteniendo una desviación muy baja del bloque, entre -0,7 y 0,7° respecto a la vertical, tal como se observa en la imagen de abajo.
<p align="center"><img src="https://i.postimg.cc/5yDK9JN7/Simulaci-n-Balancer-Simulink.png"></p>


## Video de funcionamiento
El sistemas Selfbalancing desarrollado sobre el robot EV3 bajo el montaje Gyro boy, fue puesto a prueba en diferentes escenarios con el ánimo de validar su desempeño, de esta manera, se condujo el robot a través de un laberinto usando el control remoto, en este mismo escenario el robot siguió adecuadamente una línea blanca sobre fondo negro haciendo uso del sensor de color, y finalmente se colocó el robot sobre una máquina trotadora para que venciera la pendiente de la banda la cual es de aproximadamente de 2%. Cabe resaltar, que en todos los casos antes expuestos el robot ejecuta su función principal de selfbalanciing.

<p>El video de funcionamiento puede apreciarse a través del siguiente enlace: <a href="https://www.youtube.com/watch?v=j_1jOWG-_PM"><img src="https://i.postimg.cc/5977gB14/Segway-EV3-en-rampa.png" alt="Selfbalancing EV3" title="Selfbalancing EV3" width="118" height="70"></a></p>

## Instrucciones para controlar el roboto con el control remoto.
Dando [clic aquí](Instrucciones.md) podrás ir a la página donde se explican los comandos del control IR para poder manejar el robot.

## Referencias
[1] LEGO. (N.R). EV3 model core set gyro boy. Recuperado de: https://education.lego.com/v3/assets/blt293eea581807678a/blt9b683d3a8c4c4078/5f8801eba0ee6b216678e013/ev3-model-core-set-gyro-boy.pdf

[2] Triviño, L. (2020). Modelado, simulación y control de un péndulo invertido. Recuperado de: https://ddd.uab.cat/pub/tfg/2020/234238/TFG_LuisGeovannyTrivinoMacias.pdf

[3] Canal mqc mechatronics. (video). Pendulo invertido-ecuaciones diferenciales. Recuperado de: https://www.youtube.com/watch?v=cvKCe4revsE

[4] Canal mqc mechatronics. (video). Modelamiento en espacio de estados - pendulo invertido. Recuperado de: https://www.youtube.com/watch?v=NpbkMvlMmzE


