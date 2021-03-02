
library IEEE;
use IEEE.std_logic_1164.all;

entity oneto32bit is

   port(i_ot32b	: in std_logic;							-- input
	o_ot32b		: out std_logic_vector(31 downto 0));	-- output

end oneto32bit;

architecture structure of oneto32bit is

begin

    o_ot32b <= "0000000000000000000000000000000" & i_ot32b;

end structure;