function varargout = sampler_GUI(varargin)
% SAMPLER_GUI MATLAB code for sampler_GUI.fig
%      SAMPLER_GUI, by itself, creates a new SAMPLER_GUI or raises the existing
%      singleton*.
%
%      H = SAMPLER_GUI returns the handle to a new SAMPLER_GUI or the handle to
%      the existing singleton*.
%
%      SAMPLER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAMPLER_GUI.M with the given input arguments.
%
%      SAMPLER_GUI('Property','Value',...) creates a new SAMPLER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sampler_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sampler_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sampler_GUI

% Last Modified by Li Wan 02/15/2023

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sampler_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @sampler_GUI_OutputFcn, ...
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


% --- Executes just before sampler_GUI is made visible.
function sampler_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sampler_GUI (see VARARGIN)

% Choose default command line output for sampler_GUI
handles.output = hObject;

movegui(gcf,'center')

guidata(hObject, handles);

addpath('sampler_SRC')

handles.z     = [];
handles.chain = [];
set(get(handles.axes1, 'xlabel'), 'string', 'Time step') 
set(get(handles.axes6, 'xlabel'), 'string', 'Samples') 
set(get(handles.axes4, 'ylabel'), 'string', 'Num. of states') 
set(get(handles.axes6, 'ylabel'), 'string', 'Emission means') 
set(handles.axes1, 'color', 'none') 
set(handles.axes2, 'color', 'none') 
set(handles.axes3, 'color', 'none') 
set(handles.axes4, 'color', 'none') 
set(handles.axes5, 'color', 'none') 
set(handles.axes6, 'color', 'none') 

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes sampler_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);





% --- Outputs from this function are returned to the command line.
function varargout = sampler_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% read parameters
opts.a = str2num( handles.edit3.String );
opts.g = str2num( handles.edit17.String );
opts.Q = [ str2num( handles.edit18.String ),...
           str2num( handles.edit22.String ),...
           str2num( handles.edit23.String ),...
           str2num( handles.edit24.String )];
opts.dr_sk  = 1;
opts.M      = str2num( handles.edit28.String );
opts.K_init = str2num( handles.edit25.String );

% create chain
handles.chain = chainer_main( handles.z, 1, [], opts, false, false );

% activate
handles.pushbutton1.Enable = 'off';
handles.edit3.Enable = 'off';
handles.edit17.Enable = 'off';
handles.edit18.Enable = 'off';
handles.edit22.Enable = 'off';
handles.edit23.Enable = 'off';
handles.edit24.Enable = 'off';
handles.edit28.Enable = 'off';
handles.edit25.Enable = 'off';
handles.pushbutton4.Enable = 'on';
handles.pushbutton7.Enable = 'on';
handles.edit26.Enable = 'on';
handles.edit27.Enable = 'on';
handles.checkbox1.Enable = 'on';
handles.checkbox2.Enable = 'on';
    

guidata(hObject, handles);





% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile( { '*.txt','Text-files (*.txt)';...
                                    '*.mat','MAT-files (*.mat)' }, ...
                                 'Import a time series', ...
                                 'MultiSelect', 'off');

if ~isequal(filename,0)
    handles.z = load(filename,pathname);
    
    % plot data
    axes( handles.axes1 )
    line( 1:length(handles.z) , handles.z )
    y_lim = get(gca,'Ylim');
    title(['Time series imported from ', filename],'Interpreter','none')
    
    axes( handles.axes2 )
    histogram( handles.z, linspace(y_lim(1),y_lim(2),25),'orientation','horizontal' )
    box off
    set(gca,'XTickLabel',[],'YTickLabel',[],'color','none')
    
    % set default parameters
    handles.edit18.String = num2str( mean(handles.z),'%10.2f' );
    handles.edit22.String = num2str( 1/var(handles.z),'%10.2f' );
    handles.edit23.String = num2str( 1,'%10.2f' );
    handles.edit24.String = num2str( 0.10,'%10.2f' );

    % activate
    handles.pushbutton3.Enable = 'off';
    handles.pushbutton2.Enable = 'on';
    handles.pushbutton1.Enable = 'on';
    handles.edit3.Enable = 'on';
    handles.edit17.Enable = 'on';
    handles.edit18.Enable = 'on';
    handles.edit22.Enable = 'on';
    handles.edit23.Enable = 'on';
    handles.edit24.Enable = 'on';
    handles.edit28.Enable = 'on';
    handles.edit25.Enable = 'on';

