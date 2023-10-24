LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;
use IEEE.std_logic_arith.ALL;

ENTITY p2_dc_6to64 IS
    PORT (
        a : IN std_logic_vector (5 DOWNTO 0);
        enabled : IN std_logic;
        q : OUT std_logic_vector (63 DOWNTO 0)
    );
END p2_dc_6to64;

ARCHITECTURE p2_dc_6to64_behaviour OF p2_dc_6to64 IS
    signal qs : std_logic_vector (63 downto 0);
BEGIN
    PROCESS (a, enabled) BEGIN
        IF enabled = '0' THEN
            qs <= (others => '0');
        ELSE
            qs <= (others => '0');
            CASE a IS
                WHEN "000001" => qs(0) <= '1';
                WHEN "000010" => qs(1) <= '1';
                WHEN "000011" => qs(2) <= '1';
                WHEN "000100" => qs(3) <= '1';
                WHEN "000101" => qs(4) <= '1';
                WHEN "000110" => qs(5) <= '1';
                WHEN "000111" => qs(6) <= '1';
                -- ...
                WHEN "111100" => qs(60) <= '1';
                WHEN "111101" => qs(61) <= '1';
                WHEN "111110" => qs(62) <= '1';
                WHEN "111111" => qs(63) <= '1';
                WHEN OTHERS   => qs <= (others => '1');
            END CASE;
        END IF;
    END PROCESS;

    q <= qs;
END p2_dc_6to64_behaviour;
