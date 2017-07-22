<Screen AllowMultipleInstances="False" ScreenKind="CommonListScreen" Name="Sys_Role_Manage">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_Role$CollectionView" Name="T_Sys_RoleCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_Sys_Role" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.Methods>
    <ScreenMethod CanExecute="T_Sys_RoleCollection.SelectedItem!=null" Name="SetMenu">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="Memu" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="设置菜单权限" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod Name="save">
      <ScreenMethod.Actions>
        <Action ActionType=":SaveChanges" />
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="保存" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod Name="cancle">
      <ScreenMethod.Actions>
        <Action ActionType=":ClosePopup">
          <Action.Parameters>
            <ActionParameter Parameter=":ClosePopup.Popup" Value="Memu" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="取消" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod CanExecute="T_Sys_RoleCollection.SelectedItem!=null" Name="SetPermisson">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="Perssion" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="设置扩展权限" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod Name="AddNew">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="PopupAdd" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="新增" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
  </Screen.Methods>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem.CommandItems>
        <ContentItem BindingPath="AddNew">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Add.png" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'新增'" />
          </ContentItem.Attributes>
        </ContentItem>
        <ContentItem BindingPath="SetMenu" />
        <ContentItem BindingPath="SetPermisson" />
      </ContentItem.CommandItems>
      <ContentItem Control=":RowsLayout">
        <ContentItem BindingPath="Screen.T_Sys_RoleCollection">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":DataGrid.ShowAddNewRow" Value="False" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="True" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'角色列表'" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem.Properties>
              <ContentItemProperty ControlProperty=":BaseControl.BrowseOnly" Value="True" />
            </ContentItem.Properties>
            <ContentItem BindingPath="No" />
            <ContentItem BindingPath="Name" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Popups>
    <ContentItem Control=":ColumnsLayout" Name="Memu">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":BaseControl.HeightSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Height" Value="500" />
        <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Width" Value="300" />
        <ContentItemProperty ControlProperty=":BaseControl.AttachedLabelPosition" Value="'Collapsed'" />
      </ContentItem.Properties>
      <ContentItem Control=":RowsLayout">
        <ContentItem Control=":UserControl" BindingPath="Screen.T_Sys_RoleCollection.SelectedItem">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":UserControl.ClassName" Value="SBE.AppFrame.Presentation.PermissionModule.RoleMenuManage, SBE.AppFrame.Presentation, Version=1.0.0.0, Culture=neutral, PublicKeyToken=7dbe5e9e82e1528c" />
            <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Stretch'" />
            <ContentItemProperty ControlProperty=":RowsLayout.WeightedRowHeight" Value="7" />
          </ContentItem.Properties>
        </ContentItem>
        <ContentItem Control=":ColumnsLayout">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.HorizontalAlignment" Value="'Right'" />
          </ContentItem.Properties>
          <ContentItem BindingPath="save">
            <ContentItem.Properties>
              <ContentItemProperty ControlProperty=":BaseControl.HorizontalAlignment" Value="'Right'" />
            </ContentItem.Properties>
          </ContentItem>
          <ContentItem BindingPath="cancle" />
        </ContentItem>
      </ContentItem>
    </ContentItem>
    <ContentItem Control=":RowsLayout" Name="Perssion">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="550" />
        <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.HeightSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Width" Value="600" />
        <ContentItemProperty ControlProperty=":BaseControl.Height" Value="420" />
      </ContentItem.Properties>
      <ContentItem Control=":UserControl" BindingPath="Screen.T_Sys_RoleCollection.SelectedItem">
        <ContentItem.Properties>
          <ContentItemProperty ControlProperty=":UserControl.ClassName" Value="SBE.AppFrame.Presentation.PermissionModule.RolePermissionManage, SBE.AppFrame.Presentation, Version=1.0.0.0, Culture=neutral, PublicKeyToken=7dbe5e9e82e1528c" />
          <ContentItemProperty ControlProperty=":BaseControl.AttachedLabelPosition" Value="'Collapsed'" />
          <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Stretch'" />
          <ContentItemProperty ControlProperty=":RowsLayout.WeightedRowHeight" Value="7" />
        </ContentItem.Properties>
      </ContentItem>
      <ContentItem Control=":ColumnsLayout">
        <ContentItem.Properties>
          <ContentItemProperty ControlProperty=":BaseControl.HorizontalAlignment" Value="'Right'" />
        </ContentItem.Properties>
        <ContentItem BindingPath="save" />
      </ContentItem>
    </ContentItem>
    <ContentItem Control=":ScreenContainer" Name="PopupAdd">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="Sys_Role_Detail" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <ScreenContainerParameter ParameterName="IsReadOnly" ParameterType=":Boolean" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="Id" ParameterType=":Int32" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
  </Screen.Popups>
  <Screen.Attributes>
    <DisplayName Value="角色管理" />
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>