LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY p1_mux4_1_b IS
    PORT (
        x : IN std_logic_vector (3 DOWNTO 0);
        a : IN std_logic_vector (1 DOWNTO 0);
        enable : IN std_logic;
        output : OUT std_logic
    );
END p1_mux4_1_b;

ARCHITECTURE p1_mux4_1_b_behaviour OF p1_mux4_1_b IS
    signal output_s : std_logic;
BEGIN
    PROCESS (x) BEGIN
        IF enable = '0' THEN
            output_s <= '0';
        ELSE
            CASE a IS
                WHEN "00" => output_s <= x(0);
                WHEN "01" => output_s <= x(1);
                WHEN "10" => output_s <= x(2);
                WHEN "11" => output_s <= x(3);
                WHEN OTHERS => output_s <= output_s;
            END CASE;
        END IF;
    END PROCESS;

    output <= output_s;
END p1_mux4_1_b_behaviour;
