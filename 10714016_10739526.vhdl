-- libraries
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- entity
entity project_reti_logiche is
    port (
        i_clk : in std_logic;
        i_rst : in std_logic;
        i_start : in std_logic;
        i_w : in std_logic;
        o_z0 : out std_logic_vector(7 downto 0);
        o_z1 : out std_logic_vector(7 downto 0);
        o_z2 : out std_logic_vector(7 downto 0);
        o_z3 : out std_logic_vector(7 downto 0);
        o_done : out std_logic;
        o_mem_addr : out std_logic_vector(15 downto 0);
        i_mem_data : in std_logic_vector(7 downto 0);
        o_mem_we : out std_logic;
        o_mem_en : out std_logic
    );
end project_reti_logiche;

-- architecture
architecture behavioral of project_reti_logiche is
begin
process(i_clk) is
    variable state : std_logic_vector(1 downto 0);
    variable in_portsel : std_logic_vector(1 downto 0);
    variable in_address : std_logic_vector(15 downto 0);
    variable old_z0 : std_logic_vector(7 downto 0);
    variable old_z1 : std_logic_vector(7 downto 0);
    variable old_z2 : std_logic_vector(7 downto 0);
    variable old_z3 : std_logic_vector(7 downto 0);
begin            
o_mem_en <= '1';
o_mem_we <= '0';
o_mem_addr <= in_address;
            
-- RESET 1
if i_rst = '1' then
    state := "00";
    in_address := "0000000000000000";
    in_portsel := "00";
    old_z0 := "00000000";
    old_z1 := "00000000";
    old_z2 := "00000000";
    old_z3 := "00000000";
    o_z3 <= "00000000";
    o_z0 <= "00000000";     
    o_z1 <= "00000000";
    o_z2 <= "00000000";
    o_z3 <= "00000000";
    o_mem_addr <= "0000000000000000";
    o_mem_en <= '1';
    o_mem_we <= '0';
    o_done <= '0';  
else                  

    -- RESET 0
    if i_clk'event and i_clk='1' then
        case state is
         
            -- state 00
            -- First port bit input
            when "00" =>
                o_done <= '0';
                o_z0 <= "00000000";
                o_z1 <= "00000000";
                o_z2 <= "00000000";
                o_z3 <= "00000000";
                in_address := "0000000000000000";
                in_portsel := "00";
                if i_start = '1' then
                    state := "01";
                    if i_w = '1' then 
                        in_portsel := "01";
                    else
                        n_portsel := "00";
                    end if;
                end if;

            -- state 01
            -- Second port bit input
            when "01" =>
                state := "10";
                if i_w = '1' then 
                    in_portsel := std_logic_vector((unsigned(in_portsel) sll 1) + "01");
                else
                    in_portsel := std_logic_vector(unsigned(in_portsel) sll 1);
                end if;
        
            -- state 10
            -- Memory address input
            when "10" =>
                if i_start = '0' then
                    state := "11";
                else
                    if i_w = '1' then 
                        in_address := std_logic_vector((unsigned(in_address) sll 1) + "0000000000000001");
                    else
                        in_address := std_logic_vector(unsigned(in_address) sll 1);
                    end if;
                end if;
        
            -- state 11
            -- Show output
            when "11" =>
                o_done <= '1';
                if in_portsel = "00" then
                    o_z0 <= i_mem_data;
                    old_z0:= i_mem_data;
                else 
                    o_z0 <= old_z0; 
                end if;
                if in_portsel = "01" then
                    o_z1 <= i_mem_data;
                    old_z1:= i_mem_data;
                else 
                    o_z1 <= old_z1; 
                end if;
                if in_portsel = "10" then
                    o_z2 <= i_mem_data;
                    old_z2 := i_mem_data;
                else 
                    o_z2 <= old_z2; 
                end if;
                if in_portsel = "11" then
                    o_z3 <= i_mem_data;
                    old_z3 := i_mem_data;
                else 
                    o_z3 <= old_z3; 
                end if;
            state := "00";

            -- (only for debugging)    
            when others => state := "11";

        end case;
    end if;
end if;
end process;
end behavioral; 
