awk -F\; '/act=order/{print $4}' 20.log | sed 's/plist=//'> to_order.log
Rscript sale_rank.R
