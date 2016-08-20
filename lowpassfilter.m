FilterSpec = fdesign.lowpass('N,Fc,Ap,Ast',100,100,1,60,1000);  % Or use the 'N,Fp,Ap,Ast' format if that's more applicable
disp(designmethods(FilterSpec))  % To verify that this specification is appropriate for the type of design method you want to use
FilterObj = design(FilterSpec,'equiripple');
fvtool(FilterObj);  % To visually explore the spectral characteristics of your filter
