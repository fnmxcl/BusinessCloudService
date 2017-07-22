<Screen AllowMultipleInstances="False" ScreenKind="Details" Name="Sys_Parameter_Set">
  <Screen.Properties>
    <ScreenLocalProperty PropertyType=":Boolean" Name="IsReadOnly">
      <ScreenLocalProperty.Attributes>
        <IsParameter />
        <Required />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
    <ScreenLocalProperty PropertyType=":String" Name="PointCode">
      <ScreenLocalProperty.Attributes>
        <IsParameter />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
    <ScreenLocalProperty PropertyType="ApplicationData.T_PointInfo" Name="T_PointInfo">
      <ScreenLocalProperty.Attributes>
        <DefaultValue Value="Contexts!CurrentPoint" />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
  </Screen.Properties>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem Control=":RowsLayout">
        <ContentItem.Properties>
          <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="IsReadOnly" />
        </ContentItem.Properties>
        <ContentItem Control=":UserControl" BindingPath="T_PointInfo">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":UserControl.ClassName" Value="SBE.AppFrame.Presentation.PermissionModule.PointSystemParamManage, SBE.AppFrame.Presentation, Version=1.0.0.0, Culture=neutral, PublicKeyToken=7dbe5e9e82e1528c" />
            <ContentItemProperty ControlProperty=":BaseControl.AttachedLabelPosition" Value="'Collapsed'" />
          </ContentItem.Properties>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Attributes>
    <DisplayName Value="业务参数管理" />
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>