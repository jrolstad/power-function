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
    It 'Should Return an Http Status of (OK)'{
        $TestContext.FunctionOutput[0].Value.StatusCode| Should -Be 'OK'
    }
}

Describe 'Executing Http Trigger without a name'{
    BeforeEach {
        $Global:TestContext.Reset()
        $request = @{Query=@{}}
        ..\..\src\HttpTrigger\run.ps1 -Request $request
    }
    It 'Should Return a response'{
        $TestContext.FunctionOutput | Should -HaveCount 1
    }
    It 'Should Return an Http Status of (BadRequest)'{
        $TestContext.FunctionOutput[0].Value.StatusCode| Should -Be 'BadRequest'
    }
}
