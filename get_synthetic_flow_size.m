function ret = get_synthetic_flow_size()
    flow=0;
    p_stable=0.5;
    p_stable_mice=0.95;
    p_stable_eleph=1-p_stable_mice;
    stable_avg_size_mice=5000; %bytes
    stable_avg_size_eleph=1e6; %bytes
    p_bursty=1-p_stable;
    p_bursty_mice=0.95;
    p_bursty_eleph=1-p_bursty_mice;
    bursty_min_size_mice=1000; %bytes
    bursty_max_size_mice=10000;%bytes
    bursty_min_size_eleph=1e5;%bytes
    bursty_max_size_eleph=1e7;%bytes
    
    % check whether stable or bursty flow
    myrand=rand();
    
    if (myrand<=p_stable)
        % check whether mice or elephant flow
        myrand=rand();
        if (myrand<=p_stable_mice)
            flow=exprnd(stable_avg_size_mice);
        else
            flow=exprnd(stable_avg_size_eleph);
        end
    else
        % check whether mice or elephant flow
        myrand=rand();
        if (myrand<=p_bursty_mice)
            flow=(bursty_max_size_mice-bursty_min_size_mice).*rand() + bursty_min_size_mice;
        else
            flow=(bursty_max_size_eleph-bursty_min_size_eleph).*rand() + bursty_min_size_eleph;
        end
    end
    ret=flow;
end