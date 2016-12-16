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
		quantized_data : out std_logic_vector(9 downto 0)
	);
end quantizer;


architecture quant of quantizer is
begin
	-- Synchronously set the output to the first 10 bits of the input.
	set_output : process(rising_edge(clock))
	begin
		quantized_data <= data_in(9 downto 0);
	end process;
end quant;