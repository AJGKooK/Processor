
library IEEE;
use IEEE.std_logic_1164.all;

entity signBit is

   port(i_sb	: in std_logic_vector(31 downto 0);		-- input
	o_sb		: out std_logic);						-- output

end signBit;

architecture structure of signBit is

begin

    o_sb <= i_sb(31);

end structure;