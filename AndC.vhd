library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use work.all;

entity andC is			--entradas e saídas do componente "and"
	port(
		a, b : in std_logic_vector(3 downto 0);
		f : out std_logic_vector(3 downto 0)
);
	
end andC;

architecture funcao of andC is
begin
		f <= a and b;	--executa a função and = a * b
end funcao;				--fim do componente "and"