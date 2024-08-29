module vending_machine_tb;

// Inputs
reg clk;
reg [1:0] in;
reg rst;

// Outputs
wire out;
wire [1:0] change;

// Instantiate the Unit Under Test (UUT)
vending_machine uut (
    .clk(clk), 
    .in(in), 
    .out(out),
    .rst(rst),
    .change(change)
);

initial begin
    // Initialize Inputs
    $dumpfile("vending_machine.vcd");
    $dumpvars(0, vending_machine_tb);

    rst = 1;
    clk = 0;
    in = 2'b00; // Initial value of input

    #6 rst = 0; // De-assert reset after 6 time units

    // Apply test cases
    #11 in = 2'b01; // Insert 5 rs
    #16 in = 2'b01; // Insert another 5 rs
    #25 $finish;    // End the simulation
end

// Clock generation
always #5 clk = ~clk;

// Monitor changes in output and change
initial begin
    $monitor($time, " in: %b, out: %b, change: %b", in, out, change);
end

endmodule
