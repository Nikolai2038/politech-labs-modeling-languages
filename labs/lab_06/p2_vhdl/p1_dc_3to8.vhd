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
    signal qs : std_logic_vector (7 downto 0);
BEGIN
    PROCESS (a, enabled) BEGIN
        IF enabled = '0' THEN
            qs <= "11111111";
        ELSE
            qs <= (others => '1');
            CASE a IS
                WHEN "000" => qs(0) <= '0';
                WHEN "001" => qs(1) <= '0';
                WHEN "010" => qs(2) <= '0';
                WHEN "011" => qs(3) <= '0';
                WHEN "100" => qs(4) <= '0';
                WHEN "101" => qs(5) <= '0';
                WHEN "110" => qs(6) <= '0';
                WHEN "111" => qs(7) <= '0';
                WHEN OTHERS => qs <= (others => '1');
            END CASE;
        END IF;
    END PROCESS;

    q <= qs;
END p1_dc_3to8_behaviour;
