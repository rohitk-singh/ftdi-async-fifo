--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:28:07 09/10/2015
-- Design Name:   
-- Module Name:   /home/rohit/AcademicResearch/hardware/FT2232H_Async_FIFO/testbench/tb_ft2232h.vhd
-- Project Name:  FT2232H_Async_FIFO
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ft2232h
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_ft2232h IS
END tb_ft2232h;
 
ARCHITECTURE behavior OF tb_ft2232h IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ft2232h
    PORT(
         clk : IN  std_logic;
         rst : IN std_logic;
         data : INOUT  std_logic_vector(7 downto 0);
         rxf_n : IN  std_logic;
         txe_n : IN  std_logic;
         rd_n : OUT  std_logic;
         wr_n : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal rxf_n : std_logic := '1';
   signal txe_n : std_logic := '0';

	--BiDirs
   signal data : std_logic_vector(7 downto 0);

 	--Outputs
   signal rd_n : std_logic;
   signal wr_n : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ft2232h PORT MAP (
          rst => rst,
          clk => clk,
          data => data,
          rxf_n => rxf_n,
          txe_n => txe_n,
          rd_n => rd_n,
          wr_n => wr_n
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;
      rxf_n <= '0';
      
      wait until rd_n = '0';
      data <= "XXXXXXXX";
      wait for 14 ns;
      data <= x"A5";
      
      wait until rd_n = '1';
      data <= "XXXXXXXX";
      wait for 14 ns;
      data <= (others => '0');
      rxf_n <= '1';

      wait for 49 ns;
      
      rxf_n <= '0';
      
      wait until rd_n = '0';
      data <= "XXXXXXXX";
      wait for 14 ns;
      data <= x"5A";
      
      wait until rd_n = '1';
      data <= "XXXXXXXX";
      wait for 14 ns;
      data <= (others => '0');
      rxf_n <= '1';
      -- insert stimulus here 

      wait;
   end process;

END;
