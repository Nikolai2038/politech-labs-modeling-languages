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
    signal run : std_logic := '0';
    signal arr : massType;
    signal id, id_max, id_inner : integer := 0;

    procedure flip_array(
        signal arr : inout massType;
        signal id2 : in integer
    ) is
        variable temp : integer;
        variable id_inner : integer;
        variable id22 : integer;
    begin
        id_inner := 0;
        id22 := id2;
        while id_inner < id22 loop
            temp := arr(id22);
            arr(id22) <= arr(id_inner);
            arr(id_inner) <= temp;
            id_inner := id_inner + 1;
            id22 := id22 - 1;
        end loop;
    end procedure;

begin
    process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                run <= '0';
                working <= '0';
                arr <= data_in;
                id <= 7;
            else
                if run = '0' then
                    working <= '1';
                    run <= '1';
                    id <= 7;
                else
                    if id >= 0 then
                        id_max <= id;
                        id_inner <= 0;

                        while id_inner < id loop
                            if arr(id_inner) > arr(id_max) then
                                id_max <= id_inner;
                            end if;
                            id_inner <= id_inner + 1;
                        end loop;

                        if id_max /= id then
                            if id_max /= 0 then
                                flip_array(arr, id_max);
                            end if;
                            flip_array(arr, id);
                        end if;

                        id <= id - 1;
                    else
                        working <= '0';
                        run <= '0';
                        data_out <= arr;
                    end if;
                end if;
            end if;
        end if;
    end process;
end sort_architecture;
