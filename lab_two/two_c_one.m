function [ shortest_path_bin ] = two_c_one(r)
%This function decodes the given (8,4,4) codeword using Viterbi decoding.

% This is the indicator for each of the tfs that is made
tfs = [ 
    0 0 0 0 ;
    3 3*2^2 3*2^4 3*2^6 ;
    1 1*2^2 1*2^4 1*2^6 ;
    2 2*2^2 2*2^4 2*2^6 ;
];

% First state transition: 4 edges
top_s1 = (r(1))^2 + (r(2))^2;
top_s1_2 = (r(1)-1)^2 + (r(2)-1)^2;
bottom_s1 = (r(1))^2 + (r(2)-1)^2;
bottom_s1_2 = (r(1)-1)^2 + (r(2))^2;

edges_stage1 = [ top_s1 top_s1_2 bottom_s1 bottom_s1_2 ]';

% Second state transition
stay_top_s2 = (r(3))^2 + (r(5))^2;
stay_top_s2_2 = (r(3)-1)^2 + (r(5)-1)^2;
stay_bottom_s2 = (r(3))^2 + (r(5)-1)^2;
stay_bottom_s2_2 = (r(3)-1)^2 + (r(5))^2;

edges_stage2 = [ stay_top_s2 stay_top_s2_2 stay_bottom_s2 stay_bottom_s2_2 ]';

% Third state transition
stay_top_s3 = (r(4))^2 + (r(6))^2;
stay_top_s3_2 = (r(4)-1)^2 + (r(6)-1)^2;
stay_bottom_s3 = (r(4))^2 + (r(6)-1)^2;
stay_bottom_s3_2 = (r(4)-1)^2 + (r(6))^2;

edges_stage3 = [ stay_top_s3 stay_top_s3_2 stay_bottom_s3 stay_bottom_s3_2 ]';

% Fourth state transition
top_s4 = (r(7))^2 + (r(8))^2;
top_s4_2 = (r(7)-1)^2 + (r(8)-1)^2;
bottom_s4 = (r(7))^2 + (r(8)-1)^2;
bottom_s4_2 = (r(7)-1)^2 + (r(8))^2;

edges_stage4 = [ top_s4 top_s4_2 bottom_s4 bottom_s4_2 ]';

% Full state of the map
grph = horzcat([edges_stage1 edges_stage2 edges_stage3 edges_stage4]);

% First reduction - Reduce the matrix by partitioning as follows
%
% a1 a2 | a3 a4          path to a | path from a
% b1 b2 | b3 b4          path to b | path from b
% -------------    -->    -------     ---------
% c1 c2 | c3 c4          path to c | path from c
% d1 d2 | d3 d4          path to d | path from d
%
% and reducing each of the partitions into a path to it's middle nodes

% top left
top_left = grph(1:2,1:2);

top_left_tf = tfs(1:2,1:2);

paths_to_a = [
    top_left(1,1) + top_left(1,2);
    top_left(2,1) + top_left(2,2);
];

paths_to_b = [
    top_left(2,1) + top_left(1,2);
    top_left(1,1) + top_left(2,2);
];

bins_to_a = [
    top_left_tf(1,1) top_left_tf(1,2);
    top_left_tf(2,1) top_left_tf(2,2);
];

bins_to_b = [
    top_left_tf(2,1) top_left_tf(1,2);
    top_left_tf(1,1) top_left_tf(2,2);
];

[ min_to_a, ind_to_a ] = min(paths_to_a);

bin_to_a = bins_to_a(ind_to_a,:);

[ min_to_b, ind_to_b ] = min(paths_to_b);

bin_to_b = bins_to_b(ind_to_b,:);


% bottom left
bottom_left = grph(3:4,1:2);

bottom_left_tf = tfs(3:4,1:2);

paths_to_c = [
    bottom_left(1,1) + bottom_left(1,2);
    bottom_left(2,1) + bottom_left(2,2);
];

paths_to_d = [
    bottom_left(2,1) + bottom_left(1,2);
    bottom_left(1,1) + bottom_left(2,2);
];

bins_to_c = [
    bottom_left_tf(1,1) bottom_left_tf(1,2);
    bottom_left_tf(2,1) bottom_left_tf(2,2);
];

bins_to_d = [
    bottom_left_tf(2,1) bottom_left_tf(1,2);
    bottom_left_tf(1,1) bottom_left_tf(2,2);
];

[ min_to_c, ind_to_c ] = min(paths_to_c);

bin_to_c = bins_to_c(ind_to_c,:);

[ min_to_d, ind_to_d ] = min(paths_to_d);

bin_to_d = bins_to_d(ind_to_d,:);


% top right
top_right = grph(1:2,3:4);

top_right_tf = tfs(1:2,3:4);

paths_from_a = [
    top_right(1,1) + top_right(1,2);
    top_right(2,1) + top_right(2,2);
];

paths_from_b = [
    top_right(1,1) + top_right(2,2);
    top_right(2,1) + top_right(1,2);
];

bins_from_a = [
    top_right_tf(1,1) top_right_tf(1,2);
    top_right_tf(2,1) top_right_tf(2,2);
];

bins_from_b = [
    top_right_tf(1,1) top_right_tf(2,2);
    top_right_tf(2,1) top_right_tf(1,2);
];

[ min_from_a, ind_from_a ] = min(paths_from_a);

bin_from_a = bins_from_a(ind_from_a,:);

[ min_from_b, ind_from_b ] = min(paths_from_b);

bin_from_b = bins_from_b(ind_from_b,:);


% bottom right
bottom_right = grph(3:4,3:4);

bottom_right_tf = tfs(3:4,3:4);

paths_from_c = [
    bottom_right(1,1) + bottom_right(1,2);
    bottom_right(2,1) + bottom_right(2,2);
];

paths_from_d = [
    bottom_right(1,1) + bottom_right(2,2);
    bottom_right(2,1) + bottom_right(1,2);
];

bins_from_c = [
    bottom_right_tf(1,1) bottom_right_tf(1,2);
    bottom_right_tf(2,1) bottom_right_tf(2,2);
];

bins_from_d = [
    bottom_right_tf(1,1) bottom_right_tf(2,2);
    bottom_right_tf(2,1) bottom_right_tf(1,2);
];

[ min_from_c, ind_from_c ] = min(paths_from_c);

bin_from_c = bins_from_c(ind_from_c,:);

[ min_from_d, ind_from_d ] = min(paths_from_d);

bin_from_d = bins_from_d(ind_from_d,:);


% Second level of reduction
% We have to take the reduced paths to and from each node
% and sum up their weights. Then we need to do simple comparisons
% to determine which path is the shortest.
path_lengths = [
    min_to_a + min_from_a;
    min_to_b + min_from_b;
    min_to_c + min_from_c;
    min_to_d + min_from_d;
];

path_bins = [
    horzcat(bin_to_a,bin_from_a);
    horzcat(bin_to_b,bin_from_b);
    horzcat(bin_to_c,bin_from_c);
    horzcat(bin_to_d,bin_from_d);
];

[ shortest_path_length, index ] = min(path_lengths);

% shortest path binary
s_p_bin = de2bi(sum(path_bins(index,:)),8);

shortest_path_bin = [ s_p_bin(1:3) s_p_bin(5) s_p_bin(4) s_p_bin(6:8) ];
