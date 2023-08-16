function[Policy,Value]= MazeSolver_New(nStates ,nActions,R,T)
% R -> Reward matrix
% maxItr -> Maximum Number of iterations
% p,q -> Transition Probabilities
% Function is specific to Gridworld examples and can be modified otherwise
MaxIteration = 50;
% Number of rows
% nrow=size(R,1);
nrow=nStates;
% Number of coloumns
% ncol=size(R,2);
ncol=nStates;
maxItr=50;
% Initializing Value function as 3-D Matrix
V=zeros(nrow,ncol,maxItr);

% Initializing Policy as matix
Policy=zeros(nrow,ncol);

%Value function in different Directions
Vn=zeros(nrow,ncol,maxItr); % North
Ve=zeros(nrow,ncol,maxItr); % East
Vs=zeros(nrow,ncol,maxItr); % South 
Vw=zeros(nrow,ncol,maxItr); % West

gamma=0.9;

% Possible actions are: 1. up, 2. Right, 3. Down 4. Left
for itr=1:MaxIteration
    for ii =1:nrow
        for jj=1:ncol

          % loop over each possible action {up,down,right,left}: 
          
            v_tmp = 0; 
            V(1,2,itr)=-10;
            V(2,2,itr)=-10;
            V(4,1,itr)=-10;
            V(4,2,itr)=-10;
            V(1,5,itr)=-10;
            V(2,5,itr)=-10;
            V(4,7,itr)=-10;
            V(4,8,itr)=-10;
            V(8,8,itr)=-10;

          if( (ii==1 && jj==ncol) ) continue; end 
          
          % action = LEFT 
          if( jj==1 )% s is ON the left most column ... this action does not change our position 
            v_tmp = v_tmp + T(ii,jj,ii,jj,4)*(-1.5 + gamma*V(ii,jj,itr) ); 
            Vw(ii,jj,itr)=v_tmp;
            
          elseif( jj==2 && ii==1 )% s is NOT on the left most column but this action will move us into a termial position (reward is zero)

            v_tmp = v_tmp +T(ii,jj,ii,jj-1,4)*( R(ii,jj-1) + gamma*V(ii,jj-1,itr) ); 
            Vw(ii,jj,itr)=v_tmp;
            
          else        % s is NOT on the left most column ... this action moves us left 
            v_tmp = v_tmp + T(ii,jj,ii,jj-1,4)*( R(ii,jj-1) + gamma*V(ii,jj-1,itr) ); 
            Vw(ii,jj,itr)=v_tmp;
            
          end
           % action = UP
            v_tmp=0;
          if( ii==1 )                % s is ON the top row ... this action does not change our position 
            v_tmp = v_tmp + T(ii,jj,ii,jj,1)*( -1.5 + gamma*V(ii,jj,itr) );
            Vn(ii,jj,itr)=v_tmp;
            
          elseif( ii==2 && jj==1 )   % s is NOT on the top row but will step into a terminal state (reward is zero)

            v_tmp = v_tmp + T(ii,jj,ii-1,jj,1)*( R(ii-1,jj) + gamma*V(ii-1,jj,itr) ); 
            Vn(ii,jj,itr)=v_tmp;
            
          else          % s is NOT on the top row ... this action moves us up
            v_tmp = v_tmp + T(ii,jj,ii-1,jj,1)*( R(ii-1,jj) + gamma*V(ii-1,jj,itr) ); 
            Vn(ii,jj,itr)=v_tmp;
           
          end
            v_tmp=0;
          % action = RIGHT
          if( jj==ncol )                    % s is ON the right most column ... this action does not change our position 
            v_tmp = v_tmp + T(ii,jj,ii,jj,2)*( -1.5 + gamma*V(ii,jj,itr) );
            Ve(ii,jj,itr)=v_tmp;
            
          elseif( jj==ncol-1 && ii==nrow )  % s is NOT on the right most column but will step into a terminal position (reward is zero) 

            v_tmp = v_tmp + T(ii,jj,ii,jj+1,2)*( R(ii,jj+1) + gamma*V(ii,jj+1,itr) ); 
            Ve(ii,jj,itr)=v_tmp;
            
          else           % s is NOT on the right most column ... this action moves us right
            v_tmp = v_tmp + T(ii,jj,ii,jj+1,2)*( R(ii,jj+1) + gamma*V(ii,jj+1,itr) ); 
            Ve(ii,jj,itr)=v_tmp;
            
          end

          v_tmp=0;
          % action = DOWN
          if( ii==nrow )                 % s is ON the bottom row ... this action does not change our position 
            v_tmp = v_tmp + T(ii,jj,ii,jj,3)*( -1.5 + gamma*V(ii,jj,itr) ); 
            Vs(ii,jj,itr)=v_tmp;
            
          elseif( ii==nrow-1 && jj==ncol ) % s is NOT on the bottom row but will step into a terminal state (reward is zero) 

            v_tmp = v_tmp + T(ii,jj,ii+1,jj,3)*(  R(ii+1,jj) + gamma*V(ii+1,jj,itr) ); 
            Vs(ii,jj,itr)=v_tmp;
            
          else                              % s is NOT on the bottom row ... this action moves us down
            v_tmp = v_tmp + T(ii,jj,ii+1,jj,3)*( R(ii+1,jj) + gamma*V(ii+1,jj,itr) ); 
            Vs(ii,jj,itr)=v_tmp;
            
          end
            
          [V(ii,jj,itr+1),Policy(ii,jj)] = max([Vn(ii,jj,itr),Ve(ii,jj,itr),Vs(ii,jj,itr),Ve(ii,jj,itr)]);
%             if  abs( v-V(1,8,itr) ) < 0.00001
%                 break
%             end
           
        end % jj loop 
    end % ii loop
end

V(1,nStates,end-1)=10;
Value=V(1:end,1:end,end-1);
Policy=Policy(1:end,1:end);

end
