library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is

	port 
	(	
		MAX10_CLK1_50		: in std_logic;
		KEY	   		: in std_logic_vector (1 downto 0);
		SW	   		: in std_logic_vector (9 downto 0);
		LEDR   		: out std_logic_vector (9 downto 0);
		HEX0					: out std_logic_vector (7 downto 0);
		HEX1 			   	: out std_logic_vector (7 downto 0);
		HEX2			   	: out std_logic_vector (7 downto 0);
		HEX3		   	   : out std_logic_vector (7 downto 0);
		HEX4	   		   : out std_logic_vector (7 downto 0);
		HEX5   			   : out std_logic_vector (7 downto 0)
	);

end entity;

architecture arch of top_level is

    signal CLK, Start, Reset, Done : std_logic;
    signal A, B : std_logic_vector(4 downto 0);
    signal Result : std_logic_vector(9 downto 0);
    signal N : integer := A'left - A'right + B'left - B'right + 2;

    component controlador is
        generic (
            N : integer := 2
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

    begin
        LEDR(9) <= CLK;
        LEDR(8) <= Done;
        A <= SW (4 downto 0);
        B <= SW (4 downto 0);

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

    clkdiv : process (MAX10_CLK1_50) is
        variable count : integer range 0 to 29999999;
    begin
        if (rising_edge (MAX10_CLK1_50)) then
            if (count = 29999999) then
                CLK <= not CLK;
                count := 0;
            else
                count := count + 1;
            end if;
        end if;
    end process;

    process(Result)
        variable digit1, digit2, digit3 : std_logic_vector(3 downto 0);
    begin
        digit1 := Result(9 downto 6);
        digit2 := Result(5 downto 2);
        digit3 := Result(1 downto 0);

        HEX0 <= decode_digit(digit1);
        HEX1 <= decode_digit(digit2);
        HEX2 <= decode_digit(digit3);
        HEX3 <= "1111111";
        HEX4 <= "1111111";
        HEX5 <= "1111111";
    end process;

    function decode_digit(digit : std_logic_vector(3 downto 0)) return std_logic_vector is
        variable segment : std_logic_vector(6 downto 0);
    begin
        case digit is
            when "0000" => segment := "0000001";
            when "0001" => segment := "1001111";
            when "0010" => segment := "0010010";
            when "0011" => segment := "0000110";
            when "0100" => segment := "1001100";
            when "0101" => segment := "0100100";
            when "0110" => segment := "0100000";
            when "0111" => segment := "0001111";
            when "1000" => segment := "0000000";
            when "1001" => segment := "0000100";
            when others => segment := "1111111";
        end case;

        return segment;
    end function;
end arch;