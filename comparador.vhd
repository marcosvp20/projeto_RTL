library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Comparador is
    generic (
        N : integer := 2  -- Número de bits (2 a 5)
    );
    port (
        A : in std_logic_vector(N-1 downto 0);
        B : in std_logic_vector(N-1 downto 0);

        A_less_B : out std_logic
    );
end Comparador;

architecture Behavioral of Comparador is
begin
    process (A, B)
    begin
        if A < B then
            A_less_B <= '1';
        else
            A_less_B <= '0';
        end if;
    end process;
end Behavioral;
