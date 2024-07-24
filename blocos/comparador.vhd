library ieee;
use ieee.std_logic_1164.all;

entity comparador is
    generic (
        N : integer
    );
    port (
        X : in std_logic_vector(N-1 downto 0);
        Y : in std_logic_vector(N-1 downto 0);

        X_lt_Y : out std_logic
    );
end comparador;

architecture arch_comp of comparador is
begin
    process (X, Y)
    begin
        if X < Y then
            X_lt_Y <= '1';
        else
            X_lt_Y <= '0';
        end if;
    end process;
end arch_comp;
