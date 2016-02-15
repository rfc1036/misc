# vim: syntax=tt2
[%
SET days = (end_time - start_time) / 86400
%]
# [% days %] days

[% IF outfile.match('\.png$') %]
set terminal pngcairo \
  font "mbfont:DejaVuSans,10" \
  enhanced size 1024,768
set output "[% outfile %]"
[% ELSIF NOT outfile %]
set terminal x11 persist \
  font "mbfont:DejaVuSans,15" \
  enhanced size 1024,768
[% ELSE %]
[% THROW 'invalid output file format' %]
[% END %]

set xdata time
set timefmt "%s"

set xtics rotate out
set format x "%b %d"

[% IF days < 90 %]
# for daily tics
set xtics 86400
unset mxtics
set grid xtics linetype 1 linecolor rgb "gray"
[% END %]

set xrange ["[% start_time %]":"[% end_time %]"]

set ylabel "°C"
set ytics 1
set grid ytics linetype 1 linecolor rgb "gray"

#set yrange [18:34]

set style rectangle \
  fillcolor rgb "cyan" \
  fillstyle transparent pattern 2 noborder

[% IF NOT (start_time > 1381788000 AND end_time < 1397512800) %]
# 1381788000 date --date="2013-10-15" +%s
# 1397512800 date --date="2014-4-15" +%s
set obj rectangle from first "1381788000", graph 0 to "1397512800", graph 1
[% END %]

[% IF NOT (start_time > 1413324000 AND end_time < 1429048800) %]
# 1413324000 date --date="2014-10-15" +%s
# 1429048800 date --date="2015-4-15" +%s
set obj rectangle from first "1413324000", graph 0 to "1429048800", graph 1
[% END %]

[% IF NOT (start_time > 1444860000 AND end_time < 1460671200) %]
# 1444860000 date --date="2015-10-15" +%s
# 1460671200 date --date="2016-4-15" +%s
set obj rectangle from first "1444860000", graph 0 to "1460671200", graph 1
[% END %]

plot '[% data %]' \
  using 1:2 with lines title "Temperatura" [% IF data2 %], \
  '[% data2 %]' using 1:2 with lines title "ARPA Corsico" [% END +%]

