% param setting
clc
clear
TIME_COL=2;
PACKET_SIZE_COL=3;
PACKET_QOS_COL=4;
SOURCE_COL=5;
DES_COL=6;
PLOT_TIME_COL=7;
nodes=8;
input_table=readtable('traffic_dataset.csv');
traffic_dset = table2cell(input_table);
t_begin=0;
t_end=0.1;

% sort traffic by time of arrival
traffic_dset_sorted = sortrows(traffic_dset,2);
% destination buffers with size[nodesx5], cols={High, MedSmall, MedBig, LowSmall, LowBig}
buffers=zeros(nodes,5); 

for row=1:size(traffic_dset_sorted,1)
    % get packet info from timely-sorted traffic dataset
    new_source=traffic_dset_sorted{row,SOURCE_COL};
    new_dest=traffic_dset_sorted{row,DES_COL};
    new_qos=traffic_dset_sorted{row,PACKET_QOS_COL};
    new_size=traffic_dset_sorted{row,PACKET_SIZE_COL};
    
    % calculate destination buffer
    buffer_row=new_dest;
    buffer_col=0;
    if isequal(new_qos,'high')
        buffer_col=1;
    elseif isequal(new_qos,'med')
        if new_size==60
            buffer_col=2;
        else
            buffer_col=3;
        end
    else %low
        if new_size==60
            buffer_col=4;
        else
            buffer_col=5;
        end
    end
    
    % add packet to buffer
    buffers(buffer_row,buffer_col)=buffers(buffer_row,buffer_col)+1;
end

disp(buffers);