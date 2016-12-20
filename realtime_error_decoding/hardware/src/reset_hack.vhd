-- Filname says it all.

library ieee;
use ieee.std_logic_1164.all;

entity reset_hack is
	port(
		input : in std_logic_vector(2 downto 0);
		output : out std_logic
	);
end reset_hack;

architecture r_h of reset_hack is
begin
	output <= input(0);
end r_h;