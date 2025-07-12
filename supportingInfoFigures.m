%% SUPPORTING INFORMATION FIGURES


%% FIGURE S1 - Mesh dip and curvature for Bloch "t" and Sypus "geometry"
% set some plotting parameters
cax = [0 30]; ax = [231 239 39.5 51 -41 0.5]; cmap = acton;
regxx = [231 239];
figure(1); clf; set(gcf,'position',[1   491   661   390])
subplot(1,2,1)
trisurf(w.v, wrapTo360(w.c(:,1)), w.c(:,2),w.c(:,3),w.dip)
hold on
% plot the contours
cont = [-5:-5:-40];
for i = 1:length(cont)
    tmp = find(w.c(:,3) >cont(i)-0.1 &w.c(:,3) <cont(i)+0.1);
    [tmp2,tmp3] = sort(w.c(tmp,2));
    plot3(wrapTo360(w.c(tmp(tmp3),1)),w.c(tmp(tmp3),2),w.c(tmp(tmp3),3),'k','lineWidth',1)
    begs(i,:) = [wrapTo360(w.c(tmp(tmp3(1)),1)) w.c(tmp(tmp3(1)),2) w.c(tmp(tmp3(1)),3)];
    ends(i,:) = [wrapTo360(w.c(tmp(tmp3(end)),1)) w.c(tmp(tmp3(end)),2) w.c(tmp(tmp3(end)),3)];
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
text(238.5,50.5,'Sypus "geometry"','HorizontalAlignment','right','fontSize',fsz)
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

subplot(1,2,2)
trisurf(bt.v, wrapTo360(bt.c(:,1)), bt.c(:,2),bt.c(:,3),bt.dip)
hold on
% plot the contours
cont = [-6.5 -10:-5:-40];
for i = 1:length(cont)
    tmp = find(bt.c(:,3) >cont(i)-0.1 &bt.c(:,3) <cont(i)+0.1);
    [tmp2,tmp3] = sort(bt.c(tmp,2));
    plot3(wrapTo360(bt.c(tmp(tmp3),1)),bt.c(tmp(tmp3),2),bt.c(tmp(tmp3),3),'k','lineWidth',1)
    begs(i,:) = [wrapTo360(bt.c(tmp(tmp3(1)),1)) bt.c(tmp(tmp3(1)),2) bt.c(tmp(tmp3(1)),3)];
    ends(i,:) = [wrapTo360(bt.c(tmp(tmp3(end)),1)) bt.c(tmp(tmp3(end)),2) bt.c(tmp(tmp3(end)),3)];
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
text(238.5,50.5,'Bloch "t"','HorizontalAlignment','right','fontSize',fsz)
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


% now calculating and plotting curvature 
curvbt = tricurv_v01(bt.v,bt.c);
for i = 1:bt.nEl
    ncurvbt(i) = mean([curvbt.km(bt.v(i,1)) curvbt.km(bt.v(i,2)) curvbt.km(bt.v(i,3))]);
end
curvw = tricurv_v01(w.v,w.c);
for i = 1:w.nEl
    ncurvw(i) = mean([curvw.km(w.v(i,1)) curvw.km(w.v(i,2)) curvw.km(w.v(i,3))]);
end

% plot the curvature
figure(12); clf; set(gcf,'position',[1   491   661   390])
cmap = cork; cax = [-1 1];
subplot(1,2,1)
trisurf(w.v, wrapTo360(w.c(:,1)), w.c(:,2),w.c(:,3),ncurvw)
hold on
% plot the contours
cont = [-5:-5:-40];
for i = 1:length(cont)
    tmp = find(w.c(:,3) >cont(i)-0.1 &w.c(:,3) <cont(i)+0.1);
    [tmp2,tmp3] = sort(w.c(tmp,2));
    plot3(wrapTo360(w.c(tmp(tmp3),1)),w.c(tmp(tmp3),2),w.c(tmp(tmp3),3),'k','lineWidth',1)
    begs(i,:) = [wrapTo360(w.c(tmp(tmp3(1)),1)) w.c(tmp(tmp3(1)),2) w.c(tmp(tmp3(1)),3)];
    ends(i,:) = [wrapTo360(w.c(tmp(tmp3(end)),1)) w.c(tmp(tmp3(end)),2) w.c(tmp(tmp3(end)),3)];
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
text(238.5,50.5,'Sypus "geometry"','HorizontalAlignment','right','fontSize',fsz)
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

