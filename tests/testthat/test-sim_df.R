context("sim_df")

# error messages ----
test_that("error messages", {
  expect_error( sim_df("A"), "data must be a data frame or matrix" )
  expect_error( sim_df(iris, "A"), "n must be an integer > 2" )
  expect_error( sim_df(iris, 2), "n must be an integer > 2" )
  expect_error( sim_df(iris, 10, between = FALSE), "between must be a numeric or character vector" )
})

# default parameters ----
test_that("default parameters", {
  newdf <- sim_df(iris)

  expect_equal(nrow(newdf), 100)
  expect_equal(ncol(newdf), 5)
  expect_equal(names(newdf)[2:5], names(iris)[1:4])
})

# specified parameters ----
test_that("specified parameters", {
  n <- 100
  dat <- tibble::as_tibble(iris) %>%
    dplyr::select_if(is.numeric)
  cors <- cor(dat)
  means <- dplyr::summarise_all(dat, mean) %>%
    as.data.frame()
  sds <- dplyr::summarise_all(dat, sd) %>%
    as.data.frame()
  
  # unnamed arguments in order
  newdf <- sim_df(iris, n, empirical = TRUE)
  newdat <- dplyr::select_if(newdf, is.numeric)
  newcors <- cor(newdat)
  newmeans <- dplyr::summarise_all(newdat, mean) %>%
    as.data.frame()
  newsds <- dplyr::summarise_all(newdat, sd) %>%
    as.data.frame()
  
  expect_equal(nrow(newdf), n)
  expect_equal(ncol(newdf), 5)
  expect_equal(names(newdf)[2:5], names(iris)[1:4])
  
  expect_equal(cors, newcors)
  expect_equal(means, newmeans)
  expect_equal(sds, newsds)
  
  # named arguments out of order
  newdf <- sim_df(between = c(), empirical = TRUE, data = iris, n = n)
  newdat <- dplyr::select_if(newdf, is.numeric)
  newcors <- cor(newdat)
  newmeans <- dplyr::summarise_all(newdat, mean) %>%
    as.data.frame()
  newsds <- dplyr::summarise_all(newdat, sd) %>%
    as.data.frame()
  
  expect_equal(nrow(newdf), n)
  expect_equal(ncol(newdf), 5)
  expect_equal(names(newdf)[2:5], names(iris)[1:4])
  
  expect_equal(cors, newcors)
  expect_equal(means, newmeans)
  expect_equal(sds, newsds)
  
})

# grouping by name ----
test_that("grouping by name", {
  newdf <- sim_df(iris, 20, between = "Species")
  
  expect_equal(nrow(newdf), 60)
  expect_equal(ncol(newdf), 6)
  expect_equal(names(newdf)[2:6] %>% sort(), names(iris) %>% sort())
})

# grouping by col number ----
test_that("grouping by col number", {
  newdf <- sim_df(iris, 20, between = 5)
  
  expect_equal(nrow(newdf), 60)
  expect_equal(ncol(newdf), 6)
  expect_equal(names(newdf)[2:6] %>% sort(), names(iris) %>% sort())
})

# within ----
test_that("within", {
  long_iris <- wide2long(
    iris,
    within_factors = c("feature", "dimension"),
    within_cols = c("Petal.Length", "Petal.Width", "Sepal.Length", "Sepal.Width"),
    dv = "val",
    id = "sub_id", 
    sep = "\\."
  )
  
  newdf <- sim_df(long_iris, 20, 
                  within = c("feature", "dimension"),
                  between = "Species",
                  dv = "val", id = "sub_id")
  
  expect_equal(names(newdf), c("sub_id", "Species", "Petal_Length", "Petal_Width", "Sepal_Length", "Sepal_Width" ))
})

# test_that("mean stats are close over 1000 runs", {
#   skip_on_cran()
#   
#   simiris <- purrr::map_df(1:1000, function(i) {
#     iris %>%
#       sim_df(100) %>%
#       check_sim_stats(digits = 10)
#   })
#   
#   orig_stats <- iris %>%
#     check_sim_stats(digits = 10) %>%
#     dplyr::arrange(var) %>%
#     as.data.frame()
#   
#   sim_stats <- simiris %>% 
#     dplyr::group_by(var) %>%
#     dplyr::summarise_all(mean) %>%
#     dplyr::arrange(var) %>%
#     as.data.frame()
#   
#   expect_equal(orig_stats, sim_stats, tolerance = 0.02)
# })

# seed ----
test_that("seed", {
  # setting seed returns same DF, but is reset
  set.seed(1)
  rnd0 <- rnorm(1)
  df1 <- sim_df(iris, seed = 910210)
  rnd1 <- rnorm(1)
  df2 <- sim_df(iris, seed = 910210)
  rnd2 <- rnorm(1)
  set.seed(1)
  rnd0b <- rnorm(1)
  rnd1b <- rnorm(1)
  rnd2b <- rnorm(1)
  df3 <- sim_df(iris, seed = 8675309)
  
  expect_equal(df1, df2)
  expect_false(rnd1 == rnd2)
  expect_equal(rnd0, rnd0b)
  expect_equal(rnd1, rnd1b)
  expect_equal(rnd2, rnd2b)
  expect_true(!identical(df1, df3))
  
  # user sets seed externally
  set.seed(1)
  df4 <- sim_df(iris, n = 10)
  set.seed(1)
  df5 <- sim_df(iris, n = 10)
  expect_equal(df4, df5)
})
