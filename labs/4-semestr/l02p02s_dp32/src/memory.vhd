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
            --         _id--
            --     IF_6 (id_inner < _id) THEN goto CYCLE_FLIP_ARRAY
            --     goto return_to
            --
            -- PROGRAM_END:
            -- ========================================

            -- ========================================
            -- Program
            -- ========================================
            -- [CHECKPOINT] 90ns
            --     reset 0
            0 => X"1000_0000", -- add quick             -- r0 <- r0 + 0
            --     size = array.size
            1 => X"1001_0008", -- add quick             -- r1 <- r0 + 8
            --     id = size - 1
            2 => X"1102_0101", -- subtract quick        -- r2 <- r1 - 1
            -- CYCLE_FROM_LAST_THROUGH_ALL:
            --         id_max = id
            3 => X"1003_0200", -- add quick             -- r3 <- r2 + 0
            --         id_inner = 0
            4 => X"1004_0000", -- add quick             -- r4 <- r0 + 0
            --     CYCLE_FIND_MAX_BEFORE:
            --         IF_1 (array[id_inner] > array[id_max]) THEN goto THEN_1
            5 => X"3005_0464", -- load quick            -- r5 <- M[r4 + 100]
            6 => X"3006_0364", -- load quick            -- r6 <- M[r3 + 100]
            7 => X"0107_0506", -- subtract              -- r7 <- r5 - r6
            8 => X"5107_000B", -- branch indexed quick  -- IF: ivnz == 0111 THEN: PC <- r0 + 11
            --         goto ENDIF_1
            9 => X"1000_0000", -- add quick             -- r0 <- r0 + 0
            10 => X"5109_000C", -- branch indexed quick -- IF: ivnz == 1001 THEN: PC <- r0 + 12
            --         THEN_1:
            --             id_max = id_inner
            11 => X"1003_0400", -- add quick            -- r3 <- r4 + 0
            --         ENDIF_1:
            --             id_inner++
            12 => X"1004_0401", -- add quick            -- r4 <- r4 + 1
            --     IF_2 (id_inner < id) THEN goto CYCLE_FIND_MAX_BEFORE
            13 => X"0107_0402", -- subtract             -- r7 <- r4 - r2
            14 => X"510A_0005", -- branch indexed quick -- IF: ivnz == 1010 THEN: PC <- r0 + 5
            --     IF_3 (id_max == id) THEN goto ENDIF_3
            15 => X"0107_0302", -- subtract             -- r7 <- r3 - r2
            16 => X"5109_001B", -- branch indexed quick -- IF: ivnz == 1001 THEN: PC <- r0 + 27
            --         IF_4 (id_max == 0) THEN goto ENDIF_4
            17 => X"1107_0300", -- subtract quick       -- r7 <- r3 - 0
            18 => X"5109_0017", -- branch indexed quick -- IF: ivnz == 1000 THEN: PC <- r0 + 23
            --             r8 = id_max
            19 => X"1008_0300", -- add quick            -- r8 <- r3 + 0
            --             return_to = ENDIF_4
            20 => X"1009_0017", -- add quick            -- r9 <- r0 + 23
            --             goto FLIP_ARRAY
            21 => X"1000_0000", -- add quick            -- r0 <- r0 + 0
            22 => X"5109_0022", -- branch indexed quick -- IF: ivnz == 1001 THEN: PC <- r0 + 34
            --         ENDIF_4:
            --             r8 = id
            23 => X"1008_0200", -- add quick            -- r8 <- r2 + 0
            --             return_to = ENDIF_3
            24 => X"1009_001B", -- add quick            -- r9 <- r0 + 27
            --             goto FLIP_ARRAY
            25 => X"1000_0000", -- add quick            -- r0 <- r0 + 0
            26 => X"5109_0022", -- branch indexed quick -- IF: ivnz == 1001 THEN: PC <- r0 + 34
            --     ENDIF_3:
            --     id--
            27 => X"1102_0201", -- subtract quick       -- r2 <- r2 - 1
            -- IF_5 (id >= 0) THEN goto CYCLE_FROM_LAST_THROUGH_ALL
            28 => X"1107_0200", -- subtract quick       -- r7 <- r2 - 0
            29 => X"5106_0003", -- branch indexed quick -- IF: ivnz == 0110 THEN: PC <- r0 + 2
            -- goto PROGRAM_END
            30 => X"1005_0564", -- add quick            -- r5 <- r5 + 100
            31 => X"0005_0501", -- add                  -- r5 <- r5 + r1
            32 => X"1000_0000", -- add quick            -- r0 <- r0 + 0
            33 => X"5109_0500", -- branch indexed quick -- IF: ivnz == 1001 THEN: PC <- r5 + 0
            --
            -- FLIP_ARRAY:
            --         id_inner = 0
            34 => X"1004_0000", -- add quick            -- r4 <- r0 + 0
            --     CYCLE_FLIP_ARRAY:
            --         temp_1 = array[_id]
            35 => X"300A_0864", -- load quick           -- r10 <- M[r8 + 100]
            --         temp_2 = array[id_inner]
            36 => X"300B_0464", -- load quick           -- r11 <- M[r4 + 100]
            --         array[id_inner] = temp_1
            37 => X"310A_0464", -- store quick          -- M[r4 + 100] <- r10
            --         array[_id] = temp_2
            38 => X"310B_0864", -- load quick           -- M[r8 + 100] <- r11
            --         id_inner++
            39 => X"1004_0401", -- add quick            -- r4 <- r4 + 1
            --         _id--
            40 => X"1108_0801", -- add quick            -- r8 <- r8 - 1
            --     IF_6 (id_inner < _id) THEN goto CYCLE_FLIP_ARRAY
            41 => X"0107_0408", -- subtract             -- r7 <- r4 - r8
            42 => X"510A_0023", -- branch indexed quick -- IF: ivnz == 1010 THEN: PC <- r0 + 35
            --     goto return_to
            43 => X"1000_0000", -- add quick            -- r0 <- r0 + 0
            44 => X"5109_0900", -- branch indexed quick -- IF: ivnz == 1001 THEN: PC <- r9 + 0

            -- array
            100 => X"0000_0004",
            101 => X"0000_0006",
            102 => X"0000_0001",
            103 => X"0000_0003",
            104 => X"0000_0005",
            105 => X"0000_0004",
            106 => X"0000_0002",
            107 => X"0000_0002",

            -- PROGRAM_END:
            120 => X"0000_0000",

            others => X"0000_0000"
            -- ========================================

            -- ========================================
            -- Checkpoints
            -- ========================================
            -- 90ns    - Picture 1 - On first command
            -- 5355ns              - Before first FLIP_ARRAY
            -- 6255ns  - Picture 2 - After first FLIP_ARRAY
            -- 9585ns  - Picture 3
            -- 15885ns - Picture 4
            -- 18450ns - Picture 5
            -- 22185ns - Picture 6
            -- 27135ns - Picture 7
            -- 30690ns - Picture 8
            -- 32535ns - Picture 9
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
