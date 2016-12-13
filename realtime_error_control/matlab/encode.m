function [ code ] = encode( m )
% Encode the input 5 bit message based on the 16,5,8 Reed-Muller Scheme.
sizes = size(m);
if (sizes(1) ~= 1)
    code = [
        m(1:5,:)
        mod(m(1,:)+m(2,:),2)
        mod(m(1,:)+m(3,:),2)
        mod(m(1,:)+m(4,:),2)
        mod(m(1,:)+m(5,:),2)
        mod(m(2,:)+m(3,:),2)
        mod(m(2,:)+m(4,:),2)
        mod(m(2,:)+m(5,:),2)
        mod(m(3,:)+m(4,:),2)
        mod(m(3,:)+m(5,:),2)
        mod(m(4,:)+m(5,:),2)
        mod(m(1,:)+m(2,:)+m(3,:)+m(4,:)+m(5,:),2)
    ]';
else
    code = [
        m(1:5) mod(m(1)+m(2),2) mod(m(1)+m(3),2) mod(m(1)+m(4),2) mod(m(1)+m(5),2) mod(m(2)+m(3),2) mod(m(2)+m(4),2) mod(m(2)+m(5),2) mod(m(3)+m(4),2) mod(m(3)+m(5),2) mod(m(4)+m(5),2) mod(m(1)+m(2)+m(3)+m(4)+m(5),2)
    ];
end
end

