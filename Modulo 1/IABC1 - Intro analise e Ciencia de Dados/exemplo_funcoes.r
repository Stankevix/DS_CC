installed.packages("Lahman")
installed.packages("tidyverse")
installed.packages("dslabs")

library(Lahman)
library(tidyverse)
library(dslabs)
ds_theme_set()

Team_mutated <-Teams %>% filter(yearID %in% 1961:2001) %>%
  mutate(HR_per_game = HR / G, R_per_game = R / G) %>%
  ggplot(aes(HR_per_game, R_per_game)) + 
  geom_point(alpha = 0.5)

head(Team_mutated,10)

res <- cor.test(Team_mutated$data$HR_per_game, Team_mutated$data$R_per_game, 
                method = "pearson")
res