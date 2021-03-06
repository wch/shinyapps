% Generated by roxygen2 (4.0.1): do not edit by hand
\name{configureApp}
\alias{configureApp}
\title{Configure an Application}
\usage{
configureApp(appName, appDir = getwd(), account = NULL, redeploy = TRUE,
  size = NULL, instances = NULL, quiet = FALSE)
}
\arguments{
\item{appName}{Name of application to configure}

\item{appDir}{Directory containing application. Defaults to
current working directory.}

\item{account}{Account name. If a single account is registered on the
system then this parameter can be omitted.}

\item{redeploy}{Re-deploy application after its been configured.}

\item{size}{Configure application instance size}

\item{instances}{Configure number of application instances}

\item{quiet}{Request that no status information be printed to the console
during the deployment.}
}
\description{
Configure an application currently running on ShinyApps.
}
\examples{
\dontrun{

# set instance size for an application
configureApp("myapp", size="xlarge")
}
}
\seealso{
\code{\link{applications}}, \code{\link{deployApp}}
}

