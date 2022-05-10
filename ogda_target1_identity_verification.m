%%%%%%%%%%%%%%%%%
% Identity Check for the proof of OGDA in the constrained setting (showing non-negativity of Expression Target 1)
% This code verifies an identity proposed in the following paper https://arxiv.org/abs/2204.09228
% if the outcome of the program is 0, then the identity holds.
%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%
% w0 lies anywhere
% z0 lies on  b_k     := (beta1, beta2,  1)
% w1 lies on  a_{k+1} := (alpha,     1,  0)
% z1 lies on  b_{k+1} := (1,         0,  0)

% indicator[<F(z_{k+1}), b_{k+1}>  >= 0]
Fz1projb1  = 0; % note that <F(z_{k+1}), b_{k+1}> = F(z_{k+1})[1]


% Comment: Set value of Fz1projb1 to {0, 1} to test both cases of the identity
   

%% variables definition
syms      z0 [1 3]  % z_k
syms      w0 [1 3]  % w_k
syms      z1 [1 3]  % z_{k+1}
syms      w1 [1 3]  % w_{k+1}
syms     Fz0 [1 3]  % \eta F(z_k)
syms     Fw0 [1 3]  % \eta F(w_k)
syms     Fz1 [1 3]  % \eta F(z_{k+1}) 
syms     Fw1 [1 3]  % \eta F(w_{k+1})

syms     alpha                % alpha       
syms     beta1                % beta_1
syms     beta2                % beta_2

b0  = [ beta1; beta2;  1];    % b_k 
val_b0 = beta1^2+beta2^2+1;   % ||b_k||^2

a1 = [ alpha;  1;  0];        % a_{k+1}
val_a1 = alpha^2 + 1;         % ||a_{k+1}||^2

b1  = [  1;  0;  0];          % b_{k+1}

perp_a1 = [-1; alpha; 0];     % a^{\perp}_{k+1}

%% Performing substitutions
z0(3) = -beta1*z0(1) - beta2*z0(2);

w1(2) = -alpha*w1(1);

z1(1) = 0;

z1(2) = z0(2) - Fw1(2);

z1(3) = z0(3) - Fw1(3);

w1(3) = z0(3) - Fw0(3);

%% Target = potential(k) - potential(k+1)
potential1 = (Fz0 - Fw0) * (Fz0 - Fw0).' + Fz0 * Fz0.' - (Fz0 *  b0)^2/val_b0; 
potential2 = (Fz1 - Fw1) * (Fz1 - Fw1).' + Fz1 * Fz1.' - Fz1projb1 * (Fz1 *  b1)^2;

%% LHS of Identity, 8 expressions
expression_1 = 2*(Fz1 - Fz0) * transpose(z0 - z1);

expression_2 = 2*((Fw1 - Fz1)*(Fw1 - Fz1).' - 1/4*(w1 - z1)*(w1 - z1).' );

expression_3 = 2*( z0 *  b1 )   * ((z0 - Fw1) *  b1 );

expression_4 = 2*(-(Fz1 *  b1)) * (1-Fz1projb1) * ((z0 - Fw1) *  b1 );

expression_5 = 1/val_a1*( z1 * a1 ) * ((z0 - Fw0) * a1 );

expression_6 = -1/val_b0*(Fz0 * b0) * ((w1 + z1) * b0 );

expression_7 = w1(1) * ((z0-Fw0-w1) * perp_a1);

expression_8 = alpha/val_a1 *( z1(2)) * ((z0-Fw0-w1) * perp_a1);



%% RHS of Identity, 7 squares
sos_1 = (Fw0(1) - Fz0(1) + 1/2*w1(1))^2;

sos_2 = ( z0(1) - Fw1(1) + Fz1(1)*Fz1projb1)^2;

sos_3 = ( z0(2)/2 - w1(2)/2 - Fw1(2)/2 + Fz0(2) - Fw0(2))^2;

sos_4 = 1/2*(Fw0(3) + Fw1(3) + beta1/(1+beta1^2+beta2^2)*Fz0(1) + beta2/(1+beta1^2+beta2^2)*Fz0(2) - (2*beta1^2 + 2*beta2^2 +1)/(1+beta1^2+beta2^2)*Fz0(3))^2;

sos_5 = (z0(2)/2 -w1(2)/2 + Fw1(2)/2 + beta1*beta2/(1+beta1^2+beta2^2)*Fz0(1) - (1+beta1^2)/(1+beta1^2+beta2^2)*Fz0(2) + beta2/(1+beta1^2+beta2^2)*Fz0(3))^2;

sos_6 = 1/(1+beta1^2/2 + 2*beta2^2+beta2^4)*( ...
       +(1+beta1^2/2 + 2*beta2^2+beta2^4)/(1+beta1^2+beta2^2)*Fz0(1)...
       -1/2*beta1*beta2*(1+2*beta2^2)/(1+beta1^2+beta2^2)*Fz0(2) ...
       -1/2*beta1*(1+2*beta2^2)/(1+beta1^2+beta2^2)*Fz0(3) ...
       +1/2*(1+beta2^2)*w1(1) ...
       -(1+beta2^2)*z0(1))^2;

sos_7 = 1/(beta1^2+2*(1+beta2^2)^2)*(beta2*Fz0(2) + Fz0(3) - beta1/2*w1(1) + beta1*z0(1))^2;

%% Check the Identitiy
LHS = potential1 - potential2 + expression_1 + expression_2 + expression_3 + expression_4 ...
       + expression_5 + expression_6 + expression_7 + expression_8;

RHS = sos_1 + sos_2 + sos_3 + sos_4 + sos_5 + sos_6 + sos_7;

%% if the outcome equals 0, then LHS = RHS
display(simplify(expand(LHS-RHS))); 
