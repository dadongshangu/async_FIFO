#-----------------------------------------------------------------------------
# SDC Timing Assertions for async_fifo 
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Clock definitions

# The rclk period is user-defined.
set PERIOD 1000.0

create_clock -name rclk -period $PERIOD [get_ports rclk]
create_clock -name wclk -period $PERIOD [get_ports wclk]


# Set the clock transition time to a value compatible with its period.
set CTRANSITION 40.0
set_clock_transition  $CTRANSITION  rclk
set_input_transition  $CTRANSITION  [get_ports rclk]

set_clock_transition  $CTRANSITION  wclk
set_input_transition  $CTRANSITION  [get_ports wclk]

# Set the clock uncertainty to a value compatible with its period.
set UNCERTAINTY 50.0
set_clock_uncertainty -setup $UNCERTAINTY [get_clocks rclk]
set_clock_uncertainty -setup $UNCERTAINTY [get_clocks wclk]

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Input assertions

# Set the data transition time to a value compatible with the Pclk period.
set DTRANSITION 50.0

# Set the input max cap load to a value compatible with the target library.
set ILOAD 5.0

# Input delay times:
#   PI10 = Input is valid at 10% of cycle
#   PI25 = Input is valid at 25% of cycle
#   PI50 = Input is valid at 50% of cycle
#   PI75 = Input is valid at 75% of cycle
#   PI90 = Input is valid at 90% of cycle

#   Begin   = PI10
#   Early   = PI25
#   Middle  = PI50
#   Late    = PI75
#   End     = PI90

set PI10 [expr $PERIOD * 0.10]
set PI25 [expr $PERIOD * 0.25]
set PI50 [expr $PERIOD * 0.50]
set PI75 [expr $PERIOD * 0.75]
set PI90 [expr $PERIOD * 0.90]

set_input_transition  $DTRANSITION                    [all_inputs]
set_max_capacitance   $ILOAD                          [all_inputs]

#-----------------------------------------------------------------------------
# Output assertions

# Set the output cap load to a value compatible with the target library.
set OLOAD 10.0

# Output delay times:
#   PO10 = Output is valid at 10% of cycle
#   PO25 = Output is valid at 25% of cycle
#   PO50 = Output is valid at 50% of cycle
#   PO75 = Output is valid at 75% of cycle
#   PO90 = Output is valid at 90% of cycle

#   Begin   = PO10
#   Early   = PO25
#   Middle  = PO50
#   Late    = PO75
#   End     = PO90

set PO10 [expr $PERIOD * ( 1.0 - 0.10 ) - $UNCERTAINTY]
set PO25 [expr $PERIOD * ( 1.0 - 0.25 ) - $UNCERTAINTY]
set PO50 [expr $PERIOD * ( 1.0 - 0.50 ) - $UNCERTAINTY]
set PO75 [expr $PERIOD * ( 1.0 - 0.75 ) - $UNCERTAINTY]
set PO90 [expr $PERIOD * ( 1.0 - 0.90 ) - $UNCERTAINTY]

set_load $OLOAD [all_outputs]

#--------------------------------------------------------------------------
# input assertions
#--------------------------------------------------------------------------
#
set_input_delay $PI90 -clock rclk [get_ports rinc]
set_input_delay $PI90 -clock wclk [get_ports winc]
set_input_delay $PI90 -clock wclk [get_ports wdata]

#--------------------------------------------------------------------------
# Output assertions
#--------------------------------------------------------------------------
set_output_delay $PO10 -clock rclk [get_ports rempty]
set_output_delay $PO10 -clock rclk [get_ports rdata]
set_output_delay $PO10 -clock wclk [get_ports wfull]

