AT1   = 'always (0 20) (< speed 120)';
AT2   = 'always (0 10) (< RPM  4750)';
AT51  = 'always (0 30) (implies (and (!= gear 1) (next (== gear 1))) (next (always (0 2.5) (== gear 1))))';
AT52  = 'always (0 30) (implies (and (!= gear 2) (next (== gear 2))) (next (always (0 2.5) (== gear 2))))';
AT53  = 'always (0 30) (implies (and (!= gear 3) (next (== gear 3))) (next (always (0 2.5) (== gear 3))))';
AT54  = 'always (0 30) (implies (and (!= gear 4) (next (== gear 4))) (next (always (0 2.5) (== gear 4))))';
AT6a  = 'implies (always (0 30) (< RPM 3000)) (always (0  4) (< speed 35))';
AT6b  = 'implies (always (0 30) (< RPM 3000)) (always (0  8) (< speed 50))';
AT6c  = 'implies (always (0 30) (< RPM 3000)) (always (0 20) (< speed 65))';