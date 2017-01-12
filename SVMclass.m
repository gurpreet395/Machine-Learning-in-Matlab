%clear
load MNIST_digit_data
rand('seed', 1);
size(labels_train);
inds = randperm(1000);
training_images=images_train(inds,:);
training_labels=labels_train(inds,:);
%bestParam = ['-q -c ', num2str(bestc), ' -g ', num2str(bestg)];
%model = ovrtrain(training_labels, training_images, '-c 8 -g 4');
%model = svmtrain(training_labels, training_images, '-c 1 -g 0.07 -b 1');
%[predict_label, accuracy, prob_values] = svmpredict(labels_test, images_test, model, '-b 1');
%{
train_images=training_images;
m=mean(training_images);
training_images=training_images-m;
[U,S,V] = svd(training_images);
%reduced=U(:,1:748);  %% pick up top 50 eigen vectors
%Z=reduced'*training_images;
test_images=images_test;
test_labels=labels_test;
mtest=mean(test_images);
test_images=test_images-mtest;
[Utest,Stest,Vtest] = svd(test_images);
%reducedtest=Utest(:,1:);
%Ztest=reducedtest'*test_images;
%}

train_data=training_images;
test_images=images_test;
mu=mean(training_images);
n=size(training_images,1);
training_images=training_images-ones(n,1)*mu;
training_images=training_images/sqrt(n-1);
mu_test=mean(test_images);
n_test=size(test_images,1);
test_images=test_images-ones(n_test,1)*mu_test;
test_images=test_images/sqrt(n_test-1);
[COEFF,SCORE,latent] = svd(training_images);


size(train_data)
size(latent(:,1:50))
%training_images=train_data*latent;
[COEFFtest,SCOREtest,latenttest] = svd(test_images);
size(images_test)
size(latenttest(:,1:50))
%test_images=images_test*latenttest;

test_matrix=[2,5,10,20,30,50,70,100,150,200,250, 300, 400, 500, 748];
accuracydict=[];
network=[]

for i=1:15
    reduced=COEFF(:,1:test_matrix(i));
    SCORE1=SCORE(1:test_matrix(i),1:test_matrix(i));
  % latent=latent(1:50,1:50)';
   % size(reduced)
    %size(SCORE)
    reduced=(reduced*SCORE1);
    reducedtest=COEFFtest(:,1:test_matrix(i));
    SCOREtest1=SCOREtest(1:test_matrix(i),1:test_matrix(i));
    reducedtest=(reducedtest*SCOREtest1);
    disp('starting training')


%model = svmtrain(training_labels, reduced, '-c 1 -g 0.07 -b 1');

%[predict_label, accuracy, prob_values] = svmpredict(test_labels, reducedtest, model, '-b 1');
%accuracydict=[accuracydict;accuracy];

accdict=[];
input = reduced';               %'# each column is an input vector
ouputActual = training_labels';                     %#

net = newff(input, ouputActual,[5 5  5 5 5 5 ]);          %# 1 hidden layer with 2 neurons
net.divideFcn = '';                          %# use the entire input for training

net = init(net);                             %# init
 [net,tr] = train(net, input, ouputActual);
 count=0;
 inds = randi([10 10000],1,1000);
 for l=1:1000

    outputPredicted = round(sim(net,reducedtest(inds(l),:)'));
    if(outputPredicted==labels_test(inds(l),:))
        count=count+1;
        %disp('doing count');
    end
    
end

accuracy=count/1000
accdict=[accdict;accuracy];
 end



%}
%Xapprox=reduced*Z;     %% reconstructing data again
%diff=Xapprox-train_images;


%%Code to calculate mean difference

meanarray=[];
for i=1:500
    reduced=U(:,1:i);
    Z=reduced'*training_images;
    Xapprox=reduced*Z;
    neum=0;
    denom=0;
    for j=1:1000
        neum=neum+((training_images(j,:)-Xapprox(j,:)).^2);
        denom=(denom+(((training_images(j,:)).^2)));
    end
    meandiff=neum/denom;
    meanarray=[meanarray;meandiff];
end

   % projection=

%}






