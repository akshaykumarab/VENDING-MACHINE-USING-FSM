module vending_machine(
    input clk,
    input rst,
    input [1:0] in, // 00 -> 0 rs, 01 -> 5 rs, 10 -> 10 rs
    output reg out,
    output reg [1:0] change
);

// Define the states using parameters
parameter s0 = 2'b00; // State for 0 rs
parameter s1 = 2'b01; // State for 5 rs
parameter s2 = 2'b10; // State for 10 rs

// Registers for current and next state
reg [1:0] c_state, n_state;

// Always block to update the current state on the positive edge of the clock
always @(posedge clk) begin
    if (rst == 1) begin
        // Reset condition
        c_state <= s0;
        n_state <= s0;
        change <= 2'b00;
        out <= 0;
    end else begin
        // Update current state to next state
        c_state <= n_state;
    end
end

// Combinational logic block to determine next state and outputs
always @(*) begin
    case (c_state)
        s0: begin // State 0: 0 rs
            if (in == 2'b00) begin
                n_state = s0;
                out = 0;
                change = 2'b00;
            end else if (in == 2'b01) begin
                n_state = s1;
                out = 0;
                change = 2'b00;
            end else if (in == 2'b10) begin
                n_state = s2;
                out = 0;
                change = 2'b00;
            end
        end

        s1: begin // State 1: 5 rs
            if (in == 2'b00) begin
                n_state = s0;
                out = 0;
                change = 2'b01; // Change returned: 5 rs
            end else if (in == 2'b01) begin
                n_state = s2;
                out = 0;
                change = 2'b00;
            end else if (in == 2'b10) begin
                n_state = s0;
                out = 1; // Dispense the item
                change = 2'b00;
            end
        end

        s2: begin // State 2: 10 rs
            if (in == 2'b00) begin
                n_state = s0;
                out = 0;
                change = 2'b10; // Change returned: 10 rs
            end else if (in == 2'b01) begin
                n_state = s0;
                out = 1; // Dispense the item
                change = 2'b01; // Change returned: 5 rs
            end else if (in == 2'b10) begin
                n_state = s0;
                out = 1; // Dispense the item
                change = 2'b10; // Change returned: 10 rs
            end
        end

        default: begin
            n_state = s0;
            out = 0;
            change = 2'b00;
        end
    endcase
end

endmodule