library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use work.all;

entity somador is
	port(
		a, b : in std_logic_vector(3 downto 0);
		sel : in std_logic;
		f : out std_logic_vector(3 downto 0);
		cout, overflow : out std_logic
	);
	
end somador;

architecture funcao of somador is
	
signal soma : std_logic_vector(4 downto 0);      --5 bits
	
begin
	with sel select
			soma <= ('0' & a) + b when '0',         --soma
			        ('0' & a) + (-b) when others;   --soma com -b

		f <= soma(3 downto 0);                     --os 4 bits menos significativos serão o resultado
		cout <= soma(4);                           --bit mais significativo no carry out
		overflow <= soma(4) xor a(3) xor b(3) xor soma(3);
end funcao;