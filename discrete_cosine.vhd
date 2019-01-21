use IEEE.numeric_std.all;

entity xc9536 is
port (
	clk                    : in  std_logic;
	--data events
	load_data              : in  std_logic;
	load_done              : out std_logic;
	--dct events
	dct_start              : in  std_logic;
	dct_end                : out  std_logic;
	data_out               : out std_logic_vector(11 downto 0); --output data with MSB first
	--al422b connection pins
	d0,d1,d2,d3,d4,d5,d6,d7: in  std_logic_vector(7 downto 0); --assuming al422b outputs bytes with MSB first 
	not_output_enable      : out std_logic;
	write_clk              : out std_logic;
	not_write_reset        : out std_logic;
	not_write_enable       : out std_logic;
	read_clk               : out std_logic;
	not_read_reset         : out std_logic;
	not_read_enable        : out std_logic;
 );
end entity xc9536;    


architecture hybrid of xc9536 is
	clock_input : clk;
	--define a row to store the 8bit pixels coming from al422
	type pixel_row is array (0 to 7) of std_logic_vector (7 downto 0);
	--define the 2d array of pixels
	type pixel_array is array (0 to 7) of pixel_row (0 to 7);
	input_data : pixel_array; --the block of 8 x 8 pixels
	
	type output_data_array is array(0 to 7) of std_logic_vector(0 to 7);
	output_data : output_data_array; --output array
	pointer_position : integer
	-- need to store read x, y position, so its able to read next block of pixels
	-- read counter to know when to reset FIFO and get a new frame loaded to FIFO
begin
	clock : process(clk_in) is
	begin
		
	end process clock;

	fetch_data : process(load_data, d0,d1,d2,d3,d4,d5,d6,d7) is
	begin
		--cycle thru fifo, fetch a 8x8 block, then enable dct_algorithm
		if (load_data = HIGH) then
			for I in 0 to 7 loop
				
				not_read_enable => low;
				--load fifo data
				input_data(I)(0) <= d0;
				input_data(I)(1) <= d1;
				input_data(I)(2) <= d2;
				input_data(I)(3) <= d3;
				input_data(I)(4) <= d4;
				input_data(I)(5) <= d5;
				input_data(I)(6) <= d6;
				input_data(I)(7) <= d7;
				if (I != 7) then
					for X in 0 to 639 loop
						--pulse read clock
						read_clk <= high;
						--maybe a delay will be needed here, or wait for clk
						read_clk <= low;
						--cycle to the next line in the frame
					end loop;
				end if;
			end loop;
			--set a position counter
			--reset read pointer
			not_read_reset <= LOW;
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
	end process dct_algorithm;

end architecture hybrid;
