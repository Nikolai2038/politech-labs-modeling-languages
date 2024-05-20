library ieee;
use ieee.std_logic_1164.all;

package sort_types is
    type massType is array (7 downto 0) of integer;
end sort_types;

library ieee;
use ieee.std_logic_1164.all;
use work.sort_types.all;

entity sort is
    port (
        clk : in std_logic;
        reset : in std_logic;
        working : out std_logic;
        data_in : in massType;
        data_out : out massType
    );
end sort;

architecture sort_architecture of sort is
    signal is_working : std_logic;
    signal is_finding_max : std_logic;
    signal is_flipping : std_logic;
    signal is_flipping_saved : std_logic;
    signal arr : massType;
    signal id, id_max, id_inner : integer := 0;
    signal temp : integer;
    signal temp2 : integer;
    signal id2 : integer;
    signal main_cycle_stage : integer;

    -- procedure flip_array(
    --     signal arr : inout massType;
    --     signal id2 : in integer
    -- ) is
    --     variable temp : integer;
    --     variable id_inner : integer;
    --     variable id22 : integer;
    -- begin
    --     id_inner := 0;
    --     id22 := id2;
    --     while id_inner < id22 loop
    --         temp := arr(id22);
    --         arr(id22) <= arr(id_inner);
    --         arr(id_inner) <= temp;
    --         id_inner := id_inner + 1;
    --         id22 := id22 - 1;
    --     end loop;
    -- end procedure;

begin
    process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                is_working <= '0';
                arr <= data_in;
            else
                if is_working = '0' then
                    is_working <= '1';
                    id <= 7;
                    id_max <= id;
                    id_inner <= 0;
                    is_finding_max <= '1';
                    is_flipping <= '0';
                    is_flipping_saved <= '0';
                    main_cycle_stage <= 1;
                else
                    if id >= 0 then
                        if is_finding_max = '1' then
                            if id_inner < id then
                                if arr(id_inner) > arr(id_max) then
                                    id_max <= id_inner;
                                end if;
                                id_inner <= id_inner + 1;
                            else
                                is_finding_max <= '0';
                            end if;
                        else
                            if is_flipping = '1' then
                                if id_inner < id2 then
                                    if is_flipping_saved = '0' then
                                        temp <= arr(id2);
                                        temp2 <= arr(id_inner);
                                        is_flipping_saved <= '1';
                                    else
                                        arr(id2) <= temp2;
                                        arr(id_inner) <= temp;
                                        id_inner <= id_inner + 1;
                                        id2 <= id2 - 1;
                                        is_flipping_saved <= '0';
                                    end if;
                                else
                                    is_flipping <= '0';

                                    if main_cycle_stage = 1 then
                                        main_cycle_stage <= 2;
                                    end if;

                                    if main_cycle_stage = 2 then
                                        main_cycle_stage <= 3;
                                    end if;
                                end if;
                            else
                                if main_cycle_stage = 1 then
                                    if id_max /= id and id_max /= 0 then
                                        id_inner <= 0;
                                        id2 <= id_max;
                                        is_flipping_saved <= '0';
                                        is_flipping <= '1';
                                    else
                                        main_cycle_stage <= 2;
                                    end if;
                                end if;

                                if main_cycle_stage = 2 then
                                    if id_max /= id then
                                        id_inner <= 0;
                                        id2 <= id;
                                        is_flipping_saved <= '0';
                                        is_flipping <= '1';
                                    else
                                        main_cycle_stage <= 3;
                                    end if;
                                end if;

                                if main_cycle_stage = 3 then
                                    id <= id - 1;
                                    id_max <= id - 1;
                                    id_inner <= 0;
                                    is_finding_max <= '1';
                                    main_cycle_stage <= 1;
                                end if;
                            end if;
                        end if;
                    else
                        is_working <= '0';
                    end if;
                end if;
            end if;
        end if;

        data_out <= arr;
        working <= is_working;
    end process;
end sort_architecture;
