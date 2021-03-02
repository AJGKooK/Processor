-- This is the right logical barrel shifter
-- Finished and working


library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity shift32_right is
	port(
		i_barlr : in STD_LOGIC_VECTOR(31 downto 0);
		i_swlr : in STD_LOGIC_VECTOR(4 downto 0);
		o_barlr : out STD_LOGIC_VECTOR(31 downto 0));
	end shift32_right;
	
architecture shift32_right of shift32_right is
begin

		with i_swlr select 
			o_barlr <= '0' & i_barlr(31 downto 1) when "00000",
			"00" & i_barlr(31 downto 2) when "00001",
			"000" & i_barlr(31 downto 3) when "00010",
			"0000" & i_barlr(31 downto 4) when "00011",
			"00000" & i_barlr(31 downto 5) when "00100",
			"000000" & i_barlr(31 downto 6) when "00101",
			"0000000" & i_barlr(31 downto 7) when "00110",
			"00000000" & i_barlr(31 downto 8) when "00111",
			"000000000" & i_barlr(31 downto 9) when "01000",								
			"0000000000" & i_barlr(31 downto 10) when "01001",
		    "00000000000" & i_barlr(31 downto 11) when "01010",
			"000000000000" & i_barlr(31 downto 12) when "01011",
			"0000000000000" & i_barlr(31 downto 13) when "01100",
			"00000000000000" & i_barlr(31 downto 14) when "01101",
			"000000000000000" & i_barlr(31 downto 15) when "01110",
			"0000000000000000" & i_barlr(31 downto 16) when "01111",	
			"00000000000000000" & i_barlr(31 downto 17) when "10000",								
			"000000000000000000" & i_barlr(31 downto 18) when "10001",
			"0000000000000000000" & i_barlr(31 downto 19) when "10010",
			"00000000000000000000" & i_barlr(31 downto 20) when "10011",
			"000000000000000000000" & i_barlr(31 downto 21) when "10100",
			"0000000000000000000000" & i_barlr(31 downto 22) when "10101",
			"00000000000000000000000" & i_barlr(31 downto 23) when "10110",
			"000000000000000000000000" & i_barlr(31 downto 24) when "10111",
			"0000000000000000000000000" & i_barlr(31 downto 25) when "11000",									
			"00000000000000000000000000" & i_barlr(31 downto 26) when "11001",
			"000000000000000000000000000" & i_barlr(31 downto 27) when "11010",
			"0000000000000000000000000000" & i_barlr(31 downto 28) when "11011",
			"00000000000000000000000000000" & i_barlr(31 downto 29) when "11100",
			"000000000000000000000000000000" & i_barlr(31 downto 30) when "11101",
			"0000000000000000000000000000000" & i_barlr(31) when "11110",
			"00000000000000000000000000000000" when "11111",
			i_barlr when others;			
		
end shift32_right;
			