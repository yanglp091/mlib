function varargout = CCE_engine_gui(varargin)
% CCE_ENGINE_GUI MATLAB code for CCE_engine_gui.fig
%      CCE_ENGINE_GUI, by itself, creates a new CCE_ENGINE_GUI or raises the existing
%      singleton*.
%
%      H = CCE_ENGINE_GUI returns the handle to a new CCE_ENGINE_GUI or the handle to
%      the existing singleton*.
%
%      CCE_ENGINE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CCE_ENGINE_GUI.M with the given input arguments.
%
%      CCE_ENGINE_GUI('Property','Value',...) creates a new CCE_ENGINE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CCE_engine_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CCE_engine_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CCE_engine_gui

% Last Modified by GUIDE v2.5 20-Apr-2015 09:25:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CCE_engine_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @CCE_engine_gui_OutputFcn, ...
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
%%
% --- Executes just before CCE_engine_gui is made visible.
function CCE_engine_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CCE_engine_gui (see VARARGIN)

% Choose default command line output for CCE_engine_gui
handles.output = hObject;
    handles.output = hObject;
    if nargin==5
        handles.pr=varargin{1};
        handles.para_data=varargin{2};
    elseif abs(nargin-3)>0.1 && (nargin-5)>0.1
        disp('wrong input parameters!');
    end

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes CCE_engine_gui wait for user response (see UIRESUME)
    % uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = CCE_engine_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end
