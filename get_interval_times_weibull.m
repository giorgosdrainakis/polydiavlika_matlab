function ret = get_interval_times_weibull(t_begin,t_end,packet_num,alpha)
    mean_interval_time=(t_end-t_begin)/packet_num;
    shape=alpha;
    scale=mean_interval_time;
    interval_times_abs = wblrnd(scale,shape,1,packet_num);
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
