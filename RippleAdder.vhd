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


entity Ripple_Adder is
	generic(N : integer := 32);
	port(
		--Inputs to the NbitAdder
		Xin	:in std_logic_vector (N-1 downto 0);
		Yin	:in std_logic_vector (N-1 downto 0);
		Cin	:in std_logic;
		
		--Outputs from the Adder
		Sout	:out std_logic_vector (N-1 downto 0);
		Cout	:out std_logic
	);
end Ripple_Adder;

architecture \I<3Nick\ of Ripple_Adder is
  
	--Link the FullAdder.vhd to the Ripple Adder--
	component FullAdder
		port(
			--Inputs from the Full Adder
			iX	:in std_logic;
			iY	:in std_logic;
			iC	:in std_logic;
			--Outputs from the Full Adder
			oS	:out std_logic;
			oC	:out std_logic
		);
	end component;
	
	--Add Signals that will link the multiple Adders together
	signal Carry 	: std_logic_vector(N downto 0);
	signal SUM	: std_logic_vector(N-1 downto 0);


begin
	

	Carry(0) <= Cin;
	Cout <= Carry(N);
	
	NbitAdder : for i in 0 to N-1 generate
		i_FullAdder : FullAdder
		port map(
			iX => Xin(i),
			iY => Yin(i),
			iC => Carry(i),
			oS => SUM(i),
			oC => Carry(i+1)
		);
		
	end generate NbitAdder;

	SumBits : for i in 0 to N-1 generate
		Sout(i) <= SUM(i);
	end generate SumBits;
	

	
end \I<3Nick\;