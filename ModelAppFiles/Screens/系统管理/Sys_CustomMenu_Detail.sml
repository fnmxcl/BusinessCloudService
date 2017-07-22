<Screen AllowMultipleInstances="False" ScreenKind="Details" Name="Sys_CustomMenu_Detail">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_CustomMenu" Name="Sys_CustomMenu">
      <ScreenQueryProperty.Query>
        <ScreenQuery ResultType="Single" EntityType="ApplicationData.T_Sys_CustomMenu" Filter="Id==Screen.Id" />
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
  </Screen.Properties>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem Control=":ColumnsLayout">
        <ContentItem.Properties>
          <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="IsReadOnly" />
        </ContentItem.Properties>
        <ContentItem Control=":TableLayout" BindingPath="Sys_CustomMenu">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Top'" />
          </ContentItem.Properties>
          <ContentItem Control=":TableColumn">
            <ContentItem BindingPath="No" />
            <ContentItem BindingPath="Parent" />
            <ContentItem BindingPath="Module" />
          </ContentItem>
          <ContentItem Control=":TableColumn">
            <ContentItem BindingPath="Name" />
            <ContentItem BindingPath="SortOrder" />
            <ContentItem BindingPath="Type" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Initialized>
    <Action ActionType=":ChangePropertyValue">
      <Action.Parameters>
        <ActionParameter Parameter=":ChangePropertyValue.Property" Value="Sys_CustomMenu" />
        <ActionParameter Parameter=":ChangePropertyValue.Value" Value="Sys_CustomMenu==null? new T_Sys_CustomMenu(): Sys_CustomMenu" />
      </Action.Parameters>
    </Action>
  </Screen.Initialized>
  <Screen.Attributes>
    <DisplayName Value="用户自定义菜单明细" />
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>