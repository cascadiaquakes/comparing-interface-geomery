function mainTextFigures(modelResultsFile, colorFile,latLonFile)
% Dependent on external functions found in tridsl 
    % (https://github.com/jploveless/tridisl)
    
%%%%% --------------------------- INPUTS --------------------------- %%%%%
  % modelResultsFile (string) must contain: 
    % bc, bt, m, s, w, wb: patch structures for Bloch "c", Bloch "t",
      % McCrory, Slab2, Sypus "geometry", and Sypus "adjusted buried"
      % triangular meshes
    % bloch, mccrory, slab2, sypus: patch structures for Bloch "c",
      % McCrory, Slab2, and Sypus "adjusted buried" triangular meshes that
      % incorporate the USGS Slab2 trench as the shallowest contour (the
      % patch structures used in block models)
    % casnet: GNSS velocities from Saux et al., 2022 (net field). Column
      % order: [station longitude | station latitude | east vel. (mm/yr) |
        % north vel. (mm/yr) | east sig (mm/yr) | north sig (mm/yr)]
    % g: array containing the Gaussian dip slip applied to the McCrory
      % interface 
    % noise: uniformly distributed noise around 2 cm for Gaussian
      % inversions; number of stations*3 by 250
    % out_main: structure containing arrays for each of the 4 geometries
      % with the averaged strike slip (1:2:end) and dip slip (2:2:end)
      % estimated on the triangular elements for the 250 realizations of
      % the displacement field with noise (uses the McCrory geometry as the
      % input model)
    % seg: structure containing block model slip results for each of the 
      % four geometries. Column order: [strike-slip | dip-slip | 
        % tensile-slip | strike unc. | dip unc. | tens unc. | strike | 
        % block strike-slip | block dip-slip | block tensile-slip]
    % stations: structure containing longitude (.lon) and latitude (.lat)
      % of the GNSS stations used in the uniform and Gaussian slip models
    % vel: structure containing arrays for each of the six geometries with 
      % east (1:3:end), north (2:3:end) and vertical (3:3:end) displacement
      % components for the uniform slip models
    % velg: the east (1:3:end), north (2:3:end) and vertical (3:3:end)
      % displacement components predicted by the McCrory geometry with the
      % Gaussian slip distribution applied 
      
  % colorFile (string) must contain: 
    % colors: 4-by-3 color values for yellow (Bloch), green (Slab2), blue
      % (McCrory) and pink (Sypus)
    % grayC/vik/acton/cork/oslo: 256-by-3 color maps from Crameri (2018) 
      % http://doi.org/10.5281/zenodo.1243862

  % latLonFile (string) must contain:
    % lat: array containing latitudes of coastline (length must match lon)
    % lon: array containing longitudes of coastline (length must match lat)
    
%%%%% --------------------------- OUTPUTS --------------------------- %%%%%
  % Returns figure windows with components to recreate the main text Fig.
    % 1-8. Figure 9 was generated in Adobe Illustrator and does not have
    % associated MATLAB/Octave code.
  
%%%%% ---------------------------- CODE ---------------------------- %%%%%
%% General variables
% load lat-lon for plotting the coast
load(latLonFile)
% load colormaps and color scheme for Figures 1-5
load(colorFile)
% load results 
load(modelResultsFile)

% font size
fsz = 12;
% coast color
coast = [0.25 0.25 0.25];
% five region bounds
regy = [39.5 41.25 44 46.5 49 51]; regx = [231 237.3];
% define the structure used to create displacement field from Gaussian slip
    % distribution (McCrory for main text)
p_in = m;

% calculate partials
[Gu.bc p vel.bc] = applyUniformSlip(bc,stations, [0 40 0])
[Gu.bt p vel.bt] = applyUniformSlip(bt,stations, [0 40 0])
[Gu.m p vel.m] = applyUniformSlip(m,stations, [0 40 0])
[Gu.s p vel.s] = applyUniformSlip(s,stations, [0 40 0])
[Gu.w p vel.w] = applyUniformSlip(w,stations, [0 40 0])
[Gu.wb p vel.wb] = applyUniformSlip(wb,stations, [0 40 0])
%% Figure 1 - General map with GNSS velocities 
figure(1); clf; set(gcf,'position',[477   554   398   327])
% plot mesh edges
p = m; % McCrory
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,1,'color',colors(3,:),'lineWidth',1.5);
p = s; % Slab2
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,1,'color',colors(2,:),'lineWidth',1.5);
p = wb; % Sypus "adjusted buried"
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,1,'color',colors(4,:),'lineWidth',1.5);
p = bc; % Bloch c
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,1,'color',colors(1,:),'lineWidth',1.5);
% plot major cities
cities = [237.6672 47.6061; 237.3252 45.5152; 236.8793 49.2827];
plot(cities(:,1),cities(:,2),'.','markerSize',15,'color',[0.5 0 0])
% label cities
text(cities(:,1)+.1,cities(:,2),{'Seattle','Portland','Vancouver'})
% plot the coast
plot(lon,lat,'color',coast)
% plot select GNSS velocities
lonspc = 0.5;
latspc = 0.25;
keep = [];
for i = 231.05:lonspc:240
    for j = 39:latspc:51
        loc = find(casnet(:,2) < i+lonspc & casnet(:,1) >= i &...
            casnet(:,2) < j+latspc & casnet(:,2) >= j);
        if max(size(loc)) > 0
            tmp = sqrt((casnet(loc,1)-(i+lonspc/2)).^2+(casnet(loc,2)-(j+latspc/2)).^2);
            tmp = find(tmp==min(tmp),1);
            keep = [keep;loc(tmp)];
        end
    end
end
clear('tmp','loc')
arleng = 1;
plot(casnet(:,1),casnet(:,2),'.','markerSize',4,'color',[0.4 0.4 0.4])
quiver([239; casnet(keep,1)],[50.5; casnet(keep,2)],...
    [20; casnet(keep,3)],[0; casnet(keep,4)],arleng,'color','k','lineWidth',1,'MaxHeadSize',0.02)
% general aesthetics
legend('McCrory','Slab 2','Sypus','Bloch','City')
axis('equal',[229 240 39 51 -50 10]); box on
yticks(40:2:50); yticklabels({'40°N','','','','','50°N'})
xticks(230:2:240); xticklabels({'130°W','','','','','120°W'})
box on; grid on
set(gca, 'FontSize',fsz)

%% Figure 2 - Mesh dip and curvature (broken into figure windows 2 & 14)
% set some plotting parameters
cax = [0 30]; ax = [231 239 39.5 51 -41 0.5]; cmap = acton;
regxx = [231 239];
figure(2); clf; set(gcf,'position',[1   491   964   390])
subplot(1,4,1)
trisurf(m.v, wrapTo360(m.c(:,1)), m.c(:,2),m.c(:,3),m.dip)
hold on
% plot the contours
cont = [-5:-5:-40];
for i = 1:length(cont)
    tmp = find(m.c(:,3) >cont(i)-0.1 &m.c(:,3) <cont(i)+0.1);
    [tmp2,tmp3] = sort(m.c(tmp,2));
    plot3(wrapTo360(m.c(tmp(tmp3),1)),m.c(tmp(tmp3),2),m.c(tmp(tmp3),3),'k','lineWidth',1)
    begs(i,:) = [wrapTo360(m.c(tmp(tmp3(1)),1)) m.c(tmp(tmp3(1)),2) m.c(tmp(tmp3(1)),3)];
    ends(i,:) = [wrapTo360(m.c(tmp(tmp3(end)),1)) m.c(tmp(tmp3(end)),2) m.c(tmp(tmp3(end)),3)];
    clear('tmp*')
