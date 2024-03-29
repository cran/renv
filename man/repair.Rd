% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/repair.R
\name{repair}
\alias{repair}
\title{Repair a project}
\usage{
repair(library = NULL, lockfile = NULL, project = NULL)
}
\arguments{
\item{library}{The \R library to be used. When \code{NULL}, the active project
library will be used instead.}

\item{lockfile}{The path to a lockfile (if any). When available, renv
will use the lockfile when attempting to infer the remote associated
with the inaccessible version of each missing package. When \code{NULL}
(the default), the project lockfile will be used.}

\item{project}{The project directory. If \code{NULL}, then the active project will
be used. If no project is currently active, then the current working
directory is used instead.}
}
\description{
Use \code{repair()} to recover from some common issues that can occur with
a project. Currently, two operations are performed:
}
\details{
\enumerate{
\item Packages with broken symlinks into the cache will be re-installed.
\item Packages that were installed from sources, but appear to be from
an remote source (e.g. GitHub), will have their \code{DESCRIPTION} files
updated to record that remote source explicitly.
}
}
