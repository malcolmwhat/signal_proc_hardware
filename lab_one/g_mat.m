function [ output_args ] = g_mat( er_index, column, eqn )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    output_args = length(er_index) >= column && any(eqn==er_index(column));
end

