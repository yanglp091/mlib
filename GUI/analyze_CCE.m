function varargout = analyze_CCE(varargin)
% ANALYZE_CCE MATLAB code for analyze_CCE.fig
%      ANALYZE_CCE, by itself, creates a new ANALYZE_CCE or raises the existing
%      singleton*.
%
%      H = ANALYZE_CCE returns the handle to a new ANALYZE_CCE or the handle to
%      the existing singleton*.
%
%      ANALYZE_CCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANALYZE_CCE.M with the given input arguments.
%
%      ANALYZE_CCE('Property','Value',...) creates a new ANALYZE_CCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before analyze_CCE_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to analyze_CCE_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help analyze_CCE

% Last Modified by GUIDE v2.5 02-May-2015 11:27:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @analyze_CCE_OpeningFcn, ...
                   'gui_OutputFcn',  @analyze_CCE_OutputFcn, ...
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

% --- Executes just before analyze_CCE is made visible.
function analyze_CCE_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to analyze_CCE (see VARARGIN)

    % Choose default command line output for analyze_CCE
    handles.output = hObject;
    handles.pr=varargin{1};
    handles.para_data=varargin{2};
    coh_para=handles.para_data.coh_para;
    set_evolu_para(handles,coh_para);
    %display the total coherence
    if isfield(handles,'fig_coh')
       handles=rmfield(handles,'fig_coh');             
    end
    fig_coh=figure();
    handles.fig_coh=fig_coh;   
    plot_total_coherence(handles);
    % Update handles structure

    nc=handles.pr.spin_bath.cluster_info.nclusters;
    set(handles.coh_scanning,'Min',1);
    set(handles.coh_scanning,'Max',nc);
    set(handles.coh_scanning,'SliderStep',[1./nc, 10./nc]);
    set(handles.coh_scanning,'Value',1);
    handles.scanning_option='coherence';
    guidata(hObject, handles);

    % UIWAIT makes analyze_CCE wait for user response (see UIRESUME)
%     uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = analyze_CCE_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

function set_evolu_para(handles,coh_para)
    set(handles.max_time_input,'String',num2str(coh_para.tmax));
    set(handles.time_steps_input,'String',num2str(coh_para.ntime));
    set(handles.npulse_input,'String',num2str(coh_para.npulse));
    set(handles.state1_input,'String',num2str(coh_para.state1));
    set(handles.state2_input,'String',num2str(coh_para.state2));
    set(handles.approx_input,'String',num2str(handles.pr.spin_bath.approx));
    set(handles.mf_B_input,'String',num2str(handles.pr.conditions.magnetic_field.polar_vector(1)));
    set(handles.mf_theta_input,'String',num2str(handles.pr.conditions.magnetic_field.polar_vector(2)));
    set(handles.mf_phi_input,'String',num2str(handles.pr.conditions.magnetic_field.polar_vector(3)));  
    set(handles.xlim_max,'String',num2str(coh_para.tmax));  
end

function [coh_para,approx]=get_evolu_para(handles)
    coh_para.npulse=str2double(get(handles.npulse_input,'String'));
    coh_para.tmax=str2double(get(handles.max_time_input,'String'));
    coh_para.ntime=str2double(get(handles.time_steps_input,'String'));
    coh_para.state1=str2double(get(handles.state1_input,'String'));
    coh_para.state2=str2double(get(handles.state2_input,'String'));
    approx=get(handles.approx_input,'String');

end
%% reset the xlim and ylim
function xlim_max_Callback(hObject, eventdata, handles)
% hObject    handle to xlim_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xlim_max as text
%        str2double(get(hObject,'String')) returns contents of xlim_max as a double
end

% --- Executes during object creation, after setting all properties.
function xlim_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xlim_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function xlim_min_Callback(hObject, eventdata, handles)
% hObject    handle to xlim_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xlim_min as text
%        str2double(get(hObject,'String')) returns contents of xlim_min as a double
end

% --- Executes during object creation, after setting all properties.
function xlim_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xlim_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function ylim_max_Callback(hObject, eventdata, handles)
% hObject    handle to ylim_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ylim_max as text
%        str2double(get(hObject,'String')) returns contents of ylim_max as a double
end

% --- Executes during object creation, after setting all properties.
function ylim_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ylim_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function ylim_min_Callback(hObject, eventdata, handles)
% hObject    handle to ylim_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ylim_min as text
%        str2double(get(hObject,'String')) returns contents of ylim_min as a double
end

% --- Executes during object creation, after setting all properties.
function ylim_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ylim_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in reshape_button.
function reshape_button_Callback(hObject, eventdata, handles)
% hObject    handle to reshape_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    xmin=str2double(get(handles.xlim_min,'String'));
    xmax=str2double(get(handles.xlim_max,'String'));
    ymin=str2double(get(handles.ylim_min,'String'));
    ymax=str2double(get(handles.ylim_max,'String'));
    
    figure(handles.fig_coh);  
    set(gca,'XLim',[xmin,xmax]);
    set(gca,'YLim',[ymin,ymax]);
