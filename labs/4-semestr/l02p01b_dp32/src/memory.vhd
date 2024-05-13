-- Include library with logic operations
library ieee;

-- Include types
use ieee.std_logic_1164.all;
use work.alu_32_types.all;
use work.dp32_types.all;

entity memory is
    generic (
        Tpd : time := unit_delay
    );
    port (
        d_bus : inout bus_bit_32 bus;
        a_bus : in bit_32;
        read : in std_logic;
        write : in std_logic;
        ready : out std_logic
    );
end memory;

architecture behaviour of memory is
begin
    process
        constant low_address : integer := 0;
        constant high_address : integer := 65535;

        variable address : integer := 0;

        type memory_array is array(integer range low_address to high_address) of bit_32;
        variable mem : memory_array := (
            -- ========================================
            -- Registers' descriptions
            -- ========================================
            -- r0 = 0 (for PC add)
            -- r1 = "size"
            -- r2 = "id"
            -- r3 = "id_max"
            -- r4 = "id_inner" OR "id_inner" in flip array procedure
            -- r5 = value_1_for_comparison
            -- r6 = value_2_for_comparison
            -- r7 = comparison result
            -- r8 = _id in flip array procedure
            -- r9 = "return_to" - where to return after calling flip array procedure
            -- r10 = temp_1 - in flip array procedure
            -- r11 = temp_2 - in flip array procedure
            -- ========================================

            -- ========================================
            -- Algorithm
            -- ========================================
            --     reset 0
            --     size = array.size
            --     id = size - 1
            -- CYCLE_FROM_LAST_THROUGH_ALL:
            --         id_max = id
            --         id_inner = 0
            --     CYCLE_FIND_MAX_BEFORE:
            --         IF_1 (array[id_inner] > array[id_max]) THEN goto THEN_1
            --         goto ENDIF_1
            --         THEN_1:
            --             id_max = id_inner
            --         ENDIF_1:
            --             id_inner++
            --     IF_2 (id_inner < id) THEN goto CYCLE_FIND_MAX_BEFORE
            --     IF_3 (id_max == id) THEN goto ENDIF_3
            --         IF_4 (id_max == 0) THEN goto ENDIF_4
            --             r8 = id_max
            --             return_to = ENDIF_4
            --             goto FLIP_ARRAY
            --         ENDIF_4:
            --             r8 = id
            --             return_to = ENDIF_3
            --             goto FLIP_ARRAY
            --     ENDIF_3:
            --     id--
            -- IF_5 (id >= 0) THEN goto CYCLE_FROM_LAST_THROUGH_ALL
            -- goto PROGRAM_END
            --
            -- FLIP_ARRAY:
            --         id_inner = 0
            --     CYCLE_FLIP_ARRAY:
            --         temp_1 = array[_id]
            --         temp_2 = array[id_inner]
            --         array[id_inner] = temp_1
            --         array[_id] = temp_2
            --         id_inner++
            --         _id++
            --     IF_6 (id_inner < _id) THEN goto CYCLE_FLIP_ARRAY
            --     goto return_to
            --
            -- PROGRAM_END:
            -- ========================================

            -- ========================================
            -- Program
            -- ========================================
            --     reset 0
            0 => X"1000_0000", -- add quick            -- r0 <- r0 + 0 -- +45ns
            --     size = array.size
            1 => X"1001_0008", -- add quick            -- r1 <- r0 + 8 -- +45ns
            --     id = size - 1
            2 => X"1102_0101", -- subtract quick       -- r2 <- r1 - 1 -- +45ns
            -- CYCLE_FROM_LAST_THROUGH_ALL:
            --         id_max = id
            3 => X"1003_0100", -- add quick            -- r3 <- r2 + 0 -- +45ns
            --         id_inner = 0
            4 => X"1004_0400", -- add quick            -- r4 <- r4 + 0 -- +45ns
            --     CYCLE_FIND_MAX_BEFORE:
            --         IF_1 (array[id_inner] > array[id_max]) THEN goto THEN_1
            5 => X"3005_0464", -- load quick           -- r5 <- M[r4 + 100] -- +45ns*3
            6 => X"3006_0364", -- load quick           -- r6 <- M[r3 + 100] -- +45ns*3
            7 => X"0107_0506", -- subtract             -- r7 <- r5 - r6
            8 => X"5108_000B", -- branch indexed quick -- IF: ivnz == 1000 THEN: PC <- r0 + 11
            --         goto ENDIF_1
            9 => X"1000_0000", -- add quick            -- r0 <- r0 + 0 -- +45ns
            10 => X"5109_000C", -- branch indexed quick -- IF: ivnz == 1001 THEN: PC <- r0 + 12
            --         THEN_1:
            --             id_max = id_inner
            11 => X"1003_0400", -- add quick            -- r3 <- r4 + 0 -- +45ns
            --         ENDIF_1:
            --             id_inner++
            12 => X"1004_0401", -- add quick            -- r4 <- r4 + 1 -- +45ns
            --     IF_2 (id_inner < id) THEN goto CYCLE_FIND_MAX_BEFORE
            13 => X"0107_0402", -- subtract             -- r7 <- r4 - r2
            14 => X"510A_0005", -- branch indexed quick -- IF: ivnz == 1010 THEN: PC <- r0 + 5
            --     IF_3 (id_max == id) THEN goto ENDIF_3
            15 => X"0107_0302", -- subtract             -- r7 <- r3 - r2
            16 => X"5109_00ZZ", -- branch indexed quick -- IF: ivnz == 1001 THEN: PC <- r0 + ZZ
            --         IF_4 (id_max == 0) THEN goto ENDIF_4
            17 => X"1107_0300", -- subtract quick             -- r7 <- r3 - 0
            18 => X"5109_00YY", -- branch indexed quick -- IF: ivnz == 1000 THEN: PC <- r0 + YY
            --             r8 = id_max
            19 => X"1008_0300", -- add quick            -- r8 <- r3 + 0 -- +45ns
            --             return_to = ENDIF_4
            12 => X"1009_00YY", -- add quick            -- r9 <- r0 + YY -- +45ns
            --             goto FLIP_ARRAY
            --         ENDIF_4:
            --             r8 = id
            YY => X"1008_0200", -- add quick            -- r8 <- r2 + 0 -- +45ns
            --             return_to = ENDIF_3
            12 => X"1009_00ZZ", -- add quick            -- r9 <- r0 + ZZ -- +45ns
            --             goto FLIP_ARRAY
            --     ENDIF_3:
            --     id--
            ZZ => X"1102_0201", -- subtract quick            -- r2 <- r2 + 0 -- +45ns
            -- IF_5 (id >= 0) THEN goto CYCLE_FROM_LAST_THROUGH_ALL
            -- goto PROGRAM_END
            --
            -- FLIP_ARRAY:
            --         id_inner = 0
            4 => X"1004_0400", -- add quick            -- r4 <- r4 + 0 -- +45ns
            --     CYCLE_FLIP_ARRAY:
            --         temp_1 = array[_id]
            5 => X"300A_0864", -- load quick           -- r10 <- M[r8 + 100] -- +45ns*3
            --         temp_2 = array[id_inner]
            5 => X"300B_0464", -- load quick           -- r11 <- M[r4 + 100] -- +45ns*3
            --         array[id_inner] = temp_1
            5 => X"310A_0464", -- store quick           -- M[r4 + 100] <- r10 -- +45ns*3
            --         array[_id] = temp_2
            5 => X"310B_0864", -- load quick           -- M[r8 + 100] <- r11 -- +45ns*3
            --         id_inner++
            3 => X"1004_0401", -- add quick            -- r4 <- r4 + 1 -- +45ns
            --         _id++
            3 => X"1008_0801", -- add quick            -- r8 <- r8 + 1 -- +45ns
            --     IF_6 (id_inner < _id) THEN goto CYCLE_FLIP_ARRAY
            --     goto return_to
            --
            -- PROGRAM_END:
            -- ========================================

            -- LABEL_1:
            -- value_1_for_comparison = array[id_inner]
            -- (+ 45 ns * 3)

            -- (+ 45 ns * 3)

            -- IF (array[id_inner] > array[id_max])
            -- (+ 45 ns * 2)

            10 => X"1000_0000", -- add quick      -- r0 <- r0 + 0
            11 => X"4109_0000", -- branch indexed -- IF: ivnz == 1001 THEN: PC <- r0 + disp32
            12 => X"0000_000E", -- disp32         -- goto ELSE_1

            -- THEN_1:
            --     id_max = id_inner
            13 => X"1003_0400", -- add quick      -- r3 <- r4 + 0

            -- ELSE_1:
            --     id_inner = id_inner + 1
            14 => X"1004_0401", -- add quick      -- r4 <- r4 + 1
            -- (+ 45 ns)

            -- value_1_for_comparison = id_inner
            15 => X"1005_0400", -- add quick      -- r5 <- r4 + 0
            -- (+ 45 ns)

            -- value_2_for_comparison = id
            16 => X"1006_0200", -- add quick      -- r6 <- r2 + 0
            -- (+ 45 ns)

            -- IF (id_inner < id) THEN goto LABEL_1
            17 => X"0107_0506", -- subtract       -- r7 <- r5 - r6
            18 => X"410A_0000", -- branch indexed -- IF: ivnz == 1010 THEN: PC <- r0 + disp32
            19 => X"0000_0005", -- disp32         -- IF: r5 < r6; THEN goto LABEL_1
            -- (+ 45 ns * 2)

            -- value_1_for_comparison = id_max
            20 => X"1005_0300", -- add quick      -- r5 <- r3 + 0
            -- (+ 45 ns)

            -- value_2_for_comparison = id
            21 => X"1006_0200", -- add quick      -- r6 <- r2 + 0
            -- (+ 45 ns)

            -- IF (id_max == id)
            22 => X"0107_0506", -- subtract       -- r7 <- r5 - r6
            23 => X"4109_0700", -- branch indexed -- IF: ivnz == 1001 THEN: PC <- r7 + disp32
            24 => X"0000_001C", -- disp32         -- IF: r5 == r6; THEN goto THEN_2
            -- (+ 45 ns * 2)

            25 => X"1000_0000", -- add quick      -- r0 <- r0 + 0
            26 => X"4109_0000", -- branch indexed -- IF: ivnz == 1001 THEN: PC <- r0 + disp32
            27 => X"0000_001E", -- disp32         -- goto ELSE_2

            -- THEN_2:
            --     value_1_for_comparison = id_max
            28 => X"1005_0300", -- add quick      -- r5 <- r3 + 0
            --     (+ 45 ns)

            --     value_2_for_comparison = 0
            29 => X"1006_0000", -- add quick      -- r6 <- r0 + 0
            --     (+ 45 ns)

            --     IF (id_max == 0)
            30 => X"0107_0506", -- subtract       -- r7 <- r5 - r6
            31 => X"4109_0700", -- branch indexed -- IF: ivnz == 1001 THEN: PC <- r7 + disp32
            32 => X"0000_001C", -- disp32         -- IF: r5 == r6; THEN goto THEN_3
            --     (+ 45 ns * 2)

            33 => X"1000_0000", -- add quick      -- r0 <- r0 + 0
            34 => X"4109_0000", -- branch indexed -- IF: ivnz == 1001 THEN: PC <- r0 + disp32
            35 => X"0000_001E", -- disp32         -- goto ELSE_3

            --     THEN_3:

            --     ELSE_3:

            -- ELSE_2:

            -- ELSE (LABEL_3):

            -- -- Number of elements
            -- 1 => X"1001_000A", -- add quick      -- r1 <- r0 + 8

            -- 2 => X"1002_0100", -- add quick      -- r2 <- r1 + 0

            -- -- k_greate_0
            -- 3 => X"1003_0000", -- add quick      -- r3 <- r0 + 0
            -- 4 => X"3004_0064", -- load quick     -- r4 <- M[r0 + 100]
            -- 5 => X"1101_0101", -- subtract quick -- r1 <- r1 - 1
            -- 6 => X"1002_0100", -- add quick      -- r2 <- r1 + 0

            -- 7 => X"1001_0100", -- add quick      -- r1 <- r1 + 0
            -- 8 => X"4109_0000", -- branch indexed -- IF: ivnz == 1001 THEN: PC <- r0 + disp32
            -- 9 => X"0000_0010", -- disp32         -- IF: r1 == 0 THEN: goto if_k_0
            -- 10 => X"1005_0000", -- add quick      -- r5 <- r0 + 0

            -- -- vyborka:
            -- 11 => X"1005_0501", -- add quick      -- r5 <- r5 + 1
            -- 12 => X"3006_0564", -- load quick     -- r6 <- M[r5 + 100]
            -- 13 => X"3106_0563", -- store quick    -- M[r5 + 99] <- r6
            -- 14 => X"0108_0501", -- subtract       -- r8 <- r5 - r1
            -- 15 => X"500A_00FB", -- branch quick   -- IF: ivnz == 1010 THEN: PC <- PC + 251
            -- --                -- IF: r5 < r1 THEN: goto vyborka (FB = 251)

            -- -- if_k_0:
            -- 16 => X"1001_0100", -- add quick      -- r1 <- r1 + 0
            -- 17 => X"410B_0000", -- branch indexed -- IF: ivnz == 1011 THEN: PC <- r0 + disp32
            -- 18 => X"0000_002C", -- disp32         -- IF: r1 <= 0; THEN goto else_k_0 (2C = 44)

            -- -- if_p_0:
            -- 19 => X"1002_0200", -- add quick      -- r2 <- r2 + 0
            -- 20 => X"410B_0000", -- branch indexed -- IF: ivnz == 1011 THEN: PC <- r0 + disp32
            -- 21 => X"0000_0029", -- disp32         -- IF: r2 <= 0; THEN goto else_p_0 (1E = 41)

            -- 22 => X"3006_0064", -- load quick     -- r6 <- M[r0 + 100]
            -- 23 => X"0108_0406", -- subtract       -- r8 <- r4 - r6
            -- 24 => X"410B_0000", -- branch indexed -- IF: ivnz == 1011 THEN: PC <- r0 + disp32
            -- 25 => X"0000_001E", -- disp32         -- IF: r6 >= r4 THEN: goto min (1E = 30)

            -- 26 => X"1005_0400", -- add quick      -- r5 <- r4 + 0
            -- 27 => X"1004_0600", -- add quick      -- r4 <- r6 + 0
            -- 28 => X"4100_0000", -- branch indexed -- IF: ivnz == 0000 THEN: PC <- r0 + disp32
            -- 29 => X"0000_001F", -- disp32         -- goto sdvig (1F = 31)

            -- -- min:
            -- 30 => X"1005_0600", -- add quick      -- r5 <- r6 + 0

            -- -- sdvig:
            -- 31 => X"1007_0000", -- add quick      -- r7 <- r0 + 0

            -- -- vybor_1:
            -- 32 => X"1007_0701", -- add quick      -- r7 <- r7 + 1
            -- 33 => X"3006_0764", -- load quick     -- r6 <- M[r7 + 100]
            -- 34 => X"3106_0763", -- store quick    -- M[r7 + 99] <- r6
            -- 35 => X"1108_0101", -- subtract quick -- r8 <- r1 - 1
            -- 36 => X"0108_0708", -- subtract       -- r8 <- r7 - r8
            -- 37 => X"500A_00FA", -- branch quick   -- IF: ivnz == 1010 THEN: PC <- PC + 250
            -- -- no disp32      -- IF: r7 < (r1 - 1); THEN goto vybor_1

            -- 38 => X"3105_0163", -- store quick    -- M[r1 + 99] <- r5
            -- 39 => X"1102_0201", -- subtract quick -- r2 <- r2 - 1

            -- 40 => X"5000_00EA", -- branch quick   -- IF: ivnz == 0000 THEN: PC <- PC + 234
            -- -- no disp32      -- goto if_p_0 (40 + 234 = 274 = 255 + 19)

            -- -- else_p_0:
            -- 41 => X"3104_036E", -- store quick    -- M[r3 + 110] <- r4
            -- 42 => X"1003_0301", -- add quick      -- r3 <- r3 + 1
            -- 43 => X"5000_00D8", -- branch quick   -- IF: ivnz == 0000 THEN: PC <- PC + 216
            -- -- no disp32      -- goto k_greate_0 (43 + 216 = 259 = 255 + 3)

            -- -- else_k_0:
            -- 44 => X"3104_036E", -- store quick    -- M[r3 + 110] <- r4
            -- 45 => X"1003_0301", -- add quick      -- r3 <- r3 + 1

            -- 46 => X"0007_0300", -- add            -- r7 <- r3 + r0
            -- 47 => X"0005_0000", -- add            -- r5 <- r0 + r0

            -- -- li_fi:
            -- 48 => X"1107_0701", -- subtract quick -- r7 <- r7 - 1
            -- 49 => X"1005_0501", -- add quick      -- r5 <- r5 + 1
            -- 50 => X"3006_076E", -- load quick     -- r6 <- M[r7 + 110]
            -- 51 => X"3106_0563", -- store quick    -- M[r5 + 99] <- r6
            -- 52 => X"0108_0503", -- subtract       -- r8 <- r5 - r3
            -- 53 => X"500A_00FA", -- branch quick   -- IF: ivnz == 1010 THEN: PC <- PC + 250
            -- -- no disp32      -- IF r5 < r3; THEN goto li_fi (53 + 250 = 303 = 255 + 48)

            -- 54 => X"0000_0000", -- add            -- r0 <- r0 + r0

            -- FIFO:
            100 => X"0000_0004",
            101 => X"0000_0006",
            102 => X"0000_0001",
            103 => X"0000_0003",
            104 => X"0000_0005",
            105 => X"0000_0004",
            106 => X"0000_0002",
            107 => X"0000_0002",
            108 => X"0000_0000", -- Not used
            109 => X"0000_0000", -- Not used

            -- LIFO:
            110 => X"0000_0000",
            111 => X"0000_0000",
            112 => X"0000_0000",
            113 => X"0000_0000",
            114 => X"0000_0000",
            115 => X"0000_0000",
            116 => X"0000_0000",
            117 => X"0000_0000",
            118 => X"0000_0000", -- Not used
            119 => X"0000_0000", -- Not used
            others => X"0000_0000"
            -- ========================================
        );
    begin
        -- Put d_bus and reply into initial state
        d_bus <= null after Tpd;
        ready <= '0' after Tpd;

        -- Wait for a command
        wait until (read = '1') or (write = '1');

        -- Dispatch read or write cycle
        address := bits_to_int(a_bus);
        if address >= low_address and address <= high_address then
            -- Address match for this memory
            if write = '1' then
                ready <= '1' after Tpd;

                -- Wait until end of write cycle
                wait until write = '0';
                mem(address) := d_bus;
                -- read='1'
            else
                -- Fetch data
                d_bus <= mem(address) after Tpd;
                ready <= '1' after Tpd;

                -- Hold for read cycle
                wait until read = '0';
            end if;
        end if;
    end process;
end behaviour;
