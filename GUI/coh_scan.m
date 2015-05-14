function varargout = coh_scan(varargin)
% COH_SCAN MATLAB code for coh_scan.fig
%      COH_SCAN, by itself, creates a new COH_SCAN or raises the existing
%      singleton*.
%
%      H = COH_SCAN returns the handle to a new COH_SCAN or the handle to
%      the existing singleton*.
%
%      COH_SCAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COH_SCAN.M with the given input arguments.
%
%      COH_SCAN('Property','Value',...) creates a new COH_SCAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before coh_scan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to coh_scan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help coh_scan

% Last Modified by GUIDE v2.5 04-May-2015 11:23:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @coh_scan_OpeningFcn, ...
                   'gui_OutputFcn',  @coh_scan_OutputFcn, ...
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

% --- Executes just before coh_scan is made visible.
function coh_scan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to coh_scan (see VARARGIN)

% Choose default command line output for coh_scan
    handles.output = hObject;
    data=varargin{1};
    handles.inputdata=data;%input data structure : data.timelist; data.coh; data.scan_val_list
    nb=length(data.coh);
    set(handles.slider1,'Min',1);
    set(handles.slider1,'Max',nb);
    set(handles.slider1,'SliderStep',[1./nb, 10./nb]);
    set(handles.slider1,'Value',1);

    % Update handles structure
    guidata(hObject, handles);

% UIWAIT makes coh_scan wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = coh_scan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    data=handles.inputdata;
    n=ceil(get(hObject,'Value'));
    handles.slider1.Value=n;
    update_plot(n, data); 
    guidata(hObject, handles);
end

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
end

function update_plot(n, data)

    time=data.timelist;
    scan_val_list=data.scan_val_list;
    ntime=length(time);
    ref_vals=0.3679*ones(1,ntime);
    coh=data.coh{n};
    
    nfields=sum(~structfun(@isempty,coh));
    legend_flag=cell(1,nfields-1);
    for n=1:nfields-1
        field_name=strcat('coherence_cce_',num2str(n));
        rng(n);
        colorval=rand(1,3);
        line(time,abs(coh.(field_name)),'LineStyle','-','LineWidth',2,'Marker','*','MarkerSize',4,'Color',colorval);
        legend_flag{n}=strcat('coherence-cce-',num2str(n));
    end
    line(time,ref_vals,'LineStyle','-','LineWidth',1,'Color',[0,0,0]);
    xlabel('Time');
    ylabel('Coherence');
    xlim([0,time(end)]);
    ylim([0,1]);
    title(['ScanValue=' num2str(scan_val_list(n))]);
    box on;
    
    h=legend(legend_flag);
    set(h,'FontSize',20);
    set(h,'Box','off');    



    xlabel('Time');
    ylabel('Coherence');
    xlim([0,time(end)]);
    ylim([0,1]);
    box on;
    grid on;
    grid minor;
end
