library IEEE;
use IEEE.std_logic_1164.all;

entity l04p10q_dff_async is
    port (
        data, clk, reset, preset : in std_logic;
        q : out std_logic
    );
end l04p10q_dff_async;

architecture l04p10q_dff_async_behaviour of l04p10q_dff_async is
begin
    process (clk, reset, preset) begin
        if (reset = '0') then
            q <= '0';
        elsif (preset = '0') then
            q <= '1';
        elsif (clk'event and clk = '1') then
            q <= data;
        end if;
    end process;
end l04p10q_dff_async_behaviour;
