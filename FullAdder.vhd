-------------------------------------------------------------------------
-- Mason Korkowksi
-- CPRE 381
-- Iowa State University
-------------------------------------------------------------------------
-- OnesComp.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a Ones Complementer 
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;

entity fullAdder is
	port(
		--Inputs to the Adder
		iX	:in std_logic;
		iY	:in std_logic;
		iC	:in std_logic;
		
		--Outputs from the Adder
		oS	:out std_logic;
		oC	:out std_logic
	);
end fullAdder;

architecture \I<3Nick\ of fullAdder is
begin
	oC <= (iX and iC)or(iX and iY)or(iY and iC);
	oS <= (iX xor iY xor iC);
end \I<3Nick\;