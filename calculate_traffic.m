clc
clear
traffic_dataset_name='traffic_flow_dataset.csv';
channels=4;
speed=10e9; %Gbps
channel_list={};

% bufferize
PACKET_ID_COL=1;
TIME_COL=2;
PACKET_SIZE_COL=3;
PACKET_QOS_COL=4;
SOURCE_COL=5;
DES_COL=6;
input_table=readtable(traffic_dataset_name);
traffic_dset = table2cell(input_table);

% sort traffic by time of arrival
traffic_dset_sorted = sortrows(traffic_dset,2);

% create channels
for i=1:channels
    new_channel=Channel;
    new_channel.id=i;
    new_channel.occupation_time_start=0;
    new_channel.occupation_time_end=0;
    new_channel.speed=speed;
    channel_list{end+1}=new_channel;
end

total_time=traffic_dset{end,TIME_COL}-traffic_dset{1,TIME_COL};
disp('total time=');
disp(total_time);
total_packets=0;
total_data=0;
total_data_sent=0;
data_lost=0;
packet_lost=0;

% pass through all packets
for row=1:size(traffic_dset_sorted,1)
    arrival_time=traffic_dset_sorted{row,TIME_COL};
    size_to_sent=traffic_dset_sorted{row,PACKET_SIZE_COL};
    total_data=total_data+size_to_sent;
    total_packets=total_packets+1;
    found_channel=false;
    
    for ch=1:size(channel_list,2)
        if channel_list{ch}.is_occupied(arrival_time)==false
            channel_list{ch}.occupation_time_start=arrival_time;
            channel_list{ch}.occupation_time_end=arrival_time+(size_to_sent*8)/channel_list{ch}.speed;
            found_channel=true;
            total_data_sent=total_data_sent+size_to_sent;
            break;
        end
    end
    if found_channel==false
        packet_lost=packet_lost+1;
        data_lost=data_lost+size_to_sent;
    end
end



packet_loss=packet_lost/total_packets;
data_loss=data_lost/total_data;
real_throuput=total_data_sent/total_time;

disp(traffic_dataset_name)
disp('-- stats --')
disp(total_data);
disp(total_data_sent);
disp(data_lost);
disp(data_loss);
disp('---')
disp(packet_lost);
disp(packet_loss);
disp('---')
disp(real_throuput);
disp('---')
 
