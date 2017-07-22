<Screen AllowMultipleInstances="False" ScreenKind="EditGrid" Name="Sys_CustomModuleList">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_CustomModule$CollectionView" Name="T_Sys_CustomModuleCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_Sys_CustomModule" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.Methods>
    <ScreenMethod Name="T_Sys_CustomModuleCollection_AddNew">
      <ScreenMethod.Actions>
        <Action ActionType=":AddNewItem">
          <Action.Parameters>
            <ActionParameter Parameter=":AddNewItem.Property" Value="T_Sys_CustomModuleCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="新增" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod Name="T_Sys_CustomModuleCollection_DeleteSelected">
      <ScreenMethod.Actions>
        <Action ActionType=":DeleteSelectedItem">
          <Action.Parameters>
            <ActionParameter Parameter=":DeleteSelectedItem.Property" Value="T_Sys_CustomModuleCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="移除" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
  </Screen.Methods>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem Control=":RowsLayout">
        <ContentItem BindingPath="T_Sys_CustomModuleCollection">
          <ContentItem.Attributes>
            <DisplayName Value="'自定义模块'" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem BindingPath="No" />
            <ContentItem BindingPath="Name" />
            <ContentItem BindingPath="SortOrder" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Attributes>
    <DisplayName Value="用户自定义模块管理" />
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>