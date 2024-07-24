library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_somador is
end tb_somador;

architecture arch of tb_somador is
    constant N : integer := 2;
    signal A, B : std_logic_vector(N-1 downto 0);
    signal SUM : std_logic_vector(N downto 0);

    component somador
        generic (
            N : integer
        );
        port (
            A : in std_logic_vector(N-1 downto 0);
            B : in std_logic_vector(N-1 downto 0);
            SUM : out std_logic_vector(N downto 0)
        );
    end component;

begin
    UUT: somador
        generic map (N => N)
        port map (
            A => A,
            B => B,
            SUM => SUM
        );

    -- Processo de estímulo
    stim_proc: process
    begin
        -- teste 1
        A <= "00"; B <= "00";
        wait for 20 ns;
        assert (SUM = "000") report "teste 1 falhou" severity error;
        
        -- teste 2
        A <= "01"; B <= "01";
        wait for 20 ns;
        assert (SUM = "010") report "teste 2 falhou" severity error;
        
        -- teste 3
        A <= "10"; B <= "01";
        wait for 20 ns;
        assert (SUM = "011") report "teste 3 falhou" severity error;
        
        -- teste 4
        A <= "11"; B <= "01";
        wait for 20 ns;
        assert (SUM = "100") report "teste 4 falhou" severity error;
        
        -- teste 5
        A <= "11"; B <= "11";
        wait for 20 ns;
        assert (SUM = "110") report "teste 5 falhou" severity error;

        wait;
    end process;
end architecture;
