clear all;
clc;

rf = 0.1;

ibo = simplestock([1; -0.8; 0; 0.7],rf);
fund = simplestock([2; -1.4; 0.5; 1],rf,ibo);