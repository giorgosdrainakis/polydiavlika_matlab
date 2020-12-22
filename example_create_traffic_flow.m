% param setting
clc
clear
t_begin=0; %sec (float)
t_end=10; %sec (float)
nodes=8; % (int)

% traffic dset is created by default in same dir as 'traffic_flow_dataset.csv'
export_traffic_flow_dataset(nodes,t_begin,t_end);