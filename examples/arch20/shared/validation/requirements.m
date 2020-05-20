AT1   = 'always (0 20) (< speed 120)';
AT2   = 'always (0 10) (< RPM  4750)';
AT51  = 'always (0 30) (implies (and (!= gear 1) (next (== gear 1))) (next (always (0 2.5) (== gear 1))))';
AT52  = 'always (0 30) (implies (and (!= gear 2) (next (== gear 2))) (next (always (0 2.5) (== gear 2))))';
AT53  = 'always (0 30) (implies (and (!= gear 3) (next (== gear 3))) (next (always (0 2.5) (== gear 3))))';
AT54  = 'always (0 30) (implies (and (!= gear 4) (next (== gear 4))) (next (always (0 2.5) (== gear 4))))';
AT6a  = 'implies (always (0 30) (< RPM 3000)) (always (0  4) (< speed 35))';
AT6b  = 'implies (always (0 30) (< RPM 3000)) (always (0  8) (< speed 50))';
AT6c  = 'implies (always (0 30) (< RPM 3000)) (always (0 20) (< speed 65))';

AFC27 = 'always (11 50) (implies (or rise fall) (always (1 5) (< (abs mu) 0.008)))';
AFC29 = 'always (11 50) (< (abs mu) 0.007)';
AFC33 = 'always (11 50) (< (abs mu) 0.007)';

NN    = 'always (1 18) (implies (not (<= (abs (- Pos Ref)) (+ 0.005 (* 0.03 (abs Ref))))) (eventually (0 2) (always (0 1) (<= (abs (- Pos Ref)) (+ 0.005 (* 0.03 (abs Ref)))))))';

CC1   = 'always (0 100) (<= (- y5 y4) 40)';
CC2   = 'always (0 70) (eventually (0 30) (>= (- y5 y4) 15))'; 
CC3   = 'always (0 80) (or (always (0 20) (<= (- y2 y1) 20)) (eventually (0 20) (<= (- y5 y4) 40)))';
CC4   = 'always (0 65) (eventually (0 30) (always (0 5) (>= (- y5 y4) 8)))';
CC5   = 'always (0 72) (eventually (0 8) (implies (always (0 5)  (>= (- y2 y1) 9)) (always (5 20) (>= (- y5 y4) 9))))';

F16   = 'always (0 15) (> altitude 0)';

SC    = 'always (30 35) (in pressure 87.0 87.5)';
