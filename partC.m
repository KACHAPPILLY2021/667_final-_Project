syms theta1 theta2 theta1dot theta2dot F M m1 m2 g l1 l2 x_dot x
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
A=(subs(a,[theta1 theta2 theta1dot theta2dot F M m1 m2 g l1 l2 x_dot x],[0 0 0 0 F M m1 m2 g l1 l2 0 0]))

b=jacobian(f,F);
B=(subs(b,[theta1 theta2 theta1dot theta2dot F M m1 m2 g l1 l2 x_dot x],[0 0 0 0 F M m1 m2 g l1 l2 0 0]))

c=jacobian([x theta1 theta2],u);
C=(subs(c,[theta1 theta2 theta1dot theta2dot F M m1 m2 g l1 l2 x_dot x],[0 0 0 0 F M m1 m2 g l1 l2 0 0]))

d=jacobian([x theta1 theta2],F);
D=(subs(d,[theta1 theta2 theta1dot theta2dot F M m1 m2 g l1 l2 x_dot x],[0 0 0 0 F M m1 m2 g l1 l2 0 0]))
Condition=det([B A*B A^2*B A^3*B A^4*B A^5*B])
