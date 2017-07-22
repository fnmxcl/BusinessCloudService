<Screen AllowMultipleInstances="False" ScreenKind="Custom" Name="SearchClient">
  <Screen.Properties>
    <ScreenQueryProperty ShowDeletedItems="False" PropertyType="ApplicationData.Client$CollectionView" Name="ClientCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.Client" />
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
            <ActionParameter Parameter=":RefreshQuery.Property" Value="ClientCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="新增" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod CanExecute="Screen.ClientCollection.SelectedItem!=null" Name="Edit">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="EditPopup" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="ClientCollection" />
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
    <ScreenMethod CanExecute="Screen.ClientCollection.SelectedItem!=null" Name="RefreshServerModel">
      <ScreenMethod.Actions>
        <Action ActionType=":CustomCode">
          <Action.Parameters>
            <ActionParameter Parameter=":CustomCode.Code" Value="System.Presentation.MessageBox.Show(&quot;该功能已关闭,请在网址 http://www.qqdms.com:8002 中操作&quot;,&quot;刷新模型&quot;);&#xD;&#xA;" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
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
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Modify.png" />
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
        <ContentItem BindingPath="RefreshServerModel">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="refresh.png" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'刷新模型'" />
          </ContentItem.Attributes>
        </ContentItem>
      </ContentItem.CommandItems>
      <ContentItem Control=":RowsLayout">
        <ContentItem BindingPath="ClientCollection">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":DataGrid.ShowAddNewRow" Value="False" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="True" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'客户 '" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem.Properties>
              <ContentItemProperty ControlProperty=":BaseControl.BrowseOnly" Value="True" />
            </ContentItem.Properties>
            <ContentItem BindingPath="No" />
            <ContentItem BindingPath="Name" />
            <ContentItem BindingPath="ConnectionString" />
            <ContentItem BindingPath="Database" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Popups>
    <ContentItem Control=":ScreenContainer" Name="AddNewPopup">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="ClientDetails" />
      </ContentItem.Properties>
    </ContentItem>
    <ContentItem Control=":ScreenContainer" Name="EditPopup">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="ClientDetails" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <ScreenContainerParameter ParameterName="Id" ParameterType=":Int32" Value="Screen.ClientCollection.SelectedItem.Id" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
  </Screen.Popups>
  <Screen.Attributes>
    <DisplayName Value="客户管理" />
  </Screen.Attributes>
</Screen>