% Tema PS 2022
% Autor: Andrei Nicolicioiu
 
clear;
close all;
 
%% detectie: ex 1-2
% TODO: creati semnalele x si h precum este descris in ex. 2

h = ones(100,1);

x = zeros(600,1);
x(300:400) = 1;

indice = detect(x,h,true);

  
%% clasificare: ex 3-5
load('data.mat')
load('filters.mat')
plot_figs = true
 
 
% Pentru a calcula rezultatele mai rapid, putem folosi doar o fractiune din
% fiecare semnal audio. Rezulatele vor fi mai proaste, insa viteza va
% creste
alpha = 1 / 10.0;
b = floor(size(audio_train,1) / 2 - alpha * size(audio_train,1) / 2 + 1);
e = floor(size(audio_train,1) / 2 + alpha * size(audio_train,1) / 2);
audio_train_small = audio_train(b:e,:);
b = floor(size(audio_train,1) / 2 - alpha * size(audio_train,1) / 2 + 1);
e = floor(size(audio_train,1) / 2 + alpha * size(audio_train,1) / 2);
audio_test_small = audio_test(b:e,:);
 
% Dimensiunile datelor ar trebui sa fie:
% audio_train_small: [N, D1]
% audio_test_small: [N, D2]
% labels_train: [D1, 1]
% labels_test: [D2, 1]
 
% calculam vectorii de trasaturi pentru fiecare fisier din datasetul de train si de  test
% get_features primeste toate sunetele din set date intr-o matrice
% de dimensiune Dimensiune_dataset (D) x Numaresults_esantioane (N) si returneaza toate
% trasaturile (features) acestor sunete intr-o matrice de dimensiune Numaresults_sunete (N) x (2*M)
 
% TODO: calculati trasaturile folosind un set de M filtre incarcate
% anterior
% plot_figs == true afisati figurile cerute in tema
 
% filters: [F, M]
% feat_train: [D1, 2M]
% feat_test: [D2, 2M]


dtf = fft(filters(:,1));
coefs = zeros(length(dtf)/2,12);

for i = 1:12
    dtf = fft(filters(:,i));
    coefs(:,i) = abs(dtf(1:length(dtf)/2));
end

if plot_figs == true
    figure;
    for i = 1:12
        plot(coefs(:,i))
        hold on;
    end
end



%%
 
feat_train = get_features(audio_train_small, fs, filters, plot_figs);
feat_test = get_features(audio_test_small, fs, filters, plot_figs);
 
figure, plot(filters(:,1));
figure, plot(filters(:,2));
 
top_k = 5;
% top_k: scalar (default=5)
% similarity size: [D2, D1]
% prediction size: [D2, 1]
 
[sim_train, pred_train] = knn(labels_train, feat_train, feat_train, top_k);
[sim_test, pred_test] = knn(labels_train, feat_train, feat_test, top_k);
 
% calculam acuratetea pe train si test
acc_test  = mean(pred_test(:) == labels_test(:));
acc_train = mean(pred_train(:) == labels_train(:));
 
sprintf('Accuracy on train: %0.2f', acc_train)
sprintf('Accuracy on test: %0.2f', acc_test)
 
 
% % TODO: verificati calitativ cateva exemple din setul de test. 
% % comparati clasa corecta si clasa presiza cu sunetul auzit
% 
% % alegem random un fisier audio si verificam daca am clasificat corect
% labels_name = {'Dog';'Rooster'; 'Rain' ; 'Waves';'Fire';'Baby';...
%     'Sneezing';'Clock';'Helicopter';'Chainsow'};
% labels_name = string(labels_name);
% 
% r = round(rand() * 100);
% sound(audio_test(:,r),fs);
% sprintf('Clasa corecta: %s', labels_name(labels_test(r)))
% sprintf('Clasa prezisa: %s', labels_name(pred_test(r)))