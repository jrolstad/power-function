

class TestContext
{
    # Optionally, add attributes to prevent invalid values
    $FunctionOutput
    [string]$SessionId

    Reset(){
        $this.FunctionOutput.Clear()
    }

    TestContext([string]$sessionId){
        $this.SessionId = $sessionId
        $this.FunctionOutput = New-Object System.Collections.ArrayList
    }

}
$global:TestContext = [TestContext]::new([System.Guid]::NewGuid().ToString())

