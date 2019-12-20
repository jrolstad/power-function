using namespace System.Net
Import-Module ..\TestModule\TestModule.psd1

Describe 'Executing Http Trigger with name'{
    BeforeEach {
        $Global:TestContext.Reset()
        $request = @{Query=@{Name="foo"}}
        ..\..\src\HttpTrigger\run.ps1 -Request $request
    }
    It 'Should Return a response'{
        $TestContext.FunctionOutput | Should -HaveCount 1
    }
    It 'Should Return an Http Status of 200 (OK)'{
        $response = ($TestContext.FunctionOutput | select-object -First 1)
        $response| Should -Not -Be  $null
    }
}