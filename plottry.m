x=0:0.01:10;
y=gbellmf(x,[2 4 6]);
subplot(1,1,1),plot(x,y)
xlabel('gbellmf, P=[2 4 6]')