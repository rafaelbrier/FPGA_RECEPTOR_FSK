t = 1:1:4096;

x = zeros(1,4096);
for i=1:1:4096
x(i+1) = ~x(i);
end