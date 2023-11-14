LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY l07p03b_hpri8to3 IS
    PORT (
        q : IN std_logic_vector (7 DOWNTO 0);
        ei : IN std_logic;
        g : OUT std_logic;
        eo : OUT std_logic;
        a : OUT std_logic_vector (2 DOWNTO 0)
    );
END l07p03b_hpri8to3;

ARCHITECTURE l07p03b_hpri8to3_behaviour OF l07p03b_hpri8to3 IS
    signal as : std_logic_vector (2 downto 0);
    signal gs : std_logic;
    signal eos : std_logic;
BEGIN
    PROCESS (q, ei) BEGIN
        IF ei = '0' THEN
            as <= "000";
            gs <= '0';
            eos <= '0';
        ELSE
            IF q = "0000000" THEN
                gs <= '0';
            ELSE
                gs <= '1';
            END IF;

            eos <= NOT gs;

            IF q(7) = '1' THEN
                as <= "111";
            ELSIF q(6) = '1' THEN
                as <= "110";
            ELSIF q(5) = '1' THEN
                as <= "101";
            ELSIF q(4) = '1' THEN
                as <= "100";
            ELSIF q(3) = '1' THEN
                as <= "011";
            ELSIF q(2) = '1' THEN
                as <= "010";
            ELSIF q(1) = '1' THEN
                as <= "001";
            ELSE
                as <= "000";
            END IF;
        END IF;
    END PROCESS;

    a <= as;
    g <= gs;
    eo <= eos;
END l07p03b_hpri8to3_behaviour;
