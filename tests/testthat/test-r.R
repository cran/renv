
test_that("we can use R CMD build to build a package", {
  skip_on_cran()
  if (renv_platform_windows()) {
    zip <- Sys.which("zip")
    if (!nzchar(zip))
      skip("test requires 'zip'")
  }

  testdir <- renv_scope_tempfile("renv-r-tests-")
  ensure_directory(testdir)
  # R CMD install creates file in working directory
  renv_scope_wd(testdir)

  package <- "sample.package"
  pkgdir <- file.path(testdir, package)
  ensure_directory(pkgdir)

  data <- list(Package = package, Type = "Package", Version = "0.1.0")
  renv_dcf_write(data, file = file.path(pkgdir, "DESCRIPTION"))
  expect_equal(renv_project_type(pkgdir), "package")

  tarball <- r_cmd_build(package, pkgdir)
  ensure_existing_path(tarball)
  ensure_existing_file(tarball)
  expect_true(file.exists(tarball))
  files <- renv_archive_list(tarball)
  expect_true(all(c("DESCRIPTION", "NAMESPACE", "MD5") %in% basename(files)))

  # NOTE: R 3.6 seems to check the permissions of the target library,
  # even when you just want to build a binary?
  before <- list.files(testdir)
  args <- c(
    "CMD", "INSTALL",
    "-l", renv_shell_path(tempdir()),
    "--no-multiarch",
    "--build", package
  )
  output <- r(args, stdout = TRUE, stderr = TRUE)
  after <- list.files(testdir)
  binball <- renv_vector_diff(after, c("NULL", before))

  expect_true(length(binball) == 1L)
  expect_equal(renv_package_type(binball), "binary")
})

test_that("we can supply custom options to R CMD INSTALL", {
  skip_on_cran()
  renv_tests_scope()

  # work in new renv context (don't re-use cache)
  renv_scope_envvars(RENV_PATHS_ROOT = renv_scope_tempfile())

  # make install 'fail' with bad option
  renv_scope_options(install.opts = list(oatmeal = "--version"))
  expect_error(install("oatmeal"))
})
