function [start_y,end_y,width] = Findwidth(pos_y,mask,height,plate_start_y)
   [Height,Width]=size(mask);
    count = 0;start_y = 0;end_y = 0;width=0;Count = 0;
for j = 1:Width
    if(~mask(pos_y,j))
        if(~count)
            start_y = j;
            count = 1;
        end
    else
        if(count)
            end_y = j-1;
            width = end_y-start_y;
            if(width>0.75*height)
                if(start_y > plate_start_y)
                   break;
                end
            end
            count = 0;
        end
    end
end