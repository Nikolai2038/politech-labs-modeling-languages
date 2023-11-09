LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY l08p07b_dmx2to4 IS
    PORT (
        x : IN std_logic_vector (1 DOWNTO 0);
        e : IN std_logic;
        f : OUT std_logic_vector (3 DOWNTO 0)
    );
END l08p07b_dmx2to4;

ARCHITECTURE l08p07b_dmx2to4_behaviour OF l08p07b_dmx2to4 IS
    signal fs : std_logic_vector (3 DOWNTO 0);
BEGIN
    PROCESS (x) BEGIN
        IF e = '0' THEN
            fs <= (others => '0');
        ELSE
            fs <= (others => '0');
            CASE x IS
                WHEN "00" => fs(0) <= '1';
                WHEN "01" => fs(1) <= '1';
                WHEN "10" => fs(2) <= '1';
                WHEN "11" => fs(3) <= '1';
                WHEN OTHERS => fs <= fs;
            END CASE;
        END IF;
    END PROCESS;

    f <= fs;
END l08p07b_dmx2to4_behaviour;
