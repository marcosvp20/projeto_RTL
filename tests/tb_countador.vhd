library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_contador is
end tb_contador;

architecture arch of tb_contador is
    
    constant clk_period : time := 10 ns;
    signal clk_tb : std_logic := '0';
    signal clear_tb : std_logic := '0';
    signal count_tb : std_logic := '0';
    signal count_out_tb : std_logic_vector := "00";

    component contador
        generic (
            N : integer 
        );
        port (
            clk : in std_logic;
            clear : in std_logic;
            count : in std_logic;
            count_out : out std_logic_vector(N-1 downto 0)
        );
        end component;

    begin 
        UUT: contador
            generic map (
                N => 2
            )
            port map(
                clk => clk_tb,
                clear => clear_tb,
                count => count_tb,
                count_out => count_out_tb
            );


        clk_process: process
        begin
            clk_tb <= '0';
            wait for clk_period / 2;
            clk_tb <= '1';
            wait for clk_period / 2;
        end process;
        

        stim_proc: process
        begin
            -- teste 1
            clear_tb <= '1';
            wait for clk_period * 2;
            clear_tb <= '0';
            wait for clk_period * 2;
            count_tb <= '1'; 
            wait for clk_period;
            count_tb <= '0';
            wait for clk_period;
            assert (count_out_tb = "01") report "teste de 1 count falhou" severity error;

            -- teste 2
            clear_tb <= '1';
            wait for clk_period * 2;
            clear_tb <= '0';
            wait for clk_period * 2;
            count_tb <= '1';
            wait for clk_period;
            count_tb <= '0';
            wait for clk_period;
            count_tb <= '1';
            wait for clk_period;
            count_tb <= '0';
            wait for clk_period;
            assert (count_out_tb = "10") report "teste de 2 counts falhou" severity error;

            -- teste 3
            clear_tb <= '1';
            wait for clk_period * 2;
            clear_tb <= '0';
            wait for clk_period * 2;
            count_tb <= '1';
            wait for clk_period;
            count_tb <= '0';
            wait for clk_period;
            count_tb <= '1';
            wait for clk_period;
            count_tb <= '0';
            wait for clk_period;
            count_tb <= '1';
            wait for clk_period;
            count_tb <= '0';
            wait for clk_period;
            assert (count_out_tb = "11") report "teste de 3 counts falhou" severity error;
            
            -- teste 4
            clear_tb <= '1';
            wait for clk_period * 2;
            clear_tb <= '0';
            wait for clk_period * 2;
            count_tb <= '1';
            wait for clk_period;
            count_tb <= '0';
            wait for clk_period;
            count_tb <= '1';
            wait for clk_period;
            count_tb <= '0';
            wait for clk_period;
            clear_tb <= '1';
            wait for clk_period * 2;
            clear_tb <= '1';
            wait for clk_period * 2;
            clear_tb <= '0';
            wait for clk_period * 2;
            assert (count_out_tb = "00") report "teste de clear falhou" severity error;

            -- teste 5
            wait for clk_period * 2;
            assert (count_out_tb = "00") report "teste de nada falhou" severity error;

            -- teste 6
            clear_tb <= '1';
            wait for clk_period * 2;
            count_tb <= '1';
            wait for clk_period;
            count_tb <= '0';
            wait for clk_period;
            clear_tb <= '0';
            wait for clk_period * 2;
            count_tb <= '1';
            wait for clk_period;
            count_tb <= '0';
            wait for clk_period;
            count_tb <= '1';
            wait for clk_period;
            count_tb <= '0';
            wait for clk_period;
            assert (count_out_tb = "10") report "teste 6 falhou" severity error;

            wait for clk_period * 10;
            wait;
        end process;
    end arch;