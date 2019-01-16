library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity xc9536 is
	port (
			clk_in :           in  std_logic;
			--data events
			load_data :         in  std_logic;
			load_done : out std_logic;
			--dct events
			dct_start : in  std_logic;
			dct_end : out  std_logic;
			--parallel data pins
			d0,d1,d2,d3,d4,d5,d6,d7 :    in  std_logic;
			input_vector: in  std_logic_vector(0 to 7); --change to (7 downto 0) if bits need to be inverted 
			Done :          out std_logic;
			Dout :          out std_logic_vector(0 to 11);
		 );
end entity xc9536;    


architecture hybrid of xc9536 is
	input_data : bit_vector (0 to 7, 0 to 7); --the block of 8 x 8 pixels
	output_data : bit_vector (0 to 7, 0 to 7); --the block of 8 x 8 pixels
	-- need to store read x, y position, so its able to read next block of pixels
-- read counter to know when to reset FIFO and get a new frame loaded to FIFO
begin
	fetch_data : process(load_data, ) is
	begin
		--cycle thru fifo, fetch a 8x8 block, then enable dct_algorithm
		if load_data = HIGH then
			for I in 0 to 7 loop
				if (A = I) then
					--load fifo data
				end if;
			end loop;
			load_done <= HIGH;
		end if;
	end process fetch_data;
	
	dct_algorithm : process(dct_start, load_done, input_data) is
	begin
		--apply dct algorithm and output data
		if (dct_start = high) and (load_done = high) then 
			-- do dct
			-- send data
		end if;
	end process fetch_data;

end architecture hybrid;
