function y = my_corr(x,h) 
N = length(x);
K = length(h);

y = zeros(N-K+1,1);

for n = 1:N-K+1
    % x(n:n+K-1) -> vector coloana [x(n)... x(n+K-1)]
    % e aceeasi chestie cu k = 0:K-1 si x(n+k)
    % h' -> h transpus ca sa faci inmultire de vectori (linie * coloana)
    y(n) = sum(h'*x(n:n+K-1))/(sqrt(sum(h.^2))*sqrt(sum(x(n:n+K-1).^2)));

    % pe astea le-am pus 0 ca sa arate ca in figura aia
    if isnan(y(n))
        y(n) = 0;
    end
end

end