subplot(1,2,2)
trisurf(bt.v, wrapTo360(bt.c(:,1)), bt.c(:,2),bt.c(:,3),ncurvbt)
hold on
% plot the contours
cont = [-6.5 -10:-5:-40];
for i = 1:length(cont)
    tmp = find(bt.c(:,3) >cont(i)-0.1 &bt.c(:,3) <cont(i)+0.1);
    [tmp2,tmp3] = sort(bt.c(tmp,2));
    plot3(wrapTo360(bt.c(tmp(tmp3),1)),bt.c(tmp(tmp3),2),bt.c(tmp(tmp3),3),'k','lineWidth',1)
    begs(i,:) = [wrapTo360(bt.c(tmp(tmp3(1)),1)) bt.c(tmp(tmp3(1)),2) bt.c(tmp(tmp3(1)),3)];
    ends(i,:) = [wrapTo360(bt.c(tmp(tmp3(end)),1)) bt.c(tmp(tmp3(end)),2) bt.c(tmp(tmp3(end)),3)];
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
text(238.5,50.5,'Bloch "t"','HorizontalAlignment','right','fontSize',fsz)
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


%% FIGURE S2 - Bloch "t" and Sypus "geometry" diff in longitude from McCrory @ depth contours
xq = [39.8:0.1:50.5]; tol = 0.9;

% get the contour info
[con.btlon10,con.btstrk10,con.btdip10] = getContourInfo(-10,bt,xq,tol);
[con.slon10,con.sstrk10,con.sdip10] = getContourInfo(-10,s,xq,tol);
[con.mlon10,con.mstrk10,con.mdip10] = getContourInfo(-10,m,xq,tol);
[con.wlon10,con.wstrk10,con.wdip10] = getContourInfo(-10,w,xq,tol);
[con.btlon20,con.btstrk20,con.btdip20] = getContourInfo(-20,bt,xq,tol);
[con.slon20,con.sstrk20,con.sdip20] = getContourInfo(-20,s,xq,tol);
[con.mlon20,con.mstrk20,con.mdip20] = getContourInfo(-20,m,xq,tol);
[con.wlon20,con.wstrk20,con.wdip20] = getContourInfo(-20,w,xq,tol);
[con.btlon30,con.btstrk30,con.btdip30] = getContourInfo(-30,bt,xq,tol);
[con.slon30,con.sstrk30,con.sdip30] = getContourInfo(-30,s,xq,tol);
[con.mlon30,con.mstrk30,con.mdip30] = getContourInfo(-30,m,xq,tol);
[con.wlon30,con.wstrk30,con.wdip30] = getContourInfo(-30,w,xq,tol);
[con.btlon40,con.btstrk40,con.btdip40] = getContourInfo(-40,bt,xq,tol);
[con.slon40,con.sstrk40,con.sdip40] = getContourInfo(-40,s,xq,tol);
[con.mlon40,con.mstrk40,con.mdip40] = getContourInfo(-40,m,xq,tol);
[con.wlon40,con.wstrk40,con.wdip40] = getContourInfo(-40,w,xq,tol);
[con.bclon10,con.bcstrk10,con.bcdip10] = getContourInfo(-10,bc,xq,tol);
[con.wblon10,con.wbstrk10,con.wbdip10] = getContourInfo(-10,wb,xq,tol);
[con.bclon20,con.bcstrk20,con.bcdip20] = getContourInfo(-20,bc,xq,tol);
[con.wblon20,con.wbstrk20,con.wbdip20] = getContourInfo(-20,wb,xq,tol);
[con.bclon30,con.bcstrk30,con.bcdip30] = getContourInfo(-30,bc,xq,tol);
[con.wblon30,con.wbstrk30,con.wbdip30] = getContourInfo(-30,wb,xq,tol);
[con.bclon40,con.bcstrk40,con.bcdip40] = getContourInfo(-40,bc,xq,tol);
[con.wblon40,con.wbstrk40,con.wbdip40] = getContourInfo(-40,wb,xq,tol);
% condense variables for plotting
con.lonm = [con.mlon10', con.mlon20', con.mlon30', con.mlon40'];
con.lonbt = [con.btlon10', con.btlon20', con.btlon30', con.btlon40'];
con.lons = [con.slon10', con.slon20', con.slon30', con.slon40'];
con.lonw = [con.wlon10', con.wlon20', con.wlon30', con.wlon40'];
con.strkm = [con.mstrk10',con.mstrk20',con.mstrk30',con.mstrk40'];
con.strkbt = [con.btstrk10',con.btstrk20',con.btstrk30',con.btstrk40'];
con.strks = [con.sstrk10',con.sstrk20',con.sstrk30',con.sstrk40'];
con.strkw = [con.wstrk10',con.wstrk20',con.wstrk30',con.wstrk40'];
con.dipm = [con.mdip10', con.mdip20', con.mdip30', con.mdip40'];
con.dipbt = [con.btdip10', con.btdip20', con.btdip30', con.btdip40'];
con.dips = [con.sdip10', con.sdip20', con.sdip30', con.sdip40'];
con.dipw = [con.wdip10', con.wdip20', con.wdip30', con.wdip40'];
con.lonbc = [con.bclon10', con.bclon20', con.bclon30', con.bclon40'];
con.lonwb = [con.wblon10', con.wblon20', con.wblon30', con.wblon40'];
con.strkbc = [con.bcstrk10',con.bcstrk20',con.bcstrk30',con.bcstrk40'];
con.strkwb = [con.wbstrk10',con.wbstrk20',con.wbstrk30',con.wbstrk40'];
con.dipbc = [con.bcdip10', con.bcdip20', con.bcdip30', con.bcdip40'];
con.dipwb = [con.wbdip10', con.wbdip20', con.wbdip30', con.wbdip40'];

