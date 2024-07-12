library ieee;
use ieee.std_logic_1164.all;

entity contador is
    generic (
        N : integer := 2  -- Número de bits (2 a 5)
    );
    port (
        clk : in std_logic;
        clear : in std_logic;
        count : in std_logic;
        count_out : out std_logic_vector(N-1 downto 0)
    );
end contador;

architecture arch_cont of contador is
    component registrador is
        generic (
            N : integer := 2
        );
        port (
            clk : in std_logic;
            clear : in std_logic;
            load : in std_logic;
            data_in : in std_logic_vector(N-1 downto 0);
            data_out : out std_logic_vector(N-1 downto 0)
        );
    end component;

    signal reg_data : std_logic_vector(N-1 downto 0);
    signal next_count : std_logic_vector(N-1 downto 0);
begin
    u_reg: registrador
        generic map (N => N)
        port map (
            clk => clk,
            clear => clear,
            load => count,  -- Carrega o próximo valor quando count for '1'
            data_in => next_count,
            data_out => reg_data
        );

    process (clk)
    begin
        if rising_edge(clk) then
            if count = '1' then
                next_count <= reg_data + 1;  -- Incrementa o contador
            else
                next_count <= reg_data;  -- Mantém o valor atual
            end if;
        end if;
    end process;

    count_out <= reg_data;
end arch_cont;
