library IEEE;
use IEEE.std_logic_1164.all;

entity ControlLogic is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
	port(	i_OpCode		: in std_logic_vector(5 downto 0);
			i_Function		: in std_logic_vector(5 downto 0);
			i_Overflow		: in std_logic;
			o_RD			: out std_logic;
			o_RW			: out std_logic;
			o_MW			: out std_logic;
			o_MR			: out std_logic;
			o_AS			: out std_logic;
			o_AC			: out std_logic_vector(3 downto 0);
			o_ML			: out std_logic;
			o_B				: out std_logic;
			o_BS			: out std_logic;
			o_J				: out std_logic;
			o_RPC			: out std_logic;
			o_PCR			: out std_logic;
			o_RA			: out std_logic;
			o_O				: out std_logic
		);

end ControlLogic;

architecture \I<3NickMore\ of ControlLogic is
signal s_inputs		: std_logic_vector(11 downto 0);
signal s_ouputs		: std_logic_vector(15 downto 0);

begin
	process(i_OpCode,i_Function)
begin
	--combine variables to one
    s_inputs(11 downto 6) <= i_OpCode;
	s_inputs(5 downto 0) <= i_Function;
	-- Overflow output will always be 0 unless specified (e.g. add)
	o_O <= '0';
	-- where all the assingment is done
	case s_inputs is
		when "000000100000" => -- add
			s_outputs <= "0100001000000000";
			o_O <= i_Overflow;
		when "000000100001" => -- addu
			s_outputs <= "0100001000000000";
		when "000000100010" => -- sub
			s_outputs <= "0100001010000000"
			o_O <= i_Overflow;
		when "000000100011" => -- subu
			s_outputs <= "0100001010000000";
		when "000000100100" => -- and
			s_outputs <= "0100010100000000";
		when "000000100101" => -- or
			s_outputs <= "0100011110000000";
		when "000000100111" => -- nor
			s_outputs <= "0100011100000000";
		when "000000100110" => -- xor
			s_outputs <= "0100010110000000";
		when "000000101010" => -- slt
			s_outputs <= "0100001110000000";
		when "000000101011" => -- sltu
			s_outputs <= "0100001100000000";
		when "000000000000" => -- sll
			s_outputs <= "1100100100000000";
		when "000000000010" => -- srl
			s_outputs <= "1100110000000000";
		when "000000000011" => -- sra
			s_outputs <= "1100100000000000";
		when "000000000100" => -- sllv
			s_outputs <= "0100000100000000";
		when "000000000110" => -- srlv
			s_outputs <= "0100010000000000";
		when "000000000111" => -- srav
			s_outputs <= "0100000000000000";
		when "000000001000" => -- jr
			s_outputs <= "0000000000001100";
		when "000010000000" => -- j
			s_outputs <= "0000000000001000";
		when "000011000000" => -- jal
			s_outputs <= "0100000000001011";
		when "000100000000" => -- beq
			s_outputs <= "0000001010110000";
		when "000101000000" => -- bne
			s_outputs <= "0000001010100000";
		when "001000000000" => -- addi
			s_outputs <= "1100101000000000";
			o_0 <= i_Overflow;
		when "001001000000" => -- addiu
			s_outputs <= "1100101000000000";
		when "100011000000" => -- lw
			s_outputs <= "1101000001000000";
		when "001010000000" => -- slti
			s_outputs <= "1100101110000000";
		when "001011000000" => -- sltiu
			s_outputs <= "1100101100000000";
		when "001100000000" => -- andi
			s_outputs <= "1100110100000000";
		when "001101000000" => -- ori
			s_outputs <= "1100111110000000";
		when "001110000000" => -- xori
			s_outputs <= "1100110110000000";
		when "001111000000" => -- lui
			s_outputs <= "1100111000000000";
		when "101011000000" => -- sw
			s_outputs <= "1001000000000000";
		when others =>
			s_outputs <= "0000000000000000"; -- if this happes, we are very sad bois... idk ask Duwe what Duwe (do we) do
	end case;
	-- s_output to outputs
	o_RD  <= s_outputs(15);
	o_RW  <= s_outputs(14);
	o_MW  <= s_outputs(13);
	o_MR  <= s_outputs(12);
	o_AS  <= s_outputs(11);
	o_AC  <= s_outputs(10 downto 7);
	o_ML  <= s_outputs(6);
	o_B   <= s_outputs(5);
	o_BS  <= s_outputs(4);
	o_J   <= s_outputs(3);
	o_RPC <= s_outputs(2);
	o_PCR <= s_outputs(1);
	o_RA  <= s_outputs(0);
end process;
end \I<3NickMore\;