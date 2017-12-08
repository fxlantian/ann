interface spi_slave
  #(
    parameter period = 50ns
  );

  timeunit      1ns;
  timeprecision 1ps;

  localparam SPI_STD     = 2'b00;
  localparam SPI_QUAD_TX = 2'b01;
  localparam SPI_QUAD_RX = 2'b10;

  logic       clk;
  logic [3:0] sdo;
  logic [3:0] sdi;
  logic       csn;
  logic [1:0] padmode;

  //---------------------------------------------------------------------------
  // Slave Tasks
  //---------------------------------------------------------------------------
  task wait_csn(logic csn_in);
    if (csn_in) begin
      if (~csn)
        wait(csn);
    end else begin
      if (csn)
        wait(~csn);
    end
  endtask

  task send(input logic use_quad, input logic data[]);
    for (int i = data.size()-1; i >= 0; i--)
    begin
      sdi[0] = data[i];
      clock(1);
    end
  endtask

  task clock(input int cycles);
    for(int i = 0; i < cycles; i++)
    begin
      if (clk) begin
        wait (~clk);
      end

      wait (clk);
    end
  endtask
endinterface
