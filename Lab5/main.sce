graphical_objects = findobj();

for i = [1:size(graphical_objects)(1)]
    if graphical_objects(i).type == "Axes"
        graphical_objects(i).children.thickness = 3;
        graphical_objects(i).grid = [1,1];
        legend(graphical_objects(i), string([1:size(graphical_objects(i).children)(1)]));
    end
end
