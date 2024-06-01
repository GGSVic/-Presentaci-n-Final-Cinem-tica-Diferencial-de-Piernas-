%Limpieza de pantalla
clear all
close all
clc

%Calculamos las matrices de transformación homogénea

%Posición inicial
H0 = SE3(rotx(-pi), [3 3 11]);

%Movmos a la siguiente posición: 
H1 = SE3(rotx(pi), [3 1 9]); 

H2 = SE3(rotx(-345*pi/180), [0 0 0]);

H3 = SE3(roty(-pi/2), [0 0 0]); 

H4 = SE3([3.5 0 0]); 

H5 = SE3(roty(-pi/2)*rotz(pi/2) , [3.5 0 0]); 

H6 = SE3([2 0 0]); 

%Movimiento -> Traslación en X
%Movimiento -> Traslación en X y Rotación en Z



H20 = H1*H2;
H30 = H20*H3;  %Matriz de transformación homogenea global de 3 a 0 
H40 = H30*H4; 
H50 = H40*H5; 
H60 = H50*H6; 

%Coordenadas de la estructura de translación y rotación
x=[3  3  3  3];
y=[3  1  2.812 0.8799];
z=[11  9  2.239 1.721];

plot3(x, y, z,'LineWidth', 1.5); axis([-3 6 -3 6 -1 12]); grid on;
hold on;

%Graficamos la trama absoluta o global 
trplot(H0,'rgb','axis', [-1 4 -1 6 -1 2])
% 
% %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H0, H1,'rgb','axis', [-1 4 -1 6 -1 2])
% %Realizamos una animación para la siguiente trama
 pause;
 tranimate(H1, H20,'rgb','axis', [-1 4 -1 6 -1 2])
% % %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H20, H30,'rgb','axis', [-1 4 -1 6 -1 2])
 pause; 
 tranimate(H30, H40,'rgb','axis', [-1 4 -1 6 -1 2])
 pause; 
 tranimate(H40, H50,'rgb','axis', [-1 4 -1 6 -1 2])
 pause; 
 tranimate(H50, H60,'rgb','axis', [-1 4 -1 6 -1 2])
 disp(H60)

  