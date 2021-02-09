--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : ISE
--  /   /         Filename : tb_cpu_1.vhw
-- /___/   /\     Timestamp : Thu Apr 16 00:12:22 2020
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: tb_cpu_1
--Device: Xilinx
--

library ieee;
use ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.ALL;

ENTITY tb_cpu_1 IS
END tb_cpu_1;

ARCHITECTURE testbench_arch OF tb_cpu_1 IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT cpu
        PORT (
            ck : In std_logic;
            rst : In std_logic;
            run : In std_logic;
            ch : In std_logic_vector (7 DownTo 0);
            leds : Out std_logic_vector (7 DownTo 0)
        );
    END COMPONENT;

    SIGNAL ck : std_logic := '0';
    SIGNAL rst : std_logic := '1';
    SIGNAL run : std_logic := '0';
    SIGNAL ch : std_logic_vector (7 DownTo 0) := "00000000";
    SIGNAL leds : std_logic_vector (7 DownTo 0) := "00000000";

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 0 ns;

    BEGIN
        UUT : cpu
        PORT MAP (
            ck => ck,
            rst => rst,
            run => run,
            ch => ch,
            leds => leds
        );

        PROCESS    -- clock process for ck
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                ck <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                ck <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            BEGIN
                -- -------------  Current Time:  685ns
                WAIT FOR 685 ns;
                rst <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1085ns
                WAIT FOR 400 ns;
                rst <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  9685ns
                WAIT FOR 8600 ns;
                ch <= "00000001";
                -- -------------------------------------
                -- -------------  Current Time:  13885ns
                WAIT FOR 4200 ns;
                run <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  18685ns
                WAIT FOR 4800 ns;
                run <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  25885ns
                WAIT FOR 7200 ns;
                ch <= "00000111";
                -- -------------------------------------
                -- -------------  Current Time:  32085ns
                WAIT FOR 6200 ns;
                run <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  36285ns
                WAIT FOR 4200 ns;
                run <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  42285ns
                WAIT FOR 6000 ns;
                ch <= "00001000";
                -- -------------------------------------
                -- -------------  Current Time:  48285ns
                WAIT FOR 6000 ns;
                run <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  53285ns
                WAIT FOR 5000 ns;
                run <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  60485ns
                WAIT FOR 7200 ns;
                ch <= "00000000";
                -- -------------------------------------
                -- -------------  Current Time:  65885ns
                WAIT FOR 5400 ns;
                run <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  71485ns
                WAIT FOR 5600 ns;
                run <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  78085ns
                WAIT FOR 6600 ns;
                ch <= "00000101";
                -- -------------------------------------
                -- -------------  Current Time:  84085ns
                WAIT FOR 6000 ns;
                run <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  89685ns
                WAIT FOR 5600 ns;
                run <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  96285ns
                WAIT FOR 6600 ns;
                ch <= "00000100";
                -- -------------------------------------
                -- -------------  Current Time:  104685ns
                WAIT FOR 8400 ns;
                run <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  112085ns
                WAIT FOR 7400 ns;
                run <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  130885ns
                WAIT FOR 18800 ns;
                run <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  138685ns
                WAIT FOR 7800 ns;
                run <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  156285ns
                WAIT FOR 17600 ns;
                run <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  163485ns
                WAIT FOR 7200 ns;
                run <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  175085ns
                WAIT FOR 11600 ns;
                run <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  183485ns
                WAIT FOR 8400 ns;
                run <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  196285ns
                WAIT FOR 12800 ns;
                run <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  204085ns
                WAIT FOR 7800 ns;
                run <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  217485ns
                WAIT FOR 13400 ns;
                run <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  226485ns
                WAIT FOR 9000 ns;
                run <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  244085ns
                WAIT FOR 17600 ns;
                run <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  253285ns
                WAIT FOR 9200 ns;
                run <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  267685ns
                WAIT FOR 14400 ns;
                run <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  275685ns
                WAIT FOR 8000 ns;
                run <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  290885ns
                WAIT FOR 15200 ns;
                run <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  299285ns
                WAIT FOR 8400 ns;
                run <= '0';
                -- -------------------------------------
                WAIT FOR 200915 ns;

            END PROCESS;

    END testbench_arch;

