function r = validate_transmission(phi,rin,u)
    javaaddpath('../../../falstar/scala-library.jar');
    javaaddpath('../../../falstar/falstar.jar');
    
    in = {'throttle', 'brake'};
    out = {'speed', 'RPM', 'gear'};

    T = u(end, 1);
    
    [tout, yout] = run_transmission(u, T);
    
    y = [tout yout];
    r = falstar.Main.robustness(in, out, u, y, phi);

    disp(['accuracy: ' num2str(abs(rin - r))]);
    assert((r <  0) == (rin <  0));
    assert((r <= 0) == (rin <= 0));
end
