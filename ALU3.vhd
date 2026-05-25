LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALU3 IS
    PORT (
        A          : IN  UNSIGNED(7 DOWNTO 0);
        Student_id : IN  UNSIGNED(3 DOWNTO 0);
        OP         : IN  UNSIGNED(15 DOWNTO 0);
        Reg1_out   : OUT STD_LOGIC
    );
END ALU3;

ARCHITECTURE Behavior OF ALU3 IS
    SIGNAL A_high, A_low : UNSIGNED(3 DOWNTO 0);
BEGIN

    -- Split A into upper and lower 4 bits
    A_high <= A(7 DOWNTO 4);
    A_low  <= A(3 DOWNTO 0);

    PROCESS (A, Student_id, OP)
    BEGIN
        -- Default output
        Reg1_out <= '0';

        CASE OP IS
            WHEN "0000000000000001" |
                 "0000000000000010" |
                 "0000000000000100" |
                 "0000000000001000" |
                 "0000000000010000" |
                 "0000000000100000" |
                 "0000000001000000" |
                 "0000000010000000" |
                 "0000000100000000" =>

                -- Compare halves of A with Student_id
                IF (A_high > Student_id) OR (A_low > Student_id) THEN
                    Reg1_out <= '1';   -- Meaning "yes"
                ELSE
                    Reg1_out <= '0';   -- Meaning "no"
                END IF;

            WHEN OTHERS =>
                Reg1_out <= '0';
        END CASE;
    END PROCESS;

END Behavior;
