library IEEE;
use IEEE.std_logic_1164.all;

entity not_32bit is

  port(i_not32_A          : in STD_LOGIC_VECTOR(31 downto 0);
       o_not32_F          : out STD_LOGIC_VECTOR(31 downto 0));

end not_32bit;

architecture dataflow of not_32bit is
begin

  o_not32_F <= not i_not32_A;
  
end dataflow;