end
plot3(begs(:,1),begs(:,2),begs(:,3),'k','lineWidth',1)
plot3(ends(:,1),ends(:,2),ends(:,3),'k','lineWidth',1)
% plot the coastline
plot(lon,lat,'color',coast,'lineWidth',0.5)
% aesthetics
shading flat; colormap(cmap) 
caxis(cax)
axis('equal',ax); view([0 90])
box on; grid on; yticks(40:2:50); xticks(232:2:238); 
yticklabels({'40°N','','','','','50°N'}); xticklabels({'128°W','','','122°W'})
text(238.5,50.5,'McCrory','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'a','HorizontalAlignment','center','VerticalAlignment','middle')


subplot(1,4,2)
trisurf(s.v, wrapTo360(s.c(:,1)), s.c(:,2),s.c(:,3),s.dip)
hold on
% plot the contours
cont = [-6.5 -10:-5:-40];
for i = 1:length(cont)
    tmp = find(s.c(:,3) >cont(i)-0.1 &s.c(:,3) <cont(i)+0.1);
    [tmp2,tmp3] = sort(s.c(tmp,2));
    plot3(wrapTo360(s.c(tmp(tmp3),1)),s.c(tmp(tmp3),2),s.c(tmp(tmp3),3),'k','lineWidth',1)
    begs(i,:) = [wrapTo360(s.c(tmp(tmp3(1)),1)) s.c(tmp(tmp3(1)),2) s.c(tmp(tmp3(1)),3)];
    ends(i,:) = [wrapTo360(s.c(tmp(tmp3(end)),1)) s.c(tmp(tmp3(end)),2) s.c(tmp(tmp3(end)),3)];
    clear('tmp*')
end
plot3(begs(:,1),begs(:,2),begs(:,3),'k','lineWidth',1)
plot3(ends(:,1),ends(:,2),ends(:,3),'k','lineWidth',1)
% plot the coastline
plot(lon,lat,'color',coast,'lineWidth',0.5)
% aesthetics
shading flat
caxis(cax)
axis('equal',ax); view([0 90])
box on; grid on; yticks(40:2:50); xticks(232:2:238); 
yticklabels({}); xticklabels({'128°W','','','122°W'})
text(238.5,50.5,'Slab2','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'b','HorizontalAlignment','center','VerticalAlignment','middle')

subplot(1,4,3)
trisurf(wb.v, wrapTo360(wb.c(:,1)), wb.c(:,2),wb.c(:,3),wb.dip)
hold on
% plot the contours
cont = [-5:-5:-40];
for i = 1:length(cont)
    tmp = find(wb.c(:,3) >cont(i)-0.1 &wb.c(:,3) <cont(i)+0.1);
    [tmp2,tmp3] = sort(wb.c(tmp,2));
    plot3(wrapTo360(wb.c(tmp(tmp3),1)),wb.c(tmp(tmp3),2),wb.c(tmp(tmp3),3),'k','lineWidth',1)
    begs(i,:) = [wrapTo360(wb.c(tmp(tmp3(1)),1)) wb.c(tmp(tmp3(1)),2) wb.c(tmp(tmp3(1)),3)];
    ends(i,:) = [wrapTo360(wb.c(tmp(tmp3(end)),1)) wb.c(tmp(tmp3(end)),2) wb.c(tmp(tmp3(end)),3)];
    clear('tmp*')
end
plot3(begs(:,1),begs(:,2),begs(:,3),'k','lineWidth',1)
plot3(ends(:,1),ends(:,2),ends(:,3),'k','lineWidth',1)
% plot the coastline
plot(lon,lat,'color',coast,'lineWidth',0.5)
% aesthetics
shading flat
caxis(cax)
axis('equal',ax); view([0 90])
box on; grid on; yticks(40:2:50); xticks(232:2:238); 
yticklabels({}); xticklabels({'128°W','','','122°W'})
text(238.5,50.5,'Sypus','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'c','HorizontalAlignment','center','VerticalAlignment','middle')

subplot(1,4,4)
trisurf(bc.v, wrapTo360(bc.c(:,1)), bc.c(:,2),bc.c(:,3),bc.dip)
hold on
% plot the contours
cont = [-6.5 -10:-5:-40];
for i = 1:length(cont)
    tmp = find(bc.c(:,3) >cont(i)-0.1 &bc.c(:,3) <cont(i)+0.1);
    [tmp2,tmp3] = sort(bc.c(tmp,2));
    plot3(wrapTo360(bc.c(tmp(tmp3),1)),bc.c(tmp(tmp3),2),bc.c(tmp(tmp3),3),'k','lineWidth',1)
    begs(i,:) = [wrapTo360(bc.c(tmp(tmp3(1)),1)) bc.c(tmp(tmp3(1)),2) bc.c(tmp(tmp3(1)),3)];
    ends(i,:) = [wrapTo360(bc.c(tmp(tmp3(end)),1)) bc.c(tmp(tmp3(end)),2) bc.c(tmp(tmp3(end)),3)];
    clear('tmp*')
end
plot3(begs(:,1),begs(:,2),begs(:,3),'k','lineWidth',1)
plot3(ends(:,1),ends(:,2),ends(:,3),'k','lineWidth',1)
% plot the coastline
plot(lon,lat,'color',coast,'lineWidth',0.5)
% aesthetics
shading flat
caxis(cax)
axis('equal',ax); view([0 90])
box on; grid on; yticks(40:2:50); xticks(232:2:238); 
yticklabels({}); xticklabels({'128°W','','','122°W'})
text(238.5,50.5,'Bloch','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'d','HorizontalAlignment','center','VerticalAlignment','middle')


% now calculating and plotting curvature 
curvs = tricurv_v01(s.v,s.c);
for i = 1:s.nEl
    ncurvs(i) = mean([curvs.km(s.v(i,1)) curvs.km(s.v(i,2)) curvs.km(s.v(i,3))]);
end
curvm = tricurv_v01(m.v,m.c);
for i = 1:m.nEl
    ncurvm(i) = mean([curvm.km(m.v(i,1)) curvm.km(m.v(i,2)) curvm.km(m.v(i,3))]);
end
curvbc = tricurv_v01(bc.v,bc.c);
for i = 1:bc.nEl
    ncurvbc(i) = mean([curvbc.km(bc.v(i,1)) curvbc.km(bc.v(i,2)) curvbc.km(bc.v(i,3))]);
end
curvwb = tricurv_v01(wb.v,wb.c);
for i = 1:wb.nEl
    ncurvwb(i) = mean([curvwb.km(wb.v(i,1)) curvwb.km(wb.v(i,2)) curvwb.km(wb.v(i,3))]);
end

% plot the curvature
figure(14); clf; set(gcf,'position',[1   491   964   390])
cmap = cork; cax = [-1 1];
subplot(1,4,1)
trisurf(m.v, wrapTo360(m.c(:,1)), m.c(:,2),m.c(:,3),ncurvm)
hold on
% plot the contours
cont = [-5:-5:-40];
for i = 1:length(cont)
    tmp = find(m.c(:,3) >cont(i)-0.1 &m.c(:,3) <cont(i)+0.1);
    [tmp2,tmp3] = sort(m.c(tmp,2));
    plot3(wrapTo360(m.c(tmp(tmp3),1)),m.c(tmp(tmp3),2),m.c(tmp(tmp3),3),'k','lineWidth',1)
    begs(i,:) = [wrapTo360(m.c(tmp(tmp3(1)),1)) m.c(tmp(tmp3(1)),2) m.c(tmp(tmp3(1)),3)];
    ends(i,:) = [wrapTo360(m.c(tmp(tmp3(end)),1)) m.c(tmp(tmp3(end)),2) m.c(tmp(tmp3(end)),3)];
    clear('tmp*')
end
plot3(begs(:,1),begs(:,2),begs(:,3),'k','lineWidth',1)
plot3(ends(:,1),ends(:,2),ends(:,3),'k','lineWidth',1)
% plot the coastline
plot(lon,lat,'color',coast,'lineWidth',0.5)
% aesthetics
shading flat; colormap(cmap) 
caxis(cax)
axis('equal',ax); view([0 90])
box on; grid on; yticks(40:2:50); xticks(232:2:238); 
yticklabels({'40°N','','','','','50°N'}); xticklabels({'128°W','','','122°W'})
text(238.5,50.5,'McCrory','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'e','HorizontalAlignment','center','VerticalAlignment','middle')

subplot(1,4,2)
trisurf(s.v, wrapTo360(s.c(:,1)), s.c(:,2),s.c(:,3),ncurvs)
hold on
% plot the contours
cont = [-6.5 -10:-5:-40];
for i = 1:length(cont)
    tmp = find(s.c(:,3) >cont(i)-0.1 &s.c(:,3) <cont(i)+0.1);
    [tmp2,tmp3] = sort(s.c(tmp,2));
    plot3(wrapTo360(s.c(tmp(tmp3),1)),s.c(tmp(tmp3),2),s.c(tmp(tmp3),3),'k','lineWidth',1)
    begs(i,:) = [wrapTo360(s.c(tmp(tmp3(1)),1)) s.c(tmp(tmp3(1)),2) s.c(tmp(tmp3(1)),3)];
    ends(i,:) = [wrapTo360(s.c(tmp(tmp3(end)),1)) s.c(tmp(tmp3(end)),2) s.c(tmp(tmp3(end)),3)];
    clear('tmp*')
end
plot3(begs(:,1),begs(:,2),begs(:,3),'k','lineWidth',1)
plot3(ends(:,1),ends(:,2),ends(:,3),'k','lineWidth',1)
% plot the coastline
plot(lon,lat,'color',coast,'lineWidth',0.5)
% aesthetics
shading flat
caxis(cax)
axis('equal',ax); view([0 90])
box on; grid on; yticks(40:2:50); xticks(232:2:238); 
yticklabels({}); xticklabels({'128°W','','','122°W'})
text(238.5,50.5,'Slab2','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'f','HorizontalAlignment','center','VerticalAlignment','middle')

subplot(1,4,3)
trisurf(wb.v, wrapTo360(wb.c(:,1)), wb.c(:,2),wb.c(:,3),ncurvwb)
hold on
% plot the contours
cont = [-5:-5:-40];
for i = 1:length(cont)
    tmp = find(wb.c(:,3) >cont(i)-0.1 &wb.c(:,3) <cont(i)+0.1);
    [tmp2,tmp3] = sort(wb.c(tmp,2));
    plot3(wrapTo360(wb.c(tmp(tmp3),1)),wb.c(tmp(tmp3),2),wb.c(tmp(tmp3),3),'k','lineWidth',1)
    begs(i,:) = [wrapTo360(wb.c(tmp(tmp3(1)),1)) wb.c(tmp(tmp3(1)),2) wb.c(tmp(tmp3(1)),3)];
    ends(i,:) = [wrapTo360(wb.c(tmp(tmp3(end)),1)) wb.c(tmp(tmp3(end)),2) wb.c(tmp(tmp3(end)),3)];
    clear('tmp*')
end
plot3(begs(:,1),begs(:,2),begs(:,3),'k','lineWidth',1)
plot3(ends(:,1),ends(:,2),ends(:,3),'k','lineWidth',1)
% plot the coastline
plot(lon,lat,'color',coast,'lineWidth',0.5)
% aesthetics
shading flat
caxis(cax)
axis('equal',ax); view([0 90])
box on; grid on; yticks(40:2:50); xticks(232:2:238); 
yticklabels({}); xticklabels({'128°W','','','122°W'})
text(238.5,50.5,'Sypus','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'g','HorizontalAlignment','center','VerticalAlignment','middle')

subplot(1,4,4)
trisurf(bc.v, wrapTo360(bc.c(:,1)), bc.c(:,2),bc.c(:,3),ncurvbc)
hold on
% plot the contours
cont = [-6.5 -10:-5:-40];
for i = 1:length(cont)
    tmp = find(bc.c(:,3) >cont(i)-0.1 &bc.c(:,3) <cont(i)+0.1);
    [tmp2,tmp3] = sort(bc.c(tmp,2));
    plot3(wrapTo360(bc.c(tmp(tmp3),1)),bc.c(tmp(tmp3),2),bc.c(tmp(tmp3),3),'k','lineWidth',1)
    begs(i,:) = [wrapTo360(bc.c(tmp(tmp3(1)),1)) bc.c(tmp(tmp3(1)),2) bc.c(tmp(tmp3(1)),3)];
    ends(i,:) = [wrapTo360(bc.c(tmp(tmp3(end)),1)) bc.c(tmp(tmp3(end)),2) bc.c(tmp(tmp3(end)),3)];
    clear('tmp*')
end
plot3(begs(:,1),begs(:,2),begs(:,3),'k','lineWidth',1)
plot3(ends(:,1),ends(:,2),ends(:,3),'k','lineWidth',1)
% plot the coastline
plot(lon,lat,'color',coast,'lineWidth',0.5)
% aesthetics
shading flat
caxis(cax)
axis('equal',ax); view([0 90])
box on; grid on; yticks(40:2:50); xticks(232:2:238); 
yticklabels({}); xticklabels({'128°W','','','122°W'})
text(238.5,50.5,'Bloch','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'h','HorizontalAlignment','center','VerticalAlignment','middle')


%% Figure 3 - Diff. in longitude from McCrory @ depth contours
% define latitude spacing (°) and depth tolerance (km)
xq = [39.8:0.1:50.5]; tol = 0.9;

% get the contour info
[con.bclon10,con.bcstrk10,con.bcdip10] = getContourInfo(-10,bc,xq,tol);
[con.slon10,con.sstrk10,con.sdip10] = getContourInfo(-10,s,xq,tol);
[con.mlon10,con.mstrk10,con.mdip10] = getContourInfo(-10,m,xq,tol);
[con.wblon10,con.wbstrk10,con.wbdip10] = getContourInfo(-10,wb,xq,tol);
[con.bclon20,con.bcstrk20,con.bcdip20] = getContourInfo(-20,bc,xq,tol);
[con.slon20,con.sstrk20,con.sdip20] = getContourInfo(-20,s,xq,tol);
[con.mlon20,con.mstrk20,con.mdip20] = getContourInfo(-20,m,xq,tol);
[con.wblon20,con.wbstrk20,con.wbdip20] = getContourInfo(-20,wb,xq,tol);
[con.bclon30,con.bcstrk30,con.bcdip30] = getContourInfo(-30,bc,xq,tol);
[con.slon30,con.sstrk30,con.sdip30] = getContourInfo(-30,s,xq,tol);
[con.mlon30,con.mstrk30,con.mdip30] = getContourInfo(-30,m,xq,tol);
[con.wblon30,con.wbstrk30,con.wbdip30] = getContourInfo(-30,wb,xq,tol);
[con.bclon40,con.bcstrk40,con.bcdip40] = getContourInfo(-40,bc,xq,tol);
[con.slon40,con.sstrk40,con.sdip40] = getContourInfo(-40,s,xq,tol);
[con.mlon40,con.mstrk40,con.mdip40] = getContourInfo(-40,m,xq,tol);
[con.wblon40,con.wbstrk40,con.wbdip40] = getContourInfo(-40,wb,xq,tol);
% condense variables for plotting
con.lonm = [con.mlon10', con.mlon20', con.mlon30', con.mlon40'];
con.lonbc = [con.bclon10', con.bclon20', con.bclon30', con.bclon40'];
con.lons = [con.slon10', con.slon20', con.slon30', con.slon40'];
con.lonwb = [con.wblon10', con.wblon20', con.wblon30', con.wblon40'];
con.strkm = [con.mstrk10',con.mstrk20',con.mstrk30',con.mstrk40'];
con.strkbc = [con.bcstrk10',con.bcstrk20',con.bcstrk30',con.bcstrk40'];
con.strks = [con.sstrk10',con.sstrk20',con.sstrk30',con.sstrk40'];
con.strkwb = [con.wbstrk10',con.wbstrk20',con.wbstrk30',con.wbstrk40'];
con.dipm = [con.mdip10', con.mdip20', con.mdip30', con.mdip40'];
con.dipbc = [con.bcdip10', con.bcdip20', con.bcdip30', con.bcdip40'];
con.dips = [con.sdip10', con.sdip20', con.sdip30', con.sdip40'];
con.dipwb = [con.wbdip10', con.wbdip20', con.wbdip30', con.wbdip40'];

% set x axis region for patch plotting
regxx = [-1 1];
% plot difference in longitude from McCrory
figure(3); clf; set(gcf,'Position',[448   344   544   522]); 
% 10 km (a)
subplot(1,4,1); hold on
% plot the region as background first
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% plot contour differences
plot(wrapTo360(con.lonm(:,1))-wrapTo360(con.lonm(:,1)),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lons(:,1))-wrapTo360(con.lonm(:,1)),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lonwb(:,1))-wrapTo360(con.lonm(:,1)),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lonbc(:,1))-wrapTo360(con.lonm(:,1)),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis('equal',[-1 1 39.5 51]); box on
yticks(40:2:50); yticklabels({'40°N','','','','','50°N'})
xticks(-1:0.25:1); xticklabels({'1°W','','','','0','','','','1°E'})
xlabel('\Delta Longitude (°)')
%legend('','','','','','Sypus','McCrory','Bloch','Slab2')
% add letter labels
patch([-1 -0.65 -0.65 -1],[51 51 50.65 50.65],'w','EdgeColor','k')
text(-0.85,50.85,'a','HorizontalAlignment','center','VerticalAlignment','middle')
text(0.9,50.75,'10 km','HorizontalAlignment','right')
% add region labels
text(1.25,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(1.25,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(1.25,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(1.25,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(1.25,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
set(gca,'FontSize',fsz,'Layer','top')

% 20 km (b)
subplot(1,4,2); hold on
% plot the region as background first
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% plot contour differences
plot(wrapTo360(con.lonm(:,2))-wrapTo360(con.lonm(:,2)),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lons(:,2))-wrapTo360(con.lonm(:,2)),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lonwb(:,2))-wrapTo360(con.lonm(:,2)),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lonbc(:,2))-wrapTo360(con.lonm(:,2)),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis('equal',[-1 1 39.5 51]); box on
yticks(40:2:50); yticklabels({})
xticks(-1:0.25:1); xticklabels({'1°W','','','','0','','','','1°E'})
xlabel('\Delta Longitude (°)')
%legend('','','','','','Sypus','McCrory','Bloch','Slab2')
% add letter labels
patch([-1 -0.65 -0.65 -1],[51 51 50.65 50.65],'w','EdgeColor','k')
text(-0.85,50.85,'b','HorizontalAlignment','center','VerticalAlignment','middle')
text(0.9,50.75,'20 km','HorizontalAlignment','right')
% add region labels
text(1.25,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(1.25,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(1.25,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(1.25,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(1.25,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
set(gca,'FontSize',fsz,'Layer','top')

% 30 km (c)
subplot(1,4,3); hold on
% plot the region as background first
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% plot contour differences
plot(wrapTo360(con.lonm(:,3))-wrapTo360(con.lonm(:,3)),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lons(:,3))-wrapTo360(con.lonm(:,3)),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lonwb(:,3))-wrapTo360(con.lonm(:,3)),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lonbc(:,3))-wrapTo360(con.lonm(:,3)),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis('equal',[-1 1 39.5 51]); box on
yticks(40:2:50); yticklabels({})
xticks(-1:0.25:1); xticklabels({'1°W','','','','0','','','','1°E'})
xlabel('\Delta Longitude (°)')
%legend('','','','','','Sypus','McCrory','Bloch','Slab2')
% add letter labels
patch([-1 -0.65 -0.65 -1],[51 51 50.65 50.65],'w','EdgeColor','k')
text(-0.85,50.85,'c','HorizontalAlignment','center','VerticalAlignment','middle')
text(0.9,50.75,'30 km','HorizontalAlignment','right')
% add region labels
text(1.25,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(1.25,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(1.25,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(1.25,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(1.25,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
set(gca,'FontSize',fsz,'Layer','top')

% 40 km
subplot(1,4,4); hold on
% plot the region as background first
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% plot contour differences
plot(wrapTo360(con.lonm(:,4))-wrapTo360(con.lonm(:,4)),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lons(:,4))-wrapTo360(con.lonm(:,4)),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lonwb(:,4))-wrapTo360(con.lonm(:,4)),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lonbc(:,4))-wrapTo360(con.lonm(:,4)),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis('equal',[-1 1 39.5 51]); box on
yticks(40:2:50); yticklabels({})
xticks(-1:0.25:1); xticklabels({'1°W','','','','0','','','','1°E'})
xlabel('\Delta Longitude (°)')
%legend('','','','','','Sypus','McCrory','Bloch','Slab2')
% add letter labels
patch([-1 -0.65 -0.65 -1],[51 51 50.65 50.65],'w','EdgeColor','k')
text(-0.85,50.85,'d','HorizontalAlignment','center','VerticalAlignment','middle')
text(0.9,50.75,'40 km','HorizontalAlignment','right')
% add region labels
text(1.25,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(1.25,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(1.25,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(1.25,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(1.25,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
set(gca,'FontSize',fsz,'Layer','top')


%% Figure 4 - Strike of mesh @ depth contours
% set x axis region for patch plotting
regxx = [-90 90];

figure(4); clf; set(gcf,'Position',[448   352   807   514]); 
% 10 km (a)
subplot(1,4,1); hold on
% plot the region as background first
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
plot([0 0],[39.5 51],'k')
plot(con.strkm(:,1),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strks(:,1),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strkwb(:,1),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strkbc(:,1),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis([-75 75 39.5 51]); box on
xlabel('Strike (°)')
yticks(40:2:50); yticklabels({'40°N','','','','','50°N'})
xticks(-75:15:75); xticklabels({'','','315','','','0','','','45','',''})
%legend('','','','','','','Sypus','McCrory','Bloch','Slab2')
text(72,50.75,'10 km','HorizontalAlignment','right')
set(gca,'FontSize',fsz,'Layer','top')
% add region labels
text(85,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(85,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(85,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(85,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(85,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
% add letter labels
patch([-75 -59 -59 -75],[51 51 50.6 50.6],'w','EdgeColor','k')
text(-67,50.8,'a','HorizontalAlignment','center','VerticalAlignment','middle')

% 20 km (b)
subplot(1,4,2); hold on
% plot the region as background first
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
plot([0 0],[39.5 51],'k')
plot(con.strkm(:,2),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strks(:,2),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strkwb(:,2),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strkbc(:,2),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis([-75 75 39.5 51]); box on
xlabel('Strike (°)')
yticks(40:2:50); yticklabels({})
xticks(-75:15:75); xticklabels({'','','315','','','0','','','45','',''})
text(72,50.75,'20 km','HorizontalAlignment','right')
set(gca,'FontSize',fsz,'Layer','top')
% add region labels
text(85,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(85,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(85,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(85,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(85,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
% add letter labels
patch([-75 -59 -59 -75],[51 51 50.6 50.6],'w','EdgeColor','k')
text(-67,50.8,'b','HorizontalAlignment','center','VerticalAlignment','middle')

% 30 km (c)
subplot(1,4,3); hold on
% plot the region as background first
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
plot([0 0],[39.5 51],'k')
plot(con.strkm(:,3),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strks(:,3),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strkwb(:,3),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strkbc(:,3),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis([-75 75 39.5 51]); box on
xlabel('Strike (°)')
yticks(40:2:50); yticklabels({})
xticks(-75:15:75); xticklabels({'','','315','','','0','','','45','',''})
text(72,50.75,'30 km','HorizontalAlignment','right')
set(gca,'FontSize',fsz,'Layer','top')
% add region labels
text(85,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(85,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(85,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(85,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(85,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
% add letter labels
patch([-75 -59 -59 -75],[51 51 50.6 50.6],'w','EdgeColor','k')
text(-67,50.8,'c','HorizontalAlignment','center','VerticalAlignment','middle')

% 40 km (d)
subplot(1,4,4); hold on
% plot the region as background first
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
plot([0 0],[39.5 51],'k')
plot(con.strkm(:,4),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strks(:,4),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strkwb(:,4),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strkbc(:,4),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis([-75 75 39.5 51]); box on
xlabel('Strike (°)')
yticks(40:2:50); yticklabels({})
xticks(-75:15:75); xticklabels({'','','315','','','0','','','45','',''})
text(72,50.75,'40 km','HorizontalAlignment','right')
set(gca,'FontSize',fsz,'Layer','top')
% add region labels
text(85,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(85,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(85,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(85,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(85,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
% add letter labels
patch([-75 -59 -59 -75],[51 51 50.6 50.6],'w','EdgeColor','k')
text(-67,50.8,'d','HorizontalAlignment','center','VerticalAlignment','middle')


%% Figure 5 - Uniform slip results (broken into figure windows 5,10-12)
% part a - surface displacement map
% only want to show select stations (otherwise it's too crowded)
lonspc = 0.5;
latspc = 0.25;
keep = [];
for i = 231.05:lonspc:240
    for j = 39:latspc:51
        loc = find(stations.lon < i+lonspc & stations.lon >= i &...
            stations.lat < j+latspc & stations.lat >= j);
        if max(size(loc)) > 0
            tmp = sqrt((stations.lon(loc)-(i+lonspc/2)).^2+(stations.lat(loc)-(j+latspc/2)).^2);
            tmp = find(tmp==min(tmp),1);
            keep = [keep;loc(tmp)];
        end
    end
end
% find the stations where at least one model differs by > 4 mm
dif.ms = sqrt((vel.m(1:3:end)-vel.s(1:3:end)).^2 + ...
    (vel.m(2:3:end)-vel.s(2:3:end)).^2)./40;
dif.mw = sqrt((vel.m(1:3:end)-vel.wb(1:3:end)).^2 + ...
    (vel.m(2:3:end)-vel.wb(2:3:end)).^2)./40;
dif.mb = sqrt((vel.m(1:3:end)-vel.bc(1:3:end)).^2 + ...
    (vel.m(2:3:end)-vel.bc(2:3:end)).^2)./40;
dif.sw = sqrt((vel.s(1:3:end)-vel.wb(1:3:end)).^2 + ...
    (vel.s(2:3:end)-vel.wb(2:3:end)).^2)./40;
dif.sb = sqrt((vel.s(1:3:end)-vel.bc(1:3:end)).^2 + ...
    (vel.s(2:3:end)-vel.bc(2:3:end)).^2)./40;
dif.wb = sqrt((vel.wb(1:3:end)-vel.bc(1:3:end)).^2 + ...
    (vel.wb(2:3:end)-vel.bc(2:3:end)).^2)./40;
statRed = dif.ms >0.1 |dif.mw >0.1 |dif.mb >0.1 |dif.sw >0.1 |dif.sb >0.1 |dif.wb >0.1;
clear('tmp','loc','dif')

% set vector length scale
arleng = 0.8;
% plot a
figure(5); clf; set(gcf,'position',[440   629   564   668])
plot(lon,lat,'k','lineWidth',1)
hold on
plot(stations.lon(statRed),stations.lat(statRed),'r.','markerSize',8)
plot(stations.lon(statRed==0),stations.lat(statRed==0),'k.','markerSize',8)
quiver([232; stations.lon(keep)],[40; stations.lat(keep)],...
    [10; vel.m(keep*3-2)],[0; vel.m(keep*3-1)],arleng,'color',colors(3,:),'lineWidth',1,'MaxHeadSize',0.02)
quiver([232; stations.lon(keep)],[40; stations.lat(keep)],...
    [10; vel.s(keep*3-2)],[0; vel.s(keep*3-1)],arleng,'color',colors(2,:),'lineWidth',1,'MaxHeadSize',0.02)
quiver([232; stations.lon(keep)],[40; stations.lat(keep)],...
    [10; vel.wb(keep*3-2)],[0; vel.wb(keep*3-1)],arleng,'color',colors(4,:),'lineWidth',1,'MaxHeadSize',0.02)
quiver([232; stations.lon(keep)],[40; stations.lat(keep)],...
    [10; vel.bc(keep*3-2)],[0; vel.bc(keep*3-1)],arleng,'color',colors(1,:),'lineWidth',1,'MaxHeadSize',0.02)
% general aestetics
axis('equal',[231.5 238.5 39.5 51])
yticks(40:2:50); yticklabels({'40°N','','','','','50°N'})
xticks(232:2:238); xticklabels({'128°W','','','122°W'})
box on; grid on
legend('','>4 mm','<4 mm','McCrory','Slab2','Sypus','Bloch')
set(gca,'fontSize',fsz)

% part b (all contained within a separate function)
[cormat] = dispDiffCorrelationMatrix([vel.bc,vel.bt,vel.m,vel.s,vel.w,vel.wb],{'B-c','B-t','M','S','W-G','W-A'},oslo,10);

% parts c and d prep calculations/grouping
% find all stations in each region
wrtl.loc1 = find(stations.lat > regy(5) & stations.lat < regy(6) & ...
    stations.lon > regx(1) & stations.lon < regx(2));
wrtl.loc2 = find(stations.lat > regy(4) & stations.lat < regy(5) & ...
    stations.lon > regx(1) & stations.lon < regx(2));
wrtl.loc3 = find(stations.lat > regy(3) & stations.lat < regy(4) & ...
    stations.lon > regx(1) & stations.lon < regx(2));
wrtl.loc4 = find(stations.lat > regy(2) & stations.lat < regy(3) & ...
    stations.lon > regx(1) & stations.lon < regx(2));
wrtl.loc5 = find(stations.lat > regy(1) & stations.lat < regy(2) & ...
    stations.lon > regx(1) & stations.lon < regx(2));
% calculate the magnitude (mag) and azimuth (az) for each surf. disp.
wrtl.magbc = sqrt(vel.bc(1:3:end).^2+vel.bc(2:3:end).^2);
    wrtl.azbc = rad2deg(atan(vel.bc(2:3:end)./vel.bc(1:3:end)));
wrtl.magwb = sqrt(vel.wb(1:3:end).^2+vel.wb(2:3:end).^2);
    wrtl.azwb = rad2deg(atan(vel.wb(2:3:end)./vel.wb(1:3:end)));
wrtl.magm = sqrt(vel.m(1:3:end).^2+vel.m(2:3:end).^2);
    wrtl.azm = rad2deg(atan(vel.m(2:3:end)./vel.m(1:3:end)));
wrtl.mags = sqrt(vel.s(1:3:end).^2+vel.s(2:3:end).^2);
    wrtl.azs = rad2deg(atan(vel.s(2:3:end)./vel.s(1:3:end)));

wrtl.magbt = sqrt(vel.bt(1:3:end).^2+vel.bt(2:3:end).^2);
    wrtl.azbt = rad2deg(atan(vel.bt(2:3:end)./vel.bt(1:3:end)));
wrtl.magw = sqrt(vel.w(1:3:end).^2+vel.w(2:3:end).^2);
    wrtl.azw = rad2deg(atan(vel.w(2:3:end)./vel.w(1:3:end)));
    
% plot up azimuth (c)
figure(11); clf; set(gcf,'Position',[477   474   148   407])
subplot(5,1,1) % Region 1
boxchart(ones(size(wrtl.loc1))*4,wrtl.azm(wrtl.loc1)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc1))*3,wrtl.azs(wrtl.loc1)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc1))*2,wrtl.azwb(wrtl.loc1)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc1)),wrtl.azbc(wrtl.loc1)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 -40 55]); box on
xticks([])
yticks([-45:15:45]); yticklabels({'','120','','90','','60',''})
camroll(90)

subplot(5,1,2) % Region 2
boxchart(ones(size(wrtl.loc2))*4,wrtl.azm(wrtl.loc2)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc2))*3,wrtl.azs(wrtl.loc2)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc2))*2,wrtl.azwb(wrtl.loc2)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc2)),wrtl.azbc(wrtl.loc2)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 -40 55]); box on
xticks([])
yticks([-45:15:45]); yticklabels({'','120','','90','','60',''})
camroll(90)

subplot(5,1,3) % Region 3
boxchart(ones(size(wrtl.loc3))*4,wrtl.azm(wrtl.loc3)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc3))*3,wrtl.azs(wrtl.loc3)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc3))*2,wrtl.azwb(wrtl.loc3)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc3)),wrtl.azbc(wrtl.loc3)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 -40 55]); box on
xticks([])
yticks([-45:15:45]); yticklabels({'','120','','90','','60',''})
camroll(90)

subplot(5,1,4) % Region 4
boxchart(ones(size(wrtl.loc4))*4,wrtl.azm(wrtl.loc4)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc4))*3,wrtl.azs(wrtl.loc4)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc4))*2,wrtl.azwb(wrtl.loc4)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc4)),wrtl.azbc(wrtl.loc4)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 -40 55]); box on
xticks([])
yticks([-45:15:45]); yticklabels({'','120','','90','','60',''})
camroll(90)

subplot(5,1,5) % Region 5
boxchart(ones(size(wrtl.loc5))*4,wrtl.azm(wrtl.loc5)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc5))*3,wrtl.azs(wrtl.loc5)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc5))*2,wrtl.azwb(wrtl.loc5)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc5)),wrtl.azbc(wrtl.loc5)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 -40 55]); box on
xticks([])
yticks([-45:15:45]); yticklabels({'','120','','90','','60',''})
camroll(90)

% plot up magnitude (d)
figure(12); clf; %set(gcf,'Position',[1984 203 209 676])
subplot(5,1,1) % Region 1
boxchart(ones(size(wrtl.loc1)),wrtl.magm(wrtl.loc1)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc1))*2,wrtl.mags(wrtl.loc1)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc1))*3,wrtl.magwb(wrtl.loc1)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc1))*4,wrtl.magbc(wrtl.loc1)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 0 30]); box on
xticks([])
yticks([0:10:30]); yticklabels({'0','','','30'})
camroll(270)

subplot(5,1,2) % Region 2
boxchart(ones(size(wrtl.loc2)),wrtl.magm(wrtl.loc2)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc2))*2,wrtl.mags(wrtl.loc2)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc2))*3,wrtl.magwb(wrtl.loc2)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc2))*4,wrtl.magbc(wrtl.loc2)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 0 30]); box on
xticks([])
yticks([0:10:30]); yticklabels({'0','','','30'})
camroll(270)

