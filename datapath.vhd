library ieee;
use ieee.std_logic_1164.all;

entity datapath is
    port(
        N : in integer;
        clk : in std_logic;
        i_clr : in std_logic;
        i_cnt : in std_logic;
        sum_clr: in std_logic;
        sum_ld : in std_logic;
        B : in std_logic_vector(N-1 downto 0);
        b_clr : in std_logic;
        b_ld : in std_logic;
        a_clr : in std_logic;
        a_ld : in std_logic;
        a_sh_l : in std_logic;
        i_lt_n : out std_logic;
        b_eq_1 : out std_logic;
        result : out std_logic_vector(N-1 downto 0)
        );

architecture arch of datapath is
    signal i : std_logic_vector (N-1 downto 0);
    signal B_out : std_logic_vector(N-1 downto 0);
    begin
        i_cnt: entity work.counter
        generic map (N => N)
        port map(
            clk => clk;
            clear => i_clr;
            count => i_cnt;
            count_out => i
        );
        
        b_reg: entity work.register
        generic map (N => N)
        port map(
            clk => clk
            clear => b_clr
            load => b_ld
            data_in => B
            data_out => B_out
        )

        result :