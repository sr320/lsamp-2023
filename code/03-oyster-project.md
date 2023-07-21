oyster project 1
================
Noah Krebs
2023-07-07

I want to graph intitial size data.

``` r
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──


REad in data

There are three interrelated rules which make a dataset tidy:

Each variable must have its own column. Each observation must have its
own row. Each value must have its own cell.

``` r
init <- read.csv("../data/initial-shell-length.csv", header = TRUE)
```

``` r
ggplot(data = init, mapping = aes(x = history, y = Length)) + 
  geom_boxplot()
```

![](03-oyster-project_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

``` r
oysdata <- read.csv("../data/sampling-data.csv", header = TRUE)
```

``` r
ggplot(data = oysdata, mapping = aes(x = Sex, y = Length)) + 
  geom_boxplot()
```

![](03-oyster-project_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
ggplot(data = oysdata, mapping = aes(x = group, y = Length)) + 
  geom_boxplot()
```

![](03-oyster-project_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

``` r
ggplot(data = oysdata, mapping = aes(x = subgroup, y = Length)) + 
  geom_boxplot()
```

![](03-oyster-project_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

``` r
ggplot(data = oysdata, mapping = aes(y = Length)) + 
  geom_bar()
```

![](03-oyster-project_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->
<<<<<<< HEAD
=======

``` r
ggplot(data = oysdata, mapping = aes(x = Individual, y = Length)) + 
  geom_boxplot()
```

![](03-oyster-project_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

