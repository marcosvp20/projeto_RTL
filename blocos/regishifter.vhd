library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
        data_out : out std_logic_vector(2*N-1 downto 0)
    );
end regishifter;

architecture arch_regis of regishifter is
    signal regis : std_logic_vector(2*N-1 downto 0); -- Valor registrado com tamanho adequado
begin
    process (clk, clear)
    begin
        if clear = '1' then
            regis <= (others => '0'); -- Clear assíncrono
        elsif rising_edge(clk) then
            if load = '1' then
                regis(N-1 downto 0) <= data_in;
            elsif shift_left = '1' then
                regis <= regis(2*N-2 downto 0) & '0';  -- Realiza o shift left
            end if;
        end if;
    end process;

    data_out <= regis; -- Saída
end arch_regis;
