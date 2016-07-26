function make_train_matfile_fun(image_mat,numlabels,tree_label_init)
%====================================================================
%生成 AdaBoost 算法训练图片信息 .mat 文件的函数（ling）
%make_train_matfile_fun(image_mat,numlabels,tree_label_init)
%====================================================================
%输入参数：
%   [1] image_mat 将训练图片分割出来的超像素块转换成行向量并存储在一起之后的矩阵（每行一个超像素块） 由
%   save_superpixel_fun 函数生成
%   [2] numlabels 超像素数量 由 save_superpixel_fun 函数生成
%   [3] tree_label_init 为超像素块中树所在超像素块的命名编号 即训练数据的原始标签
%====================================================================
%   函数运行完之后 将训练图片的数据写入到 SLIC_train.mat 文件中

%% [5] 存储 .mat 文件
%用于训练的图像数据
train_image=image_mat(1:numlabels,:);

%树的标签
tree_label_temp=tree_label_init;
tree_label_temp=tree_label_temp+1;%因为超像素块的标签从 0 开始，所以，实际标签要加 1

tree_label=ones(numlabels,1);
for k=1:length(tree_label_temp)
    tree_label(tree_label_temp(k))=0;%SVM算法标注为0和1
end

train_label=tree_label;
% table_label=table_label_Chip(1:numlabels);

% %用于测试的数据
% new_image=image_mat(1:numlabels,:);
% new_label=tree_label(1:numlabels);

save('SLIC_train.mat', 'train_image', 'train_label');