end

%% the scanning slider
% --- Executes on slider movement.


% --- Executes on slider movement.
function coh_scanning_Callback(hObject, eventdata, handles)
% hObject    handle to coh_scanning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    n=ceil(get(hObject,'Value'));
    handles.coh_scanning.Value=n;
    fill_cluster_info_table(n, handles);
    switch  handles.scanning_option
        case 'coherence'
        update_plot(n, handles,'coherence');
        case 'coherence_tilde'
        update_plot(n, handles,'coherence_tilde');
    end
    set(handles.cluster_index,'String',num2str(n));
    guidata(hObject, handles);

end

% --- Executes during object creation, after setting all properties.
function coh_scanning_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coh_scanning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end

function update_plot(n, handles,option)
    figure(handles.fig_coh); 
    tim=handles.pr.timelist;
    switch option
        case  'coherence'
            coh=handles.pr.spin_bath.cluster_info.clusters{n}.HilbertSpace.scalars.coherence;
             plot(tim,real(coh), 'r-o');
        case 'coherence_tilde'
             coh=handles.pr.spin_bath.cluster_info.clusters{n}.HilbertSpace.scalars.coherence_tilde;
             plot(tim,real(coh), 'b-*');
    end 
    xlabel('Time');
    ylabel('Coherence');
    title(['cluster ' num2str(n)]);
    xmin=str2double(get(handles.xlim_min,'String'));
    xmax=str2double(get(handles.xlim_max,'String'));
    ymin=str2double(get(handles.ylim_min,'String'));
    ymax=str2double(get(handles.ylim_max,'String'));
    xlim([xmin,xmax]);
    ylim([ymin,ymax]);
end
%%%%%%%%%%%%%set the scanning object%%%%%%%%%%%%%%%
% --- Executes on button press in scan_coh.
function scan_coh_Callback(hObject, eventdata, handles)
% hObject    handle to scan_coh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    handles.coh_scanning.Value=round(str2double(get(handles.cluster_index,'String')));
    handles.scanning_option='coherence';
    add_line(handles.coh_scanning.Value, handles,'coherence');
    guidata(hObject, handles);
end

