% Reading the data
Follower=readtable('Follower.csv');
Leader = readtable('leader.csv');

% finding the derived velocity and acceleration
xpos_L =482.768453- Leader.Local_Y ;
xpos_F =482.768453 - Follower.Local_Y;
N = length(xpos_L);
T = Leader.Frame_ID;
id= 511;

Vehicle_ID = zeros(521,1);
FrameID = zeros(521,1);
Position = zeros(521,1);
Velocity = zeros(521,1);
Acceleration = zeros(521,1);
Smooth_Vel = zeros(521,1);
Smooth_Pos = zeros(521,1);
Smooth_Acc = zeros(521,1);
for i = 1:N
    if (i==1)
        vr = (xpos_L(i+1) - xpos_L(i))/0.1 ;
        ar = (xpos_L(i+2) - (2*xpos_L(i+1)) + xpos_L(i))/0.1^2;
        FrameID(i) = T(i);
        Vehicle_ID(i) =  id;
        Velocity(i) = vr;
        Acceleration(i) = ar ;
        Position(i) = xpos_L(i);
    elseif (i>1) && (i<N)
        vr = (xpos_L(i+1) - xpos_L(i-1))/(2*0.1);
        ar = (xpos_L(i+1)- (2*xpos_L(i)) + xpos_L(i-1))/0.1^2;
        FrameID(i) = T(i);
        Vehicle_ID(i) =  id;
        Velocity(i) = vr;
        Acceleration(i) = ar ;
        Position(i) = xpos_L(i);
    elseif(i==N)
        vr = (xpos_L(i) - xpos_L(i-1))/ 0.1;
        ar = (xpos_L(i) - (2*xpos_L(i-1)) + xpos_L(i-2))/ 0.1^2;
        FrameID(i) = T(i);
        Vehicle_ID(i) =  id;
        Velocity(i) = vr;
        Acceleration(i) = ar ;
        Position(i) = xpos_L(i);

% creating a dataset for the Position, Velocity, Acceleration
  DS = dataset(Vehicle_ID,FrameID,Position,Velocity,Acceleration)
    end
end
subplot(2,2,1);
plot(Leader.Time,xpos_L,Follower.Time,xpos_F);
title('Time Vs Position');
legend('Leader','Follower')

subplot(2,2,2);
[Smooth_Pos] = Smoothening(Position);
plot(Leader.Time,Position, Leader.Time,Smooth_Pos);
title('Time Vs Position');
legend('Raw Velocity','Smooth Velocity')


subplot(2,2,3);
[Smooth_Vel] = Smoothening(Velocity);
plot(Leader.Time,Velocity,Leader.Time,Smooth_Vel);
title('Time Vs Velocity');
legend('Raw Velocity','Smooth Velocity')



subplot(2,2,4);
[Smooth_Acc] = Smoothening(Acceleration);
plot(Leader.Time,Acceleration, Leader.Time,Smooth_Acc);
title('Time Vs Acceleration');
legend('Raw Acceleration','Smooth Acceleration')


