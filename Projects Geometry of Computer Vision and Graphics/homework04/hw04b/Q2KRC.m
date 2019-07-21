function [ K, R, C ] = Q2KRC( Q )

M = Q([1:3], [1:3]);
m1 = M(1,:).';
m2 = M(2,:).';
m3 = M(3,:).';
m = Q([1:3], 4);

normM3Squared = norm(m3)*norm(m3);

k23 = (m2.'*m3)/normM3Squared;
k13 = (m1.'*m3)/normM3Squared;
k22 = sqrt ((m2.'*m2)/normM3Squared - k23*k23);
k12 = ((m1.'*m2)/normM3Squared - k13*k23)/k22;
k11 = sqrt((m1.'*m1)/normM3Squared - k12*k12 - k13*k13);


K = [k11 k12 k13;
    0 k22 k23;
    0 0 1];


R = K^(-1)*sign(det(M))*M/norm(m3);

C = -M^(-1)*m;

detR = det(R);
g =0;
