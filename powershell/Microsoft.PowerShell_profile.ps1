$omp_config = Join-Path $PSScriptRoot ".\obk.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression


function scf {
    scoop update
    scoop update *
    scoop cleanup *
    scoop cache rm *
}