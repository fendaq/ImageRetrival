basedir = '../../../data/cvcut/';
dataset_path = strcat(basedir, 'dataset/');
queryset_path = strcat(basedir, 'queryset/');
compiler_matcont_path = '..\..\..\third_part_lib\matconvnet-1.0-beta20\matconvnet-1.0-beta20\matlab\vl_compilenn';
setup_matcont_path = '..\..\..\third_part_lib\matconvnet-1.0-beta20\matconvnet-1.0-beta20\matlab\vl_setupnn';

% setup MatConvNet (设置这个库的路径等环境, 所有的matlab库都需要，而且每次打开matlab都需要） 
if strcmp(which('vl_simplenn'),'')
    % install and compile MatConvMat of cpp (need once)
    run(compiler_matcont_path);
    run(setup_matcont_path);
end
fprintf(1, 'load cnn libarray matconvnet over.\n');

if ~exist('../cnn_mat/imagenet-vgg-f.mat','file')
    % download a pre-trained CNN from the web (need once)
    frpintf(1, 'downlaod cnn net from internet in http://www.vlfeat.org/matconvnet/models/imagenet-vgg-f.mat.\n');
    urlwrite(...
        'http://www.vlfeat.org/matconvnet/models/imagenet-vgg-f.mat', ...
        '../cnn_mat/imagenet-vgg-f.mat') ;
end

fprintf(1, 'load cnn over\n');

% net = load('cnn_mat/imagenet-vgg-f.mat');
% net = vl_simplenn_tidy(net);

if ~exist('../dataMat/dataset.mat', 'file');
    dataset=load_vgg_feature(dataset_path, net);
    frpintf(1, 'extract feature using cnn over\n');
end

res=query_all(queryset_path, [], []);
rightRate=sum(res.right == res.query) / length(res.right)