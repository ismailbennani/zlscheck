AFC27 = 'always (11 50) (implies (or (and (< throttle 8.8) (eventually (0 0.05) (> throttle 40))) (and (> throttle 40) (eventually (0 0.05) (< throttle 8.8)))) (always (1 5) (< (abs mu) 0.008)))';
AFC29 = 'always (11 50) (< (abs mu) 0.007)';
AFC33 = 'always (11 50) (< (abs mu) 0.007)';
