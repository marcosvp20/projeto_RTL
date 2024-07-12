library ieee;
use ieee.std_logic_1164.all;

entity comparador is
    generic (
        N : integer := 2
    );
    port (
        A : in std_logic_vector(N-1 downto 0);
        B : in std_logic_vector(N-1 downto 0);

        A_less_B : out std_logic
    );
end comparador;

architecture arch_comp of comparador is
begin
    process (A, B)
    begin
        if A < B then
            A_less_B <= '1';
        else
            A_less_B <= '0';
        end if;
    end process;
end arch_comp;
