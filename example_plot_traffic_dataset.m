% param setting
clc
clear
input_table=readtable('traffic_dataset.csv');
t_begin=0;
t_end=0.1;
timerange=linspace(t_begin,t_end,1000);

% constants
TIME_COL=2;
PLOT_TIME_COL=7;
PACKET_SIZE_COL=3;
dataset = table2cell(input_table);

% group inputs by specified timesteps
for row=1:size(dataset,1)
    saved_time=0;
    for time_id=1:size(timerange,2)
        if dataset{row,TIME_COL}>=timerange(time_id)
            saved_time=timerange(time_id);
        else
            break;
        end
    end
    dataset{row,PLOT_TIME_COL}=saved_time;
end

% plot total mb generated w.r.t. timerange
Y=[];
for time_id=1:size(timerange,2)
    y=0;
    for row=1:size(dataset,1)
        if dataset{row,PLOT_TIME_COL}==timerange(time_id)
            y=y+dataset{row,PACKET_SIZE_COL};
        end
    end
    Y(end+1)=y;
end

plot(timerange,Y,'LineWidth',2)
xlabel('Time (sec)','fontsize',25)
ylabel('Data generated (bytes)','fontsize',25)
ax = gca;
ax.FontSize = 25;
title('Total traffic','fontsize',25)
grid on

