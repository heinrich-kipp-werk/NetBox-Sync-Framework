# NetBox-Sync-Framework

Powershell module to integrate your NetBox api in your Powershell sciprts

## Usage

Import the Module and use it!

List of Parametes:

| Name | Description | Required | Deufault value | expectet value | Example value |
| --- | --- | --- | --- | --- | --- |
| -Token | Your NetBox api token | [x] | none | [string] | `"xxxxxxxxxxxxxxxxxxxxxx"` |
| -Uri | The url to the NetBox instance (with scheme) | [x] | none | [string] | `"https://netbox.example.com"` |
| -Body | Body data for the NetBox (formatet as powershell object or array. For more information see the NetBox Documentation) | [ ] | none | [object] | `@{'address' = '10.0.0.5/24', 'status' = 'active'}` |
| -Query | Query data for the NetBox | [ ] | none | [string] | `limit=10` |
| -Create | Creates the called object (endpoints listed in the netbox documentation without a leading slash) | [ ]* | none | [string] | `ipam/ip-addresses` |
| -Delete | Delete the called object (endpoints listed in the netbox documentation without a leading slash) | [ ]* | none | [string] | `ipam/ip-addresses` |
| -PartialUpdate | PartialUpdate the called object (endpoints listed in the netbox documentation without a leading slash) | [ ]* | [string] | none | `ipam/ip-addresses` |
| -BulkUpdate | BulkUpdate the called object (endpoints listed in the netbox documentation without a leading slash) | [ ]* | none | [string] | `ipam/ip-addresses` |
| -Select | Select the called object (endpoints listed in the netbox documentation without a leading slash) | [ ]* | none | [bool] | `ipam/ip-addresses` |
| -Debug | enables debug | [ ] | $false | `$true` |

*one of these is required