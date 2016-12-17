-- Encodes the input message based on the symmetric 16,5,8 encoding scheme.
--
-- Author: Malcolm Watt

library ieee;
use ieee.std_logic_1164.all;

entity encoder is
	port(
		message : in std_logic_vector(4 downto 0);
		codeword : out std_logic_vector(15 downto 0)
	);
end encoder;

architecture enc of encoder is
	-- Define the parities as signals.
	signal p1 : std_logic;
	signal p2 : std_logic;
	signal p3 : std_logic;
	signal p4 : std_logic;
	signal p5 : std_logic;
	signal p6 : std_logic;
	signal p7 : std_logic;
	signal p8 : std_logic;
	signal p9 : std_logic;
	signal p10 : std_logic;
	signal p11 : std_logic;
begin
	p1 <= message(0) XOR message(1) XOR message(2);
	p2 <= message(0) XOR message(1) XOR message(3);
	p3 <= message(0) XOR message(1) XOR message(4);
	p4 <= message(0) XOR message(2) XOR message(3);
	p5 <= message(0) XOR message(2) XOR message(4);
	p6 <= message(0) XOR message(3) XOR message(4);
	p7 <= message(1) XOR message(2) XOR message(3);
	p8 <= message(1) XOR message(2) XOR message(4);
	p9 <= message(1) XOR message(3) XOR message(4);
	p10 <= message(2) XOR message(3) XOR message(4);
	p11 <= message(0) XOR message(1) XOR message(2) XOR message(3) XOR message(4);
	
	codeword <= message & p1 & p2 & p3 & p4 & p5 & p6 & p7 & p8 & p9 & p10 & p11;
end enc; -- encoder