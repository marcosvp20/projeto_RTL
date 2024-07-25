library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is
    port 
    (    
        MAX10_CLK1_50 : in std_logic;
        KEY : in std_logic_vector (1 downto 0);
        SW : in std_logic_vector (9 downto 0);
        LEDR : out std_logic_vector (9 downto 0);
        HEX0 : out std_logic_vector (7 downto 0);
        HEX1 : out std_logic_vector (7 downto 0);
        HEX2 : out std_logic_vector (7 downto 0);
        HEX3 : out std_logic_vector (7 downto 0);
        HEX4 : out std_logic_vector (7 downto 0);
        HEX5 : out std_logic_vector (7 downto 0)
    );
end entity;

architecture arch of top_level is

    signal CLK, Start, Reset, Done : std_logic;
    signal A, B : std_logic_vector(N-1 downto 0); -- Valores de A (multiplicando) e B (multiplicador)
    signal Result : std_logic_vector((N*2)-1 downto 0); -- Registrador do resultado
    constant N : integer := 5; -- Parâmetro N (n° de bits)

    component controlador is
        generic (
            N : integer 
        );
        port(
            clock : in std_logic;
            reset : in std_logic;
            start : in std_logic;
            A : in std_logic_vector(N-1 downto 0);
            B : in std_logic_vector(N-1 downto 0);
            done : out std_logic;
            Result : out std_logic_vector(2*N-1 downto 0)
        );
    end component;

    -- Função de decodificação para display de segmentos
    function decode_digit(digit : std_logic_vector(3 downto 0)) return std_logic_vector is
        variable segment : std_logic_vector(7 downto 0);
    begin
        case digit is
            when "0000" => segment := "00000001";  -- 0
            when "0001" => segment := "10011111";  -- 1
            when "0010" => segment := "00100100";  -- 2
            when "0011" => segment := "00001100";  -- 3
            when "0100" => segment := "10011000";  -- 4
            when "0101" => segment := "01001000";  -- 5
            when "0110" => segment := "01000000";  -- 6
            when "0111" => segment := "00011111";  -- 7
            when "1000" => segment := "00000000";  -- 8
            when "1001" => segment := "00001000";  -- 9
            when others => segment := "11111111";  -- Todos segmentos desligados
        end case;
        return segment;
    end function;

begin
    -- Ligações dos signals à placa
    LEDR(9) <= CLK;
    LEDR(8) <= Done;
    A <= SW(N-1 downto 0);
    B <= SW(N+4 downto 5);
    Reset <= KEY(0);
    Start <= KEY(1);

    -- Intanciação do controlador
    controlador_inst : controlador
        generic map(
            N => N
        )
        port map(
            clock => CLK,
            reset => Reset,
            start => Start,
            A => A,
            B => B,
            done => Done,
            Result => Result
        );

    -- Definição do ciclo de clock
    clkdiv : process (MAX10_CLK1_50)
        variable count : integer range 0 to 29999999;
    begin
        if (rising_edge(MAX10_CLK1_50)) then
            if (count = 29999999) then
                CLK <= not CLK;
                count := 0;
            else
                count := count + 1;
            end if;
        end if;
    end process;

    -- Decodificação no display do resultado
    process(Result)
        variable digit1, digit2, digit3 : std_logic_vector(3 downto 0);
    begin
        digit1 := Result(9 downto 6);
        digit2 := Result(5 downto 2);
        digit3 := Result(1 downto 0) & "00";  -- Ajuste para 4 bits

        HEX0 <= decode_digit(digit1);
        HEX1 <= decode_digit(digit2);
        HEX2 <= decode_digit(digit3);
        HEX3 <= "11111111";  -- Todos segmentos desligados
        HEX4 <= "11111111";  -- Todos segmentos desligados
        HEX5 <= "11111111";  -- Todos segmentos desligados
    end process;

end architecture;