subplot(5,1,3) % Region 3
boxchart(ones(size(wrtl.loc3)),wrtl.magm(wrtl.loc3)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc3))*2,wrtl.mags(wrtl.loc3)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc3))*3,wrtl.magwb(wrtl.loc3)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc3))*4,wrtl.magbc(wrtl.loc3)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 0 30]); box on
xticks([])
yticks([0:10:30]); yticklabels({'0','','','30'})
camroll(270)

subplot(5,1,4) % Region 4
boxchart(ones(size(wrtl.loc4)),wrtl.magm(wrtl.loc4)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc4))*2,wrtl.mags(wrtl.loc4)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc4))*3,wrtl.magwb(wrtl.loc4)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc4))*4,wrtl.magbc(wrtl.loc4)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 0 30]); box on
xticks([])
yticks([0:10:30]); yticklabels({'0','','','30'})
camroll(270)

subplot(5,1,5) % Region 5
boxchart(ones(size(wrtl.loc5)),wrtl.magm(wrtl.loc5)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc5))*2,wrtl.mags(wrtl.loc5)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc5))*3,wrtl.magwb(wrtl.loc5)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc5))*4,wrtl.magbc(wrtl.loc5)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 0 30]); box on
xticks([])
yticks([0:10:30]); yticklabels({'0','','','30'})
camroll(270)


