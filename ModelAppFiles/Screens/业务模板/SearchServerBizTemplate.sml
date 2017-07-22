<Screen AllowMultipleInstances="False" ScreenKind="Custom" Name="SearchServerBizTemplate">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.ServerBizTemplate$CollectionView" Name="ServerBizTemplateCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.ServerBizTemplate" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.Methods>
    <ScreenMethod Name="AddNew">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="AddNewPopup" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="ServerBizTemplateCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="新增" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod CanExecute="ServerBizTemplateCollection.SelectedItem!=null" Name="Edit">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="EditPopup" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="ServerBizTemplateCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="编辑" />
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
        <ContentItem BindingPath="AddNew">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="AddNew.png" />
          </ContentItem.Properties>
        </ContentItem>
        <ContentItem BindingPath="Edit">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="UnInitialize.png" />
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
        <ContentItem BindingPath="ServerBizTemplateCollection">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":DataGrid.ShowAddNewRow" Value="False" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="True" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'服务端业务模板'" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem.Properties>
              <ContentItemProperty ControlProperty=":BaseControl.BrowseOnly" Value="True" />
            </ContentItem.Properties>
            <ContentItem BindingPath="Id" />
            <ContentItem BindingPath="No" />
            <ContentItem BindingPath="CustomCode" />
            <ContentItem BindingPath="CreateTime" />
            <ContentItem BindingPath="UpdateTime" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Popups>
    <ContentItem Control=":ScreenContainer" Name="AddNewPopup">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="ServerBizTemplateDetails" />
      </ContentItem.Properties>
    </ContentItem>
    <ContentItem Control=":ScreenContainer" Name="EditPopup">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="ServerBizTemplateDetails" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <ScreenContainerParameter ParameterName="Id" ParameterType=":Int32" Value="Screen.ServerBizTemplateCollection.SelectedItem.Id" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
  </Screen.Popups>
  <Screen.Attributes>
    <DisplayName Value="服务端业务模板管理" />
  </Screen.Attributes>
</Screen>