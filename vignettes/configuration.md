---
title: "Configuring renv"
author: "Kevin Ushey"
date: "2020-07-24"
output:
   rmarkdown::html_vignette:
      keep_md: true
      pandoc_args:
         - --columns=1000
vignette: >
  %\VignetteIndexEntry{Configuring renv}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---




`renv` is a tool, and we acknowledge that different users will want to use `renv`
in different ways. To this end, it's possible to configure `renv` in a variety
of ways -- either through project-specific settings, or user-specific configuration.


## Project Settings

Project-specific settings can be accessed and set through the `renv::settings`
helper object. For example, we can instruct `renv` to ignore the package `dplyr`
in a project by setting:


```r
renv::settings$ignored.packages("dplyr")
```

You can then query the set of ignored packages by calling the same function
without arguments:


```r
renv::settings$ignored.packages()
```

Please see the documentation in `?renv::settings` for more information.


## User Configuration

The options available are documented in `?renv::config`, but are repeated here for
reference. Configuration options can be set either via environment variables;
typically set within an appropriate `.Renviron` start-up file:

    # check whether renv.lock + project library are synchronized on startup
    RENV_CONFIG_SYNCHRONIZED_CHECK = TRUE

Alternatively, these options can be set via an R option:

    # check whether renv.lock + project library are synchronized on startup
    options(renv.config.synchronized.check = TRUE)

The options available in `renv` 0.11.0-5 are:


