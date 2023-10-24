LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

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
                WHEN "000001" => qs <= (others => '0');
                WHEN "111110" => qs(63) <= '1';
                WHEN OTHERS   => qs <= (others => '1');
            END CASE;
        END IF;
    END PROCESS;

    q <= qs;
END p2_dc_6to64_behaviour;
