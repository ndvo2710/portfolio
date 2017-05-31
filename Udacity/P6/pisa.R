library(tidyverse)
library(dplyr)

pisa <- read_csv('pisa2012.csv')


df_name <- data.frame(CNT = sort(unique(pisa$CNT)))
df_name


pisa %>%
select(CNT, PV1MATH, W_FSTUWT) %>%
group_by(CNT) %>%
summarise(
    COUNT_GRP =  n(),
    math_score = sum(PV1MATH*W_FSTUWT/sum(W_FSTUWT)),
    sd_math_score =
sqrt(sum(W_FSTUWT*(PV1MATH - math_score)^2)/sum(W_FSTUWT* ((COUNT_GRP-1)/COUNT_GRP))))


df_math <- pisa %>%
select(CNT, PV1MATH, W_FSTUWT) %>%
group_by(CNT) %>%
summarise(
    COUNT_GRP =  n(),
    math_score = sum(PV1MATH*W_FSTUWT/sum(W_FSTUWT)),
    sd_math_score =
sqrt(sum(W_FSTUWT*(PV1MATH - math_score)^2)/sum(W_FSTUWT* ((COUNT_GRP-1)/COUNT_GRP)))) %>%
arrange(desc(math_score))
df_math
df_math_rank <- data.frame(CNT = df_math$CNT, rank = 1:68, stringsAsFactors=FALSE)
df_math_rank
df_math_rank <- inner_join(df_name,df_math_rank, by = "CNT")
colnames(df_math_rank) = c("CNT", "math")


df_read <- pisa %>%
select(CNT, PV1READ, W_FSTUWT) %>%
group_by(CNT) %>%
summarise(
    COUNT_GRP =  n(),
    read_score = sum(PV1READ*W_FSTUWT/sum(W_FSTUWT)),
    sd_read_score =
sqrt(sum(W_FSTUWT*(PV1READ - read_score)^2)/sum(W_FSTUWT* ((COUNT_GRP-1)/COUNT_GRP)))) %>%
arrange(desc(read_score))
df_read
df_read_rank <- data.frame(CNT = df_read$CNT, rank = 1:68)
df_read_rank %>% head
df_read_rank <- inner_join(df_name,df_read_rank, by = "CNT")
colnames(df_read_rank) = c("CNT", "read")



df_sci <- pisa %>%
select(CNT, PV1SCIE, W_FSTUWT) %>%
group_by(CNT) %>%
summarise(
    COUNT_GRP =  n(),
    sci_score = sum(PV1SCIE*W_FSTUWT/sum(W_FSTUWT)),
    sd_sci_score =
sqrt(sum(W_FSTUWT*(PV1SCIE - sci_score)^2)/sum(W_FSTUWT* ((COUNT_GRP-1)/COUNT_GRP)))) %>%
arrange(desc(sci_score))
df_sci
df_sci_rank <- data.frame(CNT = df_sci$CNT, rank = 1:68, stringsAsFactors=FALSE)
df_sci_rank %>% head
df_sci_rank <- inner_join(df_name,df_sci_rank, by = "CNT")
colnames(df_sci_rank) = c("CNT", "sci")

country_rank_df <- df_math_rank %>%
inner_join(df_read_rank, by = "CNT") %>%
inner_join(df_sci_rank, by = "CNT")



country_rank_df <- country_rank_df %>%
inner_join(df_math, by = "CNT") %>%
inner_join(df_read, by = "CNT") %>%
inner_join(df_sci, by = "CNT")

country_rank_df <- country_rank_df[,c(-5,-8,-11)]


data.frame(df_math$CNT,df_read$CNT,df_sci$CNT)

country_rank_df[country_rank_df$CNT == 'Chinese Taipei', 'CNT'] = 'Chinese-Taipei'
country_rank_df[country_rank_df$CNT == 'Connecticut (USA)', 'CNT'] = 'Connecticut-USA'
country_rank_df[country_rank_df$CNT == 'Costa Rica', 'CNT'] = 'CostaRica'
country_rank_df[country_rank_df$CNT == 'Czech Republic', 'CNT'] = 'CzechRepublic'
country_rank_df[country_rank_df$CNT == 'Florida (USA)', 'CNT'] = 'Florida-USA'
country_rank_df[country_rank_df$CNT == 'Hong Kong-China', 'CNT'] = 'HongKong-China'
country_rank_df[country_rank_df$CNT == 'Massachusetts (USA)', 'CNT'] = 'Massachusetts-USA'
country_rank_df[country_rank_df$CNT == 'New Zealand', 'CNT'] = 'NewZealand'
country_rank_df[country_rank_df$CNT == 'Perm(Russian Federation)', 'CNT'] = 'Perm-RussianFederation'
country_rank_df[country_rank_df$CNT == 'Russian Federation', 'CNT'] = 'RussianFederation'
country_rank_df[country_rank_df$CNT == 'Slovak Republic', 'CNT'] = 'SlovakRepublic'
country_rank_df[country_rank_df$CNT == 'United Arab Emirates', 'CNT'] = 'UnitedArabEmirates'
country_rank_df[country_rank_df$CNT == 'United Kingdom', 'CNT'] = 'UK'
country_rank_df[country_rank_df$CNT == 'United States of America', 'CNT'] = 'USA'


country_rank_df <- data.frame(country_rank_df[,1:4],country_rank_df[,5:10] %>% round(2))
write.csv(country_rank_df, file = "country_rank.csv", row.names = FALSE)





