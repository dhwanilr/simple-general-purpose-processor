LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sseg2 IS
  PORT(
    yn_flag     : IN  STD_LOGIC;        -- '1' = Y, '0' = N
    digit_leds  : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)  -- 7-segment display
  );
END sseg2;

ARCHITECTURE Behavior OF sseg2 IS
BEGIN
  PROCESS(yn_flag)
  BEGIN
    IF yn_flag = '1' THEN
      digit_leds <= "1000100"; 
    ELSE
      digit_leds <= "0001001"; 
    END IF;
  END PROCESS;
END Behavior;
