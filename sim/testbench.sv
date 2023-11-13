// Code your testbench here
// or browse Examples
`define REG_ADDR_WIDTH 5

module testbench;
  parameter PC_WIDTH = 32;
  parameter INS_WIDTH = 32;
  parameter REG_WIDTH = 32;
  parameter IMMFULLWIDTH = 19;
  parameter TOTAL_REGS = 32;

  parameter REG_ADDR_WIDTH = 5;
  logic resetn;
  logic clk;
  
  logic [REG_WIDTH-1:0] regRdData1;
  logic [REG_WIDTH-1:0] regRdData2;
 
  
  logic [REG_WIDTH-1:0] memrdData;
  
  logic [INS_WIDTH-1:0] InstrData;
  
  logic [REG_ADDR_WIDTH-1:0] regWrAdr;
  logic [REG_ADDR_WIDTH-1:0] regRdAdr1;
  logic [REG_ADDR_WIDTH-1:0] regRdAdr2;
  logic regWE;
  logic [REG_WIDTH-1:0] regWrData;
    
  logic [PC_WIDTH-1:0] memAdr;
  logic [REG_WIDTH-1:0] memwrData;
  logic memWE;
  
  logic [PC_WIDTH-1:0] InstrAdr;
  
  reg [INS_WIDTH-1:0] Iram [0:1023];
  logic [REG_WIDTH-1:0] regs [0:TOTAL_REGS-1];
  logic [REG_WIDTH-1:0] Dram[0:4095];
  
  riscvCpu RV32UI (.*);
  
  always forever #5 clk = ~clk;
  
  initial begin
    //#1500;
    $dumpfile("dump.vcd"); $dumpvars;
    #10000 $finish;
  end
  
  initial begin
    resetn=1;
    clk = 0;
    //    stall = 0;
    
    $readmemh ("custom.hex", Iram); //branch // testsw.vec
    $readmemh ("regfile", regs);  
    
    // For Custom Tests
    Dram['h2114 >>2] = 'h00ff00ff;
    Dram['h208c >>2] = 'hff00ff00;
    
    // Custom Test Init Ends
    
    #20 resetn = 0;
    #60 resetn = 1;
    print_regs;
  
    repeat (4) @(posedge clk);   
    
    $display ("Initialization Done");

    repeat (10) @ (posedge clk);
    
    do  @(posedge clk) ; while ( (regs[7] != 'h5a5) && ( regs[7] != 'ha5) );
    
    if (regs[7] == 'h5a5 ) $display ("Test passed");
    else $display ("Test Failed");
    $display ("%0t Test completed", $time);
    repeat (5) @ (posedge clk);
    print_regs;
    $finish;
    
  end
  
  //IRAM Model
  
  assign InstrData = Iram [InstrAdr>>2];

  // Dram Model  
  always @(posedge clk) memrdData <= Dram[memAdr>>2];
  always @(posedge clk) if (memWE) Dram[memAdr>>2] <= memwrData;
  
  // Reg Model
  assign regRdData1 = regs[regRdAdr1];
  assign regRdData2 = regs[regRdAdr2];
  
  always @(posedge clk) begin
    if (regWE ) begin
      regs[regWrAdr] <= regWrData;
    
      $display("time = %0t", $time);
     // print_regs;
      
    end 
  end
  
  task print_regs;
    $display ("time = %t", $time);
    for (int i=0; i<4; i++) begin
        $display ("x%0d = %0x, x%0d = %0x; x%0d = %0x, x%0d = %0x, x%0d = %0x, x%0d = %0x, x%0d = %0x, x%0d = %0x",
                  i*8, regs[i*8], i*8+1, regs[i*8+1], i*8+2, regs[i*8+2], i*8+3, regs[i*8+3], 
                  i*8+4, regs[i*8+4], i*8+5, regs[i*8+5], i*8+6, regs[i*8+6], i*8+7, regs[i*8+7]);
       //$display ("x%0d = %x", i, regs[i]);
       end 
  endtask
  
endmodule
