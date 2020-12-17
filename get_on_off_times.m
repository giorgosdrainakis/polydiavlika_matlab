function ret = get_on_off_times(t_begin,t_end,packet_num,c_pareto,sigma)
    mean_interval_time=(t_end-t_begin)/packet_num;
    on_times_abs=gprnd(c_pareto,mean_interval_time,0,1,packet_num);
    off_times_abs=lognrnd(log(mean_interval_time),sigma,1,packet_num);
    on_periods=[];
    counter=1;
    current_time=t_begin;

    while current_time<=t_end
        % off phase
        current_time=current_time+off_times_abs(counter);
        new_on_start=current_time;
        % on phase
        current_time=current_time+on_times_abs(counter);
        new_off_start=current_time;
        if current_time<=t_end
            on_periods(end+1,:)=[new_on_start,new_off_start];
        end
        counter=counter+1;
    end
    ret=on_periods;
end