end

guidata(hObject,handles)
    
    






% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~isempty(handles.chain) && handles.chain.r_max > 1
    choice = questdlg({'This will delete the imported time series and the current chain.','Do you want to continue?'},'Delete data and samples','Yes','No','Yes');
else
    choice = questdlg({'This will delete the imported time series.','Do you want to continue?'},'Delete data','Yes','No','Yes');
end

switch choice
    case 'Yes'

        handles.x = [];

        pushbutton4_Callback(hObject, eventdata, handles);

        
        delete(handles.axes1.Children)
        delete(handles.axes2.Children)
        handles.axes1.Title = [];

        handles.pushbutton3.Enable = 'on';
        handles.pushbutton2.Enable = 'off';
        handles.pushbutton1.Enable = 'off';

        handles.edit3.Enable = 'off';
        handles.edit17.Enable = 'off';
        handles.edit18.Enable = 'off';
        handles.edit22.Enable = 'off';
        handles.edit23.Enable = 'off';
        handles.edit24.Enable = 'off';
        handles.edit28.Enable = 'off';
        handles.edit25.Enable = 'off';

        handles.edit18.String = '-';
        handles.edit22.String = '-';
        handles.edit23.String = '-';
        handles.edit24.String = '-';

        guidata(hObject,handles)

end












% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

del = true;

if ~isempty(handles.z) && ~isempty(handles.chain) && handles.chain.r_max > 1
    choice = questdlg({'This will delete the current chain.','Do you want to continue?'},'Delete samples','Yes','No','Yes');

    switch choice
        case 'No'
            del = false;
    end
end

    
if del        
    handles.chain = [];

    delete(handles.axes3.Children)
    delete(handles.axes4.Children)
    delete(handles.axes5.Children)
    delete(handles.axes6.Children)
    legend(handles.axes4,'off')

    handles.pushbutton1.Enable = 'on';

    handles.pushbutton4.Enable = 'off';
    handles.pushbutton5.Enable = 'off';
    handles.pushbutton6.Enable = 'off';
    handles.pushbutton7.Enable = 'off';

    handles.checkbox1.Enable = 'off';
    handles.checkbox2.Enable = 'off';

    handles.edit26.Enable = 'off';
    handles.edit27.Enable = 'off';


    handles.edit3.Enable = 'on';
    handles.edit17.Enable = 'on';
    handles.edit18.Enable = 'on';
    handles.edit22.Enable = 'on';
    handles.edit23.Enable = 'on';
    handles.edit24.Enable = 'on';
    handles.edit28.Enable = 'on';
    handles.edit25.Enable = 'on';


    handles.pushbutton1.Enable = 'on';
    handles.edit3.Enable = 'on';
    handles.edit17.Enable = 'on';
    handles.edit18.Enable = 'on';
    handles.edit22.Enable = 'on';
    handles.edit23.Enable = 'on';
    handles.edit24.Enable = 'on';
    handles.edit25.Enable = 'on';


    guidata(hObject,handles)

end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uiputfile({ '*.mat', 'MAT-files (*.mat)'},...
                                   'Save samples','samples.mat');

if ~isequal(filename,0)
    [~,name,ext] = fileparts(filename);
    chainer_export(handles.chain,str2num( handles.edit27.String ),1,[pathname,name],ext(2:end));
end





% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.pushbutton6.Enable = 'off';
drawnow

choice = questdlg({'This might take a while.','Do you want to continue?'},'Sample analysis','Yes','No','Yes');
    
