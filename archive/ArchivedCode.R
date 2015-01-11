## Methodology over time

```{r echo=FALSE}
year <- filter(pi.df, attributes == "YR") %>%
    mutate(year = as.numeric(record)) %>% select(-record, -attributes)


methodology <- pi.df %>%
    filter(attributes == "MD") %>%
    select(articleID = articleID, method = record) %>%
    mutate(method = gsub(" ", "", method))

methodology.year <- methodology %>%
    left_join(year) %>%
    group_by(method, year) %>%
    summarise(n = n()) %>%
    arrange(method, year, n)

methodology.year.top <- slice(methodology.table, 1:5) %>%
    rename(method = methodology.terms) %>%
    mutate(method = gsub(" ", "", method))

methodology.year.reduced <- methodology.year %>%
    filter(method %in% methodology.year.top$method)

ggplot(methodology.year.reduced, aes(x = year, y = n, colour = method)) +
    geom_line()
```

