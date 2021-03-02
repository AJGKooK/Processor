library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signExtender is 
    port( 
			i_D0 : in std_logic_vector(15 downto 0);
			o_D0 : out std_logic_vector(31 downto 0)
		);
end signExtender;
architecture \I<3NickMore\ of signExtender is 

begin
	process(i_D0)

begin
    o_D0(15 downto 0) <= i_D0;
	o_D0(31 downto 16) <= (31 downto 16 => i_D0(15));
	
end process;     
end \I<3NickMore\;