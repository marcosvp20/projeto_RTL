library ieee;
use ieee.std_logic_1164.all;

entity regishifter is
    generic (
        N : integer
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

architecture arch_regis of regishifter is
    signal regis : std_logic_vector(N-1 downto 0);
begin
    process (clk, clear)
    begin
        if clear = '1' then
            regis <= (others => '0'); 
        elsif rising_edge(clk) then
            if load = '1' then
                regis <= data_in;
            elsif shift_left = '1' then
                regis <= data_out(N-2 downto 0) & '0';  -- Realiza o shift left
            end if;
        end if;
    end process;
    
    data_out <= regis;
end arch_regis;
