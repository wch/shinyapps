context("lint")

test_that("linter warns about absolute paths and relative paths", {
  
  serverPath <- list.files("shinyapp-with-absolute-paths", pattern = "server\\.R$")
  result <- lint("shinyapp-with-absolute-paths")
  
  printLinterResults(result)
  
  absPathLintedIndices <- result[[serverPath]]$absolute.paths$indices
  expect_identical(as.numeric(absPathLintedIndices), c(15, 16, 18))
  
  relPathLintedIndices <- result[[serverPath]]$invalid.relative.paths$indices
  expect_identical(as.numeric(relPathLintedIndices), 17)
  
})

test_that("badRelativePaths identifies bad paths correctly", {
  
  path <- "R/test.R"
  ok <- "file.path('../inst/include')"
  expect_false(badRelativePaths(ok, path = path))
  
  bad <- "file.path('../../elsewhere')"
  expect_true(badRelativePaths(bad, path = path))
  
  ok <- "'../foo', '../bar', '../baz'"
  expect_false(badRelativePaths(ok, path = path))
    
})

test_that("The linter identifies invalid application structures", {
  expect_error(lint("."))
  expect_error(lint("shiny-app-in-subdir"))
  lint("shiny-app-in-subdir/my-app")
  file.create("shiny-app-in-subdir/index.html")
  lint("shiny-app-in-subdir")
  file.remove("shiny-app-in-subdir/index.html")
})
