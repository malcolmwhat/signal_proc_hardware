-- Quantizer Module.
--
-- Quantize a thirty-two bit input downto a 10 bit output.
-- 
-- The purpose of this in the overall system is to take each of the
-- input channels and quantize them down into two `messages` each.
-- Once we have the two five bit messages we will do our processing
-- and error correction on them.
--
-- Author: Malcolm Watt

library ieee;
use ieee.std_logic_1164.all;

entity quantizer is
	port(
		clock : in std_logic;
		data_in : in std_logic_vector(31 downto 0);
		message1 : out std_logic_vector(4 downto 0);
		message2 : out std_logic_vector(4 downto 0)
	);
end quantizer;


architecture quant of quantizer is
begin
	message1 <= data_in(4 downto 0);
	message2 <= data_in(9 downto 5);
end quant;