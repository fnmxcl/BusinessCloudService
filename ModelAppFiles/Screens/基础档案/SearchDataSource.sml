<Screen AllowMultipleInstances="False" ScreenKind="Custom" Name="SearchDataSource">
  <Screen.Properties>
    <ScreenQueryProperty ShowDeletedItems="False" PropertyType="ApplicationData.DataSource$CollectionView" Name="DataSourceCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.DataSource" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.Methods>
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
    <ScreenMethod Name="AddNew">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="AddNewPopup" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="DataSourceCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="新增" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod CanExecute="Screen.DataSourceCollection.SelectedItem!=null" Name="Edit">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="EditPopup" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="DataSourceCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="编辑" />
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
          <ContentItem.Attributes>
            <DisplayName Value="'新增'" />
          </ContentItem.Attributes>
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
      </ContentItem.CommandItems>
      <ContentItem Control=":RowsLayout">
        <ContentItem BindingPath="DataSourceCollection">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":DataGrid.ShowAddNewRow" Value="False" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="True" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'数据源列表'" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem.Properties>
              <ContentItemProperty ControlProperty=":BaseControl.BrowseOnly" Value="True" />
            </ContentItem.Properties>
            <ContentItem BindingPath="No" />
            <ContentItem BindingPath="Name" />
            <ContentItem BindingPath="Description" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Popups>
    <ContentItem Control=":ScreenContainer" Name="AddNewPopup">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="DataSourceDetails" />
        <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Width" Value="800" />
        <ContentItemProperty ControlProperty=":BaseControl.HeightSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Height" Value="600" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <ScreenContainerParameter ParameterName="IsReadOnly" ParameterType=":Boolean" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="Id" ParameterType=":Int32" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
    <ContentItem Control=":ScreenContainer" Name="EditPopup">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="DataSourceDetails" />
        <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Width" Value="800" />
        <ContentItemProperty ControlProperty=":BaseControl.HeightSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Height" Value="600" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <ScreenContainerParameter ParameterName="IsReadOnly" ParameterType=":Boolean" Value="False" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="Id" ParameterType=":Int32" Value="Screen.DataSourceCollection.SelectedItem.Id" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
  </Screen.Popups>
  <Screen.Attributes>
    <DisplayName Value="数据源列表" />
  </Screen.Attributes>
</Screen>