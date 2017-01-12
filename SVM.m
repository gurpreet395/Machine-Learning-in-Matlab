%function [model,bias]=SVM(training_data,iterations,training_labels,epoch,C,ita)
function [accuracy2]=SVM(training_data,iterations,training_labels,epoch,C,ita,testsvm,testsvmlabels)
    [m,n]=size(training_data);
    train_data=training_data;
    accuracy2=[];
   
    w=zeros(1,n);
    
    b=0;
   % accuracy=[];
    
    for j=1:epoch
        grad=zeros(1,n);
        b_grad=0;
        
        for i=1:iterations
            ita=1/iterations;
            
            result=dot(w,train_data(i,:))+b;
            if result*training_labels(i)<=1
                 
                grad=grad+training_labels(i,:)*train_data(i,:);
                b_grad=b_grad+training_labels(i);
                w=w+ita*(C*grad-w);
                b=b+ita*b_grad;
                
                %accuracy1=accuracy2;
            end
            accuracy2=[accuracy2;calculateaccuracy(w,b,testsvm,testsvmlabels)];
        end
        %grad=C*grad-w;
      %  w=w-ita*grad-w;
        %b=b+ita*b_grad;
       % b=b+ita*b_grad;
    end
    model=w;
    bias=b;
   % accuracy=calculateaccuracy(w,b,testsvm,testsvmlabels);
end