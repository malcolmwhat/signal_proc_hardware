-- Reconstruction module.
--
-- This module takes the two interpreted outputs for a given channel
-- and reassembles it and pads it with zeros to get back to the 32 bit
-- wide audio signal for the outputs.
--
-- Author: Malcolm Watt

library ieee;
use ieee.std_logic_1164.all;

entity reassembler is
	port(
		clock : in std_logic;
		m_hat1 : in std_logic_vector(4 downto 0);
		m_hat2 : in std_logic_vector(4 downto 0);
		data_out : out std_logic_vector(31 downto 0)
	);
end reassembler;

architecture reassemble of reassembler is
	signal padding : std_logic_vector(21 downto 0) := (others => '0');
	begin
	padding <= (others => '0');
	
	sync_set : process (clock) is
	begin
		if rising_edge(clock) then
			data_out <= padding & m_hat2 & m_hat1;
		end if;
	end process sync_set;
end reassemble;