%%
% --- Executes on button press in set_ext_para.
function set_ext_para_Callback(hObject, eventdata, handles)
% hObject    handle to set_ext_para (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    ext_para=set_external_para;%openning the external parameters setting window and get corresponding data
    handles.para_data.conditions=ext_para.conditions;
    handles.para_data.cspin=ext_para.cspin;
    if isfield(handles,'pr')
      handles=rmfield(handles,'pr');
      handles.pr=ext_para.pr;
    else
      handles.pr=ext_para.pr;
    end
    set(hObject, 'BackgroundColor',[1 1 0]);
    set(handles.reset_para, 'BackgroundColor',[0.702 0.702 0.702]); 
    guidata(hObject, handles);
end
%%
% --- Executes on button press in set_cluster_para.
function set_cluster_para_Callback(hObject, eventdata, handles)
% hObject    handle to set_cluster_para (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    tic;
    clu_para=set_cluster_para;%openning the clustering parameters setting window and get corresponding data
    
    cutoff=clu_para.cutoff;
    handles.para_data.cutoff=cutoff;
    cutoff_original=handles.pr.spin_bath.cutoff(1,1);
    cutoff_change=abs(cutoff-cutoff_original);
    
    maxorder=clu_para.maxorder;
    handles.para_data.maxorder=maxorder;
    maxorder_orginal=handles.pr.spin_bath.maxorder;
    maxorder_change=abs(maxorder_orginal-maxorder);
    
    approx=clu_para.approx;
    handles.para_data.approx=approx;
    approx_orginal=handles.pr.spin_bath.approx;
    approx_change=strcmp(approx,approx_orginal)-1;

    if cutoff_change>0 || maxorder_change || approx_change
        disp('generating clusters of spin-system...');
       
        handles.pr.spin_bath.clustering(cutoff, maxorder,approx);
        handles.pr.set_clusters();  
    end
    display_clu_num_list(handles);
    set(hObject, 'BackgroundColor',[1 1 0]);
    set(handles.reset_para, 'BackgroundColor',[0.702 0.702 0.702]); 
    guidata(hObject, handles);
    toc;
end
%%
% --- Executes on button press in set_evolu_para.
function set_evolu_para_Callback(hObject, eventdata, handles)
% hObject    handle to set_evolu_para (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   coh_para=set_evolution_para;%openning the evolution parameters setting window and get corresponding data
   handles.para_data.coh_para=coh_para;
   guidata(hObject, handles);
   set(hObject, 'BackgroundColor',[1 1 0]);
   set(handles.reset_para, 'BackgroundColor',[0.702 0.702 0.702]); 
end

function display_clu_num_list(handles)
            %display the cluster number list
        nclist=handles.pr.spin_bath.cluster_info.cluster_number_list;
        cceorder=handles.pr.spin_bath.maxorder;
        nclist_str=[];
        for n=1:cceorder
            nclist_str=[nclist_str nclist{n,1} ':' num2str(nclist{n,2}) '.  '];
        end
        set(handles.clu_number_list,'String',nclist_str);
end

function clu_number_list_Callback(hObject, eventdata, handles)
% hObject    handle to clu_number_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clu_number_list as text
%        str2double(get(hObject,'String')) returns contents of clu_number_list as a double
end

% --- Executes during object creation, after setting all properties.
function clu_number_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clu_number_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
%%
% --- Executes on button press in calculate_coh.
function calculate_coh_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_coh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    tic;
    disp('calculating clusters and total coherence...');
    coh_para=handles.para_data.coh_para;
    handles.pr.coherence_evolution(coh_para);
    set(handles.cce_order_input,'String',num2str(handles.pr.spin_batn.maxorder));
          
    disp('calculation of coherence finished.');
    guidata(hObject, handles);
    pr=handles.pr;
    fig_coh=figure();
    plot(pr.timelist,abs(pr.coherence.coherence), 'k-*');
    ylim([0,1]);
    xlabel('Time');
    ylabel('Coherence');
    box on;
    assignin('base','pr',pr);
    assignin('base','para_data',handles.para_data);
    set(hObject, 'BackgroundColor',[1 1 0]);
    handles.fig_coh=fig_coh;
    guidata(hObject, handles);
    toc;
end

% --- Executes on button press in reset_para.
function reset_para_Callback(hObject, eventdata, handles)
% hObject    handle to reset_para (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if isfield(handles,'pr')    
        handles=rmfield(handles,'pr');
    end
    if isfield(handles,'para_data')
        handles=rmfield(handles,'para_data');
    end
    set(handles.clu_number_list,'String','');
    set(handles.set_ext_para, 'BackgroundColor',[0.702 0.702 0.702]);
    set(handles.set_cluster_para, 'BackgroundColor',[0.702 0.702 0.702]);
    set(handles.set_evolu_para, 'BackgroundColor',[0.702 0.702 0.702]); 
    set(handles.calculate_coh, 'BackgroundColor',[0.702 0.702 0.702]);
    set(hObject, 'BackgroundColor',[1 1 0]);
    guidata(hObject, handles);
end

% --- Executes on button press in analy_window.
function analy_window_Callback(hObject, eventdata, handles)
% hObject    handle to analy_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    analyze_CCE(handles.pr,handles.para_data);
end



function cce_order_input_Callback(hObject, eventdata, handles)
% hObject    handle to cce_order_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cce_order_input as text
%        str2double(get(hObject,'String')) returns contents of cce_order_input as a double
end

% --- Executes during object creation, after setting all properties.
function cce_order_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cce_order_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end

% --- Executes on button press in plot_coh.
function plot_coh_Callback(hObject, eventdata, handles)
% hObject    handle to plot_coh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if isfield(handles,'fig_coh')&&isempty(handles.fig_coh)
        close(handles.fig_coh);
        handles=rmfield(handles,'fig_coh');
    end
    cceorder=get(handles.cce_order_input,'String');
    field_name=strcat('coherence_cce_',cceorder);
    coh=handles.pr.coherence.(field_name);
    fig_coh=figure();
    plot(handles.pr.timelist,abs(coh), 'r-o');
    xlim([0,handles.pr.timelist(end)]);
    ylim([0,1]);
    xlabel('Time');
    ylabel('Coherence');
    box on;
    handles.fig_coh=fig_coh;
    guidata(hObject, handles);
    
end

% --- Executes on button press in add_coh_line.
function add_coh_line_Callback(hObject, eventdata, handles)
% hObject    handle to add_coh_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    figure(handles.fig_coh);
    cceorder=get(handles.cce_order_input,'String');
    field_name=strcat('coherence_cce_',cceorder);
    coh=handles.pr.coherence.(field_name);
    tim=handles.pr.timelist;
    colorval=rand(1,3);
    line(tim,real(coh),'LineWidth',2,'Marker','o','Color',colorval);
    ylim([0,1]);
    %%%%%%%%%%%%%%%%there is a little problem%%%%%%%%%%%%%%%
end
