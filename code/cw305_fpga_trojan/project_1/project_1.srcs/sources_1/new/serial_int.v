`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2022 10:39:19 PM
// Design Name: 
// Module Name: serial_int
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module serial_int(
    input wire clk,
    input wire s,
    input wire k,
    output reg c,
    output reg trig
    );
   
    reg [127:0] state_buf;
    reg [127:0] key_buf;
    wire [127:0] ciphertext_buf;
   
    reg [127:0] state;
    reg [127:0] key;
    reg [127:0] ciphertext;
   
   
    reg [6:0] counter = 0;
    reg [4:0] prop_counter = 0;
    reg enc_done = 0;
    reg handshake = 0;
   
    always @(posedge clk) begin
        if(counter != 127 && !enc_done) begin
            if (handshake) begin
                state[counter] <= s;
                key[counter] <= k;
                counter = counter + 1;
            end
            else begin
                if(s && k) begin
                    handshake <= 1;
                end
            end
        end
        else begin

            if(prop_counter == 7'b11111) begin
                  if(!enc_done) begin
                      ciphertext <= ciphertext_buf;
                      enc_done <= 1;
                      state_buf <= 0;
                      key_buf <= 0;
                      trig <= 0;
                  end
                  c <= ciphertext[counter];
                  counter = counter - 1;
            end
            else begin
                prop_counter <= prop_counter + 1;
                trig <= 1;
                state_buf <= state;
                key_buf <= key;
            end
           
         
           
       
        end
       
        if(counter == 0 && enc_done) begin
            prop_counter <= 0;
            enc_done <= 0;
            trig <= 0;
            handshake <= 0;
        end
   
    end
   
    aes_128 enc_inst(
        .clk(clk),
        .state(state_buf),
        .key(key_buf),
        .out(ciphertext_buf)
    );
endmodule