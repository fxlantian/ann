interface spi_bus_master
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
  // Master Tasks
  //---------------------------------------------------------------------------
  task set_csn(logic csn_in);
    #(period/2);
    csn = csn_in;
    #(period/2);
  endtask

  task send(input logic use_quad, input logic data[]);
    if (use_quad)
    begin
      padmode = SPI_QUAD_TX;
      for (int i = data.size()/4; i > 0; i--)
      begin
        for (int j = 3; j >= 0; j-- )
          sdo[j] = data[4*i-j+1];

        clock(1);
      end
    end else begin
      padmode = SPI_STD;
      for (int i = data.size(); i > 0; i--)
      begin
        sdo[0] = data[i];
        clock(1);
      end
    end
  endtask

  task receive(input logic use_quad, output logic data[]);
    if (use_quad)
    begin
      padmode = SPI_QUAD_RX;
      for (int i = data.size()/4; i > 0; i--)
      begin
        for (int j = 3; j >= 0; j-- )
          data[4*i-j+1] = sdi[j];

        clock(1);
      end
    end else begin
      padmode = SPI_STD;
      for (int i = data.size(); i > 0; i--)
      begin
        data[i] = sdi[0];
        clock(1);
      end
    end
  endtask

  task clock(input int cycles);
    for(int i = 0; i < cycles; i++)
    begin
      #(period/2) clk = 1;
      #(period/2) clk = 0;
    end
  endtask
endinterface
