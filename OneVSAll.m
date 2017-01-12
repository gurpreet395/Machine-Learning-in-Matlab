%pull all images of n mark them +ve rest -ve
classifier_weights =[]; %containers.Map('KeyType','double','ValueType','any');
classifier_bias = [];%containers.Map('KeyType','double','ValueType','any');

%images_onevsall_pos=[];
%labels_onevsall_pos=[];
%images_onevsall_neg=[];
%labels_onevsall_neg=[];
%training_onevsall=[];
%training_onevsall_labels=[];

for i=0:9
    images_onevsall_pos=[];
    labels_onevsall_pos=[];
    images_onevsall_neg=[];
    labels_onevsall_neg=[];
    training_onevsall=[];
    training_onevsall_labels=[];
    point_count=0;
    disp('starting extraction for')
    i
    for index=1:size(images_train,1)
        if labels_train(index)==i
        %index
            images_onevsall_pos = [images_onevsall_pos;images_train(index, :)];
        
            labels_onevsall_pos = [labels_onevsall_pos;1];
           % disp('new point found')
            point_count=point_count+1;
        end
        if labels_train(index)~=2
        
            images_onevsall_neg = [images_onevsall_neg;images_train(index, :)];
        
            labels_onevsall_neg = [labels_onevsall_neg;-1];
        end
        if point_count==500
            break;
        end
    
    end
    disp('starting shuffling')
    for inds=1:size(images_onevsall_pos,1)
       % if inds<2*size(images_onevsall_pos,1)-2
            training_onevsall=[training_onevsall;images_onevsall_pos(inds, :)];
            training_onevsall_labels=[training_onevsall_labels;labels_onevsall_pos(inds, :)];
            training_onevsall=[training_onevsall;images_onevsall_neg(inds,:)];
            training_onevsall_labels=[training_onevsall_labels;labels_onevsall_neg(inds, :)];
        %    continue;
       % else
        %training_onevsall=[training_onevsall;images_onevsall_neg(inds,:)];
       % training_onevsall_labels=[training_onevsall_labels;labels_onevsall_neg(inds, :)];
        %end
   
    end
    %weight=0;
    %bias=0;
    disp('starting training ')
    
    datapoints_count=size(training_onevsall,1);
    [weight,bias]=SVM(training_onevsall,datapoints_count,training_onevsall_labels,2,.1,.01);
    classifier_weights=[classifier_weights;weight];
    classifier_bias=[classifier_bias;bias];
    disp('training complete')
end