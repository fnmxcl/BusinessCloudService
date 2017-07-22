<Screen AllowMultipleInstances="False" ScreenKind="Details" Name="Sys_ClientUpdate_Detail">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_ClientUpdate" Name="Sys_ClientUpdate">
      <ScreenQueryProperty.Query>
        <ScreenQuery ResultType="Single" EntityType="ApplicationData.T_Sys_ClientUpdate" Filter="Id==Screen.Id" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenLocalProperty PropertyType=":Boolean" Name="IsReadOnly">
      <ScreenLocalProperty.Attributes>
        <IsParameter />
        <Required />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
    <ScreenLocalProperty PropertyType=":Int32" Name="Id">
      <ScreenLocalProperty.Attributes>
        <IsParameter />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_ClientUpdateFile$CollectionView" Name="ClientUpdateDetailCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery Source="Sys_ClientUpdate.ClientUpdateDetail" EntityType="ApplicationData.T_Sys_ClientUpdateFile" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem Control=":RowsLayout">
        <ContentItem.Properties>
          <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="IsReadOnly" />
        </ContentItem.Properties>
        <ContentItem Control=":TableLayout" BindingPath="Sys_ClientUpdate">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Top'" />
          </ContentItem.Properties>
          <ContentItem Control=":TableColumn">
            <ContentItem BindingPath="Description" />
          </ContentItem>
          <ContentItem Control=":TableColumn">
            <ContentItem BindingPath="Version" />
          </ContentItem>
        </ContentItem>
        <ContentItem Control=":TabsLayout">
          <ContentItem.Attributes>
            <DisplayName Value="'更新明细'" />
          </ContentItem.Attributes>
          <ContentItem BindingPath="ClientUpdateDetailCollection">
            <ContentItem.Attributes>
              <DisplayName Value="'更新明细'" />
            </ContentItem.Attributes>
            <ContentItem>
              <ContentItem Control=":FileSelector" BindingPath="Data">
                <ContentItem.Properties>
                  <ContentItemProperty ControlProperty=":FileSelector.FileName" Value="FileName" />
                </ContentItem.Properties>
              </ContentItem>
              <ContentItem BindingPath="FileName" />
              <ContentItem BindingPath="FilePath" />
              <ContentItem BindingPath="Length" />
            </ContentItem>
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Initialized>
    <Action ActionType=":ChangePropertyValue">
      <Action.Parameters>
        <ActionParameter Parameter=":ChangePropertyValue.Property" Value="Sys_ClientUpdate" />
        <ActionParameter Parameter=":ChangePropertyValue.Value" Value="Sys_ClientUpdate==null? new T_Sys_ClientUpdate(): Sys_ClientUpdate" />
      </Action.Parameters>
    </Action>
  </Screen.Initialized>
  <Screen.Attributes>
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>