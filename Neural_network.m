
input = reduced';               
ouputActual = training_labels';                     %#

net = newff(input, ouputActual,[5 5  5 5 5 5 ]);         
net.divideFcn = '';                          

net = init(net);                             
 [net,tr] = train(net, input, ouputActual);   %# train

 
 %%calculate accuracy of model
 inds = randi([10 10000],1,1000);
 inds

 count=0;
 for j=1:15
     net1=network(i,:);
for i=1:1000

    outputPredicted = round(sim(net1,reducedtest(inds(i),:)'));
    if(outputPredicted==labels_test(inds(i),:))
        count=count+1;
        %disp('doing count');
    end
    
end

accuracy=count/1000
 end

%test_labels(9743,:)
%# predict

%[err,cm] = confusionmat(labels_test,outputPredicted);
%err
%}

