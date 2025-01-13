module sccb_master_controller #(
    // Memory Mapping
    parameter IP_CONF_BASE_ADDR = 32'h2000_0000,        // Memory mapping - BASE
    // AXI4 Bus Configuration
    parameter DATA_W            = 8,
    parameter ADDR_W            = 32,
    parameter MST_ID_W          = 5,
    parameter TRANS_DATA_LEN_W  = 8,
    parameter TRANS_DATA_SIZE_W = 3,
    parameter TRANS_RESP_W      = 2
) (
    // Input declaration
    // -- Global 
    input                                   clk,
    input                                   rst_n,
    // -- AXI4 Interface            
    // -- -- AW channel         
    input   [MST_ID_W-1:0]                  m_awid_i,
    input   [ADDR_W-1:0]                    m_awaddr_i,
    input   [TRANS_DATA_LEN_W-1:0]          m_awlen_i,
    input                                   m_awvalid_i,
    // -- -- W channel          
    input   [DATA_W-1:0]                    m_wdata_i,
    input                                   m_wlast_i,
    input                                   m_wvalid_i,
    // -- -- B channel          
    input                                   m_bready_i,
    // -- -- AR channel         
    input   [MST_ID_W-1:0]                  m_arid_i,
    input   [ADDR_W-1:0]                    m_araddr_i,
    input   [TRANS_DATA_LEN_W-1:0]          m_arlen_i,
    input                                   m_arvalid_i,
    // -- -- R channel          
    input                                   m_rready_i,
    // Output declaration           
    // -- -- AW channel         
    output                                  m_awready_o,
    // -- -- W channel          
    output                                  m_wready_o,
    // -- -- B channel          
    output  [MST_ID_W-1:0]                  m_bid_o,
    output  [TRANS_RESP_W-1:0]              m_bresp_o,
    output                                  m_bvalid_o,
    // -- -- AR channel         
    output                                  m_arready_o,
    // -- -- R channel          
    output  [DATA_W-1:0]                    m_rdata_o,
    output  [TRANS_RESP_W-1:0]              m_rresp_o,
    output                                  m_rlast_o,
    output                                  m_rvalid_o,
    // -- SCCB Master Interface
    output                                  sio_c,
    inout                                   sio_d
);


    // Module instances
    axi4_ctrl #(
        
    ) ac (
        
    );

    sccb_timing_gen #(
    
    ) stg (
        
    );

    sccb_fsm #(
    
    ) sf (
        
    );


endmodule