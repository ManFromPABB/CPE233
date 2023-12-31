`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Ratner Surf Designs
// Engineer:  James Ratner
// 
// Create Date: 07/07/2018 08:05:03 AM
// Design Name: 
// Module Name: fsm_template
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Generic FSM model with both Mealy & Moore outputs. 
//    Note: data widths of state variables are not specified 
//
// Dependencies: 
// 
// Revision:
// Revision 1.00 - File Created (07-07-2018) 
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module fsm_template(rco, clr, clk, up, state, load); 
    input clk, rco;
    output reg clr, up, load;
    output reg [1:0] state;
     
    //- next state & present state variables
    reg [1:0] NS, PS; 
    //- bit-level state representations
    parameter [1:0] st_A=2'b00, st_B=2'b01, st_C=2'b10, st_D=2'b11;
    
    initial PS = st_A; 
    

    //- model the state registers
    always @ (negedge rco, posedge clk)
        if (rco == 1) PS <= st_B;
        else PS <= NS; 
    
    
    //- model the next-state and output decoders
    always @ (PS)
    begin
       clr = 0; up = 0; state = 0; load = 0;
       case(PS)
          st_A:
          begin
             up = 1;
             clr = 0;
             load = 0;
             state = 2'b00;
             if (rco == 1) 
             begin
             load = 1;
             NS = st_B;
             end
             else NS = st_A;
          end
          
          st_B:
             begin
                up = 0;
                clr = 0;
                load = 1;
                state = 2'b01;
                NS = st_C;
             end   
             
          st_C:
             begin
                 clr = 1;
                 up = 0;
                 load = 0;
                 state = 2'b10;
                 NS = st_D;
             end
          
          st_D:
            begin
                clr = 0;
                up = 0;
                load = 0;
                state = 2'b11;
                NS = st_A;
            end
             
          default: NS = st_A; 
            
          endcase
      end              
endmodule


