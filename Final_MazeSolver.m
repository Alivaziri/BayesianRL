function[Policy,Value]= Final_MazeSolver(nStates ,nActions,R,T)
width = 8;
height = 8;
% Define the number of states and actions
num_states = width * height;
num_actions = 4;
MaxIteration = 100;
% Number of rows
nrow=8;
ncol=8;
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
    for s = 1:num_states
        % Get the (x,y) coordinates of the current state
        [x, y] = ind2sub([width, height], s);
        ii=x;
        jj=y;
        % loop over each possible action {up,down,right,left}:
        for a = 1:num_actions
            % Get the (x,y) coordinates of the next state
            switch a
                case 1 % move up
                    next_x = x;
                    next_y = max(y-1, 1);
                case 2 % move down
                    next_x = x;
                    next_y = min(y+1, height);
                case 3 % move left
                    next_x = max(x-1, 1);
                    next_y = y;
                case 4 % move right
                    next_x = min(x+1, width);
                    next_y = y;
            end
            % Convert the (x,y) coordinates of the next state to a state index
            next_s = sub2ind([width, height], next_x, next_y);
            
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
                v_tmp = v_tmp + T(s,next_s,4)*(-1.5 + gamma*V(ii,jj,itr) );
                Vw(ii,jj,itr)=v_tmp;
                
            elseif( jj==2 && ii==1 )% s is NOT on the left most column but this action will move us into a termial position (reward is zero)
                
                v_tmp = v_tmp +T(s,next_s,4)*( R(ii,jj-1) + gamma*V(ii,jj-1,itr) );
                Vw(ii,jj,itr)=v_tmp;
                
            else        % s is NOT on the left most column ... this action moves us left
                v_tmp = v_tmp +T(s,next_s,4)*( R(ii,jj-1) + gamma*V(ii,jj-1,itr) );
                Vw(ii,jj,itr)=v_tmp;
                
            end
            % action = UP
            v_tmp=0;
            if( ii==1 )                % s is ON the top row ... this action does not change our position
                v_tmp = v_tmp + T(s,next_s,4)*( -1.5 + gamma*V(ii,jj,itr) );
                Vn(ii,jj,itr)=v_tmp;
                
            elseif( ii==2 && jj==1 )   % s is NOT on the top row but will step into a terminal state (reward is zero)
                
                v_tmp = v_tmp + T(s,next_s,4)*( R(ii-1,jj) + gamma*V(ii-1,jj,itr) );
                Vn(ii,jj,itr)=v_tmp;
                
            else          % s is NOT on the top row ... this action moves us up
                v_tmp = v_tmp + T(s,next_s,4)*( R(ii-1,jj) + gamma*V(ii-1,jj,itr) );
                Vn(ii,jj,itr)=v_tmp;
                
            end
            v_tmp=0;
            % action = RIGHT
            if( jj==ncol )                    % s is ON the right most column ... this action does not change our position
                v_tmp = v_tmp + T(s,next_s,4)*( -1.5 + gamma*V(ii,jj,itr) );
                Ve(ii,jj,itr)=v_tmp;
                
            elseif( jj==ncol-1 && ii==nrow )  % s is NOT on the right most column but will step into a terminal position (reward is zero)
                
                v_tmp = v_tmp + T(s,next_s,4)*( R(ii,jj+1) + gamma*V(ii,jj+1,itr) );
                Ve(ii,jj,itr)=v_tmp;
                
            else           % s is NOT on the right most column ... this action moves us right
                v_tmp = v_tmp + T(s,next_s,4)*( R(ii,jj+1) + gamma*V(ii,jj+1,itr) );
                Ve(ii,jj,itr)=v_tmp;
                
            end
            
            v_tmp=0;
            % action = DOWN
            if( ii==nrow )                 % s is ON the bottom row ... this action does not change our position
                v_tmp = v_tmp + T(s,next_s,4)*( -1.5 + gamma*V(ii,jj,itr) );
                Vs(ii,jj,itr)=v_tmp;
                
            elseif( ii==nrow-1 && jj==ncol ) % s is NOT on the bottom row but will step into a terminal state (reward is zero)
                
                v_tmp = v_tmp + T(s,next_s,4)*(  R(ii+1,jj) + gamma*V(ii+1,jj,itr) );
                Vs(ii,jj,itr)=v_tmp;
                
            else                              % s is NOT on the bottom row ... this action moves us down
                v_tmp = v_tmp + T(s,next_s,4)*( R(ii+1,jj) + gamma*V(ii+1,jj,itr) );
                Vs(ii,jj,itr)=v_tmp;
                
            end
            
            [V(ii,jj,itr+1),Policy(ii,jj)] = max([Vn(ii,jj,itr),Ve(ii,jj,itr),Vs(ii,jj,itr),Ve(ii,jj,itr)]);
            
        end
        
    end
end
% Other flags
V(1,3,end-1)=5;
V(7,8,end-1)=5;
V(8,1,end-1)=5;

% Start
V(1,1,end-1)=-5;

% Goal
% V(1,8,end-1)=10;

% Final Value and  Corresponding Policy
Value=V(1:end,1:end,end-1);
Policy=Policy(1:end,1:end);


end
