LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controlador is
    -- Fazer logica do N
    -- generic (
    --     N : integer range 2 to 5 := 3  -- Largura do registrador de estado (2 a 5 bits)
    -- );
    port(
        clock  : in std_logic;
        reset  : in std_logic;
        start  : in std_logic;
        i_lt_N : in std_logic;
        B_eq_1 : in std_logic;
        A      : in std_logic_vector (3 downto 0);
        B      : in std_logic_vector (3 downto 0);
        done   : out std_logic;
        i_clear: out std_logic;
        R_clear: out std_logic;
        A_ld   : out std_logic;
        A_clr  : out std_logic;
        A_sh_l : out std_logic;
        B_ld   : out std_logic;
        B_clr  : out std_logic;
        R_ld   : out std_logic;
        i_count: out std_logic;
        Result : out std_logic_vector (4 downto 0)
    );
end controlador;

architecture arch of controlador is
    -- Definição dos estados usando um tipo enumerado
    type state_type is (I, S1, S2, S3, S4, S5, S6);
    signal state, next_state : state_type;

    component datapath is
        port(
            N : in integer;
            clk : in std_logic;

            I_clr : in std_logic;
            I_cnt : in std_logic;
            I_lt_N : out std_logic;

            Result_clr: in std_logic;
            Result_ld : in std_logic;
            Result : out std_logic_vector(N-1 downto 0);

            B : in std_logic_vector(N-1 downto 0);
            B_clr : in std_logic;
            B_ld : in std_logic;
            B_eq_1 : out std_logic;

            A : in std_logic_vector(N-1 downto 0);
            A_clr : in std_logic;
            A_ld : in std_logic;
            A_sh_l : in std_logic
        );
    end component;

begin

    datapath_inst : datapath
    port map(
        N => N,
        clk => clock,
        I_clr => i_clear,
        I_cnt => i_count,
        I_lt_N => i_lt_N,
        Result_clr => R_clear,
        Result_ld => R_ld,
        Result => Result,
        B => B,
        B_clr => B_clr,
        B_ld => B_ld,
        B_eq_1 => B_eq_1,
        A => A,
        A_clr => A_clr,
        A_ld => A_ld,
        A_sh_l => A_sh_l
    );
    -- Processo de transição de estados
    sync_proc : process(clock, reset)
    begin
        if reset = '1' then
            state <= I;
        elsif rising_edge(clock) then
            state <= next_state;
        end if;
    end process;

    comb_proc : process(state, start, i_lt_N, B_eq_1)
    begin
        case state is
            when I =>
                i_clear <= '1';
                R_clear <= '1';
                
                if start = '1' then
                    next_state <= S1;
                else
                    next_state <= I;
                end if;
            when S1 =>
                A_ld <= '1';
                done <= '1';

                if start = '1' then
                    next_state <= S1;
                else
                    next_state <= S2;
                end if;
            when S2 =>
                done <= '0';
                B_ld <= '1';

                if start = '1' then
                    next_state <= S3;
                else
                    next_state <= S2;
                end if;
            when S3 =>
                if B_eq_1 = '1' then
                    next_state <= S4;
                else
                    next_state <= S5;
                end if;
            when S4 =>
                R_ld <= '1';

                next_state <= S5;
            when S5 =>
                A_sh_l <= '1';
                i_count <= '1';

                if i_lt_N = '1' then
                    next_state <= S3;
                else
                    next_state <= S6;
                end if;
            when S6 =>
                done <= '1';
                
                if start = '1' then
                    next_state <= S6;
                else
                    next_state <= I;
                end if;
            when others =>
                next_state <= I;
        end case;
    end process;

end arch;
