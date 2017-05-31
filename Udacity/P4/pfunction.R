if(TRUE){
draw_bar_plot <- function(df_var, title_label, x_label, axis_text_size = 20, ptext_size = 5, color_fill = 'Sky Blue'){
    library(ggplot2)
    library(dplyr)
    # Remove all NA values
    # Name the column as "x" since it is blank now
    p_df_var <- df_var %>% subset(!is.na(df_var)) %>% as.data.frame
    colnames(p_df_var)[1] <- "x"

    if (levels(p_df_var$x) %>% is.null){
        p_df_var$x <- p_df_var$x %>% ordered(levels = (unique(p_df_var$x) %>% sort))
    }
    # Remove all NA values
    # Even though the name of first column of the df_table is not blank,
    # However we should name as "x" because we want to put the percentage on the same plot
    p_df_var_table <- table(p_df_var) %>% as.data.frame
    p_df_var_table$percent <- (100 * p_df_var_table$Freq / nrow(p_df_var)) %>% sprintf('%1.1f%%',.) %>% as.character
    colnames(p_df_var_table)[1] <- 'x'

    if(FALSE){
        print(p_df_var_table)
    }

    # ggplot +
    p_bar_plot <- p_df_var %>%
        ggplot(aes(x = x), data = .) +
        geom_bar(width = .9, fill = color_fill, aes(alpha = factor(..count..))) +
        theme_minimal() +
        scale_x_discrete(drop = FALSE) +
        theme(text = element_text(color = '#458b74', face = 'bold', size = 10),
            axis.text = element_text(color = '#a52a2a', size = axis_text_size),
            legend.position = 'none') +
        geom_text(data = p_df_var_table, aes(x = x, y = Freq, label = percent), hjust = 0.4,
            color = 'Black', size = ptext_size, fontface = 2) +
        labs(title = title_label, x = x_label) +
        coord_flip()
    return(p_bar_plot)
}
}


if(FALSE){
draw_group_bar_plot <- function(df_2vars, title_label, x_label, y_label, axis_text_size = 20, xjust = 0.4, text_size = 5){
    library(ggplot2)
    library(dplyr)
    # Remove all NA values
    # Name the column as "x" since it is blank now
    p_df_2vars <- df_2vars
    colnames(p_df_2vars)[1] <- "x"
    colnames(p_df_2vars)[2] <- "y"
    p_df_2vars <- p_df_2vars %>% subset(!is.na(x) & !is.na(y)) %>% as.data.frame
    if (levels(p_df_var$x) %>% is.null){
        p_df_var$x <- p_df_var$x %>% ordered(levels = (unique(p_df_var$x) %>% sort))
    }
    else {
        p_df_2vars$x <- droplevels(p_df_2vars$x)
        p_df_2vars$x <- p_df_2vars$x %>% ordered(levels = (unique(p_df_2vars$x) %>% sort))
    }
    p_df_2vars$y <- droplevels(p_df_2vars$y)
    p_df_2vars$y <- p_df_2vars$y %>% ordered(levels = (unique(p_df_2vars$y) %>% sort))
    # Remove all NA values
    # Even though the name of first column of the df_table is not blank,
    # However we should name as "x" because we want to put the percentage on the same plot
    p_df_2vars_table <- table(p_df_2vars$x, p_df_2vars$y) %>% as.data.frame
    p_df_2vars_table$percent <- (100 * p_df_2vars_table$Freq / sum(p_df_2vars_table$Freq))
    p_df_2vars_table$percent[p_df_2vars_table$percent < 1] = NA
    p_df_2vars_table$percent <- p_df_2vars_table$percent %>% sprintf('%1.1f%%',.) %>% as.character
    p_df_2vars_table$percent[p_df_2vars_table$percent == "NA%"] = NA
    colnames(p_df_2vars_table)[1] <- 'x'
    colnames(p_df_2vars_table)[2] <- 'y'


    if(FALSE){
        print(p_df_2vars_table)
    }

    # ggplot +
    p_group_bar_plot <- p_df_2vars %>%
        ggplot(aes(x = x, fill = y), data = .) +
        geom_bar(position = "dodge") +
        theme_minimal() +
        theme(text = element_text(color = '#458b74', face = 'bold', size = 15),
            axis.text = element_text(color = '#a52a2a', size = axis_text_size)) +
        geom_text(data = p_df_2vars_table, aes(x = x, y = Freq, label = percent),
            position = position_dodge(width =0.9), hjust = xjust,
            color = 'Black', vjust = 1, size = text_size, fontface = 2) +
        labs(title = title_label, x = x_label) +
        guides(fill=guide_legend(title= y_label))
       # coord_flip()
    return(p_group_bar_plot)
}
}


if(TRUE){
draw_group_bar_plot <- function(df_2vars, title_label, x_label, y_label, axis_text_size = 20, text_size = 5){
    library(ggplot2)
    library(dplyr)
    library(RColorBrewer)
    # Remove all NA values
    # Name the column as "x" since it is blank now
    p_df_2vars <- df_2vars
    colnames(p_df_2vars)[1] <- "x"
    colnames(p_df_2vars)[2] <- "y"
    p_df_2vars <- p_df_2vars %>% subset(!is.na(x) & !is.na(y)) %>% as.data.frame
    if (levels(p_df_2vars$x) %>% is.null){
        p_df_2vars$x <- p_df_2vars$x %>% ordered(levels = (unique(p_df_2vars$x) %>% sort))
    }
    else {
        p_df_2vars$x <- droplevels(p_df_2vars$x)
        p_df_2vars$x <- p_df_2vars$x %>% ordered(levels = (unique(p_df_2vars$x) %>% sort))
    }
    p_df_2vars$y <- droplevels(p_df_2vars$y)
    p_df_2vars$y <- p_df_2vars$y %>% ordered(levels = (unique(p_df_2vars$y) %>% sort))
    # Remove all NA values
    # Even though the name of first column of the df_table is not blank,
    # However we should name as "x" because we want to put the percentage on the same plot
    p_df_2vars_table <- table(p_df_2vars$x, p_df_2vars$y) %>% as.data.frame
    p_df_2vars_table$percent <- (100 * p_df_2vars_table$Freq / sum(p_df_2vars_table$Freq))
    p_df_2vars_table$percent[p_df_2vars_table$percent < 1] = NA
    p_df_2vars_table$percent <- p_df_2vars_table$percent %>% sprintf('%1.1f%%',.) %>% as.character
    p_df_2vars_table$percent[p_df_2vars_table$percent == "NA%"] = NA
    colnames(p_df_2vars_table)[1] <- 'x'
    colnames(p_df_2vars_table)[2] <- 'y'


    if(FALSE){
        print(p_df_2vars_table)
    }

    ny <- p_df_2vars$y %>% levels %>% length
    color_vals <- brewer.pal(ny, "Set2")

    # ggplot +
    p_group_bar_plot <- p_df_2vars %>%
        ggplot(aes(x = x, fill = y), data = .) +
        geom_bar(position = "fill") +
        scale_y_continuous(labels = percent_format()) +
        theme_minimal() +
        scale_fill_manual(values = color_vals) +
        theme(text = element_text(color = '#458b74', face = 'bold', size = text_size),
            axis.text = element_text(color = '#a52a2a', size = axis_text_size)) +
        labs(title = title_label, x = x_label) +
        guides(fill=guide_legend(title= y_label))
       # coord_flip()
    return(p_group_bar_plot)
}
}




























