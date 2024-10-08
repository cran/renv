% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/retrieve.R
\name{retrieve}
\alias{retrieve}
\title{Retrieve packages}
\usage{
retrieve(packages = NULL, ..., lockfile = NULL, destdir = NULL, project = NULL)
}
\arguments{
\item{packages}{Either \code{NULL} (the default) to install all packages required
by the project, or a character vector of packages to install. renv
supports a subset of the remotes syntax used for package installation,
e.g:
\itemize{
\item \code{pkg}: install latest version of \code{pkg} from CRAN.
\item \code{pkg@version}: install specified version of \code{pkg} from CRAN.
\item \code{username/repo}: install package from GitHub
\item \code{bioc::pkg}: install \code{pkg} from Bioconductor.
}

See \url{https://remotes.r-lib.org/articles/dependencies.html} and the examples
below for more details.

renv deviates from the remotes spec in one important way: subdirectories
are separated from the main repository specification with a \code{:}, not \code{/}.
So to install from the \code{subdir} subdirectory of GitHub package
\code{username/repo} you'd use \verb{"username/repo:subdir}.}

\item{...}{Unused arguments, reserved for future expansion. If any arguments
are matched to \code{...}, renv will signal an error.}

\item{lockfile}{The path to an \code{renv} lockfile. When set, \code{renv}
will retrieve the packages as defined within that lockfile.
If \code{packages} is also non-\code{NULL}, then only those packages will
be retrieved.}

\item{destdir}{The directory where packages should be downloaded.
When \code{NULL} (the default), the default internal storage locations
(normally used by e.g. \code{\link[=install]{install()}} or \code{\link[=restore]{restore()}}) will
be used.}

\item{project}{The project directory. If \code{NULL}, then the active project will
be used. If no project is currently active, then the current working
directory is used instead.}
}
\value{
A named vector, mapping package names to the paths where
those packages were downloaded.
}
\description{
Retrieve (download) one or more packages from external sources.
Using \code{renv::retrieve()} can be useful in CI / CD workflows, where
you might want to download all packages listed in a lockfile
before later invoking \code{\link[=restore]{restore()}}. Packages will be downloaded
to an internal path within \code{renv}'s local state directories -- see
\link{paths} for more details.
}
\details{
If \code{destdir} is \code{NULL} and the requested package is already available
within the \code{renv} cache, \code{renv} will return the path to that package
directory in the cache.
}
\examples{
\dontrun{

# retrieve package + versions as defined in the lockfile
# normally used as a pre-flight step to renv::restore()
renv::retrieve()

# download one or more packages locally
renv::retrieve("rlang", destdir = ".")

}
}
