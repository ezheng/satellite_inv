function generateData()

datapath = 'xiapu';
base_name = '10Dec31030525-P2AS-052783824100_01_P001';
% match_name = '10DEC31030630-P2AS-052783824100_01_P001';

% datapath = 'F:\Enliang\matlab\satelliteImage\triangulation_copy\cl';
% base_name = '09DEC12143944-P1BS-052869847050_01_P001';
% match_name = '09DEC12144010-P1BS-052869863040_01_P002';

% datapath = 'F:\Enliang\matlab\satelliteImage\triangulation_copy\052333524010_01_P001_PAN';
% base_name = '10JAN19130923-P2AS-052333524010_01_P001';
% match_name = '10JAN19130954-P2AS-052333524010_01_P001';


rpc1 = parseRPCFile(fullfile(datapath, [base_name, '.RPB']));
% rpc2 = parseRPCFile(fullfile(datapath, [match_name, '.RPB']));

num = 20000;
rng('default')
lon = 2 * rand(num, 1) - 1;
lat = 2 * rand(num, 1) - 1;
alt = 2 * rand(num, 1) - 1;

% normalize to get lon2, lat2 and alt2

row = eval_rpc(rpc1.INVERSE_LINE_NUM, lat, lon, alt) ./ eval_rpc(rpc1.INVERSE_LINE_DEN, lat, lon, alt);
col = eval_rpc(rpc1.INVERSE_SAMP_NUM, lat, lon, alt) ./ eval_rpc(rpc1.INVERSE_SAMP_DEN, lat, lon, alt);

[~,taskname,~] = fileparts(datapath);
fileName = ['coeffs_', taskname, '.mat' ];
coeffs1 = rpc1.INVERSE_LINE_NUM;
coeffs2 = rpc1.INVERSE_LINE_DEN;
coeffs3 = rpc1.INVERSE_SAMP_NUM; 
coeffs4 = rpc1.INVERSE_SAMP_DEN;
% save( fileName, rpc1.INVERSE_LINE_NUM, rpc1.INVERSE_LINE_DEN, rpc1.INVERSE_SAMP_NUM, rpc1.INVERSE_SAMP_DEN );
save( fileName, 'coeffs1', 'coeffs2', 'coeffs3', 'coeffs4');
fileName = ['coord_', taskname, '.mat' ];
save( fileName,  'lon', 'lat', 'alt', 'row', 'col');


end




function res = eval_rpc(C, lat, lon, alt)
    res = C(1) + C(2) .* lon + C(3) .* lat + C(4) .* alt + C(5) .* lon .* lat + C(6) .* lon .* alt + C(7) .* lat .* alt + C(8) .* lon .* lon + C(9) .* lat .* lat + C(10) .* alt .* alt + C(11) .* lat .* lon .* alt + C(12) .* lon .* lon .* lon + C(13) .* lon .* lat .* lat + C(14) .* lon .* alt .* alt + C(15) .* lon .* lon .* lat + C(16) .* lat .* lat .* lat + C(17) .* lat .* alt .* alt + C(18) .* lon .* lon .* alt + C(19) .* lat .* lat .* alt + C(20) .* alt .* alt .* alt;
end

