function python_mods = init_umap(varargin)
    % Loads the python modules for umap with matlab
    % parameters:
    %   python_path (str): path to the executable of python (in the
    %   environment where the package matumap was installed).
    %   No input assumes running from conda environment mumap.
    % returns:
    %   python_mods: the loaded module with the embedding functions
    % (what in python would be 'from matumap import matumap as
    % umapmodule')
    
    % check if running from a conda environment
    
    if nargin == 0
        % No argument is default, assumes running from mumap conda environment
        conda_env = getenv('CONDA_DEFAULT_ENV');
        if ~isempty(conda_env) && strcmp(conda_env, 'mumap')
            fprintf('running matlab within mumap env');
        else
            error('MatUmap:wrongEnvironment', ...
                'Not running in mumap environment') 
        end
    
    elseif nargin == 1
        python_path = varargin{1};
        % A path to a python environment was entered
        try
            pyversion(python_path);
        catch ME
            % either it was already loaded, or there was a problem
            [ ~, set_py_path, ~] = pyversion;
            if ~strcmpi(set_py_path, python_path)
                rethrow(ME)
            end
        end
    end
    python_mods = py.importlib.import_module('matumap.matumap');
    fprintf('Loaded python umap module')
end
