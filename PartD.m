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
Control=[B A*B A^2*B A^3*B A^4*B A^5*B];




%%
%%LQR and step response
Q=diag([10000,10,10000,10,10000,10]);
R=0.001;
K=lqr(A,B,Q,R);
sys=ss((A-B*K),B,C,D);
%5step(sys);


%%
%%Reference tracking
tspan=0:0.1:100;
x0=[0;0;0;0;0;0];
wr=[5;0;0;0;0;0];
v=@ (i) -K*(i-wr);
[t,i]=ode45(@(t,i)system(i,A,B,v(i)),tspan,x0);

subplot(3,1,1);
plot(t,i(:,1));
title('Cart position (m)');
subplot(3,1,2);
plot(t,i(:,2));
title('theta1 (radian)');
subplot(3,1,3);
plot(t,i(:,3));
title('theta2 (radian)');

%%lypunov function part
lypunov_eigen_values=eig(A-B*K)





%%

%%
function dx=system(i,A,B,v)
         dx=(A*i) +B*v;
end
