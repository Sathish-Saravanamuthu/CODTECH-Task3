module uart_rx (
    input wire clk,          // System clock
    input wire rst,          // Reset signal
    input wire rx,           // UART receive line
    output reg [7:0] rx_data, // Received data
    output reg rx_done       // Reception complete flag
);

    parameter BAUD_RATE = 9600;
    parameter CLK_FREQ = 50000000; // 50 MHz clock
    parameter CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;
    parameter STATE_IDLE = 0;
    parameter STATE_START = 1;
    parameter STATE_DATA = 2;
    parameter STATE_STOP = 3;

    reg [2:0] state = STATE_IDLE;
    reg [15:0] clk_count = 0;
    reg [2:0] bit_index = 0;
    reg [7:0] rx_shift_reg = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= STATE_IDLE;
            clk_count <= 0;
            bit_index <= 0;
            rx_done <= 0;
        end else begin
            case (state)
                STATE_IDLE: begin
                    rx_done <= 0;
                    if (rx == 0) begin
                        state <= STATE_START;
                        clk_count <= 0;
                    end
                end
                STATE_START: begin
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 0;
                        state <= STATE_DATA;
                    end
                end
                STATE_DATA: begin
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 0;
                        rx_shift_reg[bit_index] <= rx;
                        if (bit_index < 7) begin
                            bit_index <= bit_index + 1;
                        end else begin
                            bit_index <= 0;
                            state <= STATE_STOP;
                        end
                    end
                end
                STATE_STOP: begin
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 0;
                        rx_data <= rx_shift_reg;
                        rx_done <= 1;
                        state <= STATE_IDLE;
                    end
                end
            endcase
        end
    end
endmodule
