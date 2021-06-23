%% Rolling disk - Kinematic constraint
% Animation of a disk rolling without slipping on a horizontal plane.
%
%%

clear ; close all ; clc

%% Parameters

% Video
tF      = 30;                   % Final time                    [s]
fR      = 30;                   % Frame rate                    [fps]
dt      = 1/fR;                 % Time resolution               [s]
time    = linspace(0,tF,tF*fR); % Time                          [s]

% Disc
R = 1;                          % Disc radius                   [m]
disc_c_x = 1;                   % Disc center x position        [m]
disc_c_y = R;                   % Disc center y position        [m]
th = 0:0.1:2*pi+0.1;            % Angle for disc shape          [rad]
disc_x = R*cos(th);             % Disc circumference x coord.   [m]
disc_y = R*sin(th);             % Disc circumference y coord.   [m]
disc_v = 5/30;                  % Disc speed                    [m/s]
x = linspace(0,tF*disc_v,tF*fR); % Disc position over time      [m]

%% Animation

figure
set(gcf,'Position',[50 50 1280 720]) % 720p
% set(gcf,'Position',[50 50 854 480]) % 480p

% Create and open video writer object
v = VideoWriter('Rolling_disk_kinematic.avi');
v.Quality   = 100;
v.FrameRate = fR;
open(v);

for i=1:length(time)
    
    disc_c_x = x(i);
    
    % Arc
    th_arc = 0:0.0001:disc_c_x/R;
    arc_x = -R*sin(th_arc);
    arc_y = -R*cos(th_arc);
    
    cla
    hold on ; grid on ; box on ; axis equal
    set(gca,'Xlim',[-1.1 6.1],'Ylim',[-0.1 2.1])
    % Disc origin
    plot(disc_x,disc_y+disc_c_y,'k:')
    % Disc center
    plot(disc_c_x,disc_c_y,'ko','MarkerFaceColor','k')
    % Disc
    plot(disc_x+disc_c_x,disc_y+disc_c_y,'k')
    % Diameter 
    plot([disc_c_x-arc_x(end) disc_c_x+arc_x(end)],[disc_c_y-arc_y(end) disc_c_y+arc_y(end)],'k--')
    % x distance
    plot([0 disc_c_x],[0 0],'r','LineWidth',1.5)
    % arc = x/R
    plot(arc_x+disc_c_x,arc_y+disc_c_y,'r','LineWidth',1.5)
    % Contact point initial
    plot(0,0,'ro','MarkerFaceColor','r')
    % Contact point 
    plot(disc_c_x,0,'ro','MarkerFaceColor','r')
    % Point surface
    plot(arc_x(end)+disc_c_x,arc_y(end)+disc_c_y,'ro','MarkerFaceColor','r')
    
    xlabel('x [m]')
    ylabel('y [m]')

    frame = getframe(gcf);
    writeVideo(v,frame);
    
end

close(v);