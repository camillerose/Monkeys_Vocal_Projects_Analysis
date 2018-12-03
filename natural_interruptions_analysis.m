
% count M1 calls
total_M1_calls = length(monkey1_data);

% count M2 calls
total_M2_calls = length(monkey2_data);

M1_interruptions = {};
M2_interruptions = {};
interruption_times = {};
Next_call_interrupter = {};
Next_call_interruptee = {};
Next_call_interrupter_latency = {};
Next_call_interruptee_latency = {};


% count interruptions

for i=1:length(full_list_ordered)

    % if the sequence is two different monkeys
    if ~strcmp(full_list_ordered(i),full_list_ordered(i+1))
    
        % the ending time of the first overlaps with the starting time of
        % the second, indicating an interruption
        if cell2mat(full_list_ordered(i,4)) > cell2mat(full_list_ordered(i+1,3)) &&...
             strcmp(full_list_ordered(i+1,2),'tsk')   
            
            % time into call interruption occurred
            interruption_time = cell2mat(full_list_ordered(i+1,3)) - cell2mat(full_list_ordered(i,3));
            interruption_times{i} = interruption_time;
            
            %store response in each monkey?s bin
            if strcmp(full_list_ordered(i+1), 'Monkey 1')
               
                M1_interruptions{i} = 1;
                
            elseif strcmp(full_list_ordered(i+1), 'Monkey 2')
                
                M2_interruptions{i} = 1;
            end
            
            %who calls next after an interruption
                if strcmp(full_list_ordered(i+2), full_list_ordered(i+1))
                    
                    Next_call_interrupter{i} = 1; %1 = interrupter
                    
                    Next_call_time = cell2mat(full_list_ordered(i+2,3)) - cell2mat(full_list_ordered(i+1,3));
                    Next_call_interrupter_latency{i} = Next_call_time;
                    
                elseif ~strcmp(full_list_ordered(i+2), full_list_ordered(i+1))
                    
                    Next_call_interruptee{i} = 1; %1 = interruptee
                    
                    Next_call_time = cell2mat(full_list_ordered(i+2,3)) - cell2mat(full_list_ordered(i+1,3));
                    Next_call_interruptee_latency{i} = Next_call_time;
                    
                end
                
            
        end
        
    end
            
    if i == length(full_list_ordered) || i+1 == length(full_list_ordered)
       break 
    end
    
end

%calculations
M1_interruptions = sum(cell2mat(M1_interruptions));
M2_interruptions = sum(cell2mat(M2_interruptions));

Interrupter_calls_after_interruption = sum(cell2mat(Next_call_interrupter));
Interruptee_calls_after_interruption = sum(cell2mat(Next_call_interruptee));

interruption_time_avg = mean(cell2mat(interruption_times));
next_call_interrupter_latency_avg = mean(cell2mat(Next_call_interrupter_latency));
next_call_interruptee_latency_avg = mean(cell2mat(Next_call_interruptee_latency));

%display results
disp('total_M1_calls')
disp(total_M1_calls)

disp('total_M2_calls')
disp(total_M2_calls)

disp('M1_interruptions')
disp(M1_interruptions)

disp('M2_interruptions')
disp(M2_interruptions)

disp('interruption_time_avg')
disp(interruption_time_avg)

disp('Interrupter_calls_after_interruption')
disp(Interrupter_calls_after_interruption)

disp('Interruptee_calls_after_interruption')
disp(Interruptee_calls_after_interruption)

disp('next_call_interrupter_latency_avg')
disp(next_call_interrupter_latency_avg)

disp('next_call_interruptee_latency_avg')
disp(next_call_interruptee_latency_avg)

% pause for a moment
disp('change to other sheet to enter raw latencies')

disp('Interruption Times')
disp(cell2mat(interruption_times)');

disp('Latency to call after interruption: interrupter')
disp(cell2mat(Next_call_interrupter_latency)');

disp('Latency to call after interruption: interruptee')
disp(cell2mat(Next_call_interruptee_latency)');

