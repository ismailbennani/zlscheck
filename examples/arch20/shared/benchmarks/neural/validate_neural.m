function r = validate_neural(phi,rin,u)
    javaaddpath('../../../falstar/scala-library.jar');
    javaaddpath('../../../falstar/falstar.jar');
    
    in = {'Ref'};
    out = {'Pos', 'NNPos'};

    T = u(end, 1);
    
    [tout, yout] = run_neural(u, T);
    
    y = [tout yout];
    r = falstar.Main.robustness(in, out, u, y, phi);

    disp(['accuracy: ' num2str(abs(rin - r))]);
    assert((r <  0) == (rin <  0));
    assert((r <= 0) == (rin <= 0));
end
