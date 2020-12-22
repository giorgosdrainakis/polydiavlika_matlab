function export_traffic_flow_dataset(nodes,t_begin,t_end)
    csv_content={};
    nodes_dict=1:nodes;
    mean_interval_time=2e-3; %sec
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
        
        node_flow=generate_flow(t_begin,t_end,mean_interval_time,source_id,dest_ids);
        csv_content = [csv_content;node_flow];
    end

    % Define csv column tags
    csv_names={'flow_id','time','flow_size','flow_qos','source_id','destination_id'};
    output_table= cell2table(csv_content(1:end,:),'VariableNames',csv_names(1,:));

    % Write the table to a CSV file
    writetable(output_table,'traffic_flow_dataset.csv')
end
