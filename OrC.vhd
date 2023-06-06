library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.all;

entity orC is
	port(
		a, b : in std_logic_vector(3 downto 0);	--entradas e saídas do componente "or"
		f : out std_logic_vector(3 downto 0)		
);
	
end OrC;

architecture funcao of orC is
	begin
		f <= a or b; 		--executa a função or = a + b
end funcao;					--fim do componente