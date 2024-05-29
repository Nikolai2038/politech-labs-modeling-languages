module l04p02q_minmax (
    input [7:0] number_1,
    input [7:0] number_2,
    input [7:0] number_3,
    input [7:0] number_4,
    output reg [7:0] min,
    output reg [7:0] max
);
always begin
    min = number_1;
    max = number_1;

    // Find the maximum number
    if (number_2 > max) max = number_2;
    if (number_3 > max) max = number_3;
    if (number_4 > max) max = number_4;

    // Find the minimum number
    if (number_2 < min) min = number_2;
    if (number_3 < min) min = number_3;
    if (number_4 < min) min = number_4;
end
endmodule
