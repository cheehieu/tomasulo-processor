-- file: i_fetch_test_stream_instr_stream_pkg.vhd (version: i_fetch_test_stream_instr_stream_pkg_non_aligned_branches.vhd)
-- Written by Gandhi Puvvada
-- date of last rivision: 7/23/2008 
--
-- A package file to define the instruction stream to be placed in the instr_cache.
-- This package, "instr_stream_pkg", is refered in a use clause in the inst_cache_sprom module.
-- We will use several files similar to this containining different instruction streams.
-- The package name will remain the same, namely instr_stream_pkg.
-- Only the file name changes from, say  i_fetch_test_stream_instr_stream_pkg.vhd
-- to say mult_test_stream_instr_stream_pkg.vhd.
-- Depending on which instr_stream_pkg file was analysed/compiled  most recently,
-- that stream will be used for simulation/synthesis.
----------------------------------------------------------
library std, ieee;
use ieee.std_logic_1164.all;

package instr_stream_pkg is

    constant DATA_WIDTH_CONSTANT     : integer := 128; -- data width of of our cache
    constant ADDR_WIDTH_CONSTANT     : integer :=   6; -- address width of our cache

	-- type declarations
	type mem_type is array (0 to (2**ADDR_WIDTH_CONSTANT)-1) of std_logic_vector((DATA_WIDTH_CONSTANT-1) downto 0); 

    ---------------------------------------------------    
    ---------------------------------------------------    
    -- $0 : 0
-- $1 : 1
-- $2 : 2
-- $3 : 3
-- $4 : 4
-- $5 : 5
-- $6 : F0

-- $29: contains fixed bottom of stack for $31 values

	-- The program calculates factorial of the number n
	
	
		-- 		addi $4, $0, n     ---put factorial candidate in $4
		-- 		addi $3, $0, n	 ---put factorial candidate in $3
		-- 		slt $5, $4, $2    ---check if no. is zero or one
		-- 		bne $5, $1, skiptwo ---go ahead if no. is not 0 or 1
		-- 		add $5, $1, $0     ---no. is 0 or 1, ans is 1
		-- 		jump exit1 	--- exit the code. $5 has final ans.
-- skiptwo:		jal subroutine	---calculate factorial. goto function.
		-- 		add $5, $3, $0	---store final ans. in $5
-- exit1:		jr $6	---jump to exit


-- subroutine:	
		-- 		addi $29, $29, -4 --decrement address
		-- 		sw $31,0($29) --put contents of $31 into location pointed by $29
	
		-- 		sub $4, $4, $1	---$4=$4 - 1
		-- 		mul $3, $3, $4	---$3=$3 * $4
		-- 		beq $1, $4, outofloop ---check if $4 has reached 1 
		-- 		jal subroutine; --- if $4 /= 1, do 1 more iteration
		
