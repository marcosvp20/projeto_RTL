-- EM CONSTRUCAO



-- library ieee;
-- use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;

-- entity rtl is

-- 	port 
-- 	(	
-- 		MAX10_CLK1_50		: in std_logic;
-- 		KEY	   		: in std_logic_vector (1 downto 0);
-- 		SW	   		: in std_logic_vector (9 downto 0);
-- 		LEDR   		: out std_logic_vector (9 downto 0);
-- 		HEX0					: out std_logic_vector (7 downto 0);
-- 		HEX1 			   	: out std_logic_vector (7 downto 0);
-- 		HEX2			   	: out std_logic_vector (7 downto 0);
-- 		HEX3		   	   : out std_logic_vector (7 downto 0);
-- 		HEX4	   		   : out std_logic_vector (7 downto 0);
-- 		HEX5   			   : out std_logic_vector (7 downto 0)
-- 	);

-- end entity;

-- architecture arch of rtl is

--     signal CLK, Start, Done : std_logic;
--     signal A, B : std_logic_vector(3 downto 0);

--     component controlador is
--         generic (
--             N : integer := 4
--         );
--         port(
--             clock  : in std_logic;
--             reset  : in std_logic;
--             start  : in std_logic;
--             i_lt_N : in std_logic;
--             B_eq_1 : in std_logic;
--             done   : out std_logic;
--             i_clear: out std_logic;
--             R_clear: out std_logic;
--             A_ld   : out std_logic;
--             B_ld   : out std_logic;
--             R_ld   : out std_logic;
--             D_ld   : out std_logic;
--             i_count: out std_logic
--         );
--     end component;

--     begin

--         controlador_inst : controlador
--         port map(
--             clock  => MAX10_CLK1_50,
--             reset  => SW(0),
--             start  => SW(1),
--             i_lt_N => SW(2),
--             B_eq_1 => SW(3),
--             done   => LEDR(0),
--             i_clear=> LEDR(1),
--             R_clear=> LEDR(2),
--             A_ld   => LEDR(3),
--             B_ld   => LEDR(4),
--             R_ld   => LEDR(5),
--             D_ld   => LEDR(6),
--             i_count=> LEDR(7)
--         );

--     clkdiv : process (MAX10_CLK1_50) is
--         variable count : integer range 0 to 50000000;
--     begin
--         if (rising_edge (MAX10_CLK1_50)) then
--             if (count = 50000000) then
--                 CLK <= not CLK;
--                 count := 0;
--             else
--                 count := count + 1;
--             end if;
--         end if;
--     end process;

-- end arch;