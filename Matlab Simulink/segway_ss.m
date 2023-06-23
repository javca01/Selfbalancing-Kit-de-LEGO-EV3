%Constantes
m=0.6;       %Masa del robot
M=0.2;       %Masa de las llantas
l=0.105;     %Distancia desde el eje de las llantas hasta el centro de masa del robot
g=9.81;      %Gravedad
r=0.0275;    %Radio de las llantas

%Modelo en espacio de estados
A=[0 1 0 0;0 0 (-m*g/M) 0;0 0 0 1;0 0 ((M+m)*g/(M*l)) 0];
B=[0;1/(M*r);0;-1/(M*l*r)];
C=[1 0 0 0;0 0 1 0];
D=[0;0];

sys=ss(A,B,C,D);

%Función de transferencia
systf=tf(sys);
[num1, den1] = tfdata(systf(1), 'v');    %Coeficientes TF X(s)/Torque(s)
[num2, den2] = tfdata(systf(2), 'v');    %Coeficientes TF Theta(s)/Torque(s)


%[num3, den3] = linmod('EV3_reducido');
%Planta_aumentada = tf(num3,den3);

%syms s kp ki
%Planta_aum_sym = poly2sym(num3, s) / poly2sym(den3, s);
%PI=kp+ki/s;

%G=Planta_aum_sym*PI;
%G_0=G/(1+G);
%G_0=simplify(G_0)

