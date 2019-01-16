-- Code your testbench here
   library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

    entity std_lv_dct is
        port (
                clk_in :           in  std_logic;
                load_data :         in  std_logic;
                load_done : out std_logic;
                dct_start : in  std_logic;
                dct_end : out  std_logic;
                d0,d1,d2,d3,d4,d5,d6,d7 :    in  std_logic;
                input_vector: in  std_logic_vector(7 downto 0);
                Done :          out std_logic;
                Dout :          out std_logic_vector(11 downto 0);
             );
    end std_lv_dct;    

	architecture fetch_data of xc9536 is
    	start : bit;
        data_array : bit_vector (0 to 7, 0 to 7); --the block of 8 x 8 pixels
        -- need to store read x, y position, so its able to read next block of pixels
        -- read counter to know when to reset FIFO and get a new frame loaded to FIFO
    begin
    	--reset states
    	load_done => LOW;
    	start => load_data;
        load_done => HIGH;
        
    end architecture fetch_data;

	-- copied code below need to adapt it
    architecture dct_algorithm of xc9536 is
       Dout_int  : integer range 0 to 4095;
       Start_int : bit;
    begin

    -- internal signals as type adapters
    Dout      <= std_logic_vector(to_unsigned(Dout_int),11);
    Start_int <= to_bit(Start);

    -- direct entity instantiation for the real core
    Transform : entity work.dct
        port map(
                Clk   => to_bit(Clk),
                Start => Start_int,
                Din   => to_integer(unsigned(Din)),
                std_logic(Done) => Done,
                Dout => Dout_int
                );

    end architecture dct_algorithm;