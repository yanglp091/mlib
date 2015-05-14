function varargout = set_external_para(varargin)
% SET_EXTERNAL_PARA MATLAB code for set_external_para.fig
%      SET_EXTERNAL_PARA, by itself, creates a new SET_EXTERNAL_PARA or raises the existing
%      singleton*.
%
%      H = SET_EXTERNAL_PARA returns the handle to a new SET_EXTERNAL_PARA or the handle to
%      the existing singleton*.
%
%      SET_EXTERNAL_PARA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SET_EXTERNAL_PARA.M with the given input arguments.
%
%      SET_EXTERNAL_PARA('Property','Value',...) creates a new SET_EXTERNAL_PARA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before set_external_para_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to set_external_para_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help set_external_para

% Last Modified by GUIDE v2.5 09-Apr-2015 19:41:31

% Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @set_external_para_OpeningFcn, ...
                       'gui_OutputFcn',  @set_external_para_OutputFcn, ...
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
end
% End initialization code - DO NOT EDIT


% --- Executes just before set_external_para is made visible.
function set_external_para_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to set_external_para (see VARARGIN)
    % Choose default command line output for set_external_para
        handles.output = hObject;

        % Update handles structure
        guidata(hObject, handles);

        % UIWAIT makes set_external_para wait for user response (see UIRESUME)
        uiwait(handles.figure1);
        
end


% --- Outputs from this function are returned to the command line.
function varargout = set_external_para_OutputFcn(hObject, eventdata, handles) 
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




function B_magnitue_Callback(hObject, eventdata, handles)
% hObject    handle to B_magnitue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B_magnitue as text
%        str2double(get(hObject,'String')) returns contents of B_magnitue as a double
end

% --- Executes during object creation, after setting all properties.
function B_magnitue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B_magnitue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end




function B_theta_Callback(hObject, eventdata, handles)
% hObject    handle to B_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B_theta as text
%        str2double(get(hObject,'String')) returns contents of B_theta as a double
end

% --- Executes during object creation, after setting all properties.
function B_theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double
end

% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function B_phi_Callback(hObject, eventdata, handles)
% hObject    handle to B_phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B_phi as text
%        str2double(get(hObject,'String')) returns contents of B_phi as a double
end

% --- Executes during object creation, after setting all properties.
function B_phi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B_phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function ZFS_input_Callback(hObject, eventdata, handles)
% hObject    handle to ZFS_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ZFS_input as text
%        str2double(get(hObject,'String')) returns contents of ZFS_input as a double
end

% --- Executes during object creation, after setting all properties.
function ZFS_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZFS_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function cspin_type_Callback(hObject, eventdata, handles)
% hObject    handle to cspin_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cspin_type as text
%        str2double(get(hObject,'String')) returns contents of cspin_type as a double
end

% --- Executes during object creation, after setting all properties.
function cspin_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cspin_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function cspin_theta_Callback(hObject, eventdata, handles)
% hObject    handle to cspin_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cspin_theta as text
%        str2double(get(hObject,'String')) returns contents of cspin_theta as a double
end

% --- Executes during object creation, after setting all properties.
function cspin_theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cspin_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function cspin_phi_Callback(hObject, eventdata, handles)
% hObject    handle to cspin_phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cspin_phi as text
%        str2double(get(hObject,'String')) returns contents of cspin_phi as a double
end

% --- Executes during object creation, after setting all properties.
function cspin_phi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cspin_phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function cspin_x_Callback(hObject, eventdata, handles)
% hObject    handle to cspin_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cspin_x as text
%        str2double(get(hObject,'String')) returns contents of cspin_x as a double
end


% --- Executes during object creation, after setting all properties.
function cspin_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cspin_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function cspin_y_Callback(hObject, eventdata, handles)
% hObject    handle to cspin_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cspin_y as text
%        str2double(get(hObject,'String')) returns contents of cspin_y as a double
end


% --- Executes during object creation, after setting all properties.
function cspin_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cspin_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function cspin_z_Callback(hObject, eventdata, handles)
% hObject    handle to cspin_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cspin_z as text
%        str2double(get(hObject,'String')) returns contents of cspin_z as a double
end


% --- Executes during object creation, after setting all properties.
function cspin_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cspin_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function bath_address_Callback(hObject, eventdata, handles)
% hObject    handle to bath_address (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bath_address as text
%        str2double(get(hObject,'String')) returns contents of bath_address as a double
end


% --- Executes during object creation, after setting all properties.
function bath_address_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bath_address (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in set_para.
function set_para_Callback(hObject, eventdata, handles)
% hObject    handle to set_para (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    fprintf('setting conditions...\n');
    conditions=phy.condition.LabCondition();
    B=str2double(get(handles.B_magnitue,'String'));
    B_theta=str2double(get(handles.B_theta,'String'));
    B_phi=str2double(get(handles.B_phi,'String'));
    conditions.magnetic_field.polar_vector=[B,B_theta, B_phi]';
    conditions.reference_frequency=str2double(get(handles.ZFS_input,'String'));
    conditions.reference_direction.theta=str2double(get(handles.cspin_theta,'String'));
    conditions.reference_direction.phi=str2double(get(handles.cspin_phi,'String'));

    disp('creating a center spin...');
    cspin_type=get(handles.cspin_type,'String');
    cs_coordx=str2double(get(handles.cspin_x,'String'));
    cs_coordy=str2double(get(handles.cspin_y,'String'));
    cs_coordz=str2double(get(handles.cspin_z,'String'));
    cspin=phy.stuff.Spin(cspin_type, [cs_coordx cs_coordy cs_coordz]);

    bath_ID=get(handles.bath_address,'String');
    bath_spins=phy.stuff.SpinCollection(bath_ID);
    pr=phy.model.CCEengine(cspin, conditions,'SpinCollection', bath_spins);

        temp.cspin=cspin;
    temp.conditions=conditions;
    temp.pr=pr;
    guidata(hObject, handles);
    setappdata(handles.figure1,'settings',temp);
    uiresume(handles.figure1);
end
