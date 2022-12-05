`include "code.v"

module tb_Urna();
reg tb_clk;
reg tb_finish;
reg tb_digit0;
reg tb_digit2;
reg tb_digit1;
reg tb_digit3;
reg tb_swap;
reg tb_valid;
wire [1:0] tb_estado;

wire [7:0] tb_TotalC1;
wire [7:0] tb_TotalC2;
wire [7:0] tb_TotalNull;
wire tb_VoteStatus;

Urna urnatb
(
    .finish(tb_finish),
    .clk(tb_clk),
    .swap(tb_swap),
    .voto0(tb_digit0),
    .voto1(tb_digit1),
    .voto2(tb_digit2),
    .voto3(tb_digit3),
    .valid(tb_valid),
    .Vote_Status(tb_VoteStatus),
    .TotalC1(tb_TotalC1),
    .TotalC2(tb_TotalC2),
    .TotalNull(tb_TotalNull),
    .estado(tb_estado)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) tb_clk=~tb_clk;

initial
begin
    $monitor ("time = %d,estado = %d, finish = %b, valid = %d digito0 = %b, digito1 = %b, digito2 = %b, digito3 = %b votestatus = %b, result_1 = %d, result_2 = %d, result_3 = %d,\n",
    $time, tb_estado, tb_finish, tb_valid, tb_digit0, tb_digit1, tb_digit2, tb_digit3, tb_VoteStatus, tb_TotalC1, tb_TotalC2, tb_TotalNull,);

    tb_digit0 = 1'b0;
    tb_digit1 = 1'b0;
    tb_digit2 = 1'b0;
    tb_digit3 = 1'b0;
    tb_valid = 1'b0;
    tb_swap = 1'b0;

    #5 tb_digit0 = 1'b0;
    #5 tb_digit1 = 1'b0;
    #5 tb_digit2 = 1'b1;
    #5 tb_digit3 = 1'b0;
    #5 tb_valid = 1'b1;
    #5 tb_valid = 1'b0;

    #5 tb_digit0 = 1'b0;
    #5 tb_digit1 = 1'b0;
    #5 tb_digit2 = 1'b1;
    #5 tb_digit3 = 1'b0;
    #5 tb_valid = 1'b1;
    #5 tb_valid = 1'b0;

    #5 tb_digit0 = 1'b0;
    #5 tb_digit1 = 1'b0;
    #5 tb_digit2 = 1'b0;
    #5 tb_digit3 = 1'b1;
    #5 tb_valid = 1'b1;
    #5 tb_valid = 1'b0;

    #5 tb_digit0 = 1'b0;
    #5 tb_digit1 = 1'b0;
    #5 tb_digit2 = 1'b1;
    #5 tb_digit3 = 1'b1;
    #5 tb_valid = 1'b1;
    #5 tb_valid = 1'b0;

    #5 tb_digit0 = 1'b0;
    #5 tb_digit1 = 1'b0;
    #5 tb_digit2 = 1'b0;
    #5 tb_digit3 = 1'b1;
    #5 tb_valid = 1'b1;
    #5 tb_valid = 1'b0;

    #5 tb_digit0 = 1'b0;
    #5 tb_digit1 = 1'b0;
    #5 tb_digit2 = 1'b1;
    #5 tb_digit3 = 1'b1;
    #5 tb_valid = 1'b1;
    #5 tb_valid = 1'b0;


    #10 tb_finish = 1'b1;                                

    #50 $stop;                                        
end

initial begin
    $dumpfile("tb_Urna.vcd");
    $dumpvars(0, tb_Urna);
end

endmodule