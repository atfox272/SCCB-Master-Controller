`timescale 1ns/1ps

`define DUT_CLK_PERIOD  2
`define RST_DLY_START   3
`define RST_DUR         9

// `define CONF_MODE_ONLY
// `define WR_ST_MODE
// `define RD_ST_MODE 
// `define CUSTOMIZE_MODE

`define END_TIME        500000

// Slave device physical timing simulation
`define SLV_DVC_LATENCY 2 // Time unit
module sccb_master_controller_tb;

    // Parameters
    parameter IP_CONF_BASE_ADDR     = 32'h2000_0000;    // Configuration registers region - BASE
    parameter IP_TX_BASE_ADDR       = 32'h2100_0000;    // SCCB TX FIFO region - BASE
    parameter IP_RX_BASE_ADDR       = 32'h2200_0000;    // SCCB RX FIFO region - BASE
    parameter SCCB_TX_FIFO_DEPTH    = 8;                // SCCB TX FIFO depth (element's width = 8bit)
    parameter SCCB_RX_FIFO_DEPTH    = 8;                // SCCB RX FIFO depth (element's width = 8bit)
    parameter DATA_W                = 8;
    parameter ADDR_W                = 32;
    parameter MST_ID_W              = 5;
    parameter TRANS_DATA_LEN_W      = 8;
    parameter TRANS_DATA_SIZE_W     = 3;
    parameter TRANS_RESP_W          = 2;
    parameter INTERNAL_CLK_FREQ     = 1_000_000;
    parameter MAX_SCCB_FREQ         = 100_000;
    
    // Signals
    // -- Global 
    logic                                   clk;
    logic                                   rst_n;
    // -- AXI4 Interface            
    // -- -- AW channel         
    logic   [MST_ID_W-1:0]                  m_awid_i;
    logic   [ADDR_W-1:0]                    m_awaddr_i;
    logic   [TRANS_DATA_LEN_W-1:0]          m_awlen_i;
    logic                                   m_awvalid_i;
    // -- -- W channel          
    logic   [DATA_W-1:0]                    m_wdata_i;
    logic                                   m_wlast_i;
    logic                                   m_wvalid_i;
    // -- -- B channel          
    logic                                   m_bready_i;
    // -- -- AR channel         
    logic   [MST_ID_W-1:0]                  m_arid_i;
    logic   [ADDR_W-1:0]                    m_araddr_i;
    logic   [TRANS_DATA_LEN_W-1:0]          m_arlen_i;
    logic                                   m_arvalid_i;
    // -- -- R channel          
    logic                                   m_rready_i;
    // logic  declaration           
    // -- -- AW channel         
    logic                                   m_awready_o;
    // -- -- W channel          
    logic                                   m_wready_o;
    // -- -- B channel          
    logic   [MST_ID_W-1:0]                  m_bid_o;
    logic   [TRANS_RESP_W-1:0]              m_bresp_o;
    logic                                   m_bvalid_o;
    // -- -- AR channel         
    logic                                   m_arready_o;
    // -- -- R channel          
    logic   [DATA_W-1:0]                    m_rdata_o;
    logic   [TRANS_RESP_W-1:0]              m_rresp_o;
    logic                                   m_rlast_o;
    logic                                   m_rvalid_o;
    // -- SCCB Master Interface
    logic                                   sio_c;
    wire                                    sio_d;
    logic                                   sio_oe_m = 0;   // Master SIO_D output enable
    logic                                   sio_d_slv;
    assign sio_d = sio_oe_m ? sio_d_slv : 1'bz;

    // Instantiate the DUT (Device Under Test)
    sccb_master_controller #(
        .IP_CONF_BASE_ADDR(IP_CONF_BASE_ADDR),
        .IP_TX_BASE_ADDR(IP_TX_BASE_ADDR),
        .IP_RX_BASE_ADDR(IP_RX_BASE_ADDR),
        .SCCB_TX_FIFO_DEPTH(SCCB_TX_FIFO_DEPTH),
        .SCCB_RX_FIFO_DEPTH(SCCB_RX_FIFO_DEPTH),
        .DATA_W(DATA_W),
        .ADDR_W(ADDR_W),
        .MST_ID_W(MST_ID_W),
        .TRANS_DATA_LEN_W(TRANS_DATA_LEN_W),
        .TRANS_DATA_SIZE_W(TRANS_DATA_SIZE_W),
        .TRANS_RESP_W(TRANS_RESP_W),
        .INTERNAL_CLK_FREQ(INTERNAL_CLK_FREQ),
        .MAX_SCCB_FREQ(MAX_SCCB_FREQ)
    ) sccb_master_controller (
        .clk        (clk),
        .rst_n      (rst_n),
        .m_awid_i   (m_awid_i),
        .m_awaddr_i (m_awaddr_i),
        .m_awlen_i  (m_awlen_i),
        .m_awvalid_i(m_awvalid_i),
        .m_wdata_i  (m_wdata_i),
        .m_wlast_i  (m_wlast_i),
        .m_wvalid_i (m_wvalid_i),
        .m_bready_i (m_bready_i),
        .m_arid_i   (m_arid_i),
        .m_araddr_i (m_araddr_i),
        .m_arlen_i  (m_arlen_i),
        .m_arvalid_i(m_arvalid_i),
        .m_rready_i (m_rready_i),
        .m_awready_o(m_awready_o),
        .m_wready_o (m_wready_o),
        .m_bid_o    (m_bid_o),
        .m_bresp_o  (m_bresp_o),
        .m_bvalid_o (m_bvalid_o),
        .m_arready_o(m_arready_o),
        .m_rdata_o  (m_rdata_o),
        .m_rresp_o  (m_rresp_o),
        .m_rlast_o  (m_rlast_o),
        .m_rvalid_o (m_rvalid_o),
        .sio_c      (sio_c),
        .sio_d      (sio_d)
    );

    initial begin
        clk             <= 0;
        rst_n           <= 1;

        m_awid_i        <= 0;
        m_awaddr_i      <= 0;
        m_awvalid_i     <= 0;
        m_awlen_i       <= 0;
        
        m_wdata_i       <= 0;
        m_wlast_i       <= 0;
        m_wvalid_i      <= 0;
        
        m_bready_i      <= 1'b1;
        
        m_awid_i       <= 0;
        m_awaddr_i     <= 0;
        m_awvalid_i    <= 0;
        
        m_bready_i     <= 1'b1;
        
        m_arid_i       <= 0;
        m_araddr_i     <= 0;
        m_arvalid_i    <= 0;

        m_rready_i     <= 1'b1;

        #(`RST_DLY_START)   rst_n <= 0;
        #(`RST_DUR)         rst_n <= 1;
    end
    
    initial begin
        forever #(`DUT_CLK_PERIOD/2) clk <= ~clk;
    end
    
    initial begin : SIM_END
        #`END_TIME;
        $finish;
    end

    initial begin   : SEQUENCER_DRIVER
        #(`RST_DLY_START + `RST_DUR + 1);
        fork 
            begin   : AW_chn
                // 1st: Request for Control signal
                m_aw_transfer(.m_awid(5'h00), .m_awaddr(32'h2100_0000), .m_awlen(8'd05));
                // 2nd: Request for CONFIG  
                m_aw_transfer(.m_awid(5'h00), .m_awaddr(32'h2000_0000), .m_awlen(8'd00));
                // 3rd: Request for TX_DATA
                m_aw_transfer(.m_awid(5'h00), .m_awaddr(32'h2100_0002), .m_awlen(8'd00));
                // 4th: Request for SUB_ADDR 
                m_aw_transfer(.m_awid(5'h00), .m_awaddr(32'h2100_0001), .m_awlen(8'd05));
                aclk_cl;
                m_awvalid_i <= 1'b0;
            end
            begin   : W_chn
                // 1st                        W/R   PHASE
                m_w_transfer(.m_wdata({5'h00, 1'b1, 2'd2}), .m_wlast(1'b0));
                m_w_transfer(.m_wdata({5'h00, 1'b1, 2'd3}), .m_wlast(1'b0));
                m_w_transfer(.m_wdata({5'h00, 1'b1, 2'd3}), .m_wlast(1'b0));
                m_w_transfer(.m_wdata({5'h00, 1'b1, 2'd3}), .m_wlast(1'b0));
                m_w_transfer(.m_wdata({5'h00, 1'b1, 2'd2}), .m_wlast(1'b0));
                m_w_transfer(.m_wdata({5'h00, 1'b1, 2'd2}), .m_wlast(1'b0));
                m_w_transfer(.m_wdata({5'h00, 1'b0, 2'd2}), .m_wlast(1'b1));
                // 2nd
                m_w_transfer(.m_wdata(8'h21), .m_wlast(1'b1));
                // 3rd
                m_w_transfer(.m_wdata(8'h11), .m_wlast(1'b0));
                m_w_transfer(.m_wdata(8'h00), .m_wlast(1'b0));
                m_w_transfer(.m_wdata(8'hFF), .m_wlast(1'b1));
                // 4th
                m_w_transfer(.m_wdata(8'h2A), .m_wlast(1'b0));
                m_w_transfer(.m_wdata(8'h3A), .m_wlast(1'b0));
                m_w_transfer(.m_wdata(8'h4A), .m_wlast(1'b0));
                m_w_transfer(.m_wdata(8'h5A), .m_wlast(1'b0));
                m_w_transfer(.m_wdata(8'h6A), .m_wlast(1'b0));
                m_w_transfer(.m_wdata(8'hFA), .m_wlast(1'b1));
                aclk_cl;
                m_wvalid_i <= 1'b0;
            end
            begin   : AR_chn
                // Request for RX_DATA
                m_ar_transfer(.m_arid(5'h00), .m_araddr(32'h2200_0000), .m_arlen(8'd00));
                aclk_cl;
                m_arvalid_i <= 1'b0;
            end
            begin: R_chn
                // Wrong request
                // TODO: monitor the response data
            end
        join_none
    end

    /*          SCCB monitor            */
    localparam IDLE_ST      = 4'd00;
    localparam TX_DAT_ST    = 4'd02;
    localparam TX_ACK_ST    = 4'd03;
    localparam RX_DAT_ST    = 4'd04;
    localparam RX_ACK_ST    = 4'd05;
    logic [3:0] slv_st      = IDLE_ST;
    logic [7:0] tx_data     [0:2];  // Data buffer of phase 1-2-3
    logic       tx_data_vld = 0;
    logic [1:0] phase_cnt   = 0;    // 0 -> 2
    logic [2:0] sioc_cl_cnt = 7;
    logic       start_tx_flg= 1;
    logic       start_tx_slv= 0;
    always @(negedge sio_c) begin
        if(~rst_n) begin
          
        end
        else begin
            tx_data_vld <= 0;
            case(slv_st)
                IDLE_ST: begin
                    if(start_tx_slv) begin
                        start_tx_slv = 0;
                    end
                    else begin
                        slv_st <= TX_DAT_ST;
                        sioc_cl_cnt <= sioc_cl_cnt - 1;
                        tx_data[phase_cnt][sioc_cl_cnt] <= sio_d;
                    end
                end
                TX_DAT_ST: begin
                    if(sioc_cl_cnt == 7) begin // Received all bits (8bit)
                        if((phase_cnt == 0) & (tx_data[phase_cnt][0])) begin  // Next phase is a READ phase
                            #(`SLV_DVC_LATENCY);
                            slv_st    <= RX_DAT_ST;
                            sio_oe_m  <= 1'b1;  // Control the bus
                            sio_d_slv <= tx_data[1][sioc_cl_cnt];   // Return the previous transmission's sub-address 
                            sioc_cl_cnt <= sioc_cl_cnt - 1;
                        end
                        else begin
                            slv_st <= IDLE_ST;
                            tx_data_vld <= 1; 
                        end
                        phase_cnt   <= phase_cnt + 1'b1;
                    end
                    else begin
                        sioc_cl_cnt <= sioc_cl_cnt - 1;
                        tx_data[phase_cnt][sioc_cl_cnt] <= sio_d;
                    end
                end
                TX_ACK_ST: begin
                    slv_st <= IDLE_ST;
                end
                RX_DAT_ST: begin
                    if(sioc_cl_cnt == 7) begin // overflow -> received all bits
                        slv_st      <= IDLE_ST;
                        sio_oe_m    <= 1'b0; // Float the bus
                        phase_cnt   <= phase_cnt + 1'b1;
                    end
                    else begin
                        sio_d_slv   <= tx_data[phase_cnt][sioc_cl_cnt];   // Return the previous transmission's sub-address 
                        sioc_cl_cnt <= sioc_cl_cnt - 1;
                    end
                end
                RX_ACK_ST: begin
                end
            endcase
        end
    end
    initial begin : STOP_DATA_TRANS_DET
        // SIO_D is changing state while SIO_C is HIGH 
        while(1'b1) begin
            @(posedge sio_d);
            #0.1;
            if(sio_c) begin 
                if(start_tx_flg) begin  // This case is the "Start Data Transmission"
                    start_tx_flg = 0;
                    start_tx_slv = 1;   // Flag to Slave FSM 
                    slv_st      <= IDLE_ST;
                    sioc_cl_cnt <= 3'd7;
                    phase_cnt   <= 0;
                    tx_data[2]  <= 8'h00;   // Reset DATA buffer
                end
                else begin
                    $display("------------ Slave new info ------------");
                    $display("Number of phases:     %2d", phase_cnt);
                    $display("SLAVE DEVICE ADDRESS: %2h", tx_data[0]);
                    $display("SUB-ADDRESS:          %2h", tx_data[1]);
                    $display("DATA:                 %2h", tx_data[2]);
                    // Reset the state and buffer in slv
                    start_tx_flg = 1;
                    slv_st      <= IDLE_ST;
                    sioc_cl_cnt <= 3'd7;
                    phase_cnt   <= 0;
                    tx_data[2]  <= 8'h00;   // Reset DATA buffer
                end
            end
        end
    end
    /*          SCCB monitor            */


   /* DeepCode */
    task automatic m_aw_transfer(
        input [MST_ID_W-1:0]            m_awid,
        input [ADDR_W-1:0]              m_awaddr,
        input [TRANS_DATA_LEN_W-1:0]    m_awlen
    );
        aclk_cl;
        m_awid_i            <= m_awid;
        m_awaddr_i          <= m_awaddr;
        m_awlen_i           <= m_awlen;
        m_awvalid_i         <= 1'b1;
        // Handshake occur
        wait(m_awready_o == 1'b1); #0.1;
    endtask

    task automatic m_w_transfer (
        input [DATA_W-1:0]  m_wdata,
        input               m_wlast
    );
        aclk_cl;
        m_wdata_i           <= m_wdata;
        m_wvalid_i          <= 1'b1;
        m_wlast_i           <= m_wlast;
        // Handshake occur
        wait(m_wready_o == 1'b1); #0.1;
    endtask

    task automatic m_ar_transfer(
        input [MST_ID_W-1:0]            m_arid,
        input [ADDR_W-1:0]              m_araddr,
        input [TRANS_DATA_LEN_W-1:0]    m_arlen
    );
        aclk_cl;
        m_arid_i            <= m_arid;
        m_araddr_i          <= m_araddr;
        m_arlen_i           <= m_arlen;
        m_arvalid_i         <= 1'b1;
        // Handshake occur
        wait(m_arready_o == 1'b1); #0.1;
    endtask

    task automatic aclk_cl;
        @(posedge clk);
        #0.2; 
    endtask
endmodule