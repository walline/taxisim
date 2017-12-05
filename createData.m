xlim([3 27]);
xticks(3:27);
[x,y] = ginput()
x(1) = 3;
x(end) = 27;
x = x*60-3*60;
plot(x,y)

%%
time = [3,5,7,9,11,13,15,17,19,21,23,25,27];

homeDest = [6,2,2,1,1,2,8,8,7,6,6,6,6]*0.1;
workDest = [1,7,7,8,8,5,1,1,1,1,1,1,1]*0.1;

%plot(time,homeDest)
%hold on
%plot(time,homeDest+workDest)
%plot(time,ones(1,length(time)))

homeOrigin = [3,8,8,8,6,1,1,1,4,4,4,4,4]*0.1;
workOrigin = [3,1,1,1,2,8,8,8,3,3,3,3,3]*0.1;

xType = time*60-3*60;

%plot(time,homeOrigin)
%hold on
%plot(time,homeOrigin+workOrigin)
%plot(time,ones(1,length(time)))

save('typedata.mat','homeDest','workDest','homeOrigin','workOrigin','xType')
