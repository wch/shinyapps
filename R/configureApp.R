#' Configure an Application
#' 
#' Configure an application currently running on ShinyApps.
#' @param appName Name of application to configure
#' @param appDir Directory containing application. Defaults to 
#'   current working directory.  
#' @param account Account name. If a single account is registered on the 
#'   system then this parameter can be omitted.
#' @param redeploy Re-deploy application after its been configured.
#' @param size Configure application instance size
#' @param instances Configure number of application instances
#' @param quiet Request that no status information be printed to the console 
#'   during the deployment. 
#' @examples
#' \dontrun{
#' 
#' # set instance size for an application
#' configureApp("myapp", size="xlarge")
#' }
#' @seealso \code{\link{applications}}, \code{\link{deployApp}}
#' @export
configureApp <- function(appName, appDir=getwd(), account = NULL, redeploy = TRUE, size = NULL, instances = NULL, quiet = FALSE) {
  
  # resolve target account and application
  accountInfo <- accountInfo(resolveAccount(account))
  application <- resolveApplication(accountInfo, appName)

  displayStatus <- displayStatus(quiet) 
  
  # some properties may required a rebuild to take effect
  rebuildRequired = FALSE
  
  # get a list of properties to set
  properties <- list()
  if (! is.null(size) ) {
    properties[[ "application.instances.template" ]] = size
  }
  if (! is.null(instances) ) {
    properties[[ "application.instances.count" ]] = instances
  }

  # set application properties
  lucid <- lucidClient(accountInfo)
  for (i in names(properties)) {
    propertyName <- i
    propertyValue <- properties[[i]]
    lucid$configureApplication(application$id, propertyName, propertyValue)
  }

  # redeploy application if requested
  if (redeploy) {
    if (length(properties) > 0) {
      deployApp(appDir=appDir, appName=appName, account=account, quiet=quiet, upload=rebuildRequired) 
    }
    else 
    {
      displayStatus("No configuration changes to deploy")
    }
  }
}
