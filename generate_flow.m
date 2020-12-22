function ret = generate_flow(t_begin,t_end,mean_interval_time,source_id,destination_ids)
    csv_reader={};
    flow_id=0;
    interval_times=get_interval_times_flows_exponential(t_begin,t_end,mean_interval_time);
    
    for i=1:size(interval_times,2)
        flow_size=get_synthetic_flow_size();
        new_time=interval_times(1,i);
        destination_id=randsample(destination_ids,1);
        qos='none';
        csv_reader(end+1,:)={flow_id,new_time,flow_size,qos,source_id,destination_id};
        flow_id=flow_id+1;
    end
    ret=csv_reader;
end



