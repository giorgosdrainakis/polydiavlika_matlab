classdef Channel
   properties
      id
      occupation_time_start
      occupation_time_end
      speed
   end
   methods
      function bl = is_occupied(obj,t) 
         if (obj.occupation_time_start <= t)&&(t<=obj.occupation_time_end)
            bl=true;
         else
            bl=false;
        end
      end
   end
end