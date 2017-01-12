
function [acc,acc_av] = kNN(images_train, labels_train, images_test, labels_test,K)
%inds = randperm(size(images_train, 1));
%images_train = images_train(inds, :);
%rand('seed', 1); %%just to make all random sequences on all computers the same.
%inds = randperm(size(images_train, 1));
%images_train = images_train(inds, :);
%labels_train = labels_train(inds, :);
%inds = randperm(size(images_test, 1));
%inds=randperm(1000);
%images_test = images_test(inds, :);
%labels_test = labels_test(inds, :);

%%% randomly permute data points
%class_labels=unique(labels_test);
[occurance,class_labels]=hist(labels_test,unique(labels_test));
initial_accuracy=zeros(size(class_labels));
accuracy_dict=containers.Map(class_labels,initial_accuracy);
original_occurances=containers.Map(class_labels,occurance);

training=size(images_train,1);

%training=1000;
test=size(images_test,1);
%test=100;
%nearest_point=size(test,1);
nearest_temp=size(images_train,1);
%nearest_temp=size(training,1);
k=K;
correct=0;
for test_index=1:test
   for index=1:training
     %temp1 =sum(abs((images_train(index,:)-images_test(test_index,:))));
     temp1=norm(images_train(index,:)-images_test(test_index,:));
     nearest_temp(index)=temp1;
   end
[sorted_distance,sorted_index]=sort(nearest_temp);
%nearest_points=sorted_distance(1:k);
nearest_index=sorted_index(1:k);
nearest_labels=size(nearest_index);
for i=1:size(nearest_index)
    nearest_labels(i)=labels_train(nearest_index(i));
end
predicted_label=mode(nearest_labels);
%predicted_label

if(labels_test(test_index)==predicted_label)
    accuracy_dict(labels_test(test_index))=accuracy_dict(labels_test(test_index))+1;
    correct=correct+1;
end
end
correct
accuracy=zeros(size(class_labels));
for i=1:size(class_labels)
   accuracy(i) = (accuracy_dict(class_labels(i)))/original_occurances(class_labels(i));
   %accuracy(i)=1-accuracy(i);
end
acc= accuracy*100;
avg_acc=sum(acc)/10;
acc_av=avg_acc;
%values(accuracy_dict)
%values(original_occurances)
end


