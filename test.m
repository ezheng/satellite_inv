function test

load coeffs_xiapu.mat;
a = load('coord_xiapu.mat');

numOfTrials = floor(size(a.alt,1));
allTheErrors = zeros(numOfTrials,1);

for kk = 1: numOfTrials    
    kk
    imageCoordinates = [a.row(kk); a.col(kk)];  % this is normalized coordinates. 
    result = inverseMapping(coeffs1, coeffs2, coeffs3, coeffs4, imageCoordinates, a.alt(kk));
    
    numOfSolutions = result(1, end);
    idx = find( sum(  result(:, 1:numOfSolutions) >= -1 & result(:, 1:numOfSolutions) <= 1 ) == 2);
    error = norm( result(:,idx) - [a.lat(kk); a.lon(kk)] );
    allTheErrors(kk) = error;
end

plotFigure(allTheErrors, 'Inverse mapping');

end

function plotFigure(error, name)
    
    numOfErrors = numel(error);

    range = -17 :1: -9;

    HH = figure(1);
    set(HH, 'Position', [   516   287   835   763]);

    edges = ( 10.^range ); 

    h=histc(error, edges );
    bar(  edges  , h/sum(h), 'histc' );
    set(gca, 'XScale', 'log')

    hh = findobj(gca,'Type','line');
    set(hh, 'Marker', 'none');
    set(gcf,'color','w');
% title( [name, ' error'] );
% ylabel([name, ' error']);
    set(gca,'fontsize', 25);

    xlabel(['log_{10} of error'],'FontWeight','bold');
    ylabel('Frequency','FontWeight','bold');
    xlim([edges(1),edges(end)]);
    if(~strcmp(name, 'rotation (degree)'))
        ylim([0,0.45]);
    else
        ylim([0,0.32]);
    end
    a=[cellstr(num2str(get(gca,'ytick')'*100))]; 
    pct = char(ones(size(a,1),1)*'%'); 
    new_yticks = [char(a),pct];
    set(gca,'yticklabel',new_yticks,'FontWeight','bold') ;
    set(gca,'XTick',edges(2:2:end-1));

% set(gcf, 'Renderer', 'opengl')
% export_fig( fullfile(outputPath, [fileName, '_' , name, '.eps']), '-a4');
%     export_fig( fileName, '-m1', '-q100', '-a4');
    export_fig('inverseMapping.png', '-r900');
%     print('inverseMapping', '-dpng', '-r600'); %<-Save as PNG with 300 DPI

end





