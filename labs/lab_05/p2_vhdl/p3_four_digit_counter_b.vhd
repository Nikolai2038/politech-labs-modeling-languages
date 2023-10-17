LIBRARY ieee;

USE ieee.std_logic_1164.ALL;

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
    signal count : integer range 0 to 15 := 0;
BEGIN
    PROCESS (r, c) BEGIN
        IF r = '1' THEN
            count <= 0;
        ELSIF c = '1' AND c'event THEN
            IF jk = '1' THEN
                count <= count + 1;
            ELSE
                count <= count;
            END IF;
        END IF;
    END PROCESS;

    q0 <= '1' when (count >= 1) else '0';
    q1 <= '1' when (count >= 2) else '0';
    q2 <= '1' when (count >= 4) else '0';
    q3 <= '1' when (count >= 8) else '0';
END p3_four_digit_counter_b_behaviour;
