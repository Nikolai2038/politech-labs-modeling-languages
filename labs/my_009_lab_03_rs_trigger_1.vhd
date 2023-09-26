LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY rs_trigger IS
    PORT(
        s : IN std_logic;
        r : IN std_logic;
        q : INOUT std_logic;
        qb : INOUT std_logic
    );
END rs_trigger;

ARCHITECTURE rs_trigger_behaviour OF rs_trigger IS
    -- описание используемого компонента
    COMPONENT my_011_lab_03_nand2
        PORT(
            a : IN std_logic;
            b : IN std_logic;
            c : INOUT std_logic
        );
    END COMPONENT;
BEGIN
    -- указание u1, как компонента my_011_lab_03_nand2
    u1: my_011_lab_03_nand2
    -- указание входов и выхода для u1
    PORT MAP (s, qb, q);

    -- указание u2, как компонента my_011_lab_03_nand2
    u2: my_011_lab_03_nand2
    -- указание входов и выхода для u2
    PORT MAP (q, r, qb);
END rs_trigger_behaviour;

CONFIGURATION rs_trigger_configuration OF rs_trigger IS
    FOR rs_trigger_behaviour
        FOR u1, u2: my_011_lab_03_nand2
            -- определяет интерфейс и модель компонента my_011_lab_03_nand2
            USE ENTITY work.my_011_lab_03_nand2 (my_011_lab_03_nand2_behaviour);
        END FOR;
    END FOR;
END rs_trigger_configuration;
