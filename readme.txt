1. functia my_corr(x,h): se implementeaza formula normalizata prin care este definita corelatia in cazul general, intre doua semnalele x si h de dimensiuni diferite (N > K)
	- se presupune ca x este semnalul mare si h semnalul mic
	- y se construieste treptat, calculand y(n), unde n =1:N-K+1, prin utilizarea formulei prezentate in laborator
	- pentru numarator se va face inmultirea dintre vectorul transpus h si vectorul x cu valori care apartin intervalului [n:n+K-1], urmand sa se adune valorile rezultatului (sum(h'*x(n:n+K-1))), acesta este definitia operatiei de corelatie
	- numitorul normalizeaza valoarea corelatiei si este reprezentat de inmultirea dintre: radical din semnalul h ridicat la patrat si radical portiunea semnalului x (prezentata anterior) ridicat la patrat  (sqrt(sum(h.^2))*sqrt(sum(x(n:n+K-1).^2)))
	- daca valorile lui y(n) nu sunt definite (de tip NaN) acestea vor fi 0

2. definire semnale x si h 
   functia detect(x,h,plt): returneaza indicele unde valoarea corelatiei este maxima, echivalent cu esantionul de timp unde se gaseste maximul pentru semnalul y
	- se calculeaza corelatia dintre x si h folosind functia my_corr() creata anterior
	- se gaseste maximul corelatiei aplicand functia max pentru y, returnand valorea maxima a vectorului y si indicele unde apare aceasta ([M,ind] = max(y))
	- daca plt = true => se afiseaza cele 3 semnale x, h, y (lui h i se va adauga valoarea h(101) = 0 pentru a arata ca in figura din laborator)

3. se calculeaza Transformata Fourier Discreta a filtrului (vector valori complexe), iar apoi se ploteaza modulul rezultatului pentru a afisa magnitudinea spectrului (se vor folosi doar jumatate din valorile spectrului, corespunzatoare frecventelor pozitive)  -> se repeta operatia pentru toate cele 12 filtre