LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY l08p02b_mux_4to1 IS
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
END l08p02b_mux_4to1;

ARCHITECTURE l08p02b_mux_4to1_behaviour OF l08p02b_mux_4to1 IS
    signal output_s : std_logic;
BEGIN
    PROCESS (x0, x1, x2, x3) BEGIN
        IF enable = '0' THEN
            output_s <= '0';
        ELSE
            IF a1 = '0' AND a0 = '0' THEN
                output_s <= x0;
            ELSIF a1 = '0' AND a0 = '1' THEN
                output_s <= x1;
            ELSIF a1 = '1' AND a0 = '0' THEN
                output_s <= x2;
            ELSIF a1 = '1' AND a0 = '1' THEN
                output_s <= x3;
            END IF;
        END IF;
    END PROCESS;

    output <= output_s;
END l08p02b_mux_4to1_behaviour;
