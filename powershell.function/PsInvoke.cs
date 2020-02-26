using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using System.Management.Automation;
using System.Web.Http;

namespace powershell.function
{
    public static class PsInvoke
    {
        [FunctionName("PsInvoke")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = "ps/{command}")] HttpRequest req,
            ILogger log,
            string command)
        {
            try
            {
                using var powershellInstance = PowerShell.Create();
                powershellInstance.AddScript(command);
                var result = powershellInstance.Invoke();
                
                HandleErrors(powershellInstance);

                return new OkObjectResult(result);
            }
            catch (Exception e)
            {
                return new ExceptionResult(e,true);
            }
           
        }

        private static void HandleErrors(PowerShell powershellInstance)
        {
            if (powershellInstance.HadErrors || powershellInstance.Streams.Error.Any())
            {
                var exceptions = powershellInstance.Streams.Error.ReadAll().Select(e => e.Exception).FirstOrDefault();
                throw new ApplicationException("Error when executing command", exceptions);
            }
        }
    }
}
