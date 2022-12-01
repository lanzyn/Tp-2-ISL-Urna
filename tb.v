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

wire [7:0] tb_TotalC1;
wire [7:0] tb_TotalC2;
wire [7:0] tb_TotalNull;
wire tb_VoteStatus;

Urna urnatb
(
    .finish(tb_finish),
    .clk(tb_clk),
    .swap(tb_swap),
    .digit0(tb_digit0),
    .digit2(tb_digit2),
    .digit1(tb_digit1),
    .digit3(tb_digit3),
    .valid(tb_valid),
    .VoteStatus(tb_VoteStatus),
    .contadorC1(tb_TotalC1),
    .contadorC2(tb_TotalC2),
    .contadorNull(tb_TotalNull)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) tb_clk=~tb_clk;

initial
begin
    $monitor ("time = %d, finish = %b, candidate_1 = %b, candidate_2 = %b, candidate_3 = %b, vote_over = %b, result_1 = %3d, result_2 = %3d, result_3 = %3d,\n",
    $time, tb_finish, tb_digit0, tb_digit1, tb_digit2, tb_finish, tb_TotalC1, tb_TotalC2, tb_TotalNull,);

    
    tb_finish = 1'b0;
    tb_digit0 = 1'b0;
    tb_digit1 = 1'b0;
    tb_digit2 = 1'b0;
    tb_digit3 = 1'b0;
    tb_valid = 1'b0;
    tb_swap = 1'b0;

    #20 tb_digit0 = 1'b0;
    #10 tb_digit1 = 1'b0;
    #10 tb_digit2 = 1'b1;
    #10 tb_digit3 = 1'b0;
    #10 tb_valid = 1'b1;

    #20 tb_digit0 = 1'b0;
    #10 tb_digit1 = 1'b0;
    #10 tb_digit2 = 1'b1;
    #10 tb_digit3 = 1'b0;
    #10 tb_valid = 1'b1;

    #20 tb_digit0 = 1'b0;
    #10 tb_digit1 = 1'b0;
    #10 tb_digit2 = 1'b0;
    #10 tb_digit3 = 1'b1;
    #10 tb_valid = 1'b1;

    #20 tb_digit0 = 1'b0;
    #10 tb_digit1 = 1'b0;
    #10 tb_digit2 = 1'b1;
    #10 tb_digit3 = 1'b1;
    #10 tb_valid = 1'b1;

    #20 tb_digit0 = 1'b0;
    #10 tb_digit1 = 1'b0;
    #10 tb_digit2 = 1'b0;
    #10 tb_digit3 = 1'b1;
    #10 tb_valid = 1'b1;

    #20 tb_digit0 = 1'b0;
    #10 tb_digit1 = 1'b0;
    #10 tb_digit2 = 1'b1;
    #10 tb_digit3 = 1'b1;
    #10 tb_valid = 1'b1;


    #30 tb_finish = 1'b1;
    #50 tb_finish = 1'b1;                                    //reset when the voting process is over 
    
    //use $finish for simulators other than modelsim
    #60 $stop;                                          // use $stop instead of $finish to keep modelsim simulator open 
end

initial begin
    $dumpfile("tb_Urna.vcd");
    $dumpvars(0, tb_Urna);
end

endmodule