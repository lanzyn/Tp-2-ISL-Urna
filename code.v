module Urna (
    input clk, 
    input voto0,
    input voto1,
    input voto2,
    input voto3,
    input valid,
    input finish,
    input swap,
    output reg [1:0] estado,

    output reg [7:0] TotalC1,
    output reg [7:0] TotalC2,
    output reg [7:0] TotalNull,
    output reg [0:0] Vote_Status
);
    reg [0:0] digito1C1;
    reg [0:0] digito1C2;
    reg [7:0] contadorC1;
    reg [7:0] contadorC2;
    reg [7:0] contadorNull;

    reg [1:0] estado_atual, proximo_estado;

parameter inicio = 2'b00, digito1 = 2'b01, digito2 = 2'b10, final = 2'b11;

initial
begin
    estado_atual <= digito1;
end

always @(clk, posedge valid or negedge finish) begin
    estado_atual <= proximo_estado;
    case (estado_atual)
        inicio: 
        if (!finish)
        begin
            proximo_estado <= digito1;
            estado <= digito1;
        end
        else 
        begin
            contadorC1 <= 8'b0;
            contadorC2 <= 8'b0;
            contadorNull <= 8'b0;
            digito1C1 <= 1'b0;
            digito1C2 <= 1'b0;
            proximo_estado <= digito1;
            estado <= digito1;
        end
        digito1:
        if (finish)
        begin
            proximo_estado <= final;
        end
        else if (voto0 == 1'b0 && voto1 == 1'b0 && voto2 == 1'b0 && voto3 == 1'b1)
        begin
            digito1C1 <= 1'b1;
            Vote_Status <= 1'bx;
            proximo_estado <= digito2;
            estado <= digito2;
        end
        else if (voto0 == 1'b0 && voto1 == 1'b0 && voto2 == 1'b1 && voto3 == 1'b0)
        begin
            digito1C2 <= 1'b1;
            Vote_Status <= 1'bx;
            proximo_estado <= digito2;
            estado <= digito2;
        end
        else if (valid)
        begin
            Vote_Status <= 1'bx;
            proximo_estado <= digito2;
            estado <= digito2;
        end
        digito2:
        if (finish)
        begin
            proximo_estado <= final;
        end
        else if (digito1C1 == 1'b1 && voto0 == 1'b0 && voto1 == 1'b0 && voto2 == 1'b1 && voto3 == 1'b1 && valid == 1'b1 && swap == 1'b1)
        begin
            contadorC2 <= contadorC2 + 1'b1;
            TotalC2 <= contadorC2;
            digito1C1 <= 1'b0;
            digito1C2 <= 1'b0;
            Vote_Status <= 1'b1;
            proximo_estado <= digito1;
            estado <= digito1;
        end
        else if (digito1C2 == 1'b1 && voto0 == 1'b0 && voto1 == 1'b0 && voto2 == 1'b1 && voto3 == 1'b0 && valid == 1'b1 && swap == 1'b1)
        begin
            contadorC1 <= contadorC1 + 1'b1;
            digito1C1 <= 1'b0;
            digito1C2 <= 1'b0;
            Vote_Status <= 1'b1;
            proximo_estado <= digito1;
            estado <= digito1;
        end
        else if (digito1C1 == 1'b1 && voto0 == 1'b0 && voto1 == 1'b0 && voto2 == 1'b1 && voto3 == 1'b1 && valid == 1'b1)
        begin
            contadorC1 <= contadorC1 + 1'b1;
            digito1C1 <= 1'b0;
            digito1C2 <= 1'b0;
            Vote_Status <= 1'b1;
            proximo_estado <= digito1;
            estado <= digito1;
        end
        else if (digito1C2 == 1'b1 && voto0 == 1'b0 && voto1 == 1'b0 && voto2 == 1'b1 && voto3 == 1'b0 && valid == 1'b1)
        begin
            contadorC2 <= contadorC2 + 1'b1;
            digito1C1 <= 1'b0;
            digito1C2 <= 1'b0;
            Vote_Status <= 1'b1;
            proximo_estado <= digito1;
            estado <= digito1;
        end
        else if (valid == 1'b1)
        begin
            contadorNull <= contadorNull + 1'b1;
            digito1C1 <= 1'b0;
            digito1C2 <= 1'b0;
            Vote_Status <= 1'b0;
            proximo_estado <= digito1;
            estado <= digito1;
        end
        final:
        begin
            TotalC1 <= contadorC1;
            TotalC2 <= contadorC2;
            TotalNull <= contadorNull;
        end
        default: 
        begin
            contadorC1 <= 8'b0;
            contadorC2 <= 8'b0;
            contadorNull <= 8'b0;
            digito1C1 <= 1'b0;
            digito1C2 <= 1'b0;
            proximo_estado <= digito1;
            estado <= digito1;
        end
    endcase
    
end
endmodule