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
		f : out std_logic_vector(3 downto 0)
);
end Projeto_ALU;

architecture funcao of Projeto_ALU is
																	--declaração dos componentes que serão utilizados no projeto
component andC 												--realiza a operação and com 2 numeros de 4 bits e tem como resultado um numero de 4 bits; and = (a and b)
		port(
			a, b : in std_logic_vector(3 downto 0);
			f : out std_logic_vector(3 downto 0)
		);
end component andC;
	
component orC 													--realiza a operação or com 2 numeros de 4 bits e tem como resultado um numero de 4 bits; or = (a or b)
	port(
			a, b : in std_logic_vector(3 downto 0);
			f : out std_logic_vector(3 downto 0)
		);
end component orC;
	
component somador 											--soma dois numeros de 4 bits e devolve 1 : (a + b)
	port(
		a, b : in std_logic_vector(3 downto 0);
		sel : in std_logic;
		f : out std_logic_vector(3 downto 0);
		cout, overflow : out std_logic);
end component somador;
																	--declaração dos sinais utilizados
signal somaR, subR, andR, orR, fR : std_logic_vector(3 downto 0);		
signal somaCout, somaover, somaZERO, somaNeg: std_logic;				
signal subCout, subover, subZERO, subNeg: std_logic;
signal andZERO, andNeg: std_logic;
signal orZERO, orNeg: std_logic;
	
begin
	somadorPM : somador port map(a, b, '0', somaR, somaCout, somaover);
	subtPM : somador port map(a, b, '1', subR, subCout, subover);
	andCPM : andC port map(a, b, andR);
	orCPM : orC port map(a, b, orR);
		
	with s select
		fR <= somaR when "00",								--resultados das operações
				subR when "01", 
				andR when "10",
				orR when others;
				  
	with s select 
		c <= somaCout when "00",							--lógica da saída c: 
				subCout when "01",
				'0' when others;
		
	with s select 
		v <= somaover when "00",							--lógica da saída v: 
				subover when "01",
				'0' when others;
				  
f <= fR;
n <= fR(3);														--lógica da saída n:
z <= not(fR(0) or fR(1) or fR(2) or fR(3));        --lógica da saída z: 
end funcao;