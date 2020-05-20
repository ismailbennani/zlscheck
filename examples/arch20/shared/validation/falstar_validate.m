function r = falstar_validate(in, out, U, Y, phi)
    javaaddpath('../../falstar/scala-library.jar');
    javaaddpath('../../falstar/falstar.jar');

    r = falstar.Main.robustness(in, out, U, Y, phi);
end