if strcmp(choice,'Yes')

    opts.Interpreter = 'tex';
    answer = inputdlg({'Minimum \mu','Maximum \mu','Number of bins'},...
              'Discretize parameter space', [1 40; 1 40; 1 40],{num2str(min(handles.z)),num2str(max(handles.z)),'25'},opts); 
        
    if ~isempty(answer)
        m_min = str2num(answer{1});
        m_max = str2num(answer{2});
        m_num = str2num(answer{3});

        [m_mod,~] = chainer_analyze_means(handles.chain,str2num( handles.edit27.String ),1,m_min,m_max,m_num,handles.z);
        [m_edges,p_mean,d_dist] = chainer_analyze_transitions(handles.chain,str2num( handles.edit27.String ),1,m_min,m_max,m_num,true);
        [y_mean,y_std] = chainer_analyze_drift(handles.chain,str2num( handles.edit27.String ),1,handles.z);        
        
        choice = questdlg('Do you want to save the results?','Analysis','Yes','No','Yes');
        if strcmp(choice,'Yes')
            [filename, pathname] = uiputfile({ '*.mat', 'MAT-files (*.mat)'},...
                                               'Save results','results.mat');
            if ~isequal(filename,0)
                mu_sequence = m_mod;
                mu_edges = m_edges;
                transitions_mean = p_mean;
                dwell_mean = d_dist(:,1);
                dwell_std  = d_dist(:,2);
                drift_mean = y_mean;
                drift_std  = y_std;
                save( [pathname,filename], 'mu_sequence','mu_edges','transitions_mean','dwell_mean','dwell_std','drift_mean','drift_std' );
            end
        end
    end
end

handles.pushbutton6.Enable = 'on';


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.pushbutton7.Enable = 'off';
drawnow

handles.chain = chainer_main( handles.z, str2num( handles.edit26.String ), handles.chain, [],...
    handles.checkbox1.Value, handles.checkbox2.Value );

handles.pushbutton7.Enable = 'on';

% show samples
r_1 =  ceil( str2num( handles.edit27.String )*handles.chain.r_max );
r_2 = floor( str2num( handles.edit27.String )*handles.chain.r_max );

f = cell2mat(handles.chain.F);
f = f(:,1);
r = zeros(sum(handles.chain.K),1);
r(cumsum(handles.chain.K)) = 1;
r = 1 + cumsum(r);
r(end) = r(end)-1;


axes( handles.axes4 )
delete(handles.axes4.Children)
line(1:r_1,handles.chain.K(1:r_1),'color','c','marker','.','linestyle','-')
line(r_2:handles.chain.r_max,handles.chain.K(r_2:end),'marker','.','linestyle','-')
xlim([0 handles.chain.r_max])
ylim([0 max(handles.chain.K)+1])
legend(handles.axes4,'Burn-in','location','NE')
legend boxoff
y_lim = get(gca,'Ylim');

axes( handles.axes3 )
delete(handles.axes3.Children)
histogram(handles.chain.K(r_2:end),'orientation','horizontal','binmethod','integer')
box off
set(gca,'XTickLabel',[],'YTickLabel',[],'color','none')
ylim(y_lim)


axes( handles.axes6 )
delete(handles.axes6.Children)
line(r(r<r_1),f(r<r_1),'color','c','marker','.','linestyle','none')
line(r(r>=r_2),f(r>=r_2),'marker','.','linestyle','none')
xlim([0 handles.chain.r_max])
y_lim = get(gca,'Ylim');


axes( handles.axes5 )
delete(handles.axes5.Children)
histogram(f(r>=r_2),'orientation','horizontal')
box off
set(gca,'XTickLabel',[],'YTickLabel',[],'color','none')
ylim(y_lim)



handles.pushbutton5.Enable = 'on';
handles.pushbutton6.Enable = 'on';


guidata(hObject,handles)



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit27 as text
%        str2double(get(hObject,'String')) returns contents of edit27 as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit28 as text
%        str2double(get(hObject,'String')) returns contents of edit28 as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
