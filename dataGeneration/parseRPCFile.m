function RPC1 = parseRPCFile(filename)

fid = fopen(filename, 'r');

% get rid of header
for i = 1 : 4
    fgetl(fid); % satId, bandId, SpecId, BEGIN_GROUP
end

for i = 1 : 12
    text = fgetl(fid);
    if text == -1
        break;
    end
    
    text = regexp(text, '=', 'split');
    value = text{2};
    value = strtrim(strrep(value, ';', ''));
    RPC(i) = str2double(value);
end

for i = 1 : 4
    fgetl(fid);
    for j = 1 : 20
        text = fgetl(fid);
        if text == -1
            break;
        end
        
        value = strtrim(strrep(text, ',', ''));
        value = strrep(value, ');', '');
        RPC(12 + ( i - 1 ) * 20 + j) = str2double(value);
    end
end
fclose(fid);


RPC1.INVERSE_LINE_NUM = RPC(13 : 32);
RPC1.INVERSE_LINE_DEN = RPC(33 : 52);
RPC1.INVERSE_SAMP_NUM = RPC(53 : 72);
RPC1.INVERSE_SAMP_DEN = RPC(73 : 92);

RPC1.lineOffset = RPC(3);
RPC1.lineScale = RPC(8);
RPC1.sampOffset = RPC(4);
RPC1.sampScale = RPC(9);
RPC1.latOffset = RPC(5);
RPC1.latScale = RPC(10);
RPC1.longOffset = RPC(6);
RPC1.longScale = RPC(11);
RPC1.heightOffset = RPC(7);
RPC1.heightScale = RPC(12);



