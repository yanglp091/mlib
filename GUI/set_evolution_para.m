function varargout = set_evolution_para(varargin)
% SET_EVOLUTION_PARA MATLAB code for set_evolution_para.fig
%      SET_EVOLUTION_PARA, by itself, creates a new SET_EVOLUTION_PARA or raises the existing
%      singleton*.
%
%      H = SET_EVOLUTION_PARA returns the handle to a new SET_EVOLUTION_PARA or the handle to
%      the existing singleton*.
%
%      SET_EVOLUTION_PARA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SET_EVOLUTION_PARA.M with the given input arguments.
%
%      SET_EVOLUTION_PARA('Property','Value',...) creates a new SET_EVOLUTION_PARA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before set_evolution_para_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to set_evolution_para_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help set_evolution_para

% Last Modified by GUIDE v2.5 13-Apr-2015 08:34:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @set_evolution_para_OpeningFcn, ...
                   'gui_OutputFcn',  @set_evolution_para_OutputFcn, ...
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
end

% --- Executes just before set_evolution_para is made visible.
function set_evolution_para_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to set_evolution_para (see VARARGIN)

    % Choose default command line output for set_evolution_para
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes set_evolution_para wait for user response (see UIRESUME)
    uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = set_evolution_para_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
    varargout{1} = handles.output;
    temp=getappdata(handles.figure1,'settings');
    varargout{1}=temp;
    close(gcf);
end


function cs_state1_input_Callback(hObject, eventdata, handles)
% hObject    handle to cs_state1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cs_state1_input as text
%        str2double(get(hObject,'String')) returns contents of cs_state1_input as a double

end
% --- Executes during object creation, after setting all properties.
function cs_state1_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cs_state1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function cs_state2_input_Callback(hObject, eventdata, handles)
% hObject    handle to cs_state2_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cs_state2_input as text
%        str2double(get(hObject,'String')) returns contents of cs_state2_input as a double
end

% --- Executes during object creation, after setting all properties.
function cs_state2_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cs_state2_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

function pulse_number_input_Callback(hObject, eventdata, handles)
% hObject    handle to pulse_number_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pulse_number_input as text
%        str2double(get(hObject,'String')) returns contents of pulse_number_input as a double
end

% --- Executes during object creation, after setting all properties.
function pulse_number_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pulse_number_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function max_time_input_Callback(hObject, eventdata, handles)
% hObject    handle to max_time_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_time_input as text
%        str2double(get(hObject,'String')) returns contents of max_time_input as a double
end

% --- Executes during object creation, after setting all properties.
function max_time_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_time_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

end

function time_steps_input_Callback(hObject, eventdata, handles)
% hObject    handle to time_steps_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_steps_input as text
%        str2double(get(hObject,'String')) returns contents of time_steps_input as a double
end

% --- Executes during object creation, after setting all properties.
function time_steps_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_steps_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

% --- Executes on button press in set_evolu_para.
function set_evolu_para_Callback(hObject, eventdata, handles)
% hObject    handle to set_evolu_para (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    coh_para.state1=str2double(get(handles.cs_state1_input,'String'));
    coh_para.state2=str2double(get(handles.cs_state2_input,'String'));
    coh_para.tmax=str2double(get(handles.max_time_input,'String'));
    coh_para.ntime=str2double(get(handles.time_steps_input,'String'));
    coh_para.npulse=str2double(get(handles.pulse_number_input,'String'));
%     assignin('base','coh_para',coh_para);
    
    temp=coh_para;
    guidata(hObject, handles);
    setappdata(handles.figure1,'settings',temp);
    uiresume(handles.figure1);
end
