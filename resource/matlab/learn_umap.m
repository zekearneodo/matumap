%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function: learn_umap
% MATLAB wrapper for python implementation of UMAP embedding method.
% Paper: UMAP: Uniform Manifold Approximation and Projection for 
%        Dimension Reduction
% Authors: McInnes, Healy, Melville 2018
% Paper link: https://arxiv.org/abs/1802.03426
% Code repository: https://github.com/lmcinnes/umap
% API Doc: https://umap-learn.readthedocs.io/en/latest/api.html
% Tutorial: https://umap-learn.readthedocs.io/en/latest/basic_usage.html
%
%
% Inputs:
%           - python_mods: python modules from init_umap.m used for
%           computation (basically a function handle to the python code)
%           - X : input (double) data array of size [Nsamples , nfeatures]
%           - n_components: (int) number of embedding dimensions to transform to
%           - n_neighbours: (int)number of nearest neighbours for embedding
%           - metric: (str) 
%           - umap_obj: learned umap transform object for prediction (if
%           provided, the function simply returns the embedding according
%           to this object, and returns the object as well).
%
% Outputs:
%           - embedding: (double) matrix of size [Nsamples, n_components]
%           - model: umap_object that you can use again for transforming
%           new data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [embedding, model] = learn_umap(python_mods, X, n_components, n_neighbors, ...
    metric, umap_obj)

if isempty(umap_obj)
    mode = 1;
else
    mode = 2;
end

if nargin<2
    fprintf('\n ... choosing n_components = 2, n_neighbours = 5, and metric= euclidean ...');
    n_components = 2;
    n_neighbors = 5;
    metric = 'euclidean';
end

if nargin<3
    fprintf('\n .... choosing n_neighbors = 5, metric=euclidean ....');
    n_neighbors = 5;
    metric = 'euclidean';
end

if nargin<4
    fprintf('\n ... choosing metric = euclidean ... ');
    metric='euclidean';
end

% make  sure input is double
X = double(X);

% flatten input array (required)
Nsamples = size(X,1);
nfeats = size(X,2);
Y = X(:)';


if mode==1
    %% learn umap object
    fprintf('\n .... learning UMAP transformer ..... \n');
    tic
    O = python_mods.do_umap_embedding_flattened(Y,uint32(Nsamples),uint32(nfeats),[],uint8(n_neighbors), ...
        uint8(n_components), metric);
    fprintf('\n ...... DONE! ..... \n');
    toc
    
    %extract embedding 
    embedding = cell(O(1));
    embedding = double(py.array.array('d',py.numpy.nditer(embedding)));
    embedding = reshape(embedding,Nsamples,n_components);

    %extract model
    model = cell(O(2));
    model = model{1};
else
    %% prediction
    fprintf('\n ..... transforming new data with learned UMAP object ..... \n');
    tic
    O = python_mods.do_umap_embedding_flattened(Y,uint32(Nsamples),uint32(nfeats),umap_obj);
    fprintf('\n ..... DONE! ..... \n');
    toc
    
    %extract embedding 
    embedding = double(py.array.array('d',py.numpy.nditer(O)));
    embedding = reshape(embedding,Nsamples,n_components);
    model = umap_obj;
end
