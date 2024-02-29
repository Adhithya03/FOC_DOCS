function dlgSett = ACIMControlReferenceCb(objHandle)
    % Mask initialization function for MCB/ACIM Control Reference block.
    %
    % Inputs:
    %   objHandle   : Current block handle obtained by gcbh command
    
    
    %   Copyright 2020-2021 The MathWorks, Inc.
    
    %%
    %Do not run initialization code if model is running
    invalidStatus = {'external','running','compiled','restarting','paused','terminating'};
    if any(strcmpi(get_param(bdroot(objHandle),'SimulationStatus'),invalidStatus))
        
        %Return dummy values
        dlgSett.Id_ref       = 1;
        dlgSett.Id_gain      = 1;
        dlgSett.Iq_gain      = 1;
        dlgSett.Slip_speed   = 1;
        dlgSett.I_max        = 1;
        dlgSett.N_base_PU    = 1;
        
        return
    end
    
    % Get system info
    this = get_param(objHandle,'Object');
    sys = getfullname(objHandle);
    
    % Get Dialog Settings
    mEnables = get_param(objHandle,'MaskEnables');
    mVisibilities = get_param(objHandle,'MaskVisibilities');
    mValues = get_param(objHandle,'MaskValues');
    
    % Resolve parameters
    acim.p          = 1;
    acim.Llr        = 1;
    acim.Lm         = 1;
    acim.FluxRated  = 1;
    acim.N_rated    = 1;
    acim.N_base     = 1;
    acim.I_max      = 1;
    
    try
        acim.p          = double(slResolve(this.polePairs,objHandle));
        acim.Llr        = double(slResolve(this.Llr,objHandle));
        acim.Lm         = double(slResolve(this.Lm,objHandle));
        acim.FluxRated  = double(slResolve(this.FluxRated,objHandle));
        acim.N_rated    = double(slResolve(this.N_rated,objHandle));
        acim.N_base     = double(slResolve(this.N_base,objHandle));
        acim.I_max      = double(slResolve(this.I_sat,objHandle));
    catch
        %     Do nothing
    end
    
    % Compute required inductances
    acim.Lr = acim.Llr + acim.Lm;
    
    % Initialize PU values
    dlgSett.I_base_PU = 1;
    dlgSett.N_base_PU = 1;
    dlgSett.T_base_PU = 1;
    
    switch this.Units
        case 'Per-Unit (PU)'
            try
                dlgSett.I_base_PU = double(slResolve(this.I_base,objHandle));
            catch
                %     Do nothing
            end
            dlgSett.N_base_PU = acim.N_base;
            dlgSett.T_base_PU = (3/2)*acim.p*(acim.Lm/acim.Lr)*acim.FluxRated*dlgSett.I_base_PU;
            set_param(objHandle,'MaskDisplay','mcb.internal.drawIcons(''ACIM Control Reference'',1);');
        case 'SI Units'
            dlgSett.I_base_PU = 1;
            dlgSett.N_base_PU = (60/(2*pi));
            dlgSett.T_base_PU = 1;
            set_param(objHandle,'MaskDisplay','mcb.internal.drawIcons(''ACIM Control Reference'',2);');
    end
    
    dlgSett.Iq_gain     = (dlgSett.T_base_PU)/(((3/2)*acim.p*(acim.Lm^2/acim.Lr))*(dlgSett.I_base_PU^2));
    dlgSett.Id_ref      = (acim.FluxRated/(acim.Lm))/dlgSett.I_base_PU;
    dlgSett.Id_gain     = (dlgSett.Id_ref)*(acim.N_rated/dlgSett.N_base_PU);
    dlgSett.Slip_speed  = (acim.N_base - acim.N_rated)/dlgSett.N_base_PU;
    dlgSett.I_max       = acim.I_max/dlgSett.I_base_PU;
    
    %% Update Base Value for Torque
    
    %Checking updated value
    newValue = num2str(dlgSett.T_base_PU);
    oldValue = get_param(sys,'T_base');
    
    if ~strcmp(oldValue, newValue)
        mEnables(10) = {'on'};
        set_param(objHandle,'MaskEnables',mEnables);
        
        set_param(sys,'T_base',num2str(dlgSett.T_base_PU));
        
        mEnables(10) = {'off'};
        set_param(objHandle,'MaskEnables',mEnables);
    end
    
    end