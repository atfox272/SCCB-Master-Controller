onerror resume
wave tags  F0
wave update off
wave zoom range 3262530 3395923
wave group {AW channel} -backgroundcolor #004466
wave add -group {AW channel} sccb_master_controller_tb.m_awid_i -tag F0 -radix hexadecimal
wave add -group {AW channel} sccb_master_controller_tb.m_awaddr_i -tag F0 -radix hexadecimal
wave add -group {AW channel} sccb_master_controller_tb.m_awlen_i -tag F0 -radix hexadecimal
wave add -group {AW channel} sccb_master_controller_tb.m_awvalid_i -tag F0 -radix hexadecimal
wave add -group {AW channel} sccb_master_controller_tb.m_awready_o -tag F0 -radix hexadecimal
wave add -group {AW channel} sccb_master_controller_tb.m_awid_i -tag F0 -radix hexadecimal
wave add -group {AW channel} sccb_master_controller_tb.m_awaddr_i -tag F0 -radix hexadecimal
wave add -group {AW channel} sccb_master_controller_tb.m_awlen_i -tag F0 -radix hexadecimal
wave add -group {AW channel} sccb_master_controller_tb.m_awvalid_i -tag F0 -radix hexadecimal
wave add -group {AW channel} sccb_master_controller_tb.m_awready_o -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave group {W channel} -backgroundcolor #006666
wave add -group {W channel} sccb_master_controller_tb.m_wdata_i -tag F0 -radix hexadecimal
wave add -group {W channel} sccb_master_controller_tb.m_wlast_i -tag F0 -radix hexadecimal
wave add -group {W channel} sccb_master_controller_tb.m_wvalid_i -tag F0 -radix hexadecimal
wave add -group {W channel} sccb_master_controller_tb.m_wready_o -tag F0 -radix hexadecimal
wave add -group {W channel} sccb_master_controller_tb.m_wdata_i -tag F0 -radix hexadecimal
wave add -group {W channel} sccb_master_controller_tb.m_wlast_i -tag F0 -radix hexadecimal
wave add -group {W channel} sccb_master_controller_tb.m_wvalid_i -tag F0 -radix hexadecimal
wave add -group {W channel} sccb_master_controller_tb.m_wready_o -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave group {B channel} -backgroundcolor #226600
wave add -group {B channel} sccb_master_controller_tb.m_bid_o -tag F0 -radix hexadecimal
wave add -group {B channel} sccb_master_controller_tb.m_bresp_o -tag F0 -radix hexadecimal
wave add -group {B channel} sccb_master_controller_tb.m_bvalid_o -tag F0 -radix hexadecimal
wave add -group {B channel} sccb_master_controller_tb.m_bready_i -tag F0 -radix hexadecimal
wave add -group {B channel} sccb_master_controller_tb.m_bid_o -tag F0 -radix hexadecimal
wave add -group {B channel} sccb_master_controller_tb.m_bresp_o -tag F0 -radix hexadecimal
wave add -group {B channel} sccb_master_controller_tb.m_bvalid_o -tag F0 -radix hexadecimal
wave add -group {B channel} sccb_master_controller_tb.m_bready_i -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave group {AR channel} -backgroundcolor #004466
wave add -group {AR channel} sccb_master_controller_tb.m_arid_i -tag F0 -radix hexadecimal
wave add -group {AR channel} sccb_master_controller_tb.m_araddr_i -tag F0 -radix hexadecimal
wave add -group {AR channel} sccb_master_controller_tb.m_arlen_i -tag F0 -radix hexadecimal -select
wave add -group {AR channel} sccb_master_controller_tb.m_arvalid_i -tag F0 -radix hexadecimal
wave add -group {AR channel} sccb_master_controller_tb.m_arready_o -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave group {R channel} -backgroundcolor #006666
wave add -group {R channel} sccb_master_controller_tb.m_rdata_o -tag F0 -radix hexadecimal
wave add -group {R channel} sccb_master_controller_tb.m_rresp_o -tag F0 -radix hexadecimal
wave add -group {R channel} sccb_master_controller_tb.m_rlast_o -tag F0 -radix hexadecimal
wave add -group {R channel} sccb_master_controller_tb.sccb_master_controller.axi4_ctrl.m_rvalid_o -tag F0 -radix hexadecimal
wave add -group {R channel} sccb_master_controller_tb.sccb_master_controller.axi4_ctrl.m_rready_i -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave group {SCCB Interface} -backgroundcolor #666600
wave add -group {SCCB Interface} sccb_master_controller_tb.sio_c -tag F0 -radix hexadecimal
wave add -group {SCCB Interface} sccb_master_controller_tb.sio_d -tag F0 -radix hexadecimal
wave add -group {SCCB Interface} sccb_master_controller_tb.sio_oe_m -tag F0 -radix hexadecimal
wave add -group {SCCB Interface} sccb_master_controller_tb.tx_data -tag F0 -radix hexadecimal -subitemconfig { {sccb_master_controller_tb.tx_data[0]} {-radix hexadecimal} {sccb_master_controller_tb.tx_data[1]} {-radix hexadecimal} {sccb_master_controller_tb.tx_data[2]} {-radix hexadecimal} }
wave add -group {SCCB Interface} sccb_master_controller_tb.tx_data_vld -tag F0 -radix hexadecimal
wave add -group {SCCB Interface} sccb_master_controller_tb.slv_st -tag F0 -radix mnemonic
wave add -group {SCCB Interface} sccb_master_controller_tb.sioc_cl_cnt -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave group CTRL_ST_FIFO -backgroundcolor #004466
wave add -group CTRL_ST_FIFO sccb_master_controller_tb.sccb_master_controller.sccb_fsm.st_q -tag F0 -radix mnemonic
wave add -group CTRL_ST_FIFO sccb_master_controller_tb.sccb_master_controller.sccb_fsm.trans_type_i -tag F0 -radix hexadecimal
wave add -group CTRL_ST_FIFO sccb_master_controller_tb.sccb_master_controller.sccb_fsm.phase_amt_i -tag F0 -radix hexadecimal
wave add -group CTRL_ST_FIFO sccb_master_controller_tb.sccb_master_controller.ctrl_vld -tag F0 -radix hexadecimal
wave add -group CTRL_ST_FIFO sccb_master_controller_tb.sccb_master_controller.sccb_fsm.ctrl_rdy -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave group SUB_ADDR -backgroundcolor #004466
wave add -group SUB_ADDR sccb_master_controller_tb.sccb_master_controller.tx_sub_adr -tag F0 -radix hexadecimal
wave add -group SUB_ADDR sccb_master_controller_tb.sccb_master_controller.tx_sub_adr_vld -tag F0 -radix hexadecimal
wave add -group SUB_ADDR sccb_master_controller_tb.sccb_master_controller.tx_sub_adr_rdy -tag F0 -radix hexadecimal
wave insertion [expr [wave index insertpoint] + 1]
wave add sccb_master_controller_tb.sccb_master_controller.sccb_fsm.tx_sub_adr_q1 -tag F0 -radix hexadecimal
wave add sccb_master_controller_tb.sccb_master_controller.sccb_fsm.sio_d_cnt_q -tag F0 -radix decimal
wave add sccb_master_controller_tb.sccb_master_controller.sccb_fsm.sio_d_data_map -tag F0 -radix hexadecimal
wave add sccb_master_controller_tb.sccb_master_controller.sccb_fsm.phase_cnt_q -tag F0 -radix hexadecimal
wave add {sccb_master_controller_tb.sccb_master_controller.axi4_ctrl.AXI4_WR_ST.genblk1[0].wr_st_fifo.clk} -tag F0 -radix hexadecimal
wave group {W channel} -collapse
wave group {AW channel} -collapse
wave update on
wave top 0
