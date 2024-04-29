USE work.dp32_types.all,work.alu_32_types.all;
LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity memory is
    generic (Tpd    :Time:= unit_delay);
    port (    d_bus    :inout bus_bit_32 bus;
            a_bus    :in  bit_32;
            read    :in  std_logic;
            write    :in  std_logic;
            ready    :out std_logic);
end  memory;
ARCHITECTURE behaviour OF memory IS
begin
    process
        constant  low_address :integer :=0;
        constant high_address :integer :=65535;
        type memory_array is
            array(integer range low_address to high_address)of bit_32;
        variable address : integer:=0;
        variable mem :memory_array:=
            (
             0=>X"1000_0000", -- add quick      -- r0 <- r0 + 0
             1=>X"1001_0008", -- add quick      -- r1 <- r0 + 8
             2=>X"1002_0100", -- add quick      -- r2 <- r1 + 0
             3=>X"1003_0000", -- add quick      -- r3 <- r0 + 0
             4=>X"3004_0064", -- load quick     -- r4 <- M[r0 + 100]
             5=>X"1101_0101", -- subtract quick -- r1 <- r1 - 1
             6=>X"1002_0100", -- add quick      -- r2 <- r1 + 0
             7=>X"1001_0100", -- add quick      -- r1 <- r1 + 0
             8=>X"4109_0000", -- branch indexed -- IF: ivnz == 1001 THEN: PC <- r0 + disp32
             9=>X"0000_0010", -- add            -- r0 <- r0 + r16
            10=>X"1005_0000", -- add quick      -- r5 <- r0 + 0
            11=>X"1005_0501", -- add quick      -- r5 <- r5 + 1
            12=>X"3006_0564", -- load quick     -- r6 <- M[r5 + 100]
            13=>X"3106_0563", -- store quick    -- M[r5 + 99] <- r6
            14=>X"0108_0501", -- subtract       -- r8 <- r5 - r1
            15=>X"500A_00FB", -- branch quick   -- IF: ivnz == 1010 THEN: PC <- PC + 251
            16=>X"1001_0100", -- add quick      -- r1 <- r1 + 0
            17=>X"410B_0000", -- branch indexed -- IF: ivnz == 1011 THEN: PC <- r0 + disp32
            18=>X"0000_002C", -- add            -- r0 <- r0 + r44
            19=>X"1002_0200", -- add quick      -- r2 <- r2 + 0
            20=>X"410B_0000", -- branch indexed -- IF: ivnz == 1011 THEN: PC <- r0 + disp32
            21=>X"0000_0029", -- add            -- r0 <- r0 + r41
            22=>X"3006_0064", -- load quick     -- r6 <- M[r0 + 100]
            23=>X"0108_0406", -- subtract       -- r8 <- r4 - r6
            24=>X"410B_0000", -- branch indexed -- IF: ivnz == 1011 THEN: PC <- r0 + disp32
            25=>X"0000_001E", -- add            -- r0 <- r0 + r30
            26=>X"1005_0400", -- add quick      -- r5 <- r4 + 0
            27=>X"1004_0600", -- add quick      -- r4 <- r6 + 0
            28=>X"4100_0000", -- branch indexed -- IF: ivnz == 0000 THEN: PC <- r0 + disp32
            29=>X"0000_001F", -- add            -- r0 <- r0 + r31
            30=>X"1005_0600", -- add quick      -- r5 <- r6 + 0
            31=>X"1007_0000", -- add quick      -- r7 <- r0 + 0
            32=>X"1007_0701", -- add quick      -- r7 <- r7 + 1
            33=>X"3006_0764", -- load quick     -- r6 <- M[r7 + 100]
            34=>X"3106_0763", -- store quick    -- M[r7 + 99] <- r6
            35=>X"1108_0101", -- subtract quick -- r8 <- r1 - 1
            36=>X"0108_0708", -- subtract       -- r8 <- r7 - r8
            37=>X"500A_00FA", -- branch quick   -- IF: ivnz == 1010 THEN: PC <- PC + 250
            38=>X"3105_0163", -- store quick    -- M[r1 + 99] <- r5
            39=>X"1102_0201", -- subtract quick -- r2 <- r2 - 1
            40=>X"5000_00EA", -- branch quick   -- IF: ivnz == 0000 THEN: PC <- PC + 234
            41=>X"3104_036E", -- store quick    -- M[r3 + 110] <- r4
            42=>X"1003_0301", -- add quick      -- r3 <- r3 + 1
            43=>X"5000_00D8", -- branch quick   -- IF: ivnz == 0000 THEN: PC <- PC + 216
            44=>X"3104_036E", -- store quick    -- M[r3 + 110] <- r4
            45=>X"1003_0301", -- add quick      -- r3 <- r3 + 1
            46=>X"0007_0300", -- add            -- r7 <- r3 + r0
            47=>X"0005_0000", -- add            -- r5 <- r0 + r0
            48=>X"1107_0701", -- subtract quick -- r7 <- r7 - 1
            49=>X"1005_0501", -- add quick      -- r5 <- r5 + 1
            50=>X"3006_076E", -- load quick     -- r6 <- M[r7 + 110]
            51=>X"3106_0563", -- store quick    -- M[r5 + 99] <- r6
            52=>X"0108_0503", -- subtract       -- r8 <- r5 - r3
            53=>X"500A_00FA", -- branch quick   -- IF: ivnz == 1010 THEN: PC <- PC + 250
            54=>X"0000_0000", -- add            -- r0 <- r0 + r0
           100=>X"0000_0004", -- add            -- r0 <- r0 + r4
           101=>X"0000_0007", -- add            -- r0 <- r0 + r7
           102=>X"0000_0002", -- add            -- r0 <- r0 + r2
           103=>X"0000_0009", -- add            -- r0 <- r0 + r9
           104=>X"0000_0003", -- add            -- r0 <- r0 + r3
           105=>X"0000_0000", -- add            -- r0 <- r0 + r0
           106=>X"0000_0011", -- add            -- r0 <- r0 + r11
           107=>X"0000_0006", -- add            -- r0 <- r0 + r6
           109=>X"0000_0000", -- add            -- r0 <- r0 + r0
           110=>X"0000_0000", -- add            -- r0 <- r0 + r0
           111=>X"0000_0000", -- add            -- r0 <- r0 + r0
           112=>X"0000_0000", -- add            -- r0 <- r0 + r0
           113=>X"0000_0000", -- add            -- r0 <- r0 + r0
           114=>X"0000_0000", -- add            -- r0 <- r0 + r0
           115=>X"0000_0000", -- add            -- r0 <- r0 + r0
           116=>X"0000_0000", -- add            -- r0 <- r0 + r0
           117=>X"0000_0000", -- add            -- r0 <- r0 + r0
           118=>X"0000_0000", -- add            -- r0 <- r0 + r0
       others =>X"0000_0000"  -- add            -- r0 <- r0 + r0
         );
    begin
        --
        -- put d_bus and reply into initial state
        --
        d_bus <=null after Tpd;
        ready <='0' after Tpd;
        --
        -- wait for a command
        --
        wait until (read='1')or(write='1');
        --
        -- dispatch read or write cycle
        --
        address := bits_to_int(a_bus);
        if address >=low_address and address <=high_address then
            -- address match for this memory
            if write ='1' then
                ready<='1' after Tpd;
                wait until write='0'; -- wait until end of write cycle
                mem(address):=d_bus;--'delayed(Tpd); -- sample data from Tpd ago
            else  -- read='1'
                d_bus <= mem(address) after Tpd;    -- fetch data
                ready <='1' after Tpd;
                wait until read='0'; -- hold for read cycle
            end if;
        end if;
    end process;
end behaviour;


