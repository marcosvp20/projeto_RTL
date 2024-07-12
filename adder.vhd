library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder is
    generic (
        N : integer := 2  -- Número de bits (2 a 5)
    );
    port (
        A : in std_logic_vector(N-1 downto 0);
        B : in std_logic_vector(N-1 downto 0);
        SUM : out std_logic_vector(N downto 0);
    );
end adder;

architecture architecture of adder is
begin
    process (A, B)
    begin
        SUM <= ('0' & A) + ('0' & B);
    end process;
end architecture;
