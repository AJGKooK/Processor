library IEEE;
use IEEE.std_logic_1164.all;

entity complement is
  generic(N : integer := 32);
  port(i_D  : in std_logic_vector(N-1 downto 0);
       o_O  : out std_logic_vector(N-1 downto 0));

end complement;

architecture structure of complement is

component invg
  port(i_A  : in std_logic;
       o_F  : out std_logic);
end component;

begin

G1: for i in 0 to N-1 generate
  inv_i: invg
    port map(i_A  => i_D(i),
  	          o_F  => o_O(i));
end generate;

  
end structure;