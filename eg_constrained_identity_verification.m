%%%%%%%%%%%%%%%%%
% Identity Check for the proof of EG in the constrained setting
% This code verifies an identity proposed in the following paper https://arxiv.org/abs/2204.09228
% if the outcome of the program is 0, then the identity holds.
%%%%%%%%%%%%%%%%%


%% variables definition
syms      z0   % z_k
syms      z1   % z_{k+\half}
syms      z2   % z_{k+1}
syms     Fz0   % \eta F(z_k)
syms     Fz1   % \eta F(z_{k+\half})
syms     Fz2   % \eta F(z_{k+1})
syms      c0   % \eta c_k
syms      c2   % \eta c_{k+1}


% Expression (17)
expression_1 = (Fz0+ c0)^2 - (Fz2+ c2)^2;

% LHS of Inequality (18)
expression_2 = (-1)*((z1 - z2)^2 - (Fz1 - Fz2)^2);

% LHS of Inequality (19)
expression_3 = (-2)*(Fz2 - Fz0)*(z2 - z0);

% LHS of Inequality (20)
expression_4 = (-2)*(z0 - Fz0 - z1)*(z1 - z2);

% LHS of Inequality (21)
expression_5 = (-2)*(z0 - Fz1 - z2)*(z2 - z0);

% LHS of Inequality (22)
expression_6 = (-2)*c0*(z0 - z1);

% LHS of Inequality (23)
expression_7 = (-2)*(c2 + Fz2)*(z0 - Fz1 - z2);

% LHS of Inequality (24)
expression_8 = (-2)*(c2 + Fz2)*(-c2);

% Expression (25)
expression_9 = (Fz0 + c0 - z0 + z1)^2;

% Expression (26)
expression_10 = (Fz1 + c2 - z0 + z2)^2;


% LHS of the identity
LHS = expression_1 + expression_2 + expression_3 + expression_4 ...
    + expression_5 + expression_6 + expression_7 + expression_8;

% RHS of the identity
RHS = expression_9 + expression_10;


% if the outcome is 0, then LHS = RHS
P = LHS - RHS ;
Q=simplify(P);
display(Q);
