P = [100,10,2;0,5,3;10,0,10];
%P = [100,0,0;0,5,0;0,0,10];
%Pixel Accuracy (PA)
pa = 0;
s1 = 0;
s2 = 0;
for i=1:3
   for j=1:3
       s2 = s2 + P(i,j);
   end
   s1 = s1 + P(i,i);
end
pa = pa + s1/s2

%Mean Pixel Accuracy (MPA)
mpa = 0;

for i=1:3
    s1 = 0;
    s2 = 0;
   for j=1:3
       s1 = s1 + P(i,j);
   end
   mpa = mpa + P(i,i)/s1;
end
mpa = 1/3*mpa

%Mean Intersection over Union (MIOU)
miou = 0;
for i=1:3
    s1 = 0;
    s2 = 0;
   for j=1:3

       s1 = s1 + P(i,j);
       s2 = s2 + P(j,i);
       
   end
   s1
   s2
   miou = miou + P(i,i)/(s1+s2-P(i,i));
end

miou = 1/3*miou

%Frequency Weighted Intersection over Union (FWIoU)
fwiou = 0;


for i=1:3
    s1 = 0;
    s2 = 0;
    s3 = 0;
   for j=1:3
       s1 = s1 + P(i,j);
       s2 = s2 + P(j,i); 
       s3 = s3+ P(i,j)*P(j,i);
   end
   fwiou = fwiou + s3/(s1+s2-P(i,i));

end
s4 = 0;
for i=1:3
   for j=1:3
     s4 = s4 + P(i,j);  
   end  
end

fwiou = 1/s4*fwiou