-- outofloop:	lw $31,0($29)
		-- 		addi $29, $29, 4	
		-- 		jr $31	 ---start exiting the loop
		
	--($6):	
			--	sw $5, 0($29)   -- this sw stores final ans to mem
			--	add $4,$2,$2    -- load 4 into $4
			--	lw $4, 0($4)    -- add large latency in order to stop completion
			--	add $4, $4, $4
			--	add $4, $4, $4
			--	add $4, $4, $4
			--	add $4, $4, $4
			--  jr $4
	--($4):
			-- exit
			
		--- EXPECTED RESULT----
		-- the stream calculates factorial 8 and puts it in $5
		-- $5 is mapped to physical reg 37 
		-- Physical register 37 should be 40320 (d) = 9D80 (H)
				
				
				
    ---------------------------------------------------    
    ---------------------------------------------------    
	signal mem : mem_type := 
	
	( X"14A10002_0082282A_20030008_20040008", -- Loc 0C, 08, 04, 00  bne_slt_addi_addi
	  X"00602820_0C000009_08000008_00202820", -- Loc 1C, 18, 14, 10	 add_jal_jump_add
	  X"00812022_AFBF0000_23BDFFFC_08000020", -- Loc 2C, 28, 24, 20	 sub_sw_addi_jump
	  X"00000020_00000020_10240005_00641819", -- Loc 3C, 38, 34, 30  nop_nop_beq_mul
	  X"00000020_0C000009_00000020_00000020", -- Loc 4C, 48, 44, 40  nop_jal_nop_nop 
	  X"8FBF0000_00000020_00000020_00000020", -- Loc 5C, 58, 54, 50  lw_nop_nop_nop
	  X"00000020_AC0C0020_03E00008_23BD0004", -- Loc 6C, 68, 64, 60  jr_addi
	  X"00000020_00000020_00000020_00000020", -- Loc 7C, 78, 74, 70
    
	 
	  
	  X"00000020_00000020_00000020_00000020", -- Loc 8C, 88, 84, 80
	  X"00000020_00000020_00000020_00000020", -- Loc 9C, 98, 94, 90
	  X"00000020_00000020_00000020_00000020", -- Loc AC, A8, A4, A0
	  X"00000020_00000020_00000020_00000020", -- Loc BC, B8, B4, B0
	  X"00000020_00000020_00000020_00000020", -- Loc CC, C8, C4, C0
	  X"00000020_00000020_00000020_00000020", -- Loc DC, D8, D4, D0
	  X"00000020_00000020_00000020_00000020", -- Loc EC, E8, E4, E0
	  X"00000020_00000020_00000020_00000020", -- Loc FC, F8, F4, F0

	  X"00000020_00000020_00000020_00000020", -- Loc 10C, 108, 104, 100
	  X"00000020_00000020_00000020_00000020", -- Loc 11C, 118, 114, 110
	  X"00000020_00000020_00000020_00000020", -- Loc 12C, 128, 124, 120
	  X"00000020_00000020_00000020_00000020", -- Loc 13C, 138, 134, 130
	  X"00000020_00000020_00000020_00000020", -- Loc 14C, 148, 144, 140
	  X"00000020_00000020_00000020_00000020", -- Loc 15C, 158, 154, 150
	  X"00000020_00000020_00000020_00000020", -- Loc 16C, 168, 164, 160
	  X"00000020_00000020_00000020_00000020", -- Loc 17C, 178, 174, 170

	  X"00000020_00000020_00000020_00000020", -- Loc 18C, 188, 184, 180
	  X"00000020_00000020_00000020_00000020", -- Loc 19C, 198, 194, 190
	  X"00000020_00000020_00000020_00000020", -- Loc 1AC, 1A8, 1A4, 1A0
	  X"00000020_00000020_00000020_00000020", -- Loc 1BC, 1B8, 1B4, 1B0
	  X"00000020_00000020_00000020_00000020", -- Loc 1CC, 1C8, 1C4, 1C0
	  X"00000020_00000020_00000020_00000020", -- Loc 1DC, 1D8, 1D4, 1D0
	  X"00000020_00000020_00000020_00000020", -- Loc 1EC, 1E8, 1E4, 1E0
	  X"00000020_00000020_00000020_00000020", -- Loc 1FC, 1F8, 1F4, 1F0

	  X"00000020_00000020_00000020_00000020", -- Loc 20C, 208, 204, 200
	  X"00000020_00000020_00000020_00000020", -- Loc 21C, 218, 214, 221
	  X"00000020_00000020_00000020_00000020", -- Loc 22C, 228, 224, 220
	  X"00000020_00000020_00000020_00000020", -- Loc 23C, 238, 234, 230
	  X"00000020_00000020_00000020_00000020", -- Loc 24C, 248, 244, 240
	  X"00000020_00000020_00000020_00000020", -- Loc 25C, 258, 254, 250
	  X"00000020_00000020_00000020_00000020", -- Loc 26C, 268, 264, 260
	  X"00000020_00000020_00000020_00000020", -- Loc 27C, 278, 274, 270

	  X"00000020_00000020_00000020_00000020", -- Loc 28C, 288, 284, 280
	  X"00000020_00000020_00000020_00000020", -- Loc 29C, 298, 294, 290
	  X"00000020_00000020_00000020_00000020", -- Loc 2AC, 2A8, 2A4, 2A0
	  X"00000020_00000020_00000020_00000020", -- Loc 2BC, 2B8, 2B4, 2B0
	  X"00000020_00000020_00000020_00000020", -- Loc 2CC, 2C8, 2C4, 2C0
	  X"00000020_00000020_00000020_00000020", -- Loc 2DC, 2D8, 2D4, 2D0
	  X"00000020_00000020_00000020_00000020", -- Loc 2EC, 2E8, 2E4, 2E0
	  X"00000020_00000020_00000020_00000020", -- Loc 2FC, 2F8, 2F4, 2F0

	  X"00000020_00000020_00000020_00000020", -- Loc 30C, 308, 304, 300
	  X"00000020_00000020_00000020_00000020", -- Loc 31C, 318, 314, 331
	  X"00000020_00000020_00000020_00000020", -- Loc 32C, 328, 324, 320
	  X"00000020_00000020_00000020_00000020", -- Loc 33C, 338, 334, 330
	  X"00000020_00000020_00000020_00000020", -- Loc 34C, 348, 344, 340
	  X"00000020_00000020_00000020_00000020", -- Loc 35C, 358, 354, 350
	  X"00000020_00000020_00000020_00000020", -- Loc 36C, 368, 364, 360
	  X"00000020_00000020_00000020_00000020", -- Loc 37C, 378, 374, 370

	  X"00000020_00000020_00000020_00000020", -- Loc 38C, 388, 384, 380
	  X"00000020_00000020_00000020_00000020", -- Loc 39C, 398, 394, 390
	  X"00000020_00000020_00000020_00000020", -- Loc 3AC, 3A8, 3A4, 3A0
	  X"00000020_00000020_00000020_00000020", -- Loc 3BC, 3B8, 3B4, 3B0
	  
	  -- the last 16 instructions are looping ump instructions 
	  X"080000F3_080000F2_080000F1_080000F0", -- Loc 3CC, 3C8, 3C4, 3C0
	  X"080000F7_080000F6_080000F5_080000F4", -- Loc 3DC, 3D8, 3D4, 3D0
	  X"080000FB_080000FA_080000F9_080000F8", -- Loc 3EC, 3E8, 3E4, 3E0
	  X"080000FF_080000FE_080000FD_080000FC"  -- Loc 3FC, 3F8, 3F4, 3F0
	  ) ;
	  -- the last 16 instructions are looping jump instructions
	  -- of the type:   loop: j loop
	  -- This is to make sure that neither instruction fetching 
	  -- nor instruction execution proceeds beyond the end of this memory.
	  
	  -- Loc 3C0 -- 080000F0  =>  J     240	  
	  -- Loc 3C4 -- 080000F1  =>  J     241	  
	  -- Loc 3C8 -- 080000F2  =>  J     242	  
	  -- Loc 3CC -- 080000F3  =>  J     243	
	  --	  
	  -- Loc 3D0 -- 080000F4  =>  J     244	  
	  -- Loc 3D4 -- 080000F5  =>  J     245	  
	  -- Loc 3D8 -- 080000F6  =>  J     246	  
	  -- Loc 3DC -- 080000F7  =>  J     247	
	  --
	  -- Loc 3E0 -- 080000F8  =>  J     248	  
	  -- Loc 3E4 -- 080000F9  =>  J     249	  
	  -- Loc 3E8 -- 080000FA  =>  J     250	  
	  -- Loc 3EC -- 080000FB  =>  J     251	
	  --
	  -- Loc 3F0 -- 080000FC  =>  J     252	  
	  -- Loc 3F4 -- 080000FD  =>  J     253	  
	  -- Loc 3F8 -- 080000FE  =>  J     254	  
	  -- Loc 3FC -- 080000FF  =>  J     255	

end package instr_stream_pkg;

-- -- No need for s package body here
-- package body instr_stream_pkg is
--
-- end package body instr_stream_pkg;  
