-- Marcos Vinicius Pinheiro Azevedo
-- Henrique Carneiro Cardoso
-- Thiago Wriel Soares Carvalho

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_regishifter is
end tb_regishifter;

architecture behavior of tb_regishifter is
    component registrador
        generic (
            N : integer := 2
        );
        port (
            clk : in std_logic;
            clear : in std_logic;
            load : in std_logic;
            shift_left : in std_logic;
            data_in : in std_logic_vector(N-1 downto 0);
            data_out : out std_logic_vector(N-1 downto 0)
        );
    end component;

    signal clk_tb : std_logic := '0';
    signal clear_tb : std_logic := '0';
    signal load_tb : std_logic := '0';
    signal shift_left_tb : std_logic := '0';
    signal data_in_tb : std_logic_vector(1 downto 0) := (others => '0');
    signal data_out_tb : std_logic_vector(1 downto 0) := (others => '0');

    constant clk_period : time := 10 ns;

begin
    uut: registrador
        generic map (
            N => 2
        )
        port map (
            clk => clk_tb,
            clear => clear_tb,
            load => load_tb,
            shift_left => shift_left_tb,
            data_in => data_in_tb,
            data_out => data_out_tb
        );

    clk_process : process
    begin
        clk_tb <= '0';
        wait for clk_period / 2;
        clk_tb <= '1';
        wait for clk_period / 2;
    end process;

    stim_proc: process
    begin        
        -- Reset e load dos valores iniciais
        clear_tb <= '1';
        wait for clk_period * 2;
        clear_tb <= '0';
        load_tb <= '1';
        data_in_tb <= "10";
        wait for clk_period * 2;
        load_tb <= '0';

        -- Shift left
        shift_left_tb <= '1';
        wait for clk_period * 2;
        shift_left_tb <= '0';

        -- Load do novo valor
        load_tb <= '1';
        data_in_tb <= "01";
        wait for clk_period * 2;
        load_tb <= '0';

        -- Shift left
        shift_left_tb <= '1';
        wait for clk_period * 2;
        shift_left_tb <= '0';

        -- FIm da simulação
        wait for clk_period * 10;
        wait;
    end process;
end behavior;
