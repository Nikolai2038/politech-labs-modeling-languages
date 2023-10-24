LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

-- Äëÿ conv_integer
USE IEEE.std_logic_arith.ALL;

ENTITY p2_dc_6to64 IS
    PORT (
        a : IN std_logic_vector (5 DOWNTO 0);
        enabled : IN std_logic;
        q : OUT std_logic_vector (63 DOWNTO 0)
    );
END p2_dc_6to64;

ARCHITECTURE p2_dc_6to64_behaviour OF p2_dc_6to64 IS
    signal qs : std_logic_vector (63 downto 0);
    signal iii : std_logic_vector (5 downto 0);
BEGIN
    PROCESS (a, enabled)
        VARIABLE a_as_number : INTEGER;
        variable result: std_logic_vector(5 downto 0);
    BEGIN
        IF enabled = '0' THEN
            qs <= (others => '0');
        ELSE
            qs <= (others => '0');

            -- a_as_number <= conv_integer(unsigned(a));

            -- CASE a IS
            --     WHEN "000001" => qs(0) <= '1';
            --     WHEN "000010" => qs(1) <= '1';
            --     WHEN "000011" => qs(2) <= '1';
            --     WHEN "000100" => qs(3) <= '1';
            --     WHEN "000101" => qs(4) <= '1';
            --     WHEN "000110" => qs(5) <= '1';
            --     WHEN "000111" => qs(6) <= '1';
            --     -- ...
            --     WHEN "111100" => qs(60) <= '1';
            --     WHEN "111101" => qs(61) <= '1';
            --     WHEN "111110" => qs(62) <= '1';
            --     WHEN "111111" => qs(63) <= '1';
            --     WHEN OTHERS   => qs <= (others => '1');
            -- END CASE;

            -- qs(conv_integer(a) - 1) <= '1';

            -- a_as_number := 60;
            -- CASE a IS
            -- --     WHEN "000001" => qs(a_as_number) <= '1';
            -- --     WHEN "000010" => qs(a_as_number) <= '1';
            -- --     WHEN "000011" => qs(a_as_number) <= '1';
            -- --     -- ...
            -- --     WHEN "111101" => qs(a_as_number) <= '1';
            -- --     WHEN "111110" => qs(a_as_number) <= '1';
            -- --     WHEN "111111" => qs(a_as_number) <= '1';
            --     WHEN OTHERS   => qs <= (others => '1');
            -- END CASE;


            -- a_as_number := 0;

            -- FOR i IN 0 TO 63 LOOP
            -- iii <= std_logic_vector(to_unsigned(i, 6));
            --     CASE a IS
            --         WHEN iii => qs(i) <= '1';
            --         WHEN OTHERS => qs <= (others => '1');
            --     END CASE;
            -- END LOOP;

            FOR i IN 0 TO 63 LOOP
                for g in 0 to 5 loop
                    result(g) := std_logic((i shr g) mod 2);
                end loop;

                CASE a IS
                    WHEN result => qs(i) <= '1';
                    WHEN OTHERS => qs <= (others => '1');
                END CASE;
            END LOOP;


        END IF;
    END PROCESS;

    q <= qs;
END p2_dc_6to64_behaviour;
