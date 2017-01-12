function [accuracy,model]=perceptron(training_data,iterations,training_labels,epoch,testdata,testlabels)
    [m,n]=size(training_data);
    b=ones(m,1);
    train_data=[];
    train_data=training_data;%horzcat(b,training_data);
   
    w=zeros(n,1);
    b=0;
    accuracy=[];
    for j=1:epoch
        for i=1:iterations
            result=dot(w,train_data(i,:))+b;
            if result*training_labels(i)<=0
                training_labels(i,:);
                update=(training_labels(i)*train_data(i,:));
                w=w+transpose(update);
                b=b+training_labels(i,:);
                
            end
            accuracy=[accuracy;calculateaccuracy(w,testdata,testlabels)];
        end
    end
    model=w;
end