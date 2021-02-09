----------------------------------------------------------------------------------
-- Projeto: Processador simplificado
-- modulo: CPU completa - placa Starter KIT Spartan 3 Xilinx
-- Prof. Pedro l. benko - FEI - 2011
-- topo de arquitetura: cpu_1.vhd
-- 08/2011
-- Acrescido uma lógica para debounce do bpush-button "run"
---------------------------------------------------------------------------------
-- Gerado por	"Quartus II" a partir de primitivas vhd e esquema de arquitetura
-- VERSION		"Version 9.1 Build 350 03/24/2010 Service Pack 2 SJ Web Edition"
-- CREATED		"Thu Aug 25 16:28:14 2011"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY cpu IS 
	PORT
	(
		ck :  IN  STD_LOGIC; 
		rst :  IN  STD_LOGIC;
		run :  IN  STD_LOGIC;
		ch :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		leds :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END cpu; 

ARCHITECTURE bdf_type OF cpu IS 

COMPONENT ram
	PORT(rdram : IN STD_LOGIC;
		 wrram : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 Addram : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 datain : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 dataout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT es
	PORT(clock : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 en_in : IN STD_LOGIC;
		 en_out : IN STD_LOGIC;
		 chaves : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Regs : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 IO_entrada : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Leds : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux_cpu
	PORT(ALU_REGa : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 ES : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 instrucao : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 mem : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 sel_mux : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 Muxout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT pcounter
	PORT(clock : IN STD_LOGIC;
		 PCld : IN STD_LOGIC;
		 PCinc : IN STD_LOGIC;
		 PCclr : IN STD_LOGIC;
		 PCin : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 PCout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT regs
	PORT(clock : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 RFwe : IN STD_LOGIC;
		 RFr1e : IN STD_LOGIC;
		 RFr2e : IN STD_LOGIC;
		 RFr1a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 RFr2a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 RFw : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 RFwa : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 RFr1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 RFr2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT controle
	PORT(clock : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 Run : IN STD_LOGIC;
		 Instrucao_word : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 Status_crtl : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 RFwe_crtl : OUT STD_LOGIC;
		 RFr1e_crtl : OUT STD_LOGIC;
		 RFr2e_crtl : OUT STD_LOGIC;
		 ENin_crtl : OUT STD_LOGIC;
		 ENout_crtl : OUT STD_LOGIC;
		 PCinc_ctrl : OUT STD_LOGIC;
		 PCclr_ctrl : OUT STD_LOGIC;
		 PCload_crtl : OUT STD_LOGIC;
		 RDram_crtl : OUT STD_LOGIC;
		 WRram_crtl : OUT STD_LOGIC;
		 Mre_ctrl : OUT STD_LOGIC;
		 ALUop_crtl : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		 mux_crtl : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 RFr1a_crtl : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 RFr2a_crtl : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 RFwa_crtl : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT prom
	PORT(clock : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 Mre : IN STD_LOGIC;
		 address : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 instr : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT alu_1
	PORT(clock : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 ALU_op : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 REGb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 REGc : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 REGa : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 STATUS : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT debounce
	PORT(pb : IN STD_LOGIC;
		 clock : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 pb_rise : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	adpc :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	ALU_op :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL	en_in :  STD_LOGIC;
SIGNAL	en_out :  STD_LOGIC;
SIGNAL	entr :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	instr :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	mem :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	mre :  STD_LOGIC;
SIGNAL	PCclr :  STD_LOGIC;
SIGNAL	PCinc :  STD_LOGIC;
SIGNAL	PCld :  STD_LOGIC;
SIGNAL	rdram :  STD_LOGIC;
SIGNAL	REGa :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	REGb :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	REGc :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	RFr1a :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	RFr1e :  STD_LOGIC;
SIGNAL	RFr2a :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	RFr2e :  STD_LOGIC;
SIGNAL	RFw :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	RFwa :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	rfwe :  STD_LOGIC;
SIGNAL	run_en :  STD_LOGIC;
SIGNAL	sel_mux :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	STATUS :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	wrram :  STD_LOGIC;


BEGIN 



b2v_inst : ram
PORT MAP(rdram => rdram,
		 wrram => wrram,
		 clk => ck,
		 Addram => instr(7 DOWNTO 0),
		 datain => REGb,
		 dataout => mem);


b2v_inst1 : es
PORT MAP(clock => ck,
		 reset => rst,
		 en_in => en_in,
		 en_out => en_out,
		 chaves => ch,
		 Regs => REGb,
		 IO_entrada => entr,
		 Leds => leds);


b2v_inst2 : mux_cpu
PORT MAP(ALU_REGa => REGa,
		 ES => entr,
		 instrucao => instr(7 DOWNTO 0),
		 mem => mem,
		 sel_mux => sel_mux,
		 Muxout => RFw);


b2v_inst3 : pcounter
PORT MAP(clock => ck,
		 PCld => PCld,
		 PCinc => PCinc,
		 PCclr => PCclr,
		 PCin => instr(7 DOWNTO 0),
		 PCout => adpc);


b2v_inst4 : regs
PORT MAP(clock => ck,
		 rst => rst,
		 RFwe => rfwe,
		 RFr1e => RFr1e,
		 RFr2e => RFr2e,
		 RFr1a => RFr1a,
		 RFr2a => RFr2a,
		 RFw => RFw,
		 RFwa => RFwa,
		 RFr1 => REGb,
		 RFr2 => REGc);


b2v_inst5 : controle
PORT MAP(clock => ck,
		 rst => rst,
		 Run => run_en,
		 Instrucao_word => instr,
		 Status_crtl => STATUS,
		 RFwe_crtl => rfwe,
		 RFr1e_crtl => RFr1e,
		 RFr2e_crtl => RFr2e,
		 ENin_crtl => en_in,
		 ENout_crtl => en_out,
		 PCinc_ctrl => PCinc,
		 PCclr_ctrl => PCclr,
		 PCload_crtl => PCld,
		 RDram_crtl => rdram,
		 WRram_crtl => wrram,
		 Mre_ctrl => mre,
		 ALUop_crtl => ALU_op,
		 mux_crtl => sel_mux,
		 RFr1a_crtl => RFr1a,
		 RFr2a_crtl => RFr2a,
		 RFwa_crtl => RFwa);


b2v_inst6 : prom
PORT MAP(clock => ck,
		 rst => rst,
		 Mre => mre,
		 address => adpc,
		 instr => instr);


b2v_inst7 : alu_1
PORT MAP(clock => ck,
		 reset => rst,
		 ALU_op => ALU_op,
		 REGb => REGb,
		 REGc => REGc,
		 REGa => REGa,
		 STATUS => STATUS);


b2v_inst8 : debounce
PORT MAP(pb => run,
		 clock => ck,
		 reset => rst,
		 pb_rise => run_en);


END bdf_type;