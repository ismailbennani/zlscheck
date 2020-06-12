CC1   = 'always (0 100) (<= (- y5 y4) 40)';
CC2   = 'always (0 70) (eventually (0 30) (>= (- y5 y4) 15))'; 
CC3   = 'always (0 80) (or (always (0 20) (<= (- y2 y1) 20)) (eventually (0 20) (<= (- y5 y4) 40)))';
CC4   = 'always (0 65) (eventually (0 30) (always (0 5) (>= (- y5 y4) 8)))';
CC5   = 'always (0 72) (eventually (0 8) (implies (always (0 5)  (>= (- y2 y1) 9)) (always (5 20) (>= (- y5 y4) 9))))';