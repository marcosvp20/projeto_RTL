library ieee;
use ieee.std_logic_1164.all;

entity registrador is
    generic (
        N : integer
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
    signal regis : std_logic_vector(N-1 downto 0); -- Valor registrado
begin
    process (clk, clear)
    begin
        if rising_edge(clk) then
            if clear = '1' then
                regis <= (others => '0'); -- Reset assíncrono
            elsif load = '1' then
                regis <= data_in;
            end if;
        end if;
    end process;
    
    data_out <= regis; -- Saída
end arch_regis;
