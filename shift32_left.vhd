-- This is the left logical barrel shifter

library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity shift32_left is
	port(
		i_barll : in STD_LOGIC_VECTOR(31 downto 0);
		i_swll : in STD_LOGIC_VECTOR(4 downto 0);
		o_barll : out STD_LOGIC_VECTOR(31 downto 0));
	end shift32_left;
	
architecture shift32_left of shift32_left is
begin
		with i_swll select 
			o_barll <= i_barll(30 downto 0) & '0' when "00000",
			i_barll(29 downto 0) & "00" when "00001",
			i_barll(28 downto 0) & "000" when "00010",
			i_barll(27 downto 0) & "0000" when "00011",
			i_barll(26 downto 0) & "00000" when "00100",
			i_barll(25 downto 0) & "000000" when "00101",
			i_barll(24 downto 0) & "0000000" when "00110",
			i_barll(23 downto 0) & "00000000" when "00111",
			i_barll(22 downto 0) & "000000000" when "01000",								
			i_barll(21 downto 0) & "0000000000" when "01001",
		    i_barll(20 downto 0) & "00000000000" when "01010",
			i_barll(19 downto 0) & "000000000000" when "01011",
			i_barll(18 downto 0) & "0000000000000" when "01100",
			i_barll(17 downto 0) & "00000000000000" when "01101",
			i_barll(16 downto 0) & "000000000000000" when "01110",
			i_barll(15 downto 0) & "0000000000000000" when "01111",	
			i_barll(14 downto 0) & "00000000000000000" when "10000",								
			i_barll(13 downto 0) & "000000000000000000" when "10001",
			i_barll(12 downto 0) & "0000000000000000000" when "10010",
			i_barll(11 downto 0) & "00000000000000000000" when "10011",
			i_barll(10 downto 0) & "000000000000000000000" when "10100",
			i_barll(9 downto 0) & "0000000000000000000000" when "10101",
			i_barll(8 downto 0) & "00000000000000000000000" when "10110",
			i_barll(7 downto 0) & "000000000000000000000000" when "10111",
			i_barll(6 downto 0) & "0000000000000000000000000" when "11000",									
			i_barll(5 downto 0) & "00000000000000000000000000" when "11001",
			i_barll(4 downto 0) & "000000000000000000000000000" when "11010",
			i_barll(3 downto 0) & "0000000000000000000000000000" when "11011",
			i_barll(2 downto 0) & "00000000000000000000000000000" when "11100",
			i_barll(1 downto 0) & "000000000000000000000000000000" when "11101",
			i_barll(0) & "0000000000000000000000000000000" when "11110",
			"00000000000000000000000000000000" when "11111",
			i_barll when others;
			
end shift32_left;
			