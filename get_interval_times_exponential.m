function ret = get_interval_times_exponential(t_begin,t_end,packet_num)
    mean_interval_time=(t_end-t_begin)/packet_num;
    interval_times_abs = exprnd(mean_interval_time,1,packet_num);
    interval_times_actual=[];
    new_sample_time=t_begin;
    for i=1:size(interval_times_abs,2)
        new_sample_time=new_sample_time+interval_times_abs(1,i);
        if new_sample_time>t_end
            break;
        else
            interval_times_actual(end+1) = new_sample_time;
        end
    end
    ret=interval_times_actual;
end
