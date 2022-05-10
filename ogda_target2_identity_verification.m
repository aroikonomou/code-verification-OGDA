%%%%%%%%%%%%%%%%%
% Identity Check for the proof of OGDA in the unconstrained setting / showing non-negativity of target 2
% This code verifies an identity proposed in the following paper https://arxiv.org/abs/2204.09228
% if the outcome of the program is 0, then the identity holds.
%%%%%%%%%%%%%%%%%


%% variables definition
syms      z0   % z_k
syms      w0   % w_k
syms      z1   % z_{k+1}
syms      w1   % w_{k+1}
syms     Fz0   % \eta F(z_k)
syms     Fw0   % \eta F(w_k)
syms     Fz1   % \eta F(z_{k+1}) 
syms     Fw1   % \eta F(w_{k+1})

%% Performing substitutions
% Comment: According to the OGDA update rule
% variables w1 will be substituted by z0 - Fw0 
% and variable z1 will be substituted by z0 - Fw1

w1 = z0 - Fw0;

z1 = z0 - Fw1;


%% Target = potential(k) - potential(k+1)
potential1 = (Fz0 - Fw0) * (Fz0 - Fw0).' + Fz0 * Fz0.'; 
potential2 = (Fz1 - Fw1) * (Fz1 - Fw1).' + Fz1 * Fz1.';

%% LHS of Identity, 2 expressions
expression_1 = 2*(Fz1 - Fz0) * transpose(z0 - z1);

expression_2 = 2*((Fw1 - Fz1)*(Fw1 - Fz1).' - 1/4*(w1 - z1)*(w1 - z1).' );

%% RHS of Identity, 1 square
sos = 1/2*(Fw0 + Fw1 - 2*Fz0)^2;

%% Check the Identitiy
LHS = potential1 - potential2 + expression_1 + expression_2;

RHS = sos;

%% if the outcome equals 0, then LHS = RHS
display(simplify(expand(LHS-RHS))); 
