
cs = crystalSymmetry('m-3m')

plot(cs,'upper','position',[20 20 400 400])

saveFigure('../files/pic/cubic.jpg')

%%

mtexdata dubna
plot(pf({7}))

title(gca,'','visible','off')

drawNow(gcm,'position',[20 20 400 400])
drawNow(gcm)

saveFigure('../files/pic/pf.jpg')

%%

plot(SantaFe,'phi2',45*degree,'contourf')
mtexColorMap white2black

drawNow(gcm,'position',[20 20 400 400])
drawNow(gcm)

saveFigure('../files/pic/odf.jpg')

%%

%% Import 4th rank tensor as 6 by 6 matrix
%
% Olivine elastic stiffness (Cij) Tensor in GPa
% Abramson E.H., Brown J.M., Slutsky L.J., and Zaug J.(1997)
% The elastic constants of San Carlos olivine to 17 GPa.
% Journal of Geophysical Research 102: 12253-12263.
%
% Enter tensor as 6 by 6 matrix,M line by line.
M = [[320.5  68.15  71.6     0     0     0];...
    [ 68.15  196.5  76.8     0     0     0];...
    [  71.6   76.8 233.5     0     0     0];...
    [   0      0      0     64     0     0];...
    [   0      0      0      0    77     0];...
    [   0      0      0      0     0  78.7]];

 
% Define density (g/cm3)
rho=3.355;

cs_tensor = crystalSymmetry('mmm',[4.7646,10.2296,5.9942],...
    [90.00,90.00,90.00]*degree,'x||a','z||c','mineral','Olivine');

% Define tenor object in MTEX
% Cij -> Cijkl - elastic stiffness tensor
C = tensor(M,cs_tensor,'name','elastic stiffness','unit','GPa','density',rho)


%**************************************************************************
% Vs1 : Plot Vs1 velocities (km/s)
%**************************************************************************
%
% create a new axis

plot(C,'PlotType','velocity','200*(vs1-vs2)./(vs1+vs2)','complete','upper','contourf');


hold on
plot(C,'PlotType','velocity','ps1',...
  'complete','upper','linewidth',3,'color','black','position',[20 20 400 400])

drawNow(gcm,'position',[20 20 400 400])
drawNow(gcm)

saveFigure('../files/pic/tensor.jpg')

%
%**************************************************************************

%%

plotx2east
mtexdata forsterite

ebsd = ebsd('indexed')

ebsd = ebsd(inpolygon(ebsd,[5 2 5 5]*10^3));

grains = smooth(calcGrains(ebsd))


plot(grains,log(grains.grainSize ./ grains.boundarySize),'position',[20 20 400 400],'linewidth',2)

saveFigure('../files/pic/grains.jpg')

%%

plotx2east
mtexdata forsterite

ebsd = ebsd('indexed')

ebsd = ebsd(inpolygon(ebsd,[5 2 5 5]*10^3));

grains = smooth(calcGrains(ebsd))


plot(grains.boundary,grains.boundary.misrotation.angle,'linewidth',3,'position',[20 20 400 400])

saveFigure('../files/pic/boundary.jpg')

%%

plot(ebsd('Fo'),ebsd('Fo').orientations,'position',[20 20 400 400])
hold on
plot(ebsd('Di'),ebsd('Di').orientations,'position',[20 20 400 400])
plot(ebsd('En'),ebsd('En').orientations,'position',[20 20 400 400])
hold off

saveFigure('../files/pic/ebsdDoc.jpg')

%%

mtexdata fo
grains =calcGrains(ebsd)

hist(grains)
drawNow(gcm)
saveFigure('../files/pic/plotting.jpg')
%%
