library IEEE;
use IEEE.std_logic_1164.all;

entity and_32bit is

  port(i_and_A          : in STD_LOGIC_VECTOR(31 downto 0);
       i_and_B          : in STD_LOGIC_VECTOR(31 downto 0);
       o_and_F          : out STD_LOGIC_VECTOR(31 downto 0));

end and_32bit;

architecture dataflow of and_32bit is
begin

  o_and_F <= i_and_A and i_and_B;
  
end dataflow;