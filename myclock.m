function myclock
close all;

%% Exterior circumference
f = figure('Name','Guillermo clock','Color',[0.8 0.9 1]);
circ = linspace(-pi,pi,500);
xext = 10*cos(circ);
yext = 10*sin(circ);
plot(xext,yext,'b','LineWidth',3);
hold on;
axis off;
axis tight
fill(0.4*cos(circ),0.4*sin(circ),[0.6 0.6 1]); 
%axis([-10 10 -10 10])
set(gca,'position',[0.4 0.25 0.5 0.5])
axis equal
%% Markers and numbers

for k=1:12
    xmarker1 = 9*cos((12-k+3)*(1/12)*2*pi);
    xmarker2 = 10*cos((12-k+3)*(1/12)*2*pi);
    ymarker1 = 9*sin((12-k+3)*(1/12)*2*pi);
    ymarker2 = 10*sin((12-k+3)*(1/12)*2*pi);
    plot([xmarker1 xmarker2],[ymarker1 ymarker2]);
    text(0.8*xmarker2,0.8*ymarker2,num2str(k),'fontsize',16,'color',...
        [0 0 0],'HorizontalAlignment','center');
end

%% Title (Year,Month,Day)
t = datetime('now');
tit=datestr(t);
title(tit(1:strfind(tit,' ')),'fontsize',18,'Units', 'normalized', 'Position', [-0.5, 0.5, 0]);

%% Needles



%hours
hNeedlePos = -(t.Hour*(1/12)*2*pi+(1/60)*t.Minute*(1/12)*2*pi+(1/3600)*t.Second*(1/12)*2*pi)+pi/2;
hNeedlex(1) = 0;
hNeedlex(2) = 2*cos(hNeedlePos+0.4);
hNeedlex(3) = 6.5*cos(hNeedlePos);
hNeedlex(4) = 2*cos(hNeedlePos-0.4);
hNeedlex(5) = 0;
hNeedley(1) = 0;
hNeedley(2) = 2*sin(hNeedlePos+0.4);
hNeedley(3) = 6.5*sin(hNeedlePos);
hNeedley(4) = 2*sin(hNeedlePos-0.4);
hNeedley(5) = 0;
hNeedle=fill(hNeedlex,hNeedley,[1 1 1]);
handles.hNeedlex = hNeedlex;
handles.hNeedley = hNeedley;
handles.hNeedle = hNeedle;

%minutes
mNeedlePos = -(t.Minute*(1/60)*2*pi+(1/60)*t.Second*(1/60)*2*pi)+pi/2;
mNeedlex(1) = 0;
mNeedlex(2) = 4*cos(mNeedlePos+0.1);
mNeedlex(3) = 8.5*cos(mNeedlePos);
mNeedlex(4) = 4*cos(mNeedlePos-0.1);
mNeedlex(5) = 0;
mNeedley(1) = 0;
mNeedley(2) = 4*sin(mNeedlePos+0.1);
mNeedley(3) = 8.5*sin(mNeedlePos);
mNeedley(4) = 4*sin(mNeedlePos-0.1);
mNeedley(5) = 0;
mNeedle=fill(mNeedlex,mNeedley,[1 1 1]);

%seconds
sNeedlePos = -(t.Second*(1/60)*2*pi)+pi/2;
sNeedlex(1) = 0;
sNeedlex(2) = 4.5*cos(sNeedlePos+0.01);
sNeedlex(3) = 9*cos(sNeedlePos);
sNeedlex(4) = 4.5*cos(sNeedlePos-0.01);
sNeedlex(5) = 0;
sNeedley(1) = 0;
sNeedley(2) = 4.5*sin(sNeedlePos+0.01);
sNeedley(3) = 9*sin(sNeedlePos);
sNeedley(4) = 4.5*sin(sNeedlePos-0.01);
sNeedley(5) = 0;
sNeedle=fill(sNeedlex,sNeedley,[0 0 0]);

%% Push button to increase an hour
handles.t=t;
hourplus = 0;
plusHour = uicontrol('Style','pushbutton','String','Push and increase an hour','Callback',{@hourIncrease,handles},'Units','normalized','Position',[0.1 0.1 0.4 0.15]);

%% Movement

while ishandle(f)
    t = datetime('now');
    
    %hours
    hNeedlePos = -((t.Hour+hourplus)*(1/12)*2*pi+(1/60)*t.Minute*(1/12)*2*pi+(1/3600)*t.Second*(1/12)*2*pi)+pi/2;
    
    hNeedlex(2) = 2*cos(hNeedlePos+0.4);
    hNeedlex(3) = 6.5*cos(hNeedlePos);
    hNeedlex(4) = 2*cos(hNeedlePos-0.4);
    
    hNeedley(2) = 2*sin(hNeedlePos+0.4);
    hNeedley(3) = 6.5*sin(hNeedlePos);
    hNeedley(4) = 2*sin(hNeedlePos-0.4);
    
    set(hNeedle,'XData',hNeedlex,'YData',hNeedley);

    %minutes
    mNeedlePos = -(t.Minute*(1/60)*2*pi+(1/60)*t.Second*(1/60)*2*pi)+pi/2;
    
    mNeedlex(2) = 4*cos(mNeedlePos+0.1);
    mNeedlex(3) = 8.5*cos(mNeedlePos);
    mNeedlex(4) = 4*cos(mNeedlePos-0.1);
    
    mNeedley(2) = 4*sin(mNeedlePos+0.1);
    mNeedley(3) = 8.5*sin(mNeedlePos);
    mNeedley(4) = 4*sin(mNeedlePos-0.1);
    
    set(mNeedle,'XData',mNeedlex,'YData',mNeedley);

    %seconds
    sNeedlePos = -(t.Second*(1/60)*2*pi)+pi/2;
    
    sNeedlex(2) = 4.5*cos(sNeedlePos+0.01);
    sNeedlex(3) = 9*cos(sNeedlePos);
    sNeedlex(4) = 4.5*cos(sNeedlePos-0.01);
    
    sNeedley(2) = 4.5*sin(sNeedlePos+0.01);
    sNeedley(3) = 9*sin(sNeedlePos);
    sNeedley(4) = 4.5*sin(sNeedlePos-0.01);
    
    set(sNeedle,'XData',sNeedlex,'YData',sNeedley);
    
    drawnow;
    pause(0.09)
end

function hourIncrease(hObject,eventdata,handles)
    t=handles.t;
    hourplus = hourplus+1;
    hNeedlex = handles.hNeedlex;
    hNeedley = handles.hNeedley;
    hNeedle = handles.hNeedle;
    %hours
    hNeedlePos = -(t.Hour*(1/12)*2*pi+(1/60)*t.Minute*(1/12)*2*pi+(1/3600)*t.Second*(1/12)*2*pi)+pi/2-2*pi/12;
    
    hNeedlex(2) = 2*cos(hNeedlePos+0.4);
    hNeedlex(3) = 6.5*cos(hNeedlePos);
    hNeedlex(4) = 2*cos(hNeedlePos-0.4);
    
    hNeedley(2) = 2*sin(hNeedlePos+0.4);
    hNeedley(3) = 6.5*sin(hNeedlePos);
    hNeedley(4) = 2*sin(hNeedlePos-0.4);
    
    set(hNeedle,'XData',hNeedlex,'YData',hNeedley);
    drawnow;
end

end

