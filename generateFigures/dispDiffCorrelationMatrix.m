function [cormat] = dispDiffCorrelationMatrix(vels,nameOrder,cmap,figNum)
    % calculate and create a matrix of summed station velocity differences 
      % for a set of velocities
      
%%%%% --------------------------- INPUTS --------------------------- %%%%%
    % vels: an m-by-n matrix where m is the number of stations*3 and
      % velocities are ordered [e1,n1,u1,e2,n2,u2,...] and n is the
      % number of models to compare
    % nameOrder: 1-by-n cells with the names (char) for each model
    % cmap: colormap for grid (high values should be dark for the font
      % restrictions to print black on light boxes and white on dark)
      
%%%%% --------------------------- OUTPUTS --------------------------- %%%%%
    % cormat: n-by-n matrix with the summed horizontal velocity 
      % magnitude differences for each model pair. 
          
%%%%% ---------------------------- CODE ---------------------------- %%%%%
% for paper the stations used: 
%loc = find(stations.lat > 39.5 & stations.lat < 51 & ...
%stations.lon > 231 & stations.lon < 238);
%loc = loc(loc<1775);
%loc = [loc*3-2; loc*3-1; loc*3];
cormat = zeros(size(vels,2),size(vels,2));
for i = 1:size(vels,2)-1
    for j = i+1:size(vels,2)
        stadif = sqrt((vels(1:3:end,i)-vels(1:3:end,j)).^2 + ...
            (vels(2:3:end,i)-vels(2:3:end,j)).^2);
        cormat(i,j) = sum(stadif);
        cormat(j,i) = sum(stadif);
        % if you wanted to look at uplift
        updif = abs(vels(3:3:end,i)-vels(3:3:end,j));
        upmat(i,j) = sum(updif);
        upmat(j,i) = sum(updif);
    end
end

% plot up the matrix
figure(figNum); set(gcf,'Position',[477   278   776   588])
imagesc(cormat)
hold on; axis equal tight
colormap(cmap)
xticks(1:size(vels,2)); xticklabels(nameOrder)
yticks(1:size(vels,2)); yticklabels(nameOrder)
set(gca,'fontSize',18,'TickLength',[0 0])

% need to plot a grid over the image
for i = 0.5:1:size(vels,2)+0.5
    % vertical
    plot([i i],[0.5 size(vels,2)+0.5],'k','lineWidth',1)
    % horizontal
    plot([0.5 size(vels,2)+0.5],[i i],'k','lineWidth',1)
end

% need to plot actual numbers
txtPosX = repmat([1:size(vels,2)],1,size(vels,2))';
txtPosY = repmat([1:size(vels,2)],size(vels,2),1);
txtPosY = txtPosY(:);
txtCol = zeros(size(txtPosX));
txtCol(cormat(:)>(0.5*max(caxis))) = 1;
vals = round(cormat(:));
text(txtPosX(txtCol==0),txtPosY(txtCol==0),num2str(vals(txtCol==0)),...
    'fontSize',18,'HorizontalAlignment','center','VerticalAlignment',...
    'middle')
text(txtPosX(txtCol==1),txtPosY(txtCol==1),num2str(vals(txtCol==1)),...
    'fontSize',18,'Color','w','HorizontalAlignment','center',...
    'VerticalAlignment','middle')

% plot up the matrix v2: divide by number of stations
figure; set(gcf,'Position',[477   278   776   588])
imagesc(cormat./(size(vels,1)/3))
hold on; axis equal tight
colormap(cmap)
xticks(1:size(vels,2)); xticklabels(nameOrder)
yticks(1:size(vels,2)); yticklabels(nameOrder)
set(gca,'fontSize',18,'TickLength',[0 0])

% need to plot a grid over the image
for i = 0.5:1:size(vels,2)+0.5
    % vertical
    plot([i i],[0.5 size(vels,2)+0.5],'k','lineWidth',1)
    % horizontal
    plot([0.5 size(vels,2)+0.5],[i i],'k','lineWidth',1)
end

% need to plot actual numbers
txtPosX = repmat([1:size(vels,2)],1,size(vels,2))';
txtPosY = repmat([1:size(vels,2)],size(vels,2),1);
txtPosY = txtPosY(:);
txtCol = zeros(size(txtPosX));
txtCol((cormat(:)./(size(vels,1)/3))>(0.5*max(caxis))) = 1;
vals = round((cormat(:)./(size(vels,1)/3)),1);
text(txtPosX(txtCol==0),txtPosY(txtCol==0),num2str(vals(txtCol==0)),...
    'fontSize',18,'HorizontalAlignment','center','VerticalAlignment',...
    'middle')
text(txtPosX(txtCol==1),txtPosY(txtCol==1),num2str(vals(txtCol==1)),...
    'fontSize',18,'Color','w','HorizontalAlignment','center',...
    'VerticalAlignment','middle')


% plot up the uplift matrix
figure; set(gcf,'Position',[477   278   776   588])
imagesc(upmat)
hold on; axis equal tight
colormap(cmap)
xticks(1:size(vels,2)); xticklabels(nameOrder)
yticks(1:size(vels,2)); yticklabels(nameOrder)
set(gca,'fontSize',18,'TickLength',[0 0])

% need to plot a grid over the image?
for i = 0.5:1:size(vels,2)+0.5
    % vertical
    plot([i i],[0.5 size(vels,2)+0.5],'k','lineWidth',1)
    % horizontal
    plot([0.5 size(vels,2)+0.5],[i i],'k','lineWidth',1)
end

% need to add actual numbers
txtPosX = repmat([1:size(vels,2)],1,size(vels,2))';
txtPosY = repmat([1:size(vels,2)],size(vels,2),1);
txtPosY = txtPosY(:);
txtCol = zeros(size(txtPosX));
txtCol(upmat(:)>(0.5*max(caxis))) = 1;
vals = round(upmat(:));
text(txtPosX(txtCol==0),txtPosY(txtCol==0),num2str(vals(txtCol==0)),...
    'fontSize',18,'HorizontalAlignment','center','VerticalAlignment',...
    'middle')
text(txtPosX(txtCol==1),txtPosY(txtCol==1),num2str(vals(txtCol==1)),...
    'fontSize',18,'Color','w','HorizontalAlignment','center',...
    'VerticalAlignment','middle')