library IEEE;
use IEEE.std_logic_1164.all;

entity or_32bit is

  port(i_or32_A          : in STD_LOGIC_VECTOR(31 downto 0);
       i_or32_B          : in STD_LOGIC_VECTOR(31 downto 0);
       o_or32_F          : out STD_LOGIC_VECTOR(31 downto 0));

end or_32bit;

architecture dataflow of or_32bit is
begin

  o_or32_F <= i_or32_A or i_or32_B;
  
end dataflow;