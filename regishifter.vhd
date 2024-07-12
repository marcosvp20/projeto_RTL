library ieee;
use ieee.std_logic_1164.all;

entity regishifter is
    generic (
        N : integer := 2  -- Número de bits (2 a 5)
    );
    port (
        clk : in std_logic;
        clear : in std_logic;
        load : in std_logic;
        shift_left : in std_logic;
        data_in : in std_logic_vector(N-1 downto 0);
        data_out : out std_logic_vector(N-1 downto 0)
    );
end regishifter;

architecture arch_regish of regishifter is
    signal reg_data : std_logic_vector(N-1 downto 0);
    signal temp_data : std_logic_vector(N-1 downto 0);
begin
    u_reg: entity work.registrador
        generic map (N => N)
        port map (
            clk => clk,
            clear => clear,
            load => load,
            data_in => temp_data,
            data_out => reg_data
        );

    process (clk)
    begin
        if rising_edge(clk) then
            if shift_left = '1' then
                temp_data <= reg_data(N-2 downto 0) & '0';  -- Realiza o shift left
            else
                temp_data <= data_in;
            end if;
        end if;
    end process;

    data_out <= reg_data;
end arch_regish;
