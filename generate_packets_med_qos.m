function ret = generate_packets_med_qos(t_begin,t_end,avg_throughput,source_id,destination_ids,sigma_lognormal)
    csv_reader={};
    packet_id=0;
    avg_packet_size=60*0.7+1500*0.3; %bytes
    avg_traffic=avg_throughput*(t_end-t_begin); %bytes
    avg_packet_num=round(avg_traffic/avg_packet_size);
    interval_times=get_interval_times_lognormal(t_begin,t_end,avg_packet_num,sigma_lognormal);

    for i=1:size(interval_times,2)
        packet_size=get_variable_packet_size(60,1500,0.7);
        qos='med';
        new_time=interval_times(1,i);
        destination_id=randsample(destination_ids,1);
        csv_reader(end+1,:)={packet_id,new_time,packet_size,qos,source_id,destination_id};
        packet_id=packet_id+1;
    end
    ret=csv_reader;
end



