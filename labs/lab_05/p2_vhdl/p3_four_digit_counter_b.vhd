LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
-- Äëÿ std_logic_vector
use ieee.std_logic_unsigned.all;

ENTITY p3_four_digit_counter_b IS
    PORT (
        jk : IN std_logic;
        c : IN std_logic;
        r : IN std_logic;
        q0 : OUT std_logic;
        q1 : OUT std_logic;
        q2 : OUT std_logic;
        q3 : OUT std_logic
    );
END p3_four_digit_counter_b;

ARCHITECTURE p3_four_digit_counter_b_behaviour OF p3_four_digit_counter_b IS
    signal qs: std_logic_vector(3 downto 0);
BEGIN
    PROCESS (r, c) BEGIN
        IF r = '1' THEN
            qs <= "0000";
        ELSIF c = '1' AND c'event THEN
            IF jk = '1' THEN
                qs <= qs + 1;
            ELSE
                qs <= qs;
            END IF;
        END IF;
    END PROCESS;

    q0 <= qs(0);
    q1 <= qs(1);
    q2 <= qs(2);
    q3 <= qs(3);
END p3_four_digit_counter_b_behaviour;