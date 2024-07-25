library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador is
    generic (
        N : integer 
    );
    port (
        clk : in std_logic;
        clear : in std_logic;
        count : in std_logic;
        count_out : out std_logic_vector(N-1 downto 0)
    );
end contador;

architecture arch_cont of contador is
    signal reg_data : std_logic_vector(N-1 downto 0); -- Valor do contador
begin
    process (clk, clear)
    begin
        if clear = '1' then
            reg_data <= (others => '0');  -- Reset assíncrono
        elsif rising_edge(clk) then
            if count = '1' then
                reg_data <= std_logic_vector(unsigned(reg_data) + 1);  -- Incrementa o contador
            end if;
        end if;
    end process;

    count_out <= reg_data; -- Saída
end arch_cont;