% --- Executes on button press in scan_coh_tilde.
function scan_coh_tilde_Callback(hObject, eventdata, handles)
% hObject    handle to scan_coh_tilde (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.coh_scanning.Value=round(str2double(get(handles.cluster_index,'String')));
    handles.scanning_option='coherence_tilde';
    add_line(handles.coh_scanning.Value, handles,'coherence_tilde');
    guidata(hObject, handles);
end


%%

function cluster_index_Callback(hObject, eventdata, handles)
% hObject    handle to cluster_index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cluster_index as text
%        str2double(get(hObject,'String')) returns contents of cluster_index as a double
    handles.coh_scanning.Value=round(str2double(get(handles.cluster_index,'String')));
    guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function cluster_index_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cluster_index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in addline_button.
function addline_button_Callback(hObject, eventdata, handles)
% hObject    handle to addline_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    clu_idx=handles.coh_scanning.Value;
    fill_cluster_info_table(clu_idx, handles);
    option=handles.scanning_option;
    add_line(clu_idx, handles,option);  
    guidata(hObject, handles);
end

function add_line(n,handles,option)
    figure(handles.fig_coh);    
    tim=handles.pr.timelist;
     switch option
        case  'coherence'
            coh=handles.pr.spin_bath.cluster_info.clusters{n}.HilbertSpace.scalars.coherence;
            rng(n);
            colorval=rand(1,3);
        line(tim,real(coh),'LineWidth',2,'Marker','d','Color',colorval);
        case 'coherence_tilde'
             coh=handles.pr.spin_bath.cluster_info.clusters{n}.HilbertSpace.scalars.coherence_tilde;
             rng(n+1);
             colorval=rand(1,3);
             line(tim,real(coh),'LineWidth',2,'Marker','d','Color',colorval);
    end

    
end
%%
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


function npulse_input_Callback(hObject, eventdata, handles)
% hObject    handle to npulse_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of npulse_input as text
%        str2double(get(hObject,'String')) returns contents of npulse_input as a double
end

% --- Executes during object creation, after setting all properties.
function npulse_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to npulse_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function state1_input_Callback(hObject, eventdata, handles)
% hObject    handle to state1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of state1_input as text
%        str2double(get(hObject,'String')) returns contents of state1_input as a double
end

% --- Executes during object creation, after setting all properties.
function state1_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to state1_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function state2_input_Callback(hObject, eventdata, handles)
% hObject    handle to state2_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of state2_input as text
%        str2double(get(hObject,'String')) returns contents of state2_input as a double
end

% --- Executes during object creation, after setting all properties.
function state2_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to state2_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function approx_input_Callback(hObject, eventdata, handles)
% hObject    handle to approx_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of approx_input as text
%        str2double(get(hObject,'String')) returns contents of approx_input as a double
end

% --- Executes during object creation, after setting all properties.
function approx_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to approx_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function mf_B_input_Callback(hObject, eventdata, handles)
% hObject    handle to mf_B_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mf_B_input as text
%        str2double(get(hObject,'String')) returns contents of mf_B_input as a double
end

% --- Executes during object creation, after setting all properties.
function mf_B_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mf_B_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function mf_theta_input_Callback(hObject, eventdata, handles)
% hObject    handle to mf_theta_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mf_theta_input as text
%        str2double(get(hObject,'String')) returns contents of mf_theta_input as a double
end

% --- Executes during object creation, after setting all properties.
function mf_theta_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mf_theta_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function mf_phi_input_Callback(hObject, eventdata, handles)
% hObject    handle to mf_phi_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mf_phi_input as text
%        str2double(get(hObject,'String')) returns contents of mf_phi_input as a double
end

% --- Executes during object creation, after setting all properties.
function mf_phi_input_CreateFcn(hObject, eventdata, handles)
    % hObject    handle to mf_phi_input (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    empty - handles not created until after all CreateFcns called

    % Hint: edit controls usually have a white background on Windows.
    %       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end



%%
% --- Executes on button press in cal_cur_clu_coh.
function cal_cur_clu_coh_Callback(hObject, eventdata, handles)
% hObject    handle to cal_cur_clu_coh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.cluster_info_table.Data=cell(6,4);
    [coh_para,approx]=get_evolu_para(handles);
    tstep=coh_para.tmax/(coh_para.ntime-1);
    timelist=0:tstep:coh_para.tmax;
    handles.pr.timelist_check= timelist;
    cluster_idx=round(str2double(get(handles.cluster_index,'String')));
    handles.coh_scanning.Value=cluster_idx;
    
    b=str2double(get(handles.mf_B_input,'String'));
    theta=str2double(get(handles.mf_theta_input,'String'));
    phi=str2double(get(handles.mf_phi_input,'String'));
    conditions=handles.para_data.conditions;
    conditions.magnetic_field.polar_vector=[b,theta,phi];
    cluster=handles.pr.get_cluster(cluster_idx);
    cluster.set_lab_conditions(conditions);
    
    coh=handles.pr.cluster_coherence(cluster_idx,coh_para,approx);
    handles.pr.spin_bath.cluster_info.clusters{cluster_idx}.HilbertSpace.scalars.coherence_check=coh;
    handles.scanning_option='coherence';
    
    pr=handles.pr;
    assignin('base','pr',pr);
    
    figure(handles.fig_coh);  
    plot(timelist,real(coh), 'r-o');
    xlabel('Time');
    ylabel('Coherence');    
    guidata(hObject, handles);
end

% --- Executes on button press in plot_cur_clu_coh.
function plot_cur_clu_coh_Callback(hObject, eventdata, handles)
% hObject    handle to plot_cur_clu_coh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    figure(handles.fig_coh);       
    handles.cluster_info_table.Data=cell(6,4);  
    clu_idx=round(str2double(get(handles.cluster_index,'String')));
    fill_cluster_info_table(clu_idx, handles);
    scalars=handles.pr.spin_bath.cluster_info.clusters{clu_idx}.HilbertSpace.scalars;
    if isfield(scalars,'coherence_check')
        coh=scalars.coherence_check; 
        timelist=handles.pr.timelist_check;
    else
        coh=scalars.coherence;
        timelist=handles.pr.timelist;
    end

    plot(timelist,real(coh), 'r-o');
    xlabel('Time');
    ylabel('Coherence');
    handles.scanning_option='coherence';
    guidata(hObject, handles);
end

% --- Executes on button press in cal_cur_clu_tilde_coh.
function cal_cur_clu_tilde_coh_Callback(hObject, eventdata, handles)
% hObject    handle to cal_cur_clu_tilde_coh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.cluster_info_table.Data=cell(6,4);   
    [coh_para,approx]=get_evolu_para(handles);
    tstep=coh_para.tmax/(coh_para.ntime-1);
    timelist=0:tstep:coh_para.tmax;
    handles.pr.timelist_check= timelist;
    cluster_idx=round(str2double(get(handles.cluster_index,'String')));
    handles.coh_scanning.Value=cluster_idx;
    
    b=str2double(get(handles.mf_B_input,'String'));
    theta=str2double(get(handles.mf_theta_input,'String'));
    phi=str2double(get(handles.mf_phi_input,'String'));
    conditions=handles.para_data.conditions;
    conditions.magnetic_field.polar_vector=[b,theta,phi];
    cluster=handles.pr.get_cluster(cluster_idx);
    cluster.set_lab_conditions(conditions);
    
    coh=handles.pr.cluster_coherence_tilde(cluster_idx,coh_para,approx);
    handles.pr.spin_bath.cluster_info.clusters{cluster_idx}.HilbertSpace.scalars.coherence_tilde_check=coh;
    handles.scanning_option='coherence_tilde';
    guidata(hObject, handles);
    pr=handles.pr;
    assignin('base','pr',pr);
    figure(handles.fig_coh); 
    plot(timelist,real(coh), 'b-*');
    xlabel('Time');
    ylabel('Coherence');
end



% --- Executes on button press in plot_cur_clu_tilde_coh.
function plot_cur_clu_tilde_coh_Callback(hObject, eventdata, handles)
% hObject    handle to plot_cur_clu_tilde_coh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    figure(handles.fig_coh); 
    handles.cluster_info_table.Data=cell(6,4);  
    clu_idx=round(str2double(get(handles.cluster_index,'String')));
    fill_cluster_info_table(clu_idx, handles);
    scalars=handles.pr.spin_bath.cluster_info.clusters{clu_idx}.HilbertSpace.scalars;
    if isfield(scalars,'coherence_tilde_check')
        coh=scalars.coherence_tilde_check; 
        timelist=handles.pr.timelist_check;
    else
        coh=scalars.coherence_tilde;
        timelist=handles.pr.timelist;
    end
    
    plot(timelist,real(coh), 'b-*');
    xlabel('Time');
    ylabel('Coherence');
    handles.scanning_option='coherence_tilde';
    guidata(hObject, handles);
end
%%
% % --- Executes on button press in cluster_info_button.
% function cluster_info_button_Callback(hObject, eventdata, handles)
% % hObject    handle to cluster_info_button (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
%     clu_idx=get(handles.coh_scanning,'Value');
%     handles.cluster_info_table.Data=cell(6,4);
% %     clu_info_table=fill_cluster_info_table(clu_idx, handles);
% %     handles.cluster_info_table.Data=clu_info_table;
%     fill_cluster_info_table(clu_idx, handles);
%     guidata(hObject, handles);
% end
function fill_cluster_info_table( clu_idx,handles)
    cluster=handles.pr.spin_bath.cluster_info.clusters{clu_idx};
    spin_idx=find(handles.pr.spin_bath.cluster_matrix(clu_idx,:));
    handles.cluster_info_table.Data=cell(6,4);
    
    lf_para.central_spin=handles.pr.central_spin;
    lf_para.state=handles.para_data.coh_para.state2;
    approx=handles.pr.spin_bath.approx;
    cluster.set_bath_local_field('parameters',lf_para,'approx',approx);

    for m=1:cluster.nEntries
       handles.cluster_info_table.Data{m,1}=num2str(spin_idx(m));
       handles.cluster_info_table.Data{m,2}=cluster.entries{m}.name;
       coord=cluster.entries{m}.coordinate;
       handles.cluster_info_table.Data{m,3}=num2str(coord);
       cs_coord=handles.pr.central_spin.coordinate;
       handles.cluster_info_table.Data{m,4}=num2str(norm(cs_coord-coord));
       local_f=cluster.entries{m}.local_field;
       handles.cluster_info_table.Data{m,5}=num2str(local_f');
    end
end
%%
% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if isfield(handles,'fig_coh')
       handles=rmfield(handles,'fig_coh');             
    end
    fig_coh=figure();
    handles.fig_coh=fig_coh;
    plot_total_coherence(handles); 
    
    handles.cluster_info_table.Data=cell(6,4);
    set(handles.cluster_index,'String', 1);
    handles.coh_scanning.Value=1;   

    guidata(hObject, handles); 
end

function plot_total_coherence(handles)
    coh=handles.pr.coherence;
    nfields=sum(~structfun(@isempty,coh));
    legend_flag=cell(1,nfields-1);
    for n=1:nfields-1
        field_name=strcat('coherence_cce_',num2str(n));
        rng(n);
        colorval=rand(1,3);
        line(handles.pr.timelist,abs(coh.(field_name)),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',4,'Color',colorval);
        legend_flag{n}=strcat('coherence-cce-',num2str(n));
    end
    xlabel('Time');
    ylabel('Coherence');
    xlim([0,handles.pr.timelist(end)]);
    ylim([0,1]);
    box on;
    
    h=legend(legend_flag);
    set(h,'FontSize',20);
    set(h,'Box','off');

end

% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%     CCE_engine_gui;
%     uiresume(handles.figure1);
    close(gcf);
end
