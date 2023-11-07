function ind = detect(x, h, plt)
y = my_corr(x,h);
[M,ind] = max(y);

if plt == true
    h(101) = 0;
    figure,plot(x);
    hold on;
    plot(h);
    hold on;
    plot(y);
    legend('x','h','corr');
end
end

