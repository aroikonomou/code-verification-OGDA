%%%%%%%%%%%%%%%%%
% Identity Check for the proof of OGDA in the constrained setting
% This code verifies an identity proposed in the following paper https://arxiv.org/abs/2204.09228
% if the outcome of the program is 0, then the identity holds.
%%%%%%%%%%%%%%%%%


%% variables definition
syms      z0   % z_k
syms      z1   % z_{k+1}
syms      w0   % w_k
syms      w1   % w_{k+1}
syms     Fz0   % \eta F(z_k)
syms     Fz1   % \eta F(z_{k+1})
syms     Fw0   % \eta F(w_k)
syms     Fw1   % \eta F(w_{k+1})
syms      c0   % \eta c_k
syms      c1   % \eta c_{k+1}



% Expression (47)
expression_1 = ((Fz0 + c0)^2 + (Fz0 - Fw0)^2 ) - ((Fz1 + c1)^2 + (Fz1 - Fw1)^2);

% LHS of Inequality (48)
expression_2 = (-2)*(Fz1 - Fz0)*(z1 - z0);

% LHS of Inequality (49)
expression_3 = (-2)*(1/4*(z1 - w1)^2 - (Fz1 - Fw1)^2);

% LHS of Inequality (50)
expression_4 = (-1)*(z0 - Fw0 - w1)*(w1 - z1);

% LHS of Inequality (51)
expression_5 = (-2)*(z0 - Fw1 - z1)*(z1 - z0);

% LHS of Inequality (52)
expression_6 = (-1)*c0*(z0 - w1);

% LHS of Inequality (53)
expression_7 = (-1)*c0*(z0 - z1);

% LHS of Inequality (54)
expression_8 = (-2)*(c1 + Fz1)*(z0 - Fw1 - z1);

% LHS of Inequality (55)
expression_9 = (-2)*(c1 + Fz1)*(-c1);

% LHS of Inequality (56)
expression_10 = ((w1 - z1)/2 + Fw0 - Fz0)^2;

% LHS of Inequality (57)
expression_11 = (Fz0 + c0 - z0 + (w1 + z1)/2)^2;

% LHS of Inequality (58)
expression_12 = (z0 - Fw1 - z1 - c1)^2;


% LHS of the identity
LHS = expression_1 + expression_2 + expression_3 + expression_4 ...
    + expression_5 + expression_6 + expression_7 + expression_8 ...
    + expression_9;

% RHS of the identity
RHS = expression_10 + expression_11 + expression_12;


% if the outcome is 0, then LHS = RHS
P = LHS - RHS ;
Q=simplify(P);
display(Q);
