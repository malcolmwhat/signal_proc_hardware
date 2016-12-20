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
		variable ones_count1 : integer range 0 to 15 := 0;
		variable ones_count2 : integer range 0 to 15 := 0;
	begin
		effective_n1 := random_noise(31 downto 16);
		effective_n1 := random_noise(15 downto 0);
		
		-- Combinational loop which removes every `s`th 1, where `s` is 
		-- the integer value given by the evaluation of the switches.
		for i in 0 to 15 loop
			-- Check for a one in the current index.
			if effective_n1(i) = '1' then
				-- If found, increment the counter and check the mod of switches.
				ones_count1 := ones_count1 + 1;
				if (ones_count1 mod switches) = 0 then
					-- If this one's occurence was a multiple of switches, set to 0.
					effective_n1(i) := '0';
				end if;
			end if;
			
			-- Same logic as above but for the second noise vector.
			if effective_n2(i) = '1' then
				ones_count2 := ones_count2 + 1;
				if (ones_count2 mod switches) = 0 then
					effective_n2(i) := '0';
				end if;
			end if;
		end loop;
		
		effective_noise1 <= effective_n1;
		effective_noise2 <= effective_n2;
	end process;
	
	output_code1 <= input_code1 XOR effective_noise1;
	output_code2 <= input_code2 XOR effective_noise2;
end chan;