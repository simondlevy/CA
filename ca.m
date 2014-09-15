function frames = ca(varargin)
% CA generic Cellular Automaton simulator
%
%     CA(N) runs the simulation on an NxN grid.
%
%     CA(N, SEED) allows you to set the random-number generator seed.
%
%
% You must implement the following functions for a given CA application:
%
%     INIT(N) returns an initial NxN grid
%
%     UPDATE(OLDGRID, T) returns grid at time T+1 based on grid at time T
%
%     SHOWGRID(GRID) displays the grid in an appropriate way, returning
%                    a handle to the displayed graphics
%
%     GETCELL returns new value for cell clicked on by user

% Copyright (C) 2009  Simon D. Levy
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ca_OpeningFcn, ...
    'gui_OutputFcn',  @ca_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    frames = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT




% --- Executes just before ca is made visible.
function ca_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ca (see VARARGIN)

% Choose default command line output for ca
handles.output = hObject;

% store grid size, max time
handles.n = varargin{1};

% flip/flop for step
handles.step = 0;

% seed random-number generator if indicated
if length(varargin) > 1
    rand('state', varargin{2})
end

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function frames = ca_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% these are global for mouseclick callback
global grid
global h


% do app-specific inititalization
grid = init(handles.n);

% loop until current pattern differs from previous
lastgrid = grid;
t = 0;
while true
    
    % display grid
    h = showgrid(grid);
    
    % store frames for movie if indicated
    if nargout > 0
        frames(t+1) = getframe;
    end
    
    % set title to current tick
    set(gcf, 'Name', sprintf('t = %3d', t))
    
    % pause based on slider value and button state
    if strcmp(get(handles.pushbutton1, 'String'), 'Pause')
        pause(1-get(handles.slider1, 'Value')+.01)
    else
        step = getfield(guidata(hObject), 'step');
        while ishandle(hObject) &&  ...
                getfield(guidata(hObject), 'step') == step
            pause(.01)
        end
    end
    
    % handle becomes invalid when window is closed
    if ishandle(hObject)
        
        % clear old plot
        delete(h)
        
        % do app-specific update
        grid = update(grid, t);
        
        % If no change since previous, disable buttons, report done, and
        % halt
        if all(lastgrid == grid)
            set(handles.pushbutton1, 'Enable', 'off')
            set(handles.pushbutton2, 'Enable', 'off')
            set(gcf, 'Name', sprintf('t = %3d: Done', t))
           break
        end
        
    else
        
        % report final state
        fprintf('Grid contents:\n')
        for k = min(min(grid)):max(max(grid))
            fprintf('%d %2d%%\n', k, fix(100*sum(sum(grid==k)) / numel(grid)))
        end
        
        break
        
    end
    
    lastgrid = grid;
    t = t + 1;
end

% toggles step/go
function flipstep(hObject)
data = guidata(hObject);
data.step = ~data.step;
guidata(hObject, data)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(hObject, 'String'), 'Pause')
    set(hObject, 'String', 'Go')
    set(handles.pushbutton2, 'Enable', 'on')
else
    set(hObject, 'String', 'Pause')
    set(handles.pushbutton2, 'Enable', 'off')
    flipstep(hObject)
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
flipstep(hObject)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);



% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grid
global h
pt = get(gca, 'CurrentPoint');
pt = fix(pt(1,1:2));
x = pt(1);
y = pt(2);
switch get(hObject, 'SelectionType')
    case 'alt'       % right button erases
        val = 0;
    case 'extended'   % middle button is ignored
        return
    otherwise    % left button gets value from application
        val = getcell;
end
n = length(grid);
if inrange(x, n) && inrange(y, n)
    grid(y, x) = val;
    h = showgrid(grid);
end

% helper function for checking coordinates in range [1,n]
function okay = inrange(x, n)
okay = x >= 1 && x <= n;

% dummy function to ignore button clicks outside axes
function figure1_ButtonDownFcn(hObject, eventdata, handles)

