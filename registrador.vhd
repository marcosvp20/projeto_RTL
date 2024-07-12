library ieee;
use ieee.std_logic_1164.all;

entity registrador is
    generic (
        N : integer := 2
    );
    port (
        clk : in std_logic;
        clear : in std_logic;
        load : in std_logic;
        data_in : in std_logic_vector(N-1 downto 0);
        data_out : out std_logic_vector(N-1 downto 0)
    );
end registrador;

architecture arch_regis of registrador is
    signal register : std_logic_vector(N-1 downto 0);
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if clear = '1' then
                register <= (others => '0');
            elsif load = '1' then
                register <= data_in;
            end if;
        end if;
    end process;
    
    data_out <= register;
end arch_regis;
