## Install

[Installing Chocolatey](https://docs.chocolatey.org/en-us/choco/setup)

```
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```

```
choco install terraform
```

## Login

[azure-cli](https://docs.azure.cn/zh-cn/cli/install-azure-cli-windows?view=azure-cli-latest&tabs=azure-cli)

```
az login
```

```shell
 continue the login in the web browser. If no web browser is available or if the web browser fails to open, use device code flow with `az login --use-device-code`.
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "fa10340e-e325-45a4-a0c8-9f5d1414f5c7",
    "id": "8fa25555-0029-438a-b47c-ce75f4e64c74",
    "isDefault": true,
    "managedByTenants": [],
    "name": "免费试用",
    "state": "Enabled",
    "tenantId": "fa10340e-e325-45a4-a0c8-9f5d1414f5c7",
    "user": {
      "name": "Alex.xu@sappal.cn",
      "type": "user"
    }
  }
]
```


## Service Principal

[Service Principal](https://www.cnblogs.com/AllenMaster/p/13065643.html)

[Azure - Terraform](https://docs.microsoft.com/zh-cn/azure/developer/terraform/authenticate-to-azure?tabs=bash)

### 3.1，在 “azure portal” 中验证当前的Azure订阅

### 3.2，显示订阅名称ID值的列表
```
PS C:\Windows\system32> az account show
{
  "environmentName": "AzureCloud",
  "homeTenantId": "fa10340e-e325-45a4-a0c8-9f5d1414f5c7",
  "id": "8fa25555-0029-438a-b47c-ce75f4e64c74",
  "isDefault": true,
  "managedByTenants": [],
  "name": "免费试用",
  "state": "Enabled",
  "tenantId": "fa10340e-e325-45a4-a0c8-9f5d1414f5c7",
  "user": {
    "name": "Alex.xu@sappal.cn",
    "type": "user"
  }
}
PS C:\Windows\system32> az account list --query "[].{name:name, subscriptionId:id}"
[
  {
    "name": "免费试用",
    "subscriptionId": "8fa25555-0029-438a-b47c-ce75f4e64c74"
  }
]
```
### 3.3，使用 az ad sp create-for-rbac 命令，将其替换<subscription_id>为要使用的订阅帐户的ID

注意：我们将创建一个具有 “Contributor” （贡献者角色：默认角色）的服务主体。该 “Contributor” 角色具有完全的权限读取和写入到Azure的账户，
```
PS C:\Windows\system32> az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/8fa25555-0029-438a-b47c-ce75f4e64c74"
Creating 'Contributor' role assignment under scope '/subscriptions/8fa25555-0029-438a-b47c-ce75f4e64c74'
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
{
  "appId": "0c8be569-887a-4551-bb82-d469ea031dc6",
  "displayName": "azure-cli-2022-01-05-01-42-28",
  "password": "pocu_H~aH94x3JI-DPcFdSrsYin-ZRK3n7",
  "tenant": "fa10340e-e325-45a4-a0c8-9f5d1414f5c7"
}
PS C:\Windows\system32>
```


```shell
setx ARM_SUBSCRIPTION_ID 8fa25555-0029-438a-b47c-ce75f4e64c74
setx ARM_CLIENT_ID 0c8be569-887a-4551-bb82-d469ea031dc6    
setx ARM_CLIENT_SECRET pocu_H~aH94x3JI-DPcFdSrsYin-ZRK3n7
setx ARM_TENANT_ID fa10340e-e325-45a4-a0c8-9f5d1414f5c7
```

### Execute

```
terraform init
terraform plan
terraform apply
```