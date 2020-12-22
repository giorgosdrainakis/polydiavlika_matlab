function ret = get_interval_times_flows_exponential(t_begin,t_end,mean_interval_time)
    interval_times_actual=[];
    new_sample_time=t_begin;
    while new_sample_time<=t_end
        new_abs_time=exprnd(mean_interval_time);
        new_sample_time=new_sample_time+new_abs_time;
        if new_sample_time<=t_end
            interval_times_actual(end+1) = new_sample_time;
        end
    end
     ret=interval_times_actual;
end
