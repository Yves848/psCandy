using System.Management.Automation;

namespace MonModulePowerShell
{
    [Cmdlet(VerbsCommunications.Write, "Bonjour")]
    public class WriteBonjourCommand : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = false,ValueFromPipelineByPropertyName = true)]
        public string Nom { get; set; } = "le monde";

        protected override void BeginProcessing()
        {
            WriteVerbose("Début du traitement de la commande Write-Bonjour");
        }
        protected override void ProcessRecord()
        {
            WriteObject($"Bonjour {Nom} !");
        }
    }
}