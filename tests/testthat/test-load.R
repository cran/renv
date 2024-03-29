
test_that("invalid lockfile entries are reported", {

  renv_tests_scope()
  renv_scope_options(repos = NULL)

  expect_warning(renv_load_r(getwd(), NULL))
  expect_warning(renv_load_r(getwd(), list()))

  # this used to be a warning, but now we just write as an info message
  # expect_warning(renv_load_r(getwd(), list(Version = "1.0.0")))

})

test_that("renv/settings.R is sourced on load if available", {
  renv_tests_scope()
  ensure_directory("renv")
  writeLines("options(renv.test.dummy = 1)", con = "renv/settings.R")
  renv_load_settings(getwd())
  expect_equal(getOption("renv.test.dummy"), 1)
  options(renv.test.dummy = NULL)
})

test_that("errors when sourcing user profile are reported", {
  skip_on_cran()
  renv_tests_scope()
  renv_scope_options(renv.config.user.profile = TRUE)
  profile <- renv_scope_tempfile("renv-profile-", fileext = ".R")
  writeLines("stop(1)", con = profile)
  renv_scope_envvars(R_PROFILE_USER = profile)
  tryCatch(expect_warning(renv_load_rprofile(getwd())), error = identity)
})

test_that("load() installs packages if needed", {

  renv_tests_scope("breakfast")
  renv_scope_envvars(RENV_CONFIG_STARTUP_QUIET = "FALSE")

  install("bread")
  init()
  unlink("renv/library", recursive = TRUE)

  expect_snapshot(load())

})

test_that("load() reports on problems", {

  renv_scope_libpaths()
  renv_tests_scope()
  renv_scope_envvars(RENV_CONFIG_STARTUP_QUIET = "FALSE")

  renv_tests_scope("egg")
  init()
  record("egg@2.0.0")

  expect_snapshot(load())

})
