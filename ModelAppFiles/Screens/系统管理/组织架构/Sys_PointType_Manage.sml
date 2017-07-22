<Screen AllowMultipleInstances="False" ScreenKind="Custom" Name="Sys_PointType_Manage">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_PointType$CollectionView" Name="T_PointTypeCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_PointType" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.Methods>
    <ScreenMethod Name="Save">
      <ScreenMethod.Actions>
        <Action ActionType=":SaveChanges" />
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="保存" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod Name="Refresh">
      <ScreenMethod.Actions>
        <Action ActionType=":RefreshScreen" />
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="刷新" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod Name="Close">
      <ScreenMethod.Actions>
        <Action ActionType=":CloseScreen" />
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="关闭" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
  </Screen.Methods>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem.CommandItems>
        <ContentItem BindingPath="Save">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Save.png" />
          </ContentItem.Properties>
        </ContentItem>
        <ContentItem BindingPath="Refresh">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Refresh.png" />
          </ContentItem.Properties>
        </ContentItem>
        <ContentItem BindingPath="Close">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Close.png" />
          </ContentItem.Properties>
        </ContentItem>
      </ContentItem.CommandItems>
      <ContentItem Control=":RowsLayout">
        <ContentItem BindingPath="Screen.T_PointTypeCollection">
          <ContentItem.Attributes>
            <DisplayName Value="'网点类型'" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem BindingPath="PointType" />
            <ContentItem BindingPath="TabOrder" />
            <ContentItem BindingPath="SysFlag" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Attributes>
    <DisplayName Value="网点类型管理" />
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>