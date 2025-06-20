LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

ENTITY l05p06b_t_trgr IS
    PORT (
        t : IN std_logic;
        reset : IN std_logic;
        q : OUT std_logic
    );
END l05p06b_t_trgr;

ARCHITECTURE l05p06b_t_trgr_behaviour OF l05p06b_t_trgr IS
    SIGNAL qs:std_logic;
BEGIN
    PROCESS (reset, t) BEGIN
        IF reset = '1' THEN
            qs <= '0';
        ELSE
            IF t = '1' AND t'event THEN
                qs <= NOT qs;
            ELSE
                qs <= qs;
            END IF;
        END IF;
    END PROCESS;

    q <= qs;
END l05p06b_t_trgr_behaviour;
