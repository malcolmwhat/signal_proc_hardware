-- Apply random noise to the different codes.
--
-- Author: Malcolm Watt

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity channel is
	port(
		input_code1 : in std_logic_vector(15 downto 0);
		input_code2 : in std_logic_vector(15 downto 0);
		random_noise : in std_logic_vector(31 downto 0);
		noise_control : in std_logic_vector(2 downto 0);
		output_code1 : out std_logic_vector(15 downto 0);
		output_code2 : out std_logic_vector(15 downto 0)
	);
end channel;

architecture chan of channel is
	signal effective_noise1 : std_logic_vector(15 downto 0) := (others => '0');
	signal effective_noise2 : std_logic_vector(15 downto 0) := (others => '0');
	signal switches : integer range 0 to 7;
begin
	switches <= to_integer(unsigned(noise_control));
	
	-- Controls for the error channel.
	process (input_code1, input_code2, random_noise, noise_control) is
		variable effective_n1 : std_logic_vector(15 downto 0);
		variable effective_n2 : std_logic_vector(15 downto 0);
		variable intermediate1 : std_logic_vector(15 downto 0) := (others => '0');
		variable intermediate2 : std_logic_vector(15 downto 0) := (others => '0');
		variable ones_count1 : integer range 0 to 15 := 0;
		variable ones_count2 : integer range 0 to 15 := 0;
	begin
		effective_n1 := random_noise(31 downto 16);
		effective_n1 := random_noise(15 downto 0);
		
		for i in 0 to 15 loop
			if ((i mod switches) = 0) then
				intermediate1(i) := effective_n1(i);
				intermediate2(i) := effective_n2(i);
			else
				intermediate1(i) := '0';
				intermediate2(i) := '0';
			end if;
		end loop;
		
		effective_noise1 <= intermediate1;
		effective_noise2 <= intermediate2;
	end process;
	
	output_code1 <= input_code1 XOR effective_noise1;
	output_code2 <= input_code2 XOR effective_noise2;
end chan;