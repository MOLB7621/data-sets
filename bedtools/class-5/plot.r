# install.packages(c('readr', 'dplyr', 'cowplot'))
library(readr)
library(dplyr)
library(cowplot)

tab <- read_tsv('signal.tab', col_names = c('pos', 'signal'))

tab <- tab %>% mutate(coord = seq(-1000, 1000, length.out = 40))

gp <- ggplot(tab, aes(x = coord, y = signal))
gp <- gp + geom_point() + geom_line() + geom_vline(xintercept = 0, color = 'red')
gp <- gp + xlim(c(-1000, 1000))
gp <- gp + xlab('Position (bp)') + ylab('Signal (arbitrary units)')
gp <- gp + ggtitle('CTCF binding near TSS on chr22')

gp
# ggsave('plot.png', gp)
