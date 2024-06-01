%Limpieza de pantalla
clear all
close all
clc

%Calculamos las matrices de transformación homogénea

%Para colocar al sistema en el punto de origen será necesario realizar una
%doble rotación: 

initial_rotation = roty(pi/2)*rotx(pi/2);

%Posición inicial
H0=SE3(initial_rotation, [0 0 6]);
%Movimiento -> Rotación en X
H1=SE3(rotx(-pi/2), [0 0 0]); 
%Movimiento -> Traslación en X
H2=SE3([3 0 0]);  
%Movimiento -> Traslación en X y Rotación en Z
H3=SE3(rotz(-pi/2), [2 0 0]); 

H10 = H0*H1;
H20 = H10*H2;
H30 = H20*H3;  %Matriz de transformación homogenea global de 3 a 0 

%Coordenadas de la estructura de translación y rotación
x=[0  0  3];
y=[0  0  0];
z=[0  6  6];

plot3(x, y, z,'LineWidth', 1.5); axis([-1 4 -1 6 -1 6]); grid on;
hold on;

%Graficamos la trama absoluta o global 
trplot(H0,'rgb','axis', [-1 4 -1 6 -1 2])
% 
% %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H0, H10,'rgb','axis', [-1 4 -1 6 -1 2])
% %Realizamos una animación para la siguiente trama
 pause;
 tranimate(H10, H20,'rgb','axis', [-1 4 -1 6 -1 2])
% % %Realizamos una animación para la siguiente trama
 pause;
  tranimate(H20, H30,'rgb','axis', [-1 4 -1 6 -1 2])
  disp(H30)