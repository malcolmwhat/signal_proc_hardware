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
		data_in : in std_logic_vector(31 downto 0);
		message1 : out std_logic_vector(4 downto 0);
		message2 : out std_logic_vector(4 downto 0);
		message3 : out std_logic_vector(4 downto 0);
		message4 : out std_logic_vector(4 downto 0);
		message5 : out std_logic_vector(4 downto 0);
		message6 : out std_logic_vector(4 downto 0)
	);
end quantizer;


architecture quant of quantizer is
begin
	message1 <= data_in(31 downto 27);
	message2 <= data_in(26 downto 22);
	message3 <= data_in(21 downto 17);
	message4 <= data_in(16 downto 12);
	message5 <= data_in(11 downto 7);
	message6 <= data_in(6 downto 2);
end quant;