LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY p1_mux4_1_b IS
    PORT (
        x0 : IN std_logic;
        x1 : IN std_logic;
        x2 : IN std_logic;
        x3: IN std_logic;
        a0 : IN std_logic;
        a1: IN std_logic;
        enable : IN std_logic;
        output : OUT std_logic
    );
END p1_mux4_1_b;

ARCHITECTURE p1_mux4_1_b_behaviour OF p1_mux4_1_b IS
    signal output_s : std_logic;
BEGIN
    PROCESS (x0, x1, x2, x3) BEGIN
        IF enable = '0' THEN
            output_s <= '0';
        ELSE
            IF a0 = '0' AND a1 = '0' THEN
                output_s <= x0;
            ELSIF a0 = '0' AND a1 = '1' THEN
                output_s <= x1;
            ELSIF a0 = '1' AND a1 = '0' THEN
                output_s <= x2;
            ELSIF a0 = '1' AND a1 = '1' THEN
                output_s <= x3;
            END IF;
        END IF;
    END PROCESS;

    output <= output_s;
END p1_mux4_1_b_behaviour;
