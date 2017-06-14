#!/usr/bin/gnuplot
# vim: syntax=gnuplot

set terminal x11 persist \
  font "mbfont:DejaVuSans,15" \
  enhanced size 1024,768

#set terminal pngcairo \
#  font "mbfont:DejaVuSans,15" \
#  enhanced size 1024,768
#set output "rxpower.png"

set xdata time
set timefmt "%s"

set xtics rotate out
set format x "%b %d"

#set xtics 86400
#unset mxtics
set grid xtics linetype 1 linecolor rgb "gray"

set ylabel "dBm"
set ytics 1
set grid ytics linetype 1 linecolor rgb "gray"
set yrange [-18:4]

set y2label "°C"
set y2tics 1
set ytics nomirror
set y2range [20:50]

plot 'gpon.dat' \
     using 1:2 with lines title "RxPower", \
  '' using 1:3 with lines title "TxPower", \
  '' using 1:6 with lines axes x1y2 title "Temperature"

