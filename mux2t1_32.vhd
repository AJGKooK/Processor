-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 1/6/20 by H3::Created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2t1_32 is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end mux2t1_32;

architecture structural of mux2t1_32 is

  component mux2to1 is
    port(i_X	: in std_logic;		-- 1st input
		 i_Y	: in std_logic;		-- 2nd input
		 i_S	: in std_logic;		-- Switch input    
		 o_Z	: out std_logic);	-- MUX output
  end component;

begin

  -- Instantiate N mux instances.
  G_NBit_MUX: for i in 0 to N-1 generate
    MUXI: mux2to1 port map(
              i_X      => i_D0(i),      -- All instances share the same select input.
              i_Y     => i_D1(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
              i_S     => i_S,  -- ith instance's data 1 input hooked up to ith data 1 input.
              o_Z      => o_O(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_MUX;
  
end structural;
