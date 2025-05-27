clear all;close all;

alph=2/3;
lambda=1600;

DATAml=xlsread('data.xlsx','monthly data','A3:F479');
DATAql=xlsread('data.xlsx','quarterly data','A3:F161');

DATAms=xlsread('data.xlsx','monthly data','A315:F479');
DATAqs=xlsread('data.xlsx','quarterly data','A107:H161');

Yl=DATAql(:,1);Ql=DATAql(:,2);DATAml=DATAml(:,3:end);DATAql=DATAql(:,[4,5,6]);
Ys=DATAqs(:,1);Qs=DATAqs(:,2);DATAms=DATAms(:,3:end);DATAqs=DATAqs(:,[4,5,6,8]);

DATAms=quarter(DATAms);
DATAml=quarter(DATAml);

iul=1;iv=2;iur=3;ime=4;ith=5;icu=6;ie=7;igdp=8;iism=9;ifx=10;

THl=DATAml(:,iv)./DATAml(:,iul);
THs=DATAms(:,iv)./DATAms(:,iul);

DATAl=log([DATAml,THl,DATAql]);
DATAs=log([DATAms,THs,DATAqs]);

[DATAtrendl,DATAhpl]=hpfilter(DATAl,lambda);
[DATAtrends,DATAhps]=hpfilter(DATAs,lambda);

FXl=DATAhpl(:,icu)-alph.*DATAhpl(:,ime);
FXs=DATAhps(:,icu)-alph.*DATAhps(:,ime);

DATAhpl(:,ifx)=FXl;
DATAhps(:,ifx)=FXs;

csvwrite('1973_2013.csv',[Yl,Ql,DATAhpl(:,[ifx,ith,igdp,ie])])
csvwrite('1999_2013.csv',[Ys,Qs,DATAhps(:,[ifx,ith,igdp,ie,iism])])