%% Figure 6 - Applied Gaussian slip (McCrory) 
% plot the input slip distribution
figure(6); clf %set(gcf,'position',[1 295 1512 571])
regxx = [231 239];
trisurf(p_in.v, wrapTo360(p_in.c(:,1)), p_in.c(:,2),p_in.c(:,3),g)
hold on
meshedges([wrapTo360(p_in.c(:,1)),p_in.c(:,2),p_in.c(:,3)],p_in.v,p_in.nEl,6,'color','k','LineWidth',1);
% plot the coast
plot(lon,lat,'k','lineWidth',0.5)
% plot select surface displacements
lonspc = 0.5;
latspc = 0.25;
keep = [];
for i = 231.05:lonspc:240
    for j = 39:latspc:51
        loc = find(stations.lon < i+lonspc & stations.lon >= i &...
            stations.lat < j+latspc & stations.lat >= j);
        if max(size(loc)) > 0
            tmp = sqrt((stations.lon(loc)-(i+lonspc/2)).^2+...
                (stations.lat(loc)-(j+latspc/2)).^2);
            tmp = find(tmp==min(tmp),1);
            keep = [keep;loc(tmp)];
        end
    end
end
clear('tmp','loc')
quiver([233; stations.lon(keep)],[40.5; stations.lat(keep)],...
    [10; velg(keep*3-2)],[0; velg(keep*3-1)],0.9,'color','r')
