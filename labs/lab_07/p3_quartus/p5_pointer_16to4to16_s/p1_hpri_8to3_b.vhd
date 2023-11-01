LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY p1_hpri_8to3_b IS
    PORT (
        q : IN std_logic_vector (7 DOWNTO 0);
        ei : IN std_logic;
        g : OUT std_logic;
        eo : OUT std_logic;
        a : OUT std_logic_vector (2 DOWNTO 0)
    );
END p1_hpri_8to3_b;

ARCHITECTURE p1_hpri_8to3_b_behaviour OF p1_hpri_8to3_b IS
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
END p1_hpri_8to3_b_behaviour;
