
function savePngFile(filename, width_height)            
    width  = width_height(1);
    height = width_height(2);
    set(gcf, 'PaperUnits', 'inches')
    set(gcf, 'PaperSize', width_height);
    set(gcf, 'PaperPosition', [0, 0, width, height]);
    print(gcf, '-dpng', '-r300',  [filename '.png']);
end