% general aesthetics
axis('equal',[231 239 39.5 51 -41 0.2]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({'40°N','','','','','50°N'})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(grayC); caxis([-5 45]); shading flat
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.3,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(239.3,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(239.3,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(239.3,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(239.3,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')

%% Figure 7 - Slip distributions for inversions of surf. disp.(McCrory)(broken into figure windows 7 & 13)
% create a lat lon grid to interpolate slip onto
latspc = 39.5:0.1:51; lonspc = 231.7:0.1:238;
    [X,Y] = meshgrid(lonspc,latspc);
    
% create a polygon from mesh edges and find grid squares within the bounds
p = bc; % Bloch c
    i = meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)+40],p.v,p.nEl,7);
    poly.bcx = i.XData;
    poly.bcy = i.YData;
    in.bc = inpolygon(X(:),Y(:),poly.bcx,poly.bcy); 
p = m; % McCrory
    i = meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)+40],p.v,p.nEl,7);
    poly.mx = i.XData;
    poly.my = i.YData;
    in.m = inpolygon(X(:),Y(:),poly.mx,poly.my);
% input model (McCrory in this case)
i = meshedges([wrapTo360(p_in.c(:,1)),p_in.c(:,2),p_in.c(:,3)+40],p_in.v,p_in.nEl,7);
    poly.inx = i.XData;
    poly.iny = i.YData;
    in.in = inpolygon(X(:),Y(:),poly.inx,poly.iny);
