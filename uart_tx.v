module uart_tx (
    input wire clk,         // System clock
    input wire rst,         // Reset signal
    input wire tx_start,    // Start transmission signal
    input wire [7:0] tx_data, // Data to transmit
    output reg tx,          // UART transmit line
    output reg tx_busy      // Transmitter busy flag
);

    parameter BAUD_RATE = 9600;
    parameter CLK_FREQ = 50000000; // 50 MHz clock
    parameter CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;
    parameter STATE_IDLE = 0;
    parameter STATE_START = 1;
    parameter STATE_DATA = 2;
    parameter STATE_STOP = 3;
    parameter STATE_CLEANUP = 4;

    reg [2:0] state = STATE_IDLE;
    reg [15:0] clk_count = 0;
    reg [2:0] bit_index = 0;
    reg [7:0] tx_shift_reg = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= STATE_IDLE;
            clk_count <= 0;
            bit_index <= 0;
            tx <= 1;
            tx_busy <= 0;
        end else begin
            case (state)
                STATE_IDLE: begin
                    tx <= 1;
                    tx_busy <= 0;
                    if (tx_start == 1) begin
                        tx_shift_reg <= tx_data;
                        state <= STATE_START;
                        tx_busy <= 1;
                    end
                end
                STATE_START: begin
                    tx <= 0;
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 0;
                        state <= STATE_DATA;
                    end
                end
                STATE_DATA: begin
                    tx <= tx_shift_reg[bit_index];
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 0;
                        if (bit_index < 7) begin
                            bit_index <= bit_index + 1;
                        end else begin
                            bit_index <= 0;
                            state <= STATE_STOP;
                        end
                    end
                end
                STATE_STOP: begin
                    tx <= 1;
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 0;
                        state <= STATE_CLEANUP;
                    end
                end
                STATE_CLEANUP: begin
                    tx_busy <= 0;
                    state <= STATE_IDLE;
                end
            endcase
        end
    end
endmodule
