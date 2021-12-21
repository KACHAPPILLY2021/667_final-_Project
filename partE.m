syms theta1 theta2 theta1dot theta2dot F M m1 m2 g l1 l2 x_dot x

%% 
u=[x,x_dot,theta1, theta1dot, theta2, theta2dot ];
Term1=F;
Term2= m1*sin(theta1)*(g*cos(theta1)+l1*theta1dot.^2);
Term3= m2*sin(theta2)*(g*cos(theta2)+l2*theta2dot.^2);
Denom1=(M +m1*sin(theta1.^2)+m2*sin(theta2.^2));
x_ddot= (Term1-Term2-Term3)/Denom1;
theta1_ddot= ((cos(theta1)/(l1))*x_ddot)-(g*sin(theta1))/(l1);
theta2_ddot= ((cos(theta2)/(l2))*x_ddot)-(g*sin(theta2))/(l2);
%%
%%Calculate A B C D using jacobian funcions
f=[x_dot x_ddot theta1dot theta1_ddot  theta2dot theta2_ddot ];
a=jacobian(f,u);
A=double(simplify((subs(a,[theta1 theta2 theta1dot theta2dot F M m1 m2 g l1 l2 x_dot x],[0 0 0 0 F 1000 100 100 9.81 20 10 0 0]))));
b=jacobian(f,F);
B=double(simplify((subs(b,[theta1 theta2 theta1dot theta2dot F M m1 m2 g l1 l2 x_dot x],[0 0 0 0 F 1000 100 100 9.81 20 10 0 0]))));
c=jacobian([x theta1 theta2],u);
C=double(simplify((subs(c,[theta1 theta2 theta1dot theta2dot F M m1 m2 g l1 l2 x_dot x],[0 0 0 0 F 1000 100 100 9.81 20 10 0 0]))));
d=jacobian([x theta1 theta2],F);
D=double(simplify((subs(d,[theta1 theta2 theta1dot theta2dot F M m1 m2 g l1 l2 x_dot x],[0 0 0 0 F 1000 100 100 9.81 20 10 0 0]))));


%This code will print the rank of controllability matrix
c1=jacobian([x 0 0],u);
c1=double(c1);
obser1=rank([c1; c1*A; c1*A^2;c1*A^3;c1*A^4;c1*A^5])

c2=jacobian([0 theta1 theta2],u);
c2=double(c2);
obser2=rank([c2; c2*A; c2*A^2;c2*A^3;c2*A^4;c2*A^5])

c3=jacobian([x 0 theta2],u);
c3=double(c3);
obser3=rank([c3; c3*A; c3*A^2;c3*A^3;c3*A^4;c3*A^5])

c4=jacobian([x theta1 theta2],u);
c4=double(c4);
obser4=rank([c4; c4*A; c4*A^2;c4*A^3;c4*A^4;c4*A^5])


