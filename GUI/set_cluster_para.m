function varargout = set_cluster_para(varargin)
% SET_CLUSTER_PARA MATLAB code for set_cluster_para.fig
%      SET_CLUSTER_PARA, by itself, creates a new SET_CLUSTER_PARA or raises the existing
%      singleton*.
%
%      H = SET_CLUSTER_PARA returns the handle to a new SET_CLUSTER_PARA or the handle to
%      the existing singleton*.
%
%      SET_CLUSTER_PARA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SET_CLUSTER_PARA.M with the given input arguments.
%
%      SET_CLUSTER_PARA('Property','Value',...) creates a new SET_CLUSTER_PARA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before set_cluster_para_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to set_cluster_para_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help set_cluster_para

% Last Modified by GUIDE v2.5 13-Apr-2015 08:12:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @set_cluster_para_OpeningFcn, ...
                   'gui_OutputFcn',  @set_cluster_para_OutputFcn, ...
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

% --- Executes just before set_cluster_para is made visible.
function set_cluster_para_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to set_cluster_para (see VARARGIN)

% Choose default command line output for set_cluster_para
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes set_cluster_para wait for user response (see UIRESUME)
    uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = set_cluster_para_OutputFcn(hObject, eventdata, handles) 
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


function max_order_input_Callback(hObject, eventdata, handles)
% hObject    handle to max_order_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_order_input as text
%        str2double(get(hObject,'String')) returns contents of max_order_input as a double
end

% --- Executes during object creation, after setting all properties.
function max_order_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_order_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function cut_off_input_Callback(hObject, eventdata, handles)
% hObject    handle to cut_off_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cut_off_input as text
%        str2double(get(hObject,'String')) returns contents of cut_off_input as a double
end

% --- Executes during object creation, after setting all properties.
function cut_off_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cut_off_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function approximation_Callback(hObject, eventdata, handles)
% hObject    handle to approximation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of approximation as text
%        str2double(get(hObject,'String')) returns contents of approximation as a double
end

% --- Executes during object creation, after setting all properties.
function approximation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to approximation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in set_cluster_para.
function set_cluster_para_Callback(hObject, eventdata, handles)
% hObject    handle to set_cluster_para (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%     tic;
    cutoff=round(str2double(get(handles.cut_off_input,'String')));
%     assignin('base','cutoff',cutoff);
    maxorder=round(str2double(get(handles.max_order_input,'String')));
%     assignin('base','maxorder',maxorder);
    approx=get(handles.approximation,'String');
%     assignin('base','approx',approx);
    
    temp.cutoff=cutoff;
    temp.maxorder=maxorder;
    temp.approx=approx;
    guidata(hObject, handles);
    setappdata(handles.figure1,'settings',temp);
    uiresume(handles.figure1);
end
