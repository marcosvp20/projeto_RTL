library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity datapath is
    generic (
        N : integer := 2
    );
    
    port(
        clk : in std_logic;

        I_clr : in std_logic;
        I_cnt : in std_logic;
        I_lt_N : out std_logic;

        Result_clr: in std_logic;
        Result_ld : in std_logic;
        Result : out std_logic_vector(2*N-1 downto 0); -- Ajuste aqui

        B : in std_logic_vector(N-1 downto 0);
        B_clr : in std_logic;
        B_ld : in std_logic;
        B_eq_1 : out std_logic;

        A : in std_logic_vector(N-1 downto 0);
        A_clr : in std_logic;
        A_ld : in std_logic;
        A_sh_l : in std_logic
    );
end entity;

architecture arch of datapath is
    signal I : std_logic_vector (N-1 downto 0);
    signal B_out : std_logic_vector(N-1 downto 0);
    signal A_out : std_logic_vector(N-1 downto 0);
    signal parcial_result : std_logic_vector(2*N-1 downto 0); -- Ajuste aqui
    signal result_out : std_logic_vector(N-1 downto 0);
    signal N_vetor : std_logic_vector(N-1 downto 0) := std_logic_vector(to_unsigned(N, N));

    component somador is
        generic (
            N : integer := 2
        );
        port (
            A : in std_logic_vector(N-1 downto 0);
            B : in std_logic_vector(N-1 downto 0);
            SUM : out std_logic_vector(N downto 0)
        );
    end component;

    component comparador is
        generic (
            N : integer := 2
        );
        port (
            X : in std_logic_vector(N-1 downto 0);
            Y : in std_logic_vector(N-1 downto 0);
            X_lt_Y : out std_logic
        );
    end component;

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

    component regishifter is
        generic (
            N : integer := 2
        );
        port (
            clk : in std_logic;
            clear : in std_logic;
            load : in std_logic;
            shift_left : in std_logic;
            data_in : in std_logic_vector(N-1 downto 0);
            data_out : out std_logic_vector(N-1 downto 0)
        );
    end component;

    component contador is
        generic (
            N : integer := 2
        );
        port (
            clk : in std_logic;
            clear : in std_logic;
            count : in std_logic;
            count_out : out std_logic_vector(N-1 downto 0)
        );
    end component;

begin
    I_cnt_comp: contador
    generic map (N => N)
    port map(
        clk => clk,
        clear => I_clr,
        count => I_cnt,
        count_out => I
    );
    
    B_reg : registrador
    generic map (N => N)
    port map(
        clk => clk,
        clear => B_clr,
        load => B_ld,
        data_in => B,
        data_out => B_out
    );

    A_regsh : regishifter
    generic map (N => N)
    port map(
        clk => clk,
        clear => A_clr,
        load => A_ld,
        shift_left => A_sh_l,
        data_in => A,
        data_out => A_out
    );

    Result_reg : registrador
    generic map (N => N)
    port map(
        clk => clk,
        clear => Result_clr,
        load => Result_ld,
        data_in => parcial_result(N-1 downto 0),  -- Ajuste o comprimento
        data_out => result_out
    );

    Sum : somador
    generic map (N => N)
    port map(
        A => A_out,
        B => result_out,
        SUM => parcial_result(N downto 0)
    );

    I_eq_N : comparador
    generic map (N => N)
    port map(
        X => I,
        Y => N_vetor,
        X_lt_Y => I_lt_N
    );

    B_eq_1 <= B_out(N-1);

end architecture;
