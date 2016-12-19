-- Apply random noise to the different codes.
--
-- Author: Malcolm Watt

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity channel is
	port(
		input_code : in std_logic_vector(15 downto 0);
		random_noise : in std_logic_vector(31 downto 0);
		noise_control : in std_logic_vector(2 downto 0);
		output_code : out std_logic_vector(15 downto 0)
	);
end channel;

architecture chan of channel is
	signal effective_noise : std_logic_vector(15 downto 0) := (others => '0');
	signal switches : integer range 0 to 7;
begin
	-- Controls for the error channel.
	process (input_code, random_noise, noise_control) is
	begin
		switches <= to_integer(unsigned(noise_control));
		effective_noise <= (others => '0');
		for i in 0 to 8 loop
			if switches < i then
				effective_noise(i) <= '1';
			end if;
		end loop;
	end process;
	
	output_code <= input_code;
end chan;