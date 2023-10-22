@maxLength(20)
@minLength(4)
@description('Used to generate names for all resources in this file')
param resourceBaseName string

@maxLength(42)
param botDisplayName string

param botServiceName string = resourceBaseName
param botServiceSku string = 'F0'
param botAadAppClientId string
param botAppDomain string

param aadAppClientId string
@secure()
param aadAppClientSecret string


// Register your web service as a bot with the Bot Framework
resource botService 'Microsoft.BotService/botServices@2021-03-01' = {
  kind: 'azurebot'
  location: 'global'
  name: botServiceName
  properties: {
    displayName: botDisplayName
    endpoint: 'https://${botAppDomain}/api/messages'
    msaAppId: botAadAppClientId
    msaAppType: 'MultiTenant'
  }
  sku: {
    name: botServiceSku
  }
}

// Connect the bot service to Microsoft Teams
resource botServiceMsTeamsChannel 'Microsoft.BotService/botServices/channels@2021-03-01' = {
  parent: botService
  location: 'global'
  name: 'MsTeamsChannel'
  properties: {
    channelName: 'MsTeamsChannel'
  }
}

resource botServiceConnection 'Microsoft.BotService/botServices/connections@2021-03-01' = {
  parent: botService
  name: 'oauthbotsetting'
  location: 'global'
  properties: {
    serviceProviderDisplayName: 'Azure Active Directory v2'
    serviceProviderId: '30dd229c-58e3-4a48-bdfd-91ec48eb906c'
    scopes: 'User.Read openid profile User.ReadBasic.All Sites.Read.All'
    parameters: [
      {
        key: 'clientId'
        value: botAadAppClientId
      }
      {
        key: 'clientSecret'
        value: aadAppClientSecret
      }
      // {
      //   key: 'scopes'
      //   value: 'User.Read'
      // }
      {
        key: 'tenantID'
        value: 'common'
      }
      {
        key: 'tokenExchangeUrl'
        value: 'api://botid-${botAadAppClientId}'
      }
    ]
  }
}

output CONNECTION_NAME string = botServiceConnection.name