--Nome: Lucas Pegoraro Marzochi 
--RA:22009005
library ieee;													--bibliotecas que foram usadas
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.all;

entity Projeto_ALU is
	port(
		a, b : in std_logic_vector(3 downto 0);		--entradas e saídas do projeto
		s : in std_logic_vector(1 downto 0);
		z, c, v, n : out std_logic;
		f : out std_logic_vector(3 downto 0));
end Projeto_ALU;

architecture funcao of Projeto_ALU is					--declaração dos componentes que serão utilizados no projeto
component andC 												--realiza a operação lógica and com 2 numeros de 4 bits e tem como resultado um numero de 4 bits; and = (a and b)
		port(
			a, b : in std_logic_vector(3 downto 0);
			f : out std_logic_vector(3 downto 0));
end component andC;
	
component orC 													--realiza a operação lógica or com 2 numeros de 4 bits e tem como resultado um numero de 4 bits; or = (a or b)
	port(
			a, b : in std_logic_vector(3 downto 0);
			f : out std_logic_vector(3 downto 0));
end component orC;
	
component somador 											--soma dois numeros de 4 bits e devolve 1 : (a + b)
	port(
		a, b : in std_logic_vector(3 downto 0);
		s0 : in std_logic;
		f : out std_logic_vector(3 downto 0);
		cout, over : out std_logic);
end component somador;
																	
signal somaR, subR, andR, orR, fR : std_logic_vector(3 downto 0);		
signal somaCout, somaover, somaZERO, somaNeg: std_logic;				
signal subCout, subover, subZERO, subNeg: std_logic;
signal andZERO, andNeg: std_logic;
signal orZERO, orNeg: std_logic;
	
begin
	somadorPM : somador port map(a, b, '0', somaR, somacout, somaover);	--port map usando o componente "somador"
	subtPM : somador port map(a, b, '1', subR, subcout, subover);			--port map usando o componente "somador" dessa vez para subtrair
	andCPM : andC port map(a, b, andR);												--port map usando o comjponenet "and"
	orCPM : orC port map(a, b, orR);													--port map usando o componente "or"
		
with s select
		fR <= somaR when "00",								--quando s = 00 => soma
				subR when "10", 								--quando s = 10 => subtrai
				andR when "01",								--quando s = 01 => and
				orR when others;								--quando s = 11 (others) => or
				  
n <= fR(3);													--lógica saída n: último bit = 1 => negativo
				 
with s select 
		c <=  somacout when "00",						--lógica saída c: ? (errado)
				subcout when "01",
				'0' when others;
				
z <= not(fR(0) or fR(1) or fR(2) or fR(3));		--lógica saída z: caso todos os bits sejam iguas a 0 z = 1
		
with s select
		v <=  somaover when "00",							--lógica saída v: caso ocorra overflow v = 1
				subover when "01",
				'0' when others;		  
f <= fR; 														--saída F => resultado da operação 
end funcao;														--fim do projeto