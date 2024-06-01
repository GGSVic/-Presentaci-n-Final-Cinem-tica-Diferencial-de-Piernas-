
%Limpieza de pantalla
clear all
close all
clc

%Declaración de variables simbólicas (no tienen valor especifico)
syms thX_1(t) thY_1(t) thZ_1(t) l1 
syms thZ_2(t) l2
syms thZ_3(t) thY_3(t) l3
syms t

RP=[0 0 0]; %configuracion del robot, 0 para junta esferica y 1 para prismatica 

% Vector de coordenadas articulares y generalizada
Q = [thX_1, thY_3, thZ_2];
disp('Coordenadas articulares y generalizadas:');pretty(Q)%vector de velocidad articulares+
Qp = diff(Q,t); %se utiliza diff para derivadas cuya variable no depende de otras
disp('Velocidades articulares'); pretty(Qp); %Número de grado de libertad del robot
GDL= size(RP,2);

%Articulacion 1 
P(:,:,1) = [l1*cos(thX_1);  l1*sin(thY_1);  0];

% Matriz de rotación
AZ1 = [cos(thZ_1) -sin(thZ_1) 0; 
       sin(thZ_1)  cos(thZ_1) 0; 
           0          0       1];

AY1 = [cos(thY_1)   0   sin(thY_1); 
           0        1        0    ; 
       -sin(thY_1)  0  cos(thY_1)];

AX1 = [ 1    0         0    ; 
        0 cos(thX_1) -sin(thX_1); 
        0 sin(thX_1)  cos(thX_1)];

R(:,:,1) = AZ1 .* AY1 .* AX1 ; %Articulacion 2
P(:,:,2) = [l2*cos(thZ_2);  l2*sin(thZ_2); 0];

% Matriz de rotación
R(:,:,2) = [cos(thZ_2) -sin(thZ_2) 0; 
            sin(thZ_2)  cos(thZ_2) 0; 
                0          0       1]; 

P(:,:,3) = [l3*cos(thY_3);  l3*sin(thZ_3); 0];

% Matriz de rotación
AZ3 = [cos(thZ_3) -sin(thZ_3) 0; 
       sin(thZ_3)  cos(thZ_3) 0; 
           0          0       1];

AY3 = [cos(thY_3)   0   sin(thY_3); 
           0        1        0    ; 
       -sin(thY_3)  0  cos(thY_3)];

R(:,:,3) = AZ3 .* AY3; 
%Creamos un vector de ceros
Vector_Zeros= zeros(1, 3);

%Inicializamos las matrices de transformación Homogénea locales
A(:,:,GDL)=simplify([R(:,:,GDL) P(:,:,GDL); Vector_Zeros 1]);
%Inicializamos las matrices de transformación Homogénea globales
T(:,:,GDL)=simplify([R(:,:,GDL) P(:,:,GDL); Vector_Zeros 1]);
%Inicializamos las posiciones vistas desde el marco de referencia inercial
PO(:,:,GDL)= P(:,:,GDL); 
%Inicializamos las matrices de rotación vistas desde el marco de referencia inercial
RO(:,:,GDL)= R(:,:,GDL); 


for i = 1:GDL
    i_str= num2str(i);
   %disp(strcat('Matriz de Transformación local A', i_str));
    A(:,:,i)=simplify([R(:,:,i) P(:,:,i); Vector_Zeros 1]);
   %pretty (A(:,:,i));

   %Globales
    try
       T(:,:,i)= T(:,:,i-1)*A(:,:,i);
    catch
       T(:,:,i)= A(:,:,i);
    end
    disp(strcat('Matriz de Transformación global T', i_str));
    T(:,:,i)= simplify(T(:,:,i));
    pretty(T(:,:,i))

    RO(:,:,i)= T(1:3,1:3,i);
    PO(:,:,i)= T(1:3,4,i);
    %pretty(RO(:,:,i));
    %pretty(PO(:,:,i));
end