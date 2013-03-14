# a script to calculate the statistics for the strain vs strain in the drop tower and instron

gilchrist.strains <- data.frame(
  row.names = c('H1168R','H1365R','H1366R','H1368R','H1372R','H1373R','H1374R','H1375L','H1376L','H1380R','H1381R','H1382L'),
  dt.strain = c(-0.088519,-0.20108,NaN,-0.25926,-0.20183,-0.22391,-0.21516,-0.31577,-0.23411,-0.081642,-0.15576,-0.11694),
  ins.strain = c(-0.19326,-0.26511,NaN,-0.31671,-0.30983,-0.23404,-0.21259,-0.31601,-0.23949,-0.21072,-0.21062,-0.22917))

test4difference.t <- t.test(gilchrist.strains$dt.strain,gilchrist.strains$ins.strain,paired=T)
test4difference.w <- wilcox.test(gilchrist.strains$dt.strain,gilchrist.strains$ins.strain,paired=T)

test4insGreater.t <- t.test(gilchrist.strains$dt.strain,gilchrist.strains$ins.strain,paired=T,alternative="greater")
test4insGreater.w <-wilcox.test(gilchrist.strains$dt.strain,gilchrist.strains$ins.strain,paired=T,alternative="greater")

