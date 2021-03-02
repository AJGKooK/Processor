-------------------------------------------------------------------------
-- Mason Korkowksi
-- CPRE 381
-- Iowa State University
-------------------------------------------------------------------------
-- NBitRegister.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an NBitRegister
-------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;


entity programCountRegister is
	generic(N : integer := 32);
	port(
		--Inputs to the NBitRegister
		i_D_D	:in std_logic_vector (N-1 downto 0);
		i_D_RST	:in std_logic;
		i_D_CLK	:in std_logic;
		i_D_WE	:in std_logic;
		
		--Outputs from the NBitRegister
		o_D_Q	:out std_logic_vector (N-1 downto 0)
	);
end programCountRegister;

architecture \I<3Nick\ of programCountRegister is
  
	--Link the dffg.vhd to the NBitRegister--
	component dffg
		port(
			--Inputs from the DFF
			i_CLK	:in std_logic;
			i_RST	:in std_logic;
			i_WE	:in std_logic;
			i_D	:in std_logic;
			--Outputs from the DFF
			o_Q	:out std_logic
		);
	end component;
	



begin
	
	--Create N DFFs and dynamically attach signals to Dff pins--
	NDffs : for i in 0 to N-1 generate
		DFFInst : dffg
		port map(
		--  Port  => Signal --
			i_CLK => i_D_CLK,
			i_RST => i_D_RST,
			i_WE => i_D_WE,
			i_D => i_D_D(i),
			o_Q => o_D_Q(i)
		);
		
	end generate NDffs;

	

	
end \I<3Nick\;