library ieee;
use ieee.std_logic_1164.all;

entity somador is
    generic (
        N : integer := 2
    );
    port (
        A : in std_logic_vector(N-1 downto 0);
        B : in std_logic_vector(N-1 downto 0);
        SUM : out std_logic_vector(N downto 0);
    );
end somador;

architecture arch_som of somador is
begin
    process (A, B)
    begin
        SUM <= std_logic_vector(unsigned('0' & A) + unsigned('0' & B));
    end process;
end arch_som;
