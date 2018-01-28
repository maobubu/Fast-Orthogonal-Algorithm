% Triangular
%Only works when there is signal processing tool box
function [x]=tria_in(n)
 width = 1;
 A = 1;
 t = (1:n)';
 x = A*sawtooth(t,width);