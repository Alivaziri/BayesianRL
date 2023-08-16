function Policy= FindPolicy(V)
nrow=8;
ncol=8;

Policy=zeros(nrow,ncol);

%Value function in different Directions
Vn=zeros(nrow,ncol); % North
Ve=zeros(nrow,ncol); % East
Vs=zeros(nrow,ncol); % South
Vw=zeros(nrow,ncol); % West

for ii =1:nrow
    for jj=1:ncol
        for k=1:4
            
            if( (ii==1 && jj==ncol) ) continue; end
            
            v_tmp=0;
            % action = LEFT
            if( jj==1 )
                v_tmp = V(ii,jj);
                Vw(ii,jj)=v_tmp;
                
            elseif( jj==2 && ii==1 )
                
                v_tmp = V(ii,jj-1);
                Vw(ii,jj)=v_tmp;
                
            else
                v_tmp = V(ii,jj-1);
                Vw(ii,jj)=v_tmp;
                
            end
            
            
            % action = UP
            v_tmp=0;
            if( ii==1 )
                v_tmp = V(ii,jj);
                Vn(ii,jj)=v_tmp;
                
            elseif( ii==2 && jj==1 )
                
                v_tmp = V(ii-1,jj);
                Vn(ii,jj)=v_tmp;
                
            else
                v_tmp = V(ii-1,jj);
                Vn(ii,jj)=v_tmp;
                
            end
            
            
            % action = RIGHT
            v_tmp=0;
            if( jj==ncol )
                v_tmp = V(ii,jj);
                Ve(ii,jj)=v_tmp;
                
            elseif( jj==ncol-1 && ii==nrow )
                v_tmp = V(ii,jj+1);
                Ve(ii,jj)=v_tmp;
                
            else
                v_tmp = V(ii,jj+1);
                Ve(ii,jj)=v_tmp;
                
            end
            
            
            % action = DOWN
            v_tmp=0;
            if( ii==nrow )
                v_tmp = V(ii,jj);
                Vs(ii,jj)=v_tmp;
                
            elseif( ii==nrow-1 && jj==ncol )
                v_tmp = V(ii+1,jj);
                Vs(ii,jj)=v_tmp;
                
            else
                v_tmp = V(ii+1,jj);
                Vs(ii,jj)=v_tmp;
                
            end
            
            
            [~ , Policy(ii,jj)] = max([Vn(ii,jj),Ve(ii,jj),Vs(ii,jj),Ve(ii,jj)]);
        end
    end
end
Policy=Policy(1:end,1:end);

end
