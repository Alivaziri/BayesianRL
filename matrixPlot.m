function matrixPlot( Matrix ) 
imagesc(Matrix)
colormap(bone)

% Create strings from the R values
Tstring = num2str(Matrix(:),'%1.1f');

% Remove any space padding
Tstring= strtrim(cellstr(Tstring));

% Create x and y coordinates for the strings
[x,y] = meshgrid(1:length(Matrix));

% Plot the strings
text(x(:)-0.1,y(:),Tstring(:))

axis off
end

