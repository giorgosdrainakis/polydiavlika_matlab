% param setting
clc
clear
t_begin=0; %sec (float)
t_end=0.1; %sec (float)
avg_throughput=1e8; %bytes (int)
nodes=8; % (int)
qos='all'; % {'low','med','high','all'} (string)

% traffic dset is created by default in same dir as 'traffic_dataset.csv'
export_traffic_dataset(nodes,t_begin,t_end,avg_throughput,qos);