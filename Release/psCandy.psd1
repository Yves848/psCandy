@{
    # Script module or binary module file associated with this manifest.
    RootModule         = 'psCandy.psm1'

    # Version number of this module.
    ModuleVersion      = '0.0.6'

    # ID used to uniquely identify this module
    GUID               = 'e2d0c0d5-2e33-4ec7-8db5-bc786c1eb7d3'

    # Author of this module
    Author             = 'Yves Godart'

    # Company or vendor of this module
    CompanyName        = 'Private'

    # Copyright statement for this module
    Copyright          = '(c) 2024 Your Name. All rights reserved.'

    # Description of the functionality provided by this module
    Description        = 'This module provides classes for Eye-Candy in the console.'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion  = '7.0.0'

    # Modules that must be imported into the global environment prior to importing this module
    RequiredModules    = @()

    # Assemblies that must be loaded prior to importing this module
    RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module
    ScriptsToProcess   = @()

    # Type files (.ps1xml) to be loaded when importing this module
    TypesToProcess     = @()

    # Format files (.ps1xml) to be loaded when importing this module
    FormatsToProcess   = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    NestedModules      = @()

    # Functions to export from this module
    FunctionsToExport  = @()

    # Cmdlets to export from this module
    CmdletsToExport    = @()

    # Variables to export from this module
    VariablesToExport  = @()

    # Aliases to export from this module
    AliasesToExport    = @()

    # List of all modules packaged with this module
    ModuleList         = @()

    # List of all files packaged with this module
    FileList           = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess
    PrivateData       = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags         = @('Eye-Candy', 'powershell', 'TUI', 'Console')

            # A URL to the license for this module.
            LicenseUri   = 'https://github.com/Yves848/psCandy/blob/master/licence.txt'

            # A URL to the main website for this project.
            ProjectUri   = 'https://github.com/Yves848/psCandy/tree/master'

            # A URL to an icon representing this module.
            IconUri      = 'https://raw.githubusercontent.com/Yves848/psCandy/master/Release/winpack.ico'

            # ReleaseNotes of this module
            ReleaseNotes = 'https://github.com/Yves848/psCandy/tree/master/readme.md'

        
            # Prerelease string of this module
            # Prerelease   = 'alpha01'

            # Flag to indicate whether the module requires explicit user acceptance for install/update/save
            # RequireLicenseAcceptance = $true

            # External dependent modules of this module
            # ExternalModuleDependencies = @()

        } # End of PSData hashtable

    } # End of PrivateData hashtable
    # HelpInfo URI of this module
    HelpInfoURI        = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    DefaultCommandPrefix = ''
}
