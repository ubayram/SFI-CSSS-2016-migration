function varargout = GooseMigration(varargin)
% GOOSEMIGRATION MATLAB code for GooseMigration.fig
%      GOOSEMIGRATION, by itself, creates a new GOOSEMIGRATION or raises the existing
%      singleton*.
%
%      H = GOOSEMIGRATION returns the handle to a new GOOSEMIGRATION or the handle to
%      the existing singleton*.
%
%      GOOSEMIGRATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GOOSEMIGRATION.M with the given input arguments.
%
%      GOOSEMIGRATION('Property','Value',...) creates a new GOOSEMIGRATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GooseMigration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GooseMigration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GooseMigration

% Last Modified by GUIDE v2.5 28-Jun-2016 13:59:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GooseMigration_OpeningFcn, ...
                   'gui_OutputFcn',  @GooseMigration_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before GooseMigration is made visible.
function GooseMigration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GooseMigration (see VARARGIN)

% Choose default command line output for GooseMigration
handles.output = hObject;



% % This sets up the initial plot - only do when we are invisible
% % so window can get raised using GooseMigration.
% if strcmp(get(hObject,'Visible'),'off')
%     plot(rand(5));
% end

%axes(handles.goose_pic);
fig_goose = imread('goose.jpg');
handles.goose_pic = imshow(fig_goose);
axes(handles.axes1);
surf(peaks(100));
rotate3d on;
xlabel('longitude');
ylabel('latitude');
zlabel('time');
handles.season = 0;
handles.selectedyears = zeros(10, 1);
handles.ready = 0;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes GooseMigration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GooseMigration_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on button press in add_bird.
function add_bird_Callback(hObject, eventdata, handles)
% hObject    handle to add_bird (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in spring_data.
function spring_data_Callback(hObject, eventdata, handles)
% hObject    handle to spring_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.season = 1;
disp('spring')
fid = fopen('migration_spring.txt');
data = textscan(fid, '%s %s %f %f %f %s %s %d %d');
    handles.birds = data{9};
    handles.date_ = data{1};
    handles.time_ = data{2};
    handles.long_ = data{3};
    handles.lat_ = data{4};
    handles.heading = data{5};
    handles.height = data{6};
    handles.action = data{8};
    handles.bird_ids = unique(data{9});
    handles.index_nan_height = find(strcmp(handles.height, 'nan'));
% Hint: get(hObject,'Value') returns toggle state of spring_data
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in fall_data.
function fall_data_Callback(hObject, eventdata, handles)
% hObject    handle to fall_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    eventdata.season = -1;
    disp('fall')
    fid = fopen('migration_fall.txt');
    data = textscan(fid, '%s %s %f %f %f %s %s %d %d');
    handles.birds = data{9};
    handles.date_ = data{1};
    handles.time_ = data{2};
    handles.long_ = data{3};
    handles.lat_ = data{4};
    handles.heading = data{5};
    handles.height = data{6};
    handles.index_nan_height = find(strcmp(handles.height, 'nan'));
    handles.action = data{8};
    handles.bird_ids = unique(data{9});


% Hint: get(hObject,'Value') returns toggle state of fall_data
% Update handles structure
guidata(hObject, handles);

function plot_Data(hObject, handles)

if (handles.ready == 1)
    bird_ids = [];
    axes(handles.axes1);
    reset(gca);
    %clf(handles.axes1);
    xlabel('longitude');
    ylabel('latitude');
    zlabel('height');
    ax = gca;
    grid on;
    if (sum(handles.selectedyears) ~= 0)
        valid_years = find(handles.selectedyears ~= 0);
        t = size(valid_years);
        for i=1:t % When t number of years are selected to plot
            year = handles.selectedyears(valid_years(i));
            % find rows indices that belongs to the current selected year
            %years_indices = find(int(handles.date_(1:4))==year);
            index_ = stripYears(handles.date_, year);
            longitude_year_i = handles.long_(index_);
            latitude_year_i = handles.lat_(index_);
            birds_year_i = handles.birds(index_);
            height_year_i = str2double(handles.height(index_));
            bird_ids = [bird_ids unique(birds_year_i)];
            
            scatter3(longitude_year_i, latitude_year_i, height_year_i, [], birds_year_i, 'filled');
            set(ax, 'zticklabel', {handles.date_(index_)});
            
            hold on;
        end
        
    end
    hold off;
    txtInfo = sprintf(unique(bird_ids));
    set(handles.panel_screen, 'String', txtInfo);
    guidata(hObject, handles);
end

function [index_] = stripYears(date_, year)

index_ = [];

for i=1:size(date_)
   current_date =  date_(i);
   
   tmp = char(current_date);
   if (tmp(1:4) == int2str(year))
       index_ = [index_ i];
   end
end

% --- Executes on button press in y2006.
function y2006_Callback(hObject, eventdata, handles)
% hObject    handle to y2006 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedyears(1) = 2006;
% Hint: get(hObject,'Value') returns toggle state of y2006
guidata(hObject, handles);

% --- Executes on button press in y2007.
function y2007_Callback(hObject, eventdata, handles)
% hObject    handle to y2007 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedyears(2) = 2007;
% Hint: get(hObject,'Value') returns toggle state of y2007
guidata(hObject, handles);

% --- Executes on button press in y2008.
function y2008_Callback(hObject, eventdata, handles)
% hObject    handle to y2008 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedyears(3) = 2008;
% Hint: get(hObject,'Value') returns toggle state of y2008
guidata(hObject, handles);

% --- Executes on button press in y2009.
function y2009_Callback(hObject, eventdata, handles)
% hObject    handle to y2009 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedyears(4) = 2009;
% Hint: get(hObject,'Value') returns toggle state of y2009
guidata(hObject, handles);

% --- Executes on button press in y2010.
function y2010_Callback(hObject, eventdata, handles)
% hObject    handle to y2010 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedyears(5) = 2010;
% Hint: get(hObject,'Value') returns toggle state of y2010
guidata(hObject, handles);

% --- Executes on button press in y2011.
function y2011_Callback(hObject, eventdata, handles)
% hObject    handle to y2011 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedyears(6) = 2011;
% Hint: get(hObject,'Value') returns toggle state of y2011
guidata(hObject, handles);

% --- Executes on button press in y2012.
function y2012_Callback(hObject, eventdata, handles)
% hObject    handle to y2012 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedyears(7) = 2012;
% Hint: get(hObject,'Value') returns toggle state of y2012
guidata(hObject, handles);

% --- Executes on button press in y2013.
function y2013_Callback(hObject, eventdata, handles)
% hObject    handle to y2013 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedyears(8) = 2013;
% Hint: get(hObject,'Value') returns toggle state of y2013
guidata(hObject, handles);

% --- Executes on button press in y2014.
function y2014_Callback(hObject, eventdata, handles)
% hObject    handle to y2014 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedyears(9) = 2014;
% Hint: get(hObject,'Value') returns toggle state of y2014
guidata(hObject, handles);

% --- Executes on button press in y2015.
function y2015_Callback(hObject, eventdata, handles)
% hObject    handle to y2015 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selectedyears(10) = 2015;

% Hint: get(hObject,'Value') returns toggle state of y2015
guidata(hObject, handles);

% --- Executes on button press in ready_.
function ready__Callback(hObject, eventdata, handles)
% hObject    handle to ready_ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%disp(handles.selectedyears)

if (sum(handles.selectedyears) ~= 0)
    handles.ready = 1;
    %txtInfo = sprintf('Ready...');
else
    txtInfo = sprintf('You were not ready. Select a season and years to plot');
    set(handles.panel_screen, 'String', txtInfo);
end
plot_Data(hObject, handles);

guidata(hObject, handles);

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
