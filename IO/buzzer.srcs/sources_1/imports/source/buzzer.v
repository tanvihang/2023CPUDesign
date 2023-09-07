`timescale 1ns / 1ps
module buzzer(
input clk,
input rst,
input [7:0]buzzer_en,
output buzzer_out,
output [7:0] led,
output reg[7:0] sel,
output reg[7:0] seg_code
    );
    reg clk_1000 ;
    reg [2:0]buzzer_state;
    reg [19:0]cnt;
    reg [19:0]MODE;
	
    parameter CNT0 = 35000;
    parameter CNT1 = 65000;
    parameter CNT2 = 165000;
    parameter CNT3 = 265000;
	parameter CNT4 = 295000;
	parameter CNT5 = 325000;
	parameter CNT6 = 355000;
	parameter CNT7 = 400000;
	
	reg [23:0]cnt1;
	
	parameter _0 = 8'h3f,_1 = 8'h06,_2 = 8'h5b,_3 = 8'h4f,    
               _4 = 8'h66,_5 = 8'h6d,_6 = 8'h7d,_7 = 8'h07,
               _8 = 8'h7f,_9 = 8'h6f, _E = 8'b01111001,
			   _R = 8'b01110111, _RR = 8'b11110111;
	
	parameter IDLE = 3'b00,STEP1 = 3'b01,  STEP2 = 3'b11,STEP3 = 3'b100,STEP4 = 3'b101, STEP5 = 3'b110, STEP6 = 3'b111;
	
	reg [2:0]step;
	reg [3:0]dig_1 =0; 
    reg [3:0]dig_2 =0;
	reg [3:0]dig_3 =0;
	
    reg [7 : 0] light_reg;
    
    always@(posedge clk or negedge rst)
    begin
        if (~rst )
        begin
            buzzer_state<=0;
			dig_1 <= 0;
			dig_2 <= 0;
        end
        else
        begin
            case (buzzer_en)
            8'b00000000:begin 
			buzzer_state<=0; 
			light_reg<=8'b00000000;
			dig_1 <= 0;			
			dig_2 <= 0;
			dig_3 <= 0;
			end
			
			8'b10000000:begin 
			buzzer_state<=1;MODE<=CNT7; 
			light_reg<=8'b10000000; 
			dig_1 <= 8;
			dig_2 <= 0;
			dig_3 <= 0;
			end
			
            8'b01000000:begin 
			buzzer_state<=1;
			MODE<=CNT6; 
			light_reg<=8'b01000000;
			dig_1 <= 7;
			dig_2 <= 0;
			dig_3 <= 0;
			end
			
            8'b00100000:begin
			buzzer_state<=1;MODE<=CNT5; 
			light_reg<=8'b00100000; 
			dig_1 <= 6;
			dig_2 <= 0;
			dig_3 <= 0;
			end
			
            8'b00010000:begin 
			buzzer_state<=1;
			MODE<=CNT4; 
			light_reg<=8'b00010000; 
			dig_1 <= 5;
			dig_2 <= 0;
			dig_3 <= 0;
			end
			
            8'b00001000:begin 
			buzzer_state<=1;
			MODE<=CNT3; 
			light_reg<=8'b00001000; 
			dig_1 <= 4;
			dig_2 <= 0;
			dig_3 <= 0;
			end
			
            8'b00000100:
			begin buzzer_state<=1;
			MODE<=CNT2; 
			light_reg<=8'b00000100; 
			dig_1 <= 3;
			dig_2 <= 0;
			dig_3 <= 0;
			end
			
            8'b00000010:begin 
			buzzer_state<=1;
			MODE<=CNT1; 
			light_reg<=8'b00000010; 
			dig_1 <= 2;
			dig_2 <= 0;
			dig_3 <= 0;
			end
			
            8'b00000001:begin 
			buzzer_state<=1;
			MODE<=CNT0; 
			light_reg<=8'b00000001; 
			dig_1 <= 1;
			dig_2 <= 0;
			dig_3 <= 0;
			end
			
            default : begin
			buzzer_state<=0;
			dig_1 <= 9;			
			dig_2 <= 9;
			dig_3 <= 9;
			end
            endcase
        end
    end
    
    //for buzzer
    always@(posedge clk or negedge rst)
    begin
        if (~rst )
        begin
            clk_1000 <= 0;
            cnt <= 1;
        end
        else if(buzzer_state)
        begin
            if (cnt == MODE)
            begin
                clk_1000 <= ~clk_1000;
                cnt <= 0;
            end
            else
            begin
                cnt<=cnt+1;
            end
         end
     end

	//for led display
	always@(posedge clk or negedge rst)
	begin 
		if(~rst)
		begin
			step <= IDLE;
			sel <= 8'b00000000;
            seg_code<= 8'hff;
			cnt1 <= 0;
		end
		else
		begin
			case(step)
			IDLE:
				begin
					sel<=8'b00000000; 
                    if(cnt1 == 10000)         
                    begin
                        step<=STEP1;
                        cnt1 <= 0;
                    end
                    else
                    cnt1 <= cnt1+1;
				end
			STEP1:
				begin
                    sel<=8'b00000001;                   
                    step<=STEP2;
                    case(dig_1)
                        4'd0:seg_code <= _0;         
                        4'd1:seg_code <= _1;
                        4'd2:seg_code <= _2;
                        4'd3:seg_code <= _3;
                        4'd4:seg_code <= _4;
                        4'd5:seg_code <= _5;
                        4'd6:seg_code <= _6;
                        4'd7:seg_code <= _7;
                        4'd8:seg_code <= _8;
                        4'd9:seg_code <= _RR;
                    endcase
                end
			STEP2:
				begin
                    if(cnt1 == 10000)
                    begin
                        step<=STEP3;
                        cnt1 <= 0;
                    end
                    else
                    cnt1 <= cnt1+1;
                end
			STEP3:
				begin
                    sel<=8'b00000010;                
                    step<=STEP4;
                    case(dig_2)
                        4'd0:seg_code <= _0;         
                        4'd1:seg_code <= _1;
                        4'd2:seg_code <= _2;
                        4'd3:seg_code <= _3;
                        4'd4:seg_code <= _4;
                        4'd5:seg_code <= _5;
                        4'd6:seg_code <= _6;
                        4'd7:seg_code <= _7;
                        4'd8:seg_code <= _8;
                        4'd9:seg_code <= _R;
                        endcase
                end
			STEP4:
				begin
                    if(cnt1 == 10000)
                    begin
                        step<=STEP5;
                        cnt1 <= 0;
                    end
                    else
                    cnt1 <= cnt1+1;
                end
			STEP5:
				begin
                    sel<=8'b00000100;                
                    step<=STEP6;
                    case(dig_3)
                        4'd0:seg_code <= _0;         
                        4'd1:seg_code <= _1;
                        4'd2:seg_code <= _2;
                        4'd3:seg_code <= _3;
                        4'd4:seg_code <= _4;
                        4'd5:seg_code <= _5;
                        4'd6:seg_code <= _6;
                        4'd7:seg_code <= _7;
                        4'd8:seg_code <= _8;
                        4'd9:seg_code <= _E;
                        endcase
                end
			STEP6:
				begin
                            if(cnt1 == 10000)           
                            begin
                                step<=IDLE;
                                cnt1 <= 0;
                            end
                            else
                            cnt1 <= cnt1+1;
                        end      
            
            endcase
		end
	end

   assign  buzzer_out =clk_1000;
   assign  led = light_reg; 
    
endmodule
