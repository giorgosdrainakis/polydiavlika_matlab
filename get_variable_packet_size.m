function ret = get_variable_packet_size(small_size,big_size,small_prob)
    if (rand()<=small_prob)
        ret=small_size;
    else 
        ret=big_size;
    end
end