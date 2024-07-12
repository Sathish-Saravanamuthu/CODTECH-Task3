module uart_tb;
    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;
    wire tx;
    wire tx_busy;
    reg rx;
    wire [7:0] rx_data;
    wire rx_done;

    uart_tx uut_tx (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    uart_rx uut_rx (
        .clk(clk),
        .rst(rst),
        .rx(tx),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        tx_start = 0;
        tx_data = 8'b0;

        // Reset pulse
        #10 rst = 0;
        #10 rst = 1;

        // Transmit data
        #20 tx_data = 8'hA5;
        tx_start = 1;
        #20 tx_start = 0;

        // Wait for reception to complete
        wait(rx_done == 1);

        // Check received data
        if (rx_data == 8'hA5) begin
            $display("Test Passed!");
        end else begin
            $display("Test Failed!");
        end

        $finish;
    end

    // Clock generation
    always #5 clk = ~clk;
endmodule
