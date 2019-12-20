function Push-OutputBinding($Name,$Value){
    $global:TestContext.FunctionOutput.Add(@{Name=$Name;Value=$Value})
}