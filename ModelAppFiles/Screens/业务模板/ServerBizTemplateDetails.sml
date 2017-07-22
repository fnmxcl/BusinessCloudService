<Screen AllowMultipleInstances="False" ScreenKind="Custom" Name="ServerBizTemplateDetails">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.ServerBizTemplate" Name="ServerBizTemplate">
      <ScreenQueryProperty.Query>
        <ScreenQuery ResultType="Single" EntityType="ApplicationData.ServerBizTemplate" Filter="Id==Screen.Id" />
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
  <Screen.Methods>
    <ScreenMethod Name="Save">
      <ScreenMethod.Actions>
        <Action ActionType=":SaveChanges">
          <Action.Parameters>
            <ActionParameter Parameter=":SaveChanges.ShowMessageAfterSaved" Value="False" />
          </Action.Parameters>
        </Action>
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
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Save1.png" />
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
        <ContentItem.Properties>
          <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="IsReadOnly" />
        </ContentItem.Properties>
        <ContentItem BindingPath="ServerBizTemplate.No" />
        <ContentItem Control=":UserControl">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":UserControl.ClassName" Value="SBE.CloudCodeEditor.CloudServerCodeEditor, SBE.CloudCodeEditor, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null" />
            <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Stretch'" />
            <ContentItemProperty ControlProperty=":BaseControl.AttachedLabelPosition" Value="'Top'" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <UserControlProperty Property="Code" Value="ServerBizTemplate.CustomCode" />
            <DisplayName Value="'自定义代码'" />
          </ContentItem.Attributes>
        </ContentItem>
        <ContentItem Control=":Label" BindingPath="ServerBizTemplate.CreateTime" />
        <ContentItem Control=":Label" BindingPath="ServerBizTemplate.UpdateTime" />
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Initialized>
    <Action ActionType=":ChangePropertyValue">
      <Action.Parameters>
        <ActionParameter Parameter=":ChangePropertyValue.Property" Value="ServerBizTemplate" />
        <ActionParameter Parameter=":ChangePropertyValue.Value" Value="ServerBizTemplate==null?new ServerBizTemplate():ServerBizTemplate" />
      </Action.Parameters>
    </Action>
  </Screen.Initialized>
  <Screen.Attributes>
    <DisplayName Value="服务端业务模板明细" />
  </Screen.Attributes>
</Screen>