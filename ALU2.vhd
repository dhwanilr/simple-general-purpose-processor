LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ALU2 IS
    PORT (
        A, B       : IN  UNSIGNED(7 DOWNTO 0);
        OP         : IN  UNSIGNED(15 DOWNTO 0);
        Neg        : OUT STD_LOGIC;
        R1         : OUT UNSIGNED(3 DOWNTO 0);
        R2         : OUT UNSIGNED(3 DOWNTO 0)
    );
END ALU2;

ARCHITECTURE Behavior OF ALU2 IS
    SIGNAL Result : UNSIGNED(7 DOWNTO 0) := (OTHERS => '0');
BEGIN

    PROCESS (A, B, OP)
    BEGIN
        -- default
        Result <= (OTHERS => '0');
        Neg    <= '0';   -- ALU2 never uses Neg but required by entity

        CASE OP IS

            WHEN "0000000000000001" =>  
                -- Invert bit-significance order of Reg1 (= A)
                Result <= A(0) & A(1) & A(2) & A(3) & A(4) & A(5) & A(6) & A(7);

            WHEN "0000000000000010" =>
                -- Shift A left by 4, input bit = 1
                Result <= A(3 downto 0) & "1111";

            WHEN "0000000000000100" =>
                -- Invert upper 4 bits of B
                Result <= NOT(B(7 downto 4)) & B(3 downto 0);

            WHEN "0000000000001000" =>
                -- Min(A, B)
                IF A < B THEN
                    Result <= A;
                ELSE
                    Result <= B;
                END IF;

            WHEN "0000000000010000" =>
                -- A + B + 4
                Result <= A + B + "0100";

            WHEN "0000000000100000" =>
                -- Increment A by 3
                Result <= A + "0011";

            WHEN "0000000001000000" =>
                -- Replace even bits of A with even bits of B
                -- (7,5,3,1 from B)
                Result <= B(7) & A(6) & B(5) & A(4) & B(3) & A(2) & B(1) & A(0);

            WHEN "0000000010000000" =>
                -- XNOR
                Result <= NOT(A XOR B);

            WHEN "0000000100000000" =>
                -- Rotate B right by 3
                Result <= B(2 downto 0) & B(7 downto 3);

            WHEN OTHERS =>
                Result <= (OTHERS => '0');

        END CASE;
    END PROCESS;

    -- output split
    R1 <= Result(3 DOWNTO 0);
    R2 <= Result(7 DOWNTO 4);

END Behavior;