name                    type           default                 description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
----------------------  -------------  ----------------------  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
auto.snapshot           logical[1]     FALSE                   Automatically snapshot changes to the project library after a new package is installed with `renv::install()`, or removed with `renv::remove()`?                                                                                                                                                                                                                                                                                                                                                                                                                                        
bitbucket.host          character[1]   api.bitbucket.org/2.0   The default Bitbucket host to be used during package retrieval.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
copy.method             *              auto                    The method to use when attempting to copy directories. See **Copy Methods** for more information.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
connect.timeout         integer[1]     20                      The amount of time to spend (in seconds) when attempting to download a file. Only used when the `curl` downloader is used.                                                                                                                                                                                                                                                                                                                                                                                                                                                              
connect.retry           integer[1]     3                       The number of times to attempt re-downloading a file, when transient errors occur. Only used when the `curl` downloader is used.                                                                                                                                                                                                                                                                                                                                                                                                                                                        
dependency.errors       character[1]   reported                Many `renv` APIs require the enumeration of your project's \R package dependencies. This option controls how errors that occur during this enumeration are handled. By default, errors are reported but are non-fatal. Set this to `"fatal"` to force errors to be fatal, and `"ignored"` to ignore errors altogether. See [dependencies] for more details.                                                                                                                                                                                                                             
external.libraries      character[*]   NULL                    A character vector of external libraries, to be used in tandem with your projects. Be careful when using external libraries: it's possible that things can break within a project if the version(s) of packages used in your project library happen to be incompatible with packages in your external libraries; for example, if your project required `xyz 1.0` but `xyz 1.1` was present and loaded from an external library. Can also be an \R function that provides the paths to external libraries. Library paths will be expanded through [.expand_R_libs_env_var] as necessary. 
filebacked.cache        logical[1]     TRUE                    Enable the `renv` file-backed cache? When enabled, `renv` will cache the contents of files that are read (e.g. DESCRIPTION files) in memory, thereby avoiding re-reading the file contents from the filesystem if the file has not changed. `renv` uses the file `mtime` to determine if the file has changed; consider disabling this if `mtime` is unreliable on your system.                                                                                                                                                                                                         
github.host             character[1]   api.github.com          The default GitHub host to be used during package retrieval.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
gitlab.host             character[1]   gitlab.com              The default GitLab host to be used during package retrieval.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
hydrate.libpaths        character[*]   NULL                    A character vector of library paths, to be used by `renv::hydrate()` when attempting to hydrate projects. When empty, the default set of library paths (as specified in `?hydrate`) are used instead. See [`hydrate`] for more details.                                                                                                                                                                                                                                                                                                                                                 
install.staged          logical[1]     TRUE                    DEPRECATED: Please use `install.transactional` instead.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
install.transactional   logical[1]     TRUE                    Perform a transactional install of packages during install and restore? When enabled, `renv` will first install packages into a temporary library, and later copy or move those packages back into the project library only if all packages were successfully downloaded and installed. This can be useful if you'd like to avoid mutating your project library if installation of one or more packages fails.                                                                                                                                                                          
mran.enabled            logical[1]     TRUE                    Attempt to download binaries from [MRAN](https://mran.microsoft.com/) during restore? See `vignette("mran", package = "renv")` for more details.                                                                                                                                                                                                                                                                                                                                                                                                                                        
repos.override          character[*]   NULL                    Override the R package repositories used during [`restore`]. Primarily useful for deployment / continuous integration, where you might want to enforce the usage of some set of repositories over what is defined in `renv.lock` or otherwise set by the R session.                                                                                                                                                                                                                                                                                                                     
rspm.enabled            logical[1]     TRUE                    Boolean; enable RSPM integration for `renv` projects? When `TRUE`, `renv` will attempt to transform the repository URLs used by RSPM into binary URLs as appropriate for the current platform. Set this to `FALSE` if you'd like to continue using source-only RSPM URLs, or if you find that `renv` is improperly transforming your repository URLs.                                                                                                                                                                                                                                   
sandbox.enabled         logical[1]     TRUE                    Enable sandboxing for `renv` projects? When active, `renv` will attempt to sandbox the system library, preventing non-system packages installed in the system library from becoming available in `renv` projects. (That is, only packages with priority `"base"` or `"recommended"`, as reported by `installed.packages()`, are made available.)                                                                                                                                                                                                                                        
shims.enabled           logical[1]     TRUE                    Should `renv` shims be installed on package load? When enabled, `renv` will install its own shims over the functions `install.packages()`, `update.packages()` and `remove.packages()`, delegating these functions to `renv::install()`, `renv::update()` and `renv::remove()` as appropriate.                                                                                                                                                                                                                                                                                          
snapshot.validate       logical[1]     TRUE                    Validate \R package dependencies when calling snapshot? When `TRUE`, `renv` will attempt to diagnose potential issues in the project library before creating `renv.lock` -- for example, if a package installed in the project library depends on a package which is not currently installed.                                                                                                                                                                                                                                                                                           
synchronized.check      logical[1]     FALSE                   Check that the project library is synchronized with the lockfile on load?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
updates.check           logical[1]     FALSE                   Check for package updates when the session is initialized? This can be useful if you'd like to ensure that your project lockfile remains up-to-date with packages as they are released on CRAN.                                                                                                                                                                                                                                                                                                                                                                                         
updates.parallel        *              2                       Check for package updates in parallel? This can be useful when a large number of packages installed from non-CRAN remotes are installed, as these packages can then be checked for updates in parallel.                                                                                                                                                                                                                                                                                                                                                                                 
user.library            logical[1]     FALSE                   Include the user library on the library paths for your projects? Note that this risks breaking project encapsulation and is not recommended for projects which you intend to share or collaborate on with other users. See also the caveats for the `external.libraries` option.                                                                                                                                                                                                                                                                                                        
user.profile            logical[1]     FALSE                   Load the user R profile (typically located at `~/.Rprofile`) when `renv` is loaded? Consider disabling this if you require extra encapsulation in your projects; e.g. if your `.Rprofile` attempts to load packages that you might not install in your projects.                                                                                                                                                                                                                                                                                                                        

### Project Settings

Project settings are used to control project-specific options, and are appropriate
for settings that should:

1. Be tied to a particular project, and
2. Apply to all users of a particular project.

See the documentation in `?renv::settings` for more details.


### User Configuration

User-specific configuration can be used to control settings that should apply
for a particular user (e.g. yourself) across multiple `renv` project. See the
documentation in `?renv::config` for more details.
