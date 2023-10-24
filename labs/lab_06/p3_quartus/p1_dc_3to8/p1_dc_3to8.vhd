LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY p1_dc_3to8 IS
    PORT (
        a : IN std_logic_vector (2 DOWNTO 0);
        enabled : IN std_logic;
        q : OUT std_logic_vector (7 DOWNTO 0)
    );
END p1_dc_3to8;

ARCHITECTURE p1_dc_3to8_behaviour OF p1_dc_3to8 IS
BEGIN
    PROCESS (a, enabled) BEGIN
        IF enabled = '0' THEN
            q <= "00000000";
        ELSE
            CASE a IS
                WHEN "000" => q <= "00000001";
                WHEN "001" => q <= "00000010";
                WHEN "010" => q <= "00000100";
                WHEN "011" => q <= "00001000";
                WHEN "100" => q <= "00010000";
                WHEN "101" => q <= "00100000";
                WHEN "110" => q <= "01000000";
                WHEN "111" => q <= "10000000";
                WHEN OTHERS => q <= "00000000";
            END CASE;
        END IF;
    END PROCESS;
END p1_dc_3to8_behaviour;
