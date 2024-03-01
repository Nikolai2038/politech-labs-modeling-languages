LIBRARY IEEE;

USE IEEE.std_logic_1164.ALL;

ENTITY l09p05s_cmp4digits IS
    PORT (
        X0 : IN std_logic;
        X1 : IN std_logic;
        X2 : IN std_logic;
        X3 : IN std_logic;
        Y0 : IN std_logic;
        Y1 : IN std_logic;
        Y2 : IN std_logic;
        Y3 : IN std_logic;
        XMY0 : IN std_logic;
        XLY0 : IN std_logic;
        XEY0 : IN std_logic;

        XMY : OUT std_logic;
        XLY : OUT std_logic;
        XEY : OUT std_logic
    );
END l09p05s_cmp4digits;

ARCHITECTURE l09p05s_cmp4digits_behaviour OF l09p05s_cmp4digits IS
    COMPONENT l09p04b_cmp2digits
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
    END COMPONENT;

    SIGNAL XMY_FROM_1 : std_logic;
    SIGNAL XLY_FROM_1 : std_logic;
    SIGNAL XEY_FROM_1 : std_logic;
BEGIN
    cmp_1: l09p04b_cmp2digits PORT MAP (X2, X3, Y2, Y3, XMY_FROM_1, XLY_FROM_1, XEY_FROM_1, XMY, XLY, XEY);
    cmp_2: l09p04b_cmp2digits PORT MAP (X0, X1, Y0, Y1, XMY0, XLY0, XEY0, XMY_FROM_1, XLY_FROM_1, XEY_FROM_1);
END l09p05s_cmp4digits_behaviour;

CONFIGURATION l09p05s_cmp4digits_configuration OF l09p05s_cmp4digits IS
    FOR l09p05s_cmp4digits_behaviour
        FOR
            cmp_1,
            cmp_2
        : l09p04b_cmp2digits
            USE ENTITY work.l09p04b_cmp2digits (l09p04b_cmp2digits_behaviour);
        END FOR;
    END FOR;
END l09p05s_cmp4digits_configuration;
