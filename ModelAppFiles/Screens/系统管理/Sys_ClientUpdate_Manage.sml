<Screen AllowMultipleInstances="False" ScreenKind="CommonListScreen" Name="Sys_ClientUpdate_Manage">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_ClientUpdate$CollectionView" Name="T_Sys_ClientUpdateCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_Sys_ClientUpdate" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem Control=":RowsLayout">
        <ContentItem BindingPath="T_Sys_ClientUpdateCollection">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":DataGrid.ShowAddNewRow" Value="False" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="True" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'更新列表'" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem.Properties>
              <ContentItemProperty ControlProperty=":BaseControl.BrowseOnly" Value="True" />
            </ContentItem.Properties>
            <ContentItem BindingPath="CreateTime" />
            <ContentItem BindingPath="Description" />
            <ContentItem BindingPath="Version" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Popups>
    <ContentItem Control=":ScreenContainer" Name="AddNewPopup">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="Sys_ClientUpdate_Detail" />
        <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.HeightSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Width" Value="700" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <ScreenContainerParameter ParameterName="IsReadOnly" ParameterType=":Boolean" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="Id" ParameterType=":Int32" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
    <ContentItem Control=":ScreenContainer" Name="EditPopup">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="Sys_ClientUpdate_Detail" />
        <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.HeightSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Width" Value="700" />
        <ContentItemProperty ControlProperty=":BaseControl.Height" Value="400" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <ScreenContainerParameter ParameterName="IsReadOnly" ParameterType=":Boolean" Value="False" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="Id" ParameterType=":Int32" Value="Screen.T_Sys_ClientUpdateCollection.SelectedItem.Id" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
  </Screen.Popups>
  <Screen.Attributes>
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>