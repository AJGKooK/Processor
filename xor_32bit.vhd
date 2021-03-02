library IEEE;
use IEEE.std_logic_1164.all;

entity xor_32bit is

  port(i_xor_A          : in STD_LOGIC_VECTOR(31 downto 0);
       i_xor_B          : in STD_LOGIC_VECTOR(31 downto 0);
       o_xor_F          : out STD_LOGIC_VECTOR(31 downto 0));

end xor_32bit;

architecture dataflow of xor_32bit is
begin

  o_xor_F <= i_xor_A xor i_xor_B;
  
end dataflow;