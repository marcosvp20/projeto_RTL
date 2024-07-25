library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador is
    generic (
        N : integer
    );
    port (
        A : in std_logic_vector(2*N-1 downto 0);
        B : in std_logic_vector(2*N-1 downto 0);
        SUM : out std_logic_vector(2*N-1 downto 0)
    );
end somador;

architecture arch_som of somador is
begin
    -- Processo de soma sem considerar o carry out, pois não será necessário
    process (A, B)
    begin
        SUM <= std_logic_vector(unsigned(A) + unsigned(B)); 
    end process;
end arch_som;