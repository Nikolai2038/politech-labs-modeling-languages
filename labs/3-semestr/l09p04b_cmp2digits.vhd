LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY l09p04b_cmp2digits IS
    PORT (
        X0 : IN std_logic;
        X1 : IN std_logic;
        Y0 : IN std_logic;
        Y1 : IN std_logic;
        XMY0 : IN std_logic;
        XLY0 : IN std_logic;
        XEY0 : IN std_logic;

        XMY : OUT std_logic;
        XLY : OUT std_logic;
        XEY : OUT std_logic
    );
END l09p04b_cmp2digits;

ARCHITECTURE l09p04b_cmp2digits_behaviour OF l09p04b_cmp2digits IS
    signal XMY_S : std_logic;
    signal XLY_S : std_logic;
    signal XEY_S : std_logic;
BEGIN
    PROCESS (X0, X1, Y0, Y1, XMY0, XLY0, XEY0) BEGIN
        IF X1 > Y1 OR (X1 = Y1 AND X0 > Y0) OR (X1 = Y1 AND X0 = Y0 AND XMY0 = '1') THEN
            XMY_S <= '1';
            XLY_S <= '0';
            XEY_S <= '0';
        ELSIF X1 < Y1 OR (X1 = Y1 AND X0 < Y0) OR (X1 = Y1 AND X0 = Y0 AND XLY0 = '1') THEN
            XMY_S <= '0';
            XLY_S <= '1';
            XEY_S <= '0';
        ELSIF XEY0 = '1' THEN
            XMY_S <= '0';
            XLY_S <= '0';
            XEY_S <= '1';
        ELSE
            XMY_S <= '0';
            XLY_S <= '0';
            XEY_S <= '0';
        END IF;
    END PROCESS;

    XMY <= XMY_S;
    XLY <= XLY_S;
    XEY <= XEY_S;
END l09p04b_cmp2digits_behaviour;
