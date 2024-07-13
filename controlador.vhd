LIBRARY IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM_Controller is
    generic (
        N : integer range 2 to 5 := 3  -- Largura do registrador de estado (2 a 5 bits)
    );
    port(
        clock  : in std_logic;
        reset  : in std_logic;
        start  : in std_logic;
        i_lt_N : in std_logic;
        B_eq_1 : in std_logic;
        done   : out std_logic;
        i_clear: out std_logic;
        R_clear: out std_logic;
        A_ld   : out std_logic;
        B_ld   : out std_logic;
        R_ld   : out std_logic;
        D_ld   : out std_logic;
        i_count: out std_logic
    );
end FSM_Controller;

architecture arch of FSM_Controller is
    -- Definição dos estados usando um tipo enumerado
    type state_type is (I, S1, S2, S3, S4, S5, S6);
    signal state, next_state : state_type;

begin
    -- Processo de transição de estados
    process(clock, reset)
    begin
        if reset = '1' then
            state <= I;
        elsif rising_edge(clock) then
            state <= next_state;
        end if;
    end process;

    -- Processo de lógica de próxima transição de estado
    process(state, start, i_lt_N, B_eq_1)
    begin
        case state is
            when I =>
                if start = '1' then
                    next_state <= S1;
                else
                    next_state <= I;
                end if;
            when S1 =>
                next_state <= S2;
            when S2 =>
                next_state <= S3;
            when S3 =>
                if B_eq_1 = '1' then
                    next_state <= S4;
                else
                    next_state <= S5;
                end if;
            when S4 =>
                next_state <= S5;
            when S5 =>
                if i_lt_N = '1' then
                    next_state <= S3;
                else
                    next_state <= S6;
                end if;
            when S6 =>
                if start = '1' then
                    next_state <= S6;
                else
                    next_state <= I;
                end if;
            when others =>
                next_state <= I;
        end case;
    end process;

    -- Processo de lógica de saída
    process(state)
    begin
        -- Definir os valores padrão para as saídas
        done <= '0';
        i_clear <= '0';
        R_clear <= '0';
        A_ld <= '0';
        B_ld <= '0';
        R_ld <= '0';
        D_ld <= '0';
        i_count <= '0';

        case state is
            when I =>
                i_clear <= '1';
                R_clear <= '1';
            when S1 =>
                A_ld <= '1';
                done <= '1';
            when S2 =>
                B_ld <= '1';
                done <= '0';
            when S3 =>
                -- Nenhuma ação específica, valores padrão permanecem
            when S4 =>
                R_ld <= '1';
            when S5 =>
                D_ld <= '1';
                i_count <= '1';
            when S6 =>
                done <= '1';
            when others =>
                -- Nenhuma ação específica, valores padrão permanecem
        end case;
    end process;

end arch;
