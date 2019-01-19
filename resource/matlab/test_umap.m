function test_umap(umap_module)
%TEST_UMAP Summary of this function goes here
%   Detailed explanation goes here
    Nsamples = 20000;
    nfeats = 200;
    mu1 = 0;
    var1 = 1;
    mu2 = 100;
    var2 = 3;
    x1 = mu1 + sqrt(var1)*randn(Nsamples,nfeats);
    x2 = 0.5*x1.^2 + 0.4*x1 + 3;
    % use the class variable to color the output embedding when you look at the
    % scatter plot of the embedding
    class = [zeros(Nsamples,1);ones(Nsamples,1)];
    X = [x1; x2]; % X is of size 40000 x 200
    [embedding, model] = learn_umap(umap_module, X, 2, 5, 'manhattan', []);
    class_colors = zeros(Nsamples*2,3);
    for i = 1:Nsamples*2
        class_colors(i,1) = class(i);
    end
    figure; 
    scatter(Yhat_test(:,1), Yhat_test(:,2), 2, class_colors);
    title 'X1 is a N(0,1) and X2 = 0.5*X1^2 + 0.4*X1 + 3';
end