p = s; % Slab2
    i = meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)+40],p.v,p.nEl,7);
    poly.sx = i.XData;
    poly.sy = i.YData;
    in.s = inpolygon(X(:),Y(:),poly.sx,poly.sy);
p = wb; % Sypus "adjusted buried"
    i = meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)+40],p.v,p.nEl,7);
    poly.wbx = i.XData;
    poly.wby = i.YData;
    in.wb = inpolygon(X(:),Y(:),poly.wbx,poly.wby);
    
% interpolate the slip onto the grid and sub NaN where meshes don't overlap
p = bc; % Bloch c
    outu = mean(out_main.bc,2);
    v.bc = griddata(wrapTo360(p.lonc),p.latc,outu(2:2:end),X(:),Y(:),'natural');
    v.bc = v.bc.*in.bc;
    v.bc(v.bc==0) = NaN;
p = m; % McCrory
    outu = mean(out_main.m,2);
    v.m = griddata(wrapTo360(p.lonc),p.latc,outu(2:2:end),X(:),Y(:),'natural');
    v.m = v.m.*in.m;
    v.m(v.m==0) = NaN;
% input model (McCrory in this case)
v.in = griddata(wrapTo360(p_in.lonc),p_in.latc,g,X(:),Y(:),'natural');
    v.in = v.in.*in.in;
    v.in(v.in==0) = NaN;
