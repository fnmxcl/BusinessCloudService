<Screen AllowMultipleInstances="False" ScreenKind="Details" Name="Sys_Role_Detail">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_Role" Name="Sys_Role">
      <ScreenQueryProperty.Query>
        <ScreenQuery ResultType="Single" EntityType="ApplicationData.T_Sys_Role" Filter="Id==Screen.Id" />
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
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_RoleEntityPermission$CollectionView" Name="TabularTypePermissionsCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery Source="Sys_Role.TabularTypePermissions" EntityType="ApplicationData.T_Sys_RoleEntityPermission" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_RoleFieldPermission$CollectionView" Name="TabularPropertyPermissionsCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery Source="Sys_Role.TabularPropertyPermissions" EntityType="ApplicationData.T_Sys_RoleFieldPermission" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_RoleExtPermission$CollectionView" Name="ExtPermissionsCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery Source="Sys_Role.ExtPermissions" EntityType="ApplicationData.T_Sys_RoleExtPermission" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_RoleMenuPermission$CollectionView" Name="MenuPermissionCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery Source="Sys_Role.MenuPermission" EntityType="ApplicationData.T_Sys_RoleMenuPermission" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_UserRole$CollectionView" Name="UserRolesCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery Source="Sys_Role.UserRoles" EntityType="ApplicationData.T_Sys_UserRole" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_UserRole$CollectionView" Name="UserRoles">
      <ScreenQueryProperty.Query>
        <ScreenQuery Source="Sys_Role.UserRoles" EntityType="ApplicationData.T_Sys_UserRole" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem Control=":RowsLayout">
        <ContentItem.Properties>
          <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="IsReadOnly" />
        </ContentItem.Properties>
        <ContentItem Control=":TableLayout" BindingPath="Sys_Role">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Top'" />
          </ContentItem.Properties>
          <ContentItem Control=":TableColumn">
            <ContentItem BindingPath="No" />
          </ContentItem>
          <ContentItem Control=":TableColumn">
            <ContentItem BindingPath="Name" />
          </ContentItem>
        </ContentItem>
        <ContentItem Control=":TabsLayout">
          <ContentItem Control=":UserControl" BindingPath="Sys_Role">
            <ContentItem.Properties>
              <ContentItemProperty ControlProperty=":UserControl.ClassName" Value="SBE.AppFrame.Presentation.PermissionModule.RoleMenuManage, SBE.AppFrame.Presentation, Version=1.0.0.0, Culture=neutral, PublicKeyToken=7dbe5e9e82e1528c" />
              <ContentItemProperty ControlProperty=":BaseControl.AttachedLabelPosition" Value="'Collapsed'" />
              <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Stretch'" />
            </ContentItem.Properties>
            <ContentItem.Attributes>
              <DisplayName Value="'功能权限'" />
            </ContentItem.Attributes>
          </ContentItem>
          <ContentItem Control=":UserControl" BindingPath="Sys_Role">
            <ContentItem.Properties>
              <ContentItemProperty ControlProperty=":UserControl.ClassName" Value="SBE.AppFrame.Presentation.PermissionModule.RolePermissionManage, SBE.AppFrame.Presentation, Version=1.0.0.0, Culture=neutral, PublicKeyToken=7dbe5e9e82e1528c" />
              <ContentItemProperty ControlProperty=":BaseControl.AttachedLabelPosition" Value="'Collapsed'" />
              <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Stretch'" />
            </ContentItem.Properties>
            <ContentItem.Attributes>
              <DisplayName Value="'扩展权限'" />
            </ContentItem.Attributes>
          </ContentItem>
          <ContentItem BindingPath="TabularTypePermissionsCollection">
            <ContentItem.Attributes>
              <DisplayName Value="'数据权限'" />
            </ContentItem.Attributes>
            <ContentItem>
              <ContentItem BindingPath="TabularType" />
              <ContentItem BindingPath="CanRead" />
              <ContentItem BindingPath="ReadFilter" />
              <ContentItem BindingPath="CanInsert" />
              <ContentItem BindingPath="InsertFilter" />
              <ContentItem BindingPath="CanModify" />
              <ContentItem BindingPath="ModifyFilter" />
              <ContentItem BindingPath="CanDelete" />
              <ContentItem BindingPath="DeleteFilter" />
            </ContentItem>
          </ContentItem>
          <ContentItem BindingPath="TabularPropertyPermissionsCollection">
            <ContentItem.Attributes>
              <DisplayName Value="'字段权限'" />
            </ContentItem.Attributes>
            <ContentItem>
              <ContentItem BindingPath="TabularType" />
              <ContentItem BindingPath="PropertyName" />
              <ContentItem BindingPath="CanRead" />
              <ContentItem BindingPath="ReadFilter" />
              <ContentItem BindingPath="CanWrite" />
              <ContentItem BindingPath="WriteFilter" />
            </ContentItem>
          </ContentItem>
          <ContentItem BindingPath="Screen.UserRoles">
            <ContentItem.Properties>
              <ContentItemProperty ControlProperty=":DataGrid.ShowAddNewRow" Value="False" />
            </ContentItem.Properties>
            <ContentItem.Attributes>
              <DisplayName Value="'关联用户'" />
            </ContentItem.Attributes>
            <ContentItem>
              <ContentItem BindingPath="User.Name" />
              <ContentItem BindingPath="User.DisplayName" />
              <ContentItem BindingPath="User.IsActive" />
            </ContentItem>
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Initialized>
    <Action ActionType=":ChangePropertyValue">
      <Action.Parameters>
        <ActionParameter Parameter=":ChangePropertyValue.Property" Value="Sys_Role" />
        <ActionParameter Parameter=":ChangePropertyValue.Value" Value="Sys_Role==null? new T_Sys_Role(): Sys_Role" />
      </Action.Parameters>
    </Action>
  </Screen.Initialized>
  <Screen.Attributes>
    <DisplayName Value="角色明细" />
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>