% set x axis region for patch plotting
regxx = [-1 1];
% plot difference in longitude from McCrory
figure(2); clf; set(gcf,'Position',[448   344   544   522]); 
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
plot(wrapTo360(con.lonw(:,1))-wrapTo360(con.lonm(:,1)),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lonbt(:,1))-wrapTo360(con.lonm(:,1)),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
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
plot(wrapTo360(con.lonw(:,2))-wrapTo360(con.lonm(:,2)),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lonbt(:,2))-wrapTo360(con.lonm(:,2)),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
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
plot(wrapTo360(con.lonw(:,3))-wrapTo360(con.lonm(:,3)),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lonbt(:,3))-wrapTo360(con.lonm(:,3)),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
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
plot(wrapTo360(con.lonw(:,4))-wrapTo360(con.lonm(:,4)),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(wrapTo360(con.lonbt(:,4))-wrapTo360(con.lonm(:,4)),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
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



%% FIGURE S3 - Bloch "t" and Sypus "geometry" strike @ depth contours
% set x axis region for patch plotting
regxx = [-90 90];

figure(3); clf; set(gcf,'Position',[448   352   807   514]); 
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
plot(con.strkw(:,1),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strkbt(:,1),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
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
plot(con.strkw(:,2),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strkbt(:,2),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
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
plot(con.strkw(:,3),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strkbt(:,3),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
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
plot(con.strkw(:,4),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.strkbt(:,4),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
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


%% FIGURE S4 - Bloch "t" and Sypus "geometry" dip @ depth contours
% set x axis region for patch plotting
regxx = [0 25];

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
plot(con.dipm(:,1),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dips(:,1),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipw(:,1),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipbt(:,1),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis([0 25 39.5 51]); box on
xlabel('Dip (°)')
yticks(40:2:50); yticklabels({'40°N','','','','','50°N'})
xticks(0:5:30); xticklabels({'0','','10','','20','',''})
%legend('','','','','','','Sypus','McCrory','Bloch','Slab2')
text(24,50.75,'10 km','HorizontalAlignment','right')
set(gca,'FontSize',fsz,'Layer','top')
% add region labels
text(27,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(27,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(27,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(27,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(27,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
% add letter labels
patch([0 3 3 0],[51 51 50.6 50.6],'w','EdgeColor','k')
text(1.5,50.8,'a','HorizontalAlignment','center','VerticalAlignment','middle')

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
plot(con.dipm(:,2),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dips(:,2),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipw(:,2),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipbt(:,2),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis([0 25 39.5 51]); box on
xlabel('Dip (°)')
yticks(40:2:50); yticklabels({})
xticks(0:5:30); xticklabels({'0','','10','','20','',''})
text(24,50.75,'20 km','HorizontalAlignment','right')
set(gca,'FontSize',fsz,'Layer','top')
% add region labels
text(27,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(27,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(27,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(27,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(27,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
% add letter labels
patch([0 3 3 0],[51 51 50.6 50.6],'w','EdgeColor','k')
text(1.5,50.8,'b','HorizontalAlignment','center','VerticalAlignment','middle')

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
plot(con.dipm(:,3),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dips(:,3),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipw(:,3),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipbt(:,3),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis([0 25 39.5 51]); box on
xlabel('Dip (°)')
yticks(40:2:50); yticklabels({})
xticks(0:5:30); xticklabels({'0','','10','','20','',''})
text(24,50.75,'30 km','HorizontalAlignment','right')
set(gca,'FontSize',fsz,'Layer','top')
% add region labels
text(27,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(27,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(27,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(27,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(27,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
% add letter labels
patch([0 3 3 0],[51 51 50.6 50.6],'w','EdgeColor','k')
text(1.5,50.8,'c','HorizontalAlignment','center','VerticalAlignment','middle')

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
plot(con.dipm(:,4),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dips(:,4),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipw(:,4),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipbt(:,4),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis([0 25 39.5 51]); box on
xlabel('Dip (°)')
yticks(40:2:50); yticklabels({})
xticks(0:5:30); xticklabels({'0','','10','','20','',''})
text(24,50.75,'40 km','HorizontalAlignment','right')
set(gca,'FontSize',fsz,'Layer','top')
% add region labels
text(27,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(27,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(27,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(27,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(27,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
% add letter labels
patch([0 3 3 0],[51 51 50.6 50.6],'w','EdgeColor','k')
text(1.5,50.8,'d','HorizontalAlignment','center','VerticalAlignment','middle')


%% ND FIGURE S5 - Bloch "t" and Sypus "geometry" uniform slip results
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
dif.mw = sqrt((vel.m(1:3:end)-vel.w(1:3:end)).^2 + ...
    (vel.m(2:3:end)-vel.w(2:3:end)).^2)./40;
dif.mb = sqrt((vel.m(1:3:end)-vel.bt(1:3:end)).^2 + ...
    (vel.m(2:3:end)-vel.bt(2:3:end)).^2)./40;
dif.sw = sqrt((vel.s(1:3:end)-vel.w(1:3:end)).^2 + ...
    (vel.s(2:3:end)-vel.w(2:3:end)).^2)./40;
dif.sb = sqrt((vel.s(1:3:end)-vel.bt(1:3:end)).^2 + ...
    (vel.s(2:3:end)-vel.bt(2:3:end)).^2)./40;
dif.w = sqrt((vel.w(1:3:end)-vel.bt(1:3:end)).^2 + ...
    (vel.w(2:3:end)-vel.bt(2:3:end)).^2)./40;
statRed = dif.ms >0.1 |dif.mw >0.1 |dif.mb >0.1 |dif.sw >0.1 |dif.sb >0.1 |dif.w >0.1;
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
    [10; vel.w(keep*3-2)],[0; vel.w(keep*3-1)],arleng,'color',colors(4,:),'lineWidth',1,'MaxHeadSize',0.02)
quiver([232; stations.lon(keep)],[40; stations.lat(keep)],...
    [10; vel.bt(keep*3-2)],[0; vel.bt(keep*3-1)],arleng,'color',colors(1,:),'lineWidth',1,'MaxHeadSize',0.02)
% general aestetics
axis('equal',[231.5 238.5 39.5 51])
yticks(40:2:50); yticklabels({'40°N','','','','','50°N'})
xticks(232:2:238); xticklabels({'128°W','','','122°W'})
box on; grid on
legend('','>4 mm','<4 mm','McCrory','Slab2','Sypus','Bloch')
set(gca,'fontSize',fsz)

% parts b and c prep calculations/grouping
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
wrtl.magbt = sqrt(vel.bt(1:3:end).^2+vel.bt(2:3:end).^2);
    wrtl.azbt = rad2deg(atan(vel.bt(2:3:end)./vel.bt(1:3:end)));
wrtl.magw = sqrt(vel.w(1:3:end).^2+vel.w(2:3:end).^2);
    wrtl.azw = rad2deg(atan(vel.w(2:3:end)./vel.w(1:3:end)));
wrtl.magm = sqrt(vel.m(1:3:end).^2+vel.m(2:3:end).^2);
    wrtl.azm = rad2deg(atan(vel.m(2:3:end)./vel.m(1:3:end)));
wrtl.mags = sqrt(vel.s(1:3:end).^2+vel.s(2:3:end).^2);
    wrtl.azs = rad2deg(atan(vel.s(2:3:end)./vel.s(1:3:end)));

wrtl.magbt = sqrt(vel.bt(1:3:end).^2+vel.bt(2:3:end).^2);
    wrtl.azbt = rad2deg(atan(vel.bt(2:3:end)./vel.bt(1:3:end)));
wrtl.magw = sqrt(vel.w(1:3:end).^2+vel.w(2:3:end).^2);
    wrtl.azw = rad2deg(atan(vel.w(2:3:end)./vel.w(1:3:end)));
    
    
% plot up azimuth (b)
figure(2); clf;% set(gcf,'Position',[477   474   148   407])
subplot(5,1,1) % Region 1
boxchart(ones(size(wrtl.loc1))*4,wrtl.azm(wrtl.loc1)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc1))*3,wrtl.azs(wrtl.loc1)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc1))*2,wrtl.azw(wrtl.loc1)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc1)),wrtl.azbt(wrtl.loc1)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 0 55]); box on
xticks([])
yticks([-45:15:45]); yticklabels({'','120','','90','','60',''})
camroll(90)

subplot(5,1,2) % Region 2
boxchart(ones(size(wrtl.loc2))*4,wrtl.azm(wrtl.loc2)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc2))*3,wrtl.azs(wrtl.loc2)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc2))*2,wrtl.azw(wrtl.loc2)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc2)),wrtl.azbt(wrtl.loc2)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 0 55]); box on
xticks([])
yticks([-45:15:45]); yticklabels({'','120','','90','','60',''})
camroll(90)

subplot(5,1,3) % Region 3
boxchart(ones(size(wrtl.loc3))*4,wrtl.azm(wrtl.loc3)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc3))*3,wrtl.azs(wrtl.loc3)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc3))*2,wrtl.azw(wrtl.loc3)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc3)),wrtl.azbt(wrtl.loc3)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 -40 15]); box on
xticks([])
yticks([-45:15:45]); yticklabels({'','120','','90','','60',''})
camroll(90)

subplot(5,1,4) % Region 4
boxchart(ones(size(wrtl.loc4))*4,wrtl.azm(wrtl.loc4)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc4))*3,wrtl.azs(wrtl.loc4)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc4))*2,wrtl.azw(wrtl.loc4)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc4)),wrtl.azbt(wrtl.loc4)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 -40 15]); box on
xticks([])
yticks([-45:15:45]); yticklabels({'','120','','90','','60',''})
camroll(90)

subplot(5,1,5) % Region 5
boxchart(ones(size(wrtl.loc5))*4,wrtl.azm(wrtl.loc5)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc5))*3,wrtl.azs(wrtl.loc5)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc5))*2,wrtl.azw(wrtl.loc5)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc5)),wrtl.azbt(wrtl.loc5)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 -40 15]); box on
xticks([])
yticks([-45:15:45]); yticklabels({'','120','','90','','60',''})
camroll(90)