p = s; % Slab2
    outu = mean(out_main.s,2);
    v.s = griddata(wrapTo360(p.lonc),p.latc,outu(2:2:end),X(:),Y(:),'natural');
    v.s = v.s.*in.s;
    v.s(v.s==0) = NaN;
p = wb; % Sypus "adjusted buried"
    outu = mean(out_main.wb,2);
    v.wb = griddata(wrapTo360(p.lonc),p.latc,outu(2:2:end),X(:),Y(:),'natural');
    v.wb = v.wb.*in.wb;
    v.wb(v.wb==0) = NaN;  
    
% calculate average slip misfit
slipMis.bc = mean(abs(v.bc(~isnan(v.bc)& ~isnan(v.in))-v.in(~isnan(v.bc)& ~isnan(v.in))));
slipMis.s = mean(abs(v.s(~isnan(v.s)& ~isnan(v.in))-v.in(~isnan(v.s)& ~isnan(v.in))));
slipMis.wb = mean(abs(v.wb(~isnan(v.wb)& ~isnan(v.in))-v.in(~isnan(v.wb)& ~isnan(v.in))));
slipMis.m = mean(abs(v.m(~isnan(v.m)& ~isnan(v.in))-v.in(~isnan(v.m)& ~isnan(v.in))));

% open figure
figure(7); clf; set(gcf,'position',[1   491   964   390])
% plot the output slip (a-d)
cax = [-5 45]; % set color axis limits
p = m; % McCrory
subplot(1,4,1)
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),mean(out_main.m(2:2:end,:),2))
hold on
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,7,'color','k','LineWidth',1);
% plot the coast
plot(lon,lat,'k','lineWidth',0.5)
% general aesthetics
axis('equal',[231 239 39.5 51 -41 0.2]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({'40°N','','','','','50°N'})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(grayC); caxis(cax); shading flat
text(238.7, 50.5,'McCrory','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'a','HorizontalAlignment','center','VerticalAlignment','middle')

p = s; % Slab2
subplot(1,4,2)
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),mean(out_main.s(2:2:end,:),2))
hold on
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,7,'color','k','LineWidth',1);
% plot the coast
plot(lon,lat,'k','lineWidth',0.5)
% general aesthetics
axis('equal',[231 239 39.5 51 -41 0.2]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(grayC); caxis(cax); shading flat
text(238.7, 50.5,'Slab2','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'b','HorizontalAlignment','center','VerticalAlignment','middle')

p = wb; % Sypus "adjusted buried"
subplot(1,4,3)
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),mean(out_main.wb(2:2:end,:),2))
hold on
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,7,'color','k','LineWidth',1);
% plot the coast
plot(lon,lat,'k','lineWidth',0.5)
% general aesthetics
axis('equal',[231 239 39.5 51 -41 0.2]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(grayC); caxis(cax); shading flat
text(238.7, 50.5,'Sypus','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'c','HorizontalAlignment','center','VerticalAlignment','middle')

p = bc; % Bloch c
subplot(1,4,4)
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),mean(out_main.bc(2:2:end,:),2))
hold on
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,7,'color','k','LineWidth',1);
% plot the coast
plot(lon,lat,'k','lineWidth',0.5)
% general aesthetics
axis('equal',[231 239 39.5 51 -41 0.2]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(grayC); caxis(cax); shading flat
text(238.7, 50.5,'Bloch','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'d','HorizontalAlignment','center','VerticalAlignment','middle')


% plot the gridded slip differences (e-h)
cax = [-15 15]; % set color axis limits

figure(13); clf; set(gcf,'position',[1   491   964   390])
p = m; % McCrory
subplot(1,4,1)
pcolor(X,Y,reshape(v.m-v.in,116,64));
hold on
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)+40],p.v,p.nEl,13,'color','k','LineWidth',1);
meshedges([wrapTo360(p_in.c(:,1)),p_in.c(:,2),p_in.c(:,3)+40],p_in.v,p_in.nEl,13,'color',[0.5 0 0],'LineWidth',1);
% plot the coast
plot(lon,lat,'k','lineWidth',0.5)
% general aesthetics
axis('equal',[231 239 39.5 51 -41 41]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({'40°N','','','','','50°N'})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(vik); caxis(cax); shading flat
text(238.7, 50.5,'McCrory','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'e','HorizontalAlignment','center','VerticalAlignment','middle')

p = s; % Slab2
subplot(1,4,2)
pcolor(X,Y,reshape(v.s-v.in,116,64));
hold on
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)+40],p.v,p.nEl,13,'color','k','LineWidth',1);
meshedges([wrapTo360(p_in.c(:,1)),p_in.c(:,2),p_in.c(:,3)+40],p_in.v,p_in.nEl,13,'color',[0.5 0 0],'LineWidth',1);
% plot the coast
plot(lon,lat,'k','lineWidth',0.5)
% general aesthetics
axis('equal',[231 239 39.5 51 -41 41]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(vik); caxis(cax); shading flat
text(238.7, 50.5,'Slab2','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'f','HorizontalAlignment','center','VerticalAlignment','middle')

p = wb; % Sypus "adjusted buried"
subplot(1,4,3)
pcolor(X,Y,reshape(v.wb-v.in,116,64));
hold on
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)+40],p.v,p.nEl,13,'color','k','LineWidth',1);
meshedges([wrapTo360(p_in.c(:,1)),p_in.c(:,2),p_in.c(:,3)+40],p_in.v,p_in.nEl,13,'color',[0.5 0 0],'LineWidth',1);
% plot the coast
plot(lon,lat,'k','lineWidth',0.5)
% general aesthetics
axis('equal',[231 239 39.5 51 -41 41]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(vik); caxis(cax); shading flat
text(238.7, 50.5,'Sypus','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'g','HorizontalAlignment','center','VerticalAlignment','middle')

p = bc; % Bloch c
subplot(1,4,4)
pcolor(X,Y,reshape(v.bc-v.in,116,64));
hold on
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)+40],p.v,p.nEl,13,'color','k','LineWidth',1);
meshedges([wrapTo360(p_in.c(:,1)),p_in.c(:,2),p_in.c(:,3)+40],p_in.v,p_in.nEl,13,'color',[0.5 0 0],'LineWidth',1);
% plot the coast
plot(lon,lat,'k','lineWidth',0.5)
% general aesthetics
axis('equal',[231 239 39.5 51 -41 41]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(vik); caxis(cax); shading flat
text(238.7, 50.5,'Bloch','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'h','HorizontalAlignment','center','VerticalAlignment','middle')

%% Figure 8 - Block model coupling distributions
% calculate the coupling for each model
slip = seg.slipm;
coupling.m = mag(slip(:,1:2),2)./mag(slip(:,8:9),2).*sign(slip(:,2));
slip = seg.slipbc;
coupling.bc = mag(slip(:,1:2),2)./mag(slip(:,8:9),2).*sign(slip(:,2));
slip = seg.slips;
coupling.s = mag(slip(:,1:2),2)./mag(slip(:,8:9),2).*sign(slip(:,2));
slip = seg.slipw;
coupling.w = mag(slip(:,1:2),2)./mag(slip(:,8:9),2).*sign(slip(:,2));

% plot the coupling distributions
cmap = [0 1 0; vik(125:256,:)]; cax = [-0.1 1]; regxx = [231 239];
% McCrory
p = mccrory;
coup = coupling.m; loc = find(coup>0.8);
figure(8);clf
subplot(1,4,1)
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),coup)
hold on;
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,8,'color','k','LineWidth',1);
% define contours for coupling >80%
% this is not automated yet... currently using the lat. to differentiate
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v(loc(p.latc(loc)>44),:),length(loc(p.latc(loc)>44)),8,'color','w','lineWidth',2);
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v(loc(p.latc(loc)<44),:),length(loc(p.latc(loc)<44)),8,'color','w','lineWidth',2);
% grab some information about the high coupling patches
area8 = sum(p.area(loc(p.latc(loc)>44)));
len = max(p.latc(loc(p.latc(loc)>44)))-min(p.latc(loc(p.latc(loc)>44)));
dep = min(p.zc(loc(p.latc(loc)>44)));
area8 = sum(p.area(loc(p.latc(loc)<44)));
len = max(p.latc(loc(p.latc(loc)<44)))-min(p.latc(loc(p.latc(loc)<44)));
dep = min(p.zc(loc(p.latc(loc)<44)));

% repeat contour definition for coupling >50%
loc = find(coup>0.5);
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),coup)
hold on;
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v(loc,:),length(loc),8,'color','r','lineWidth',2);
area5 = sum(p.area(loc));
len = max(p.latc(loc))-min(p.latc(loc));
dep = min(p.zc(loc));
plot(lon,lat,'k','lineWidth',0.5)
axis('equal',[231 239 39.5 51 -41 41]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({'40°N','','','','','50°N'})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(cmap); caxis(cax); shading flat
text(238.7, 50.5,'McCrory','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'a','HorizontalAlignment','center','VerticalAlignment','middle')

% slab2
p = slab2; p = PatchCoords(p);
coup = coupling.s;
loc = find(coup>0.8);
subplot(1,4,2)
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),coup)
hold on;
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,8,'color','k','LineWidth',1);
% define contours for coupling >80%
% this is not automated yet... currently using the lat. to differentiate
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v(loc(p.latc(loc)>43),:),length(loc(p.latc(loc)>43)),8,'color','w','lineWidth',2);
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v(loc(p.latc(loc)<43),:),length(loc(p.latc(loc)<43)),8,'color','w','lineWidth',2);
% grab some information about the high coupling patches
area8 = sum(p.area(loc(p.latc(loc)>43)));
len = max(p.latc(loc(p.latc(loc)>43)))-min(p.latc(loc(p.latc(loc)>43)));
dep = min(p.zc(loc(p.latc(loc)>43)));
area8 = sum(p.area(loc(p.latc(loc)<43)));
len = max(p.latc(loc(p.latc(loc)<43)))-min(p.latc(loc(p.latc(loc)<43)));
dep = min(p.zc(loc(p.latc(loc)<43)));

% repeat contour definition for coupling >50%
loc = find(coup>0.5);
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),coup)
hold on;
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v(loc,:),length(loc),8,'color','r','lineWidth',2);
area5 = sum(p.area(loc));
len = max(p.latc(loc))-min(p.latc(loc));
dep = min(p.zc(loc));
plot(lon,lat,'k','lineWidth',0.5)
axis('equal',[231 239 39.5 51 -41 41]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(cmap); caxis(cax); shading flat
text(238.7, 50.5,'Slab2','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'b','HorizontalAlignment','center','VerticalAlignment','middle')


% sypus
p = sypus; p = PatchCoords(p);
coup = coupling.w;
loc = find(coup>0.8);
subplot(1,4,3)
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),coup)
hold on;
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,8,'color','k','LineWidth',1);
% define contours for coupling >80%
% this is not automated yet... currently using the lat. to differentiate
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v(loc(p.latc(loc)>43),:),length(loc(p.latc(loc)>43)),8,'color','w','lineWidth',2);
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v(loc(p.latc(loc)<43),:),length(loc(p.latc(loc)<43)),8,'color','w','lineWidth',2);
% grab some information about the high coupling patches
area8 = sum(p.area(loc(p.latc(loc)>43)));
len = max(p.latc(loc(p.latc(loc)>43)))-min(p.latc(loc(p.latc(loc)>43)));
dep = min(p.zc(loc(p.latc(loc)>43)));
area8 = sum(p.area(loc(p.latc(loc)<43)));
len = max(p.latc(loc(p.latc(loc)<43)))-min(p.latc(loc(p.latc(loc)<43)));
dep = min(p.zc(loc(p.latc(loc)<43)));

% repeat contour definition for coupling >50%
loc = find(coup>0.5);
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),coup)
hold on;
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v(loc,:),length(loc),8,'color','r','lineWidth',2);
area5 = sum(p.area(loc));
len = max(p.latc(loc))-min(p.latc(loc));
dep = min(p.zc(loc));
plot(lon,lat,'k','lineWidth',0.5)
axis('equal',[231 239 39.5 51 -41 41]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(cmap); caxis(cax); shading flat
text(238.7, 50.5,'Sypus','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'c','HorizontalAlignment','center','VerticalAlignment','middle')

% blochc
p = bloch; p = PatchCoords(p);
coup = coupling.bc;
loc = find(coup>0.8);
subplot(1,4,4)
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),coup)
hold on;
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,8,'color','k','LineWidth',1);
% define contours for coupling >80%
% this is not automated yet... currently using the lat. to differentiate
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v(loc(p.latc(loc)>43),:),length(loc(p.latc(loc)>43)),8,'color','w','lineWidth',2);
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v(loc(p.latc(loc)<43),:),length(loc(p.latc(loc)<43)),8,'color','w','lineWidth',2);
% grab some information about the high coupling patches
area8 = sum(p.area(loc(p.latc(loc)>43)));
len = max(p.latc(loc(p.latc(loc)>43)))-min(p.latc(loc(p.latc(loc)>43)));
dep = min(p.zc(loc(p.latc(loc)>43)));
area8 = sum(p.area(loc(p.latc(loc)<43)));
len = max(p.latc(loc(p.latc(loc)<43)))-min(p.latc(loc(p.latc(loc)<43)));
dep = min(p.zc(loc(p.latc(loc)<43)));

% repeat contour definition for coupling >50%
loc = find(coup>0.5);
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),coup)
hold on;
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v(loc,:),length(loc),8,'color','r','lineWidth',2);
area5 = sum(p.area(loc));
len = max(p.latc(loc))-min(p.latc(loc));
dep = min(p.zc(loc));
area5 = sum(p.area(loc(p.latc(loc)<42)));
len = max(p.latc(loc(p.latc(loc)<42)))-min(p.latc(loc(p.latc(loc)<42)));
dep = min(p.zc(loc(p.latc(loc)<42)));
area5 = sum(p.area(loc(p.latc(loc)>42)));
len = max(p.latc(loc(p.latc(loc)>42)))-min(p.latc(loc(p.latc(loc)>42)));
dep = min(p.zc(loc(p.latc(loc)>42)));
plot(lon,lat,'k','lineWidth',0.5)
axis('equal',[231 239 39.5 51 -41 41]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(cmap); caxis(cax); shading flat
text(238.7, 50.5,'Bloch','HorizontalAlignment','right','fontSize',fsz)
set(gca,'fontSize',fsz,'color','none','Layer','top')
% plot the region as background at the end otherwise it hides
for i = 1:length(regy)-1
    if rem(i,2) == 0
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.95 0.95 0.95],...
            'EdgeColor',[0.85 0.85 0.85])
    else
        patch([regxx(1) regxx(2) regxx(2) regxx(1)],...
            [regy(i) regy(i) regy(i+1) regy(i+1)],...
            [-40.5 -40.5 -40.5 -40.5],[0.9 0.9 0.9],...
            'EdgeColor',[0.8 0.8 0.8])
    end
end
% add region labels
text(239.4,50,'\it R1','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,47.75,'\it R2','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,45.25,'\it R3','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,42.625,'\it R4','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
text(239.4,40.375,'\it R5','Rotation', 270,'HorizontalAlignment','center','FontSize',fsz)
% add letter labels
patch([231 231.6 231.6 231],[51 51 50.4 50.4],'w','EdgeColor','k')
text(231.25,50.75,'d','HorizontalAlignment','center','VerticalAlignment','middle')



%% Figure 9 - Network map made in illustrator - no code