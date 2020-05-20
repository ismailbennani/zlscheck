function r = validate_cars(phi,rin,u)
    javaaddpath('../../../falstar/scala-library.jar');
    javaaddpath('../../../falstar/falstar.jar');
    
    in = {'throttle'; 'brake'};
    out = {'y1', 'y2', 'y3', 'y4', 'y5'};

    T = u(end, 1);
    
    [tout, yout] = run_cars(u, T);
    
    y = [tout yout];
    r = falstar.Main.robustness(in, out, u, y, phi);

    disp(['accuracy: ' num2str(abs(rin - r))]);
    assert((r <  0) == (rin <  0));
    assert((r <= 0) == (rin <= 0));
end
