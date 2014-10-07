mtexdata dubna

plot(pf({1:4}))

colorbar

drawNow(gcm,'position','auto')

saveFigure('pf.png')

%%

plot(SantaFe,'sections',4,'contourf')

mtexColorMap white2black

saveFigure('odf.png')

%%

mtexdata fo

ebsd= ebsd('indexed')

grains = calcGrains(ebsd)

grains = smooth(grains)

%plot(grains,log(grains.grainSize ./ grains.boundarySize))
plotx2east
plot(grains,grains.GOS./degree)

colorbar

drawNow(gcm,'position','large')
saveFigure('ebsdGOS.png')

%%

mtexdata my

plot(ebsd)

grains = calcGrains(ebsd)

plot(smooth(grains))

drawNow(gcm,'position','large')
saveFigure('ebsdPhase.png')

%%

mtexFig = mtexFigure
cs = crystalSymmetry('-3m')
oM = ipdfHSVOrientationMapping(cs)

plot(oM,'complete')

hold on
plot(cs)
hold off




