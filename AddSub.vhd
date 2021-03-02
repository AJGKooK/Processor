library IEEE;
use IEEE.std_logic_1164.all;


entity AddSub is
	generic(N : integer := 32);
	port(
		--Inputs
		i_D_0	:in std_logic_vector (N-1 downto 0);
		i_D_1	:in std_logic_vector (N-1 downto 0);
		i_S_Sub	:in std_logic;
		
		--Outputs
		o_D_Sum		:out std_logic_vector (N-1 downto 0);
		o_D_Cout	:out std_logic
	);
end AddSub;

architecture \I<3Nick\ of AddSub is
	Signal Complemented 	: std_logic_vector (N-1 downto 0);
	Signal MuxOut		: std_logic_vector (N-1 downto 0);


	component Ripple_Adder
		port(
			--Inputs to the NbitAdder
			Xin	:in std_logic_vector (N-1 downto 0);
			Yin	:in std_logic_vector (N-1 downto 0);
			Cin	:in std_logic;
		
			--Outputs from the Adder
			Sout	:out std_logic_vector (N-1 downto 0);
			Cout	:out std_logic
		);
	end component;

	component complement
		port(
			i_D  : in std_logic_vector(N-1 downto 0);
       			o_O  : out std_logic_vector(N-1 downto 0)
		);
	end component;

	component mux2t1_N
		port(
			i_S          : in std_logic;
       			i_D0         : in std_logic_vector(N-1 downto 0);
       			i_D1         : in std_logic_vector(N-1 downto 0);
       			o_O          : out std_logic_vector(N-1 downto 0)
		);
	end component;

begin
complement1: complement
	port MAP(
		i_D 	=> i_D_1,
		o_O 	=> Complemented
	);

MuxN1: mux2t1_N
	port MAP(
		i_S 	=> i_S_Sub,
		i_D0 	=> i_D_1,
		i_D1 	=> Complemented,
		o_O 	=> MuxOut
	);

Ripple_Adder1: Ripple_Adder
	port MAP(
		Xin 	=> i_D_0,
		Yin 	=> MuxOut,
		Cin 	=> i_S_Sub,
		Sout 	=> o_D_Sum,
		Cout 	=> o_D_Cout
	);
end \I<3Nick\;