% plot up magnitude (c)
figure(12); clf; %set(gcf,'Position',[1984 203 209 676])
subplot(5,1,1) % Region 1
boxchart(ones(size(wrtl.loc1)),wrtl.magm(wrtl.loc1)',...
    'BoxFaceColor',colors(3,:),'MarkerStyle','none')
hold on
boxchart(ones(size(wrtl.loc1))*2,wrtl.mags(wrtl.loc1)',...
    'BoxFaceColor',colors(2,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc1))*3,wrtl.magw(wrtl.loc1)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc1))*4,wrtl.magbt(wrtl.loc1)',...
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
boxchart(ones(size(wrtl.loc2))*3,wrtl.magw(wrtl.loc2)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc2))*4,wrtl.magbt(wrtl.loc2)',...
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
boxchart(ones(size(wrtl.loc3))*3,wrtl.magw(wrtl.loc3)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc3))*4,wrtl.magbt(wrtl.loc3)',...
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
boxchart(ones(size(wrtl.loc4))*3,wrtl.magw(wrtl.loc4)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc4))*4,wrtl.magbt(wrtl.loc4)',...
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
boxchart(ones(size(wrtl.loc5))*3,wrtl.magw(wrtl.loc5)',...
    'BoxFaceColor',colors(4,:),'MarkerStyle','none')
boxchart(ones(size(wrtl.loc5))*4,wrtl.magbt(wrtl.loc5)',...
    'BoxFaceColor',colors(1,:),'MarkerStyle','none')
axis([0.5 4.5 0 30]); box on
xticks([])
yticks([0:10:30]); yticklabels({'0','','','30'})
camroll(270)

%% ND FIGURE S6 - McCrory, Slab2, Sypus "adjusted buried" and Bloch "c" dip @ depth contours
% set x axis region for patch plotting
regxx = [0 25];

figure(6); clf; set(gcf,'Position',[448   352   807   514]); 
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
plot(con.dipm(:,1),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dips(:,1),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipwb(:,1),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipbc(:,1),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis([0 25 39.5 51]); box on
xlabel('Dip (°)')
yticks(40:2:50); yticklabels({'40°N','','','','','50°N'})
xticks(0:5:30); xticklabels({'0','','10','','20','',''})
%legend('','','','','','','Sypus','McCrory','Bloch','Slab2')
text(24,50.75,'10 km','HorizontalAlignment','right')
set(gca,'FontSize',fsz,'Layer','top')
% add region labels
text(27,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(27,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(27,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(27,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(27,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
% add letter labels
patch([0 3 3 0],[51 51 50.6 50.6],'w','EdgeColor','k')
text(1.5,50.8,'a','HorizontalAlignment','center','VerticalAlignment','middle')

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
plot(con.dipm(:,2),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dips(:,2),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipwb(:,2),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipbc(:,2),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis([0 25 39.5 51]); box on
xlabel('Dip (°)')
yticks(40:2:50); yticklabels({})
xticks(0:5:30); xticklabels({'0','','10','','20','',''})
text(24,50.75,'20 km','HorizontalAlignment','right')
set(gca,'FontSize',fsz,'Layer','top')
% add region labels
text(27,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(27,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(27,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(27,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(27,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
% add letter labels
patch([0 3 3 0],[51 51 50.6 50.6],'w','EdgeColor','k')
text(1.5,50.8,'b','HorizontalAlignment','center','VerticalAlignment','middle')

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
plot(con.dipm(:,3),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dips(:,3),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipwb(:,3),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipbc(:,3),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis([0 25 39.5 51]); box on
xlabel('Dip (°)')
yticks(40:2:50); yticklabels({})
xticks(0:5:30); xticklabels({'0','','10','','20','',''})
text(24,50.75,'30 km','HorizontalAlignment','right')
set(gca,'FontSize',fsz,'Layer','top')
% add region labels
text(27,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(27,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(27,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(27,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(27,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
% add letter labels
patch([0 3 3 0],[51 51 50.6 50.6],'w','EdgeColor','k')
text(1.5,50.8,'c','HorizontalAlignment','center','VerticalAlignment','middle')

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
plot(con.dipm(:,4),xq,'color',colors(3,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dips(:,4),xq,'color',colors(2,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipwb(:,4),xq,'color',colors(4,:),'MarkerSize',3,'lineWidth',1.5)
plot(con.dipbc(:,4),xq,'color',colors(1,:),'MarkerSize',3,'lineWidth',1.5)
axis([0 25 39.5 51]); box on
xlabel('Dip (°)')
yticks(40:2:50); yticklabels({})
xticks(0:5:30); xticklabels({'0','','10','','20','',''})
text(24,50.75,'40 km','HorizontalAlignment','right')
set(gca,'FontSize',fsz,'Layer','top')
% add region labels
text(27,50,'\it Region 1','Rotation', 270,'HorizontalAlignment','center')
text(27,47.75,'\it Region 2','Rotation', 270,'HorizontalAlignment','center')
text(27,45.25,'\it Region 3','Rotation', 270,'HorizontalAlignment','center')
text(27,42.625,'\it Region 4','Rotation', 270,'HorizontalAlignment','center')
text(27,40.375,'\it Region 5','Rotation', 270,'HorizontalAlignment','center')
% add letter labels
patch([0 3 3 0],[51 51 50.6 50.6],'w','EdgeColor','k')
text(1.5,50.8,'d','HorizontalAlignment','center','VerticalAlignment','middle')


%% ND FIGURE S7 - Difference in uniform slip surf. disp. magnitude maps for model pairs



%% ND FIGURE S8 - Smoothing weight factor assessment results



%% ND FIGURE S9 - Resolving power on TDEs normalized to TDE area
cax=[0 5e-3];
figure(1); clf
p = bc;
G = Gu.bc;
respwr = sum(abs(G(1:3:end,:)))+sum(abs(G(2:3:end,:)));
subplot(1,4,4)
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),respwr(2:2:end)'./p.area)
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,1);
plot(lon,lat,'k','lineWidth',0.5)
axis('equal',[231 239 39.5 51 -40 0.2]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(flipud(oslo)); shading flat
text(238.7, 50.5,'Bloch','HorizontalAlignment','right','fontSize',16)
caxis(cax)
set(gca,'fontSize',16)

p = m;
G = Gu.m;
respwr = sum(abs(G(1:3:end,:)))+sum(abs(G(2:3:end,:)));
subplot(1,4,1)
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),respwr(2:2:end)'./p.area)
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,1);
plot(lon,lat,'k','lineWidth',0.5)
axis('equal',[231 239 39.5 51 -40 0.2]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({'40°N','','','','','50°N'})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(flipud(oslo)); shading flat
text(238.7, 50.5,'McCrory','HorizontalAlignment','right','fontSize',16)
caxis(cax)
set(gca,'fontSize',16)

p = s;
G = Gu.s;
respwr = sum(abs(G(1:3:end,:)))+sum(abs(G(2:3:end,:)));
subplot(1,4,2)
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),respwr(2:2:end)'./p.area)
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,1);
plot(lon,lat,'k','lineWidth',0.5)
axis('equal',[231 239 39.5 51 -40 0.2]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(flipud(oslo)); shading flat
text(238.7, 50.5,'Slab2','HorizontalAlignment','right','fontSize',16)
caxis(cax)
set(gca,'fontSize',16)

p = wb;
G = Gu.wb;
respwr = sum(abs(G(1:3:end,:)))+sum(abs(G(2:3:end,:)));
subplot(1,4,3)
trisurf(p.v, wrapTo360(p.c(:,1)), p.c(:,2),p.c(:,3),respwr(2:2:end)'./p.area)
meshedges([wrapTo360(p.c(:,1)),p.c(:,2),p.c(:,3)],p.v,p.nEl,1);
plot(lon,lat,'k','lineWidth',0.5)
axis('equal',[231 239 39.5 51 -40 0.2]); view([0 90]); box on; grid on
yticks(40:2:50); yticklabels({})
xticks([230:2:240]); xticklabels({'','128°W','','','122°W',''})
colormap(flipud(oslo)); shading flat
text(238.7, 50.5,'Sypus','HorizontalAlignment','right','fontSize',16)
caxis(cax)
set(gca,'fontSize',16)


%% ND FIGURE S10 - Applied Gaussian slip to Bloch "c" interface



%% ND FIGURE S11 - Slip distributions for inversions of surf. disp.(Bloch "c")


