function make_test_matfile_fun(image_mat,numlabels,tree_label_init)
%====================================================================
%生成 AdaBoost 算法测试图片信息 .mat 文件的函数（ling）
%make_test_matfile_fun(image_mat,numlabels,tree_label_init)
%====================================================================
%输入参数：
%   [1] image_mat 将测试图片分割出来的超像素块转换成行向量并存储在一起之后的矩阵（每行一个超像素块） 由
%   save_superpixel_fun 函数生成
%   [2] numlabels 超像素数量 由 save_superpixel_fun 函数生成
%   [3] tree_label_init 为超像素块中树所在超像素块的命名编号 即测试数据的原始标签 测试数据可以没有标签
%====================================================================
%   函数运行完之后 将测试图片的数据写入到 SLIC_test.mat 文件中

%% 函数默认值设定部分
if nargin==2
    tree_label_init=ones(numlabels,1);
end

%% [5] 存储 .mat 文件
%用于训练的数据
test_image=image_mat(1:numlabels,:);

%树的标签
tree_label_temp=tree_label_init;
tree_label_temp=tree_label_temp+1;
tree_label=ones(numlabels,1);
for k=1:length(tree_label_temp)
    tree_label(tree_label_temp(k))=0;%SVM算法标注为0和1
end

test_label=tree_label;

% %用于测试的数据
% new_image=image_mat(1:numlabels,:);
% new_label=tree_label(1:numlabels);

save('SLIC_test.mat', 'test_image', 'test_label');
