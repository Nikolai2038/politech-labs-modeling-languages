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
    PROCESS (a, enabled)
    BEGIN
        IF enabled = '0' THEN
            qs <= (others => '1');
        ELSE
            qs <= (others => '0');
            CASE a IS
                WHEN "000000" => qs(0) <= '1';
                WHEN "000001" => qs(1) <= '1';
                WHEN "000010" => qs(2) <= '1';
                WHEN "000011" => qs(3) <= '1';
                WHEN "000100" => qs(4) <= '1';
                WHEN "000101" => qs(5) <= '1';
                WHEN "000110" => qs(6) <= '1';
                WHEN "000111" => qs(7) <= '1';
                WHEN "001000" => qs(8) <= '1';
                WHEN "001001" => qs(9) <= '1';
                WHEN "001010" => qs(10) <= '1';
                WHEN "001011" => qs(11) <= '1';
                WHEN "001100" => qs(12) <= '1';
                WHEN "001101" => qs(13) <= '1';
                WHEN "001110" => qs(14) <= '1';
                WHEN "001111" => qs(15) <= '1';

                WHEN "010000" => qs(16) <= '1';
                WHEN "010001" => qs(17) <= '1';
                WHEN "010010" => qs(18) <= '1';
                WHEN "010011" => qs(19) <= '1';
                WHEN "010100" => qs(20) <= '1';
                WHEN "010101" => qs(21) <= '1';
                WHEN "010110" => qs(22) <= '1';
                WHEN "010111" => qs(23) <= '1';
                WHEN "011000" => qs(24) <= '1';
                WHEN "011001" => qs(25) <= '1';
                WHEN "011010" => qs(26) <= '1';
                WHEN "011011" => qs(27) <= '1';
                WHEN "011100" => qs(28) <= '1';
                WHEN "011101" => qs(29) <= '1';
                WHEN "011110" => qs(30) <= '1';
                WHEN "011111" => qs(31) <= '1';

                WHEN "100000" => qs(32) <= '1';
                WHEN "100001" => qs(33) <= '1';
                WHEN "100010" => qs(34) <= '1';
                WHEN "100011" => qs(35) <= '1';
                WHEN "100100" => qs(36) <= '1';
                WHEN "100101" => qs(37) <= '1';
                WHEN "100110" => qs(38) <= '1';
                WHEN "100111" => qs(39) <= '1';
                WHEN "101000" => qs(40) <= '1';
                WHEN "101001" => qs(41) <= '1';
                WHEN "101010" => qs(42) <= '1';
                WHEN "101011" => qs(43) <= '1';
                WHEN "101100" => qs(44) <= '1';
                WHEN "101101" => qs(45) <= '1';
                WHEN "101110" => qs(46) <= '1';
                WHEN "101111" => qs(47) <= '1';

                WHEN "110000" => qs(48) <= '1';
                WHEN "110001" => qs(49) <= '1';
                WHEN "110010" => qs(50) <= '1';
                WHEN "110011" => qs(51) <= '1';
                WHEN "110100" => qs(52) <= '1';
                WHEN "110101" => qs(53) <= '1';
                WHEN "110110" => qs(54) <= '1';
                WHEN "110111" => qs(55) <= '1';
                WHEN "111000" => qs(56) <= '1';
                WHEN "111001" => qs(57) <= '1';
                WHEN "111010" => qs(58) <= '1';
                WHEN "111011" => qs(59) <= '1';
                WHEN "111100" => qs(60) <= '1';
                WHEN "111101" => qs(61) <= '1';
                WHEN "111110" => qs(62) <= '1';
                WHEN "111111" => qs(63) <= '1';

                WHEN OTHERS   => qs <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- Присваиваем именно в конце, так как std_logic_vector не может хранить 64 единицы - выдаёт ошибку "Unsupported feature error: Unsigned bit string literal >= 32 is not supported."
    q <= NOT qs;
END p2_dc_6to64_behaviour;
