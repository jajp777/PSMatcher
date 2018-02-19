describe 'Test JSON' {
    Import-Module $PSScriptRoot\PSMatcher.psd1 -Force

    It 'Should match id and name' {
        '{"Id":1,"name":"jane"}' | Should MatchJsonTemplate '{"Id":1,"name":"jane"}'
    }

    It 'Should match guid' {
        '{"Id":"dd4c2ca4-5c8f-4ba3-8937-a7b101f52a99","name":"john"}' |
            Should MatchJsonTemplate '{"Id":"@guid@","name":"john"}'
    }

    It 'Should match double' {
        '{"Id":"dd4c2ca4-5c8f-4ba3-8937-a7b101f52a99","name":"john","price":10.12}' |
            Should MatchJsonTemplate '{"Id":"@guid@","name":"john","price":"@double@"}'
    }
}

describe 'Test XML' {
    Import-Module $PSScriptRoot\PSMatcher.psd1 -Force

    It 'Should match XML' {
        "<users><user>Foobar</user></users>" |
            Should MatchXMLTemplate "<users><user>Foobar</user></users>"
    }

    It 'Should fail XML match' {
        $actual = "<users><user>Foobar</user></users>"
        $expected = "<users><user>Foobar1</user></users>"

        Test-XML $actual $expected | Should Be $false
    }
}