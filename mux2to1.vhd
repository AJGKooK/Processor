
library IEEE;
use IEEE.std_logic_1164.all;

entity mux2to1 is

   port(i_X	: in std_logic;		-- 1st input
	i_Y	: in std_logic;		-- 2nd input
	i_S	: in std_logic;		-- Switch input    
	o_Z	: out std_logic);	-- MUX output

end mux2to1;

architecture structure of mux2to1 is

component invg is

  port(i_A	: in std_logic;
       o_F	: out std_logic);

end component;

component andg2

  port(i_A	: in std_logic;
       i_B	: in std_logic;
       o_F	: out std_logic);

end component;

component org2

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;


signal sVALUE_notS : std_logic;
signal sVALUE_andXnS, sVALUE_andYS : std_logic;

begin

  g_notS: invg -- not gate for S'
    port MAP(i_A => i_S,
	     o_F => sVALUE_notS);

  g_andX: andg2	-- 2-in AND gate for X & S'
    port MAP(i_A => i_X,
	     i_B => sVALUE_notS,
	     o_F => sVALUE_andXnS);
 
  g_andY: andg2	-- 2-in AND gate for Y & S
    port MAP(i_A => i_S,
	     i_B => i_Y,
	     o_F => sVALUE_andYS);

  g_orZ: org2	-- 2-in OR gate
    port MAP(i_A => sVALUE_andXnS,
	     i_B => sVALUE_andYS,
	     o_F => o_Z);


end structure;