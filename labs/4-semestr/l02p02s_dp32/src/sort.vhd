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
    -- Is sorting right now?
    signal is_working : std_logic;

    -- Clock operations
    signal is_finding_max : std_logic;
    signal is_flipping : std_logic;
    signal is_flipping_saved : std_logic;

    -- Extra variable to separate operations on several clocks
    signal main_flow_clock_stage : integer;

    -- Array itself
    signal arr : massType;

    signal id : integer;
    signal id_max : integer;
    signal id_inner : integer;
    signal id_temp : integer;

    -- Temp value 1 for switching array elements
    signal temp_1 : integer;

    -- Temp value 2 for switching array elements
    signal temp_2 : integer;

begin
    process (clk, reset)
    begin
        if falling_edge(reset) then
            working <= '1';
            arr <= data_in;
            id <= 7;
            id_max <= 7;
            id_inner <= 0;
            is_finding_max <= '1';
            is_flipping <= '0';
            is_flipping_saved <= '0';
            main_flow_clock_stage <= 1;
        elsif id >= 0 then
            if is_finding_max = '1' then
                if id_inner < id then
                    if arr(id_inner) > arr(id_max) then
                        id_max <= id_inner;
                    end if;
                    id_inner <= id_inner + 1;
                else
                    is_finding_max <= '0';
                end if;
            elsif is_flipping = '1' then
                if id_inner < id_temp then
                    if is_flipping_saved = '0' then
                        temp_1 <= arr(id_temp);
                        temp_2 <= arr(id_inner);
                        is_flipping_saved <= '1';
                    else
                        arr(id_temp) <= temp_2;
                        arr(id_inner) <= temp_1;
                        id_inner <= id_inner + 1;
                        id_temp <= id_temp - 1;
                        is_flipping_saved <= '0';
                    end if;
                else
                    is_flipping <= '0';

                    if main_flow_clock_stage = 1 then
                        main_flow_clock_stage <= 2;
                    end if;

                    if main_flow_clock_stage = 2 then
                        main_flow_clock_stage <= 3;
                    end if;
                end if;
            else
                if main_flow_clock_stage = 1 then
                    if id_max /= id and id_max /= 0 then
                        id_inner <= 0;
                        id_temp <= id_max;
                        is_flipping_saved <= '0';
                        is_flipping <= '1';
                    else
                        main_flow_clock_stage <= 2;
                    end if;
                end if;

                if main_flow_clock_stage = 2 then
                    if id_max /= id then
                        id_inner <= 0;
                        id_temp <= id;
                        is_flipping_saved <= '0';
                        is_flipping <= '1';
                    else
                        main_flow_clock_stage <= 3;
                    end if;
                end if;

                if main_flow_clock_stage = 3 then
                    id <= id - 1;
                    id_max <= id - 1;
                    id_inner <= 0;
                    is_finding_max <= '1';
                    main_flow_clock_stage <= 1;
                end if;
            end if;
        else
            working <= '0';
            data_out <= arr;
        end if;
    end process;
end sort_architecture;
