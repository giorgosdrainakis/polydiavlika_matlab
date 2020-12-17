function ret = generate_packets_low_qos(t_begin,t_end,avg_throughput,source_id,destination_ids,c_pareto,sigma_lognormal,alpha)
    csv_reader={};
    packet_id=0;
    avg_packet_size=60*0.6+1500*0.4; %bytes
    avg_traffic=avg_throughput*(t_end-t_begin); %bytes
    avg_packet_num=round(avg_traffic/avg_packet_size);
    on_times=get_on_off_times(t_begin,t_end,avg_packet_num,c_pareto,sigma_lognormal);

    for row=1:size(on_times,1)
        avg_traffic=avg_throughput*(on_times(row,2)-on_times(row,1));
        avg_packet_num = max(round(avg_traffic / avg_packet_size),1);
        interval_times=get_interval_times_weibull(on_times(row,1),on_times(row,2),avg_packet_num,alpha);
        for i=1:size(interval_times,2)
            new_time=interval_times(1,i);
            packet_size = get_variable_packet_size(60, 1500, 0.6);
            qos = 'low';
            destination_id=randsample(destination_ids,1);
            csv_reader(end+1,:)={packet_id,new_time,packet_size,qos,source_id,destination_id};
            packet_id = packet_id + 1;
        end
    end
    ret=csv_reader;
end



