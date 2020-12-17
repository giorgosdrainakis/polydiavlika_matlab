function export_traffic_dataset(nodes,t_begin,t_end,avg_throughput,qos)
    sigma_lognormal_low=2.6;
    sigma_lognormal_med=1;
    alpha_weibull=0.8;
    c_pareto=0.5;
    csv_content={};
    nodes_dict=1:nodes;

    % For every source node
    for source_id=1:nodes
        % Get potential destination nodes
        if nodes==1
            dest_ids=[0,0];
        else
            dest_ids=nodes_dict(nodes_dict~=source_id);
            % If only two nodes, force each to send to the other
            if size(dest_ids)==1
                dest_ids=[dest_ids,dest_ids];
            end
        end
        
        % Generate low qos traffic
        if isequal(qos,'all') || isequal(qos,'low')
            low_packets=generate_packets_low_qos(t_begin,t_end,avg_throughput,source_id,dest_ids,c_pareto,sigma_lognormal_low,alpha_weibull);
            if isempty(low_packets)
                disp('Warning: No low packets generated - check distribution params');
            else
                csv_content = [csv_content;low_packets];
            end
        end

        % Generate medium qos traffic
        if isequal(qos,'all') || isequal(qos,'med')
            med_packets=generate_packets_med_qos(t_begin,t_end,avg_throughput,source_id,dest_ids,sigma_lognormal_med);
            csv_content = [csv_content;med_packets];
        end
        
        % Generate high qos traffic
        if isequal(qos,'all') || isequal(qos,'high')
            high_packets=generate_packets_high_qos(t_begin,t_end,avg_throughput,source_id,dest_ids);
            csv_content = [csv_content;high_packets];
        end
    end

    % Define csv column tags
    csv_names={'packet_id','time','packet_size','packet_qos','source_id','destination_id'};
    output_table= cell2table(csv_content(1:end,:),'VariableNames',csv_names(1,:));

    % Write the table to a CSV file
    writetable(output_table,'traffic_dataset.csv')
end
