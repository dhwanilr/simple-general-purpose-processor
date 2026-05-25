LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALU IS
    PORT (
        A, B       : IN  UNSIGNED(7 DOWNTO 0);
        OP         : IN  UNSIGNED(15 DOWNTO 0);
        Neg        : OUT STD_LOGIC;
        R1         : OUT UNSIGNED(3 DOWNTO 0);  -- lower 4 bits
        R2         : OUT UNSIGNED(3 DOWNTO 0)   -- upper 4 bits
    );
END ALU;

ARCHITECTURE Behavior OF ALU IS
    SIGNAL Result : UNSIGNED(7 DOWNTO 0);
    SIGNAL Neg_s  : STD_LOGIC := '0';
BEGIN

    PROCESS (A, B, OP)
    BEGIN
        -- Default
        Result <= (OTHERS => '0');
        Neg_s  <= '0';

        CASE OP IS

            WHEN "0000000000000001" =>  -- Addition
                Result <= A + B;

            WHEN "0000000000000010" =>  -- Subtraction
                IF (A < B) THEN
                    Neg_s  <= '1';
                    Result <= B - A;
                ELSE
                    Neg_s  <= '0';
                    Result <= A - B;
                END IF;

            WHEN "0000000000000100" =>  -- NOT
                Result <= NOT(A);

            WHEN "0000000000001000" =>  -- NAND
                Result <= NOT(A AND B);

            WHEN "0000000000010000" =>  -- NOR
                Result <= NOT(A OR B);

            WHEN "0000000000100000" =>  -- AND
                Result <= A AND B;

            WHEN "0000000001000000" =>  -- XOR
                Result <= A XOR B;

            WHEN "0000000010000000" =>  -- OR
                Result <= A OR B;

            WHEN "0000000100000000" =>  -- XNOR
                Result <= NOT(A XOR B);

            WHEN OTHERS =>
                Result <= (OTHERS => '0');
                Neg_s  <= '0';

        END CASE;
    END PROCESS;

    -- Output split
    R1 <= Result(3 DOWNTO 0);
    R2 <= Result(7 DOWNTO 4);
    Neg <= Neg_s;

END Behavior;
