<Screen AllowMultipleInstances="False" ScreenKind="Custom" Name="Sys_User_Manage">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_User$CollectionView" Name="T_Sys_UserCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_Sys_User" Filter="PointInfo.IsChildOrEqual(Contexts!CurrentPoint)" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.Methods>
    <ScreenMethod Name="ADD">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="AddNewPopup" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="T_Sys_UserCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
    </ScreenMethod>
    <ScreenMethod Name="Update">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="EditPopup" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="T_Sys_UserCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
    </ScreenMethod>
    <ScreenMethod Name="delete">
      <ScreenMethod.Actions>
        <Action ActionType=":ConfirmBox">
          <Action.Parameters>
            <ActionParameter Parameter=":ConfirmBox.Title" Value="'提示'" />
            <ActionParameter Parameter=":ConfirmBox.Message" Value="'删除当用户'" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":DeleteSelectedItem">
          <Action.Parameters>
            <ActionParameter Parameter=":DeleteSelectedItem.Property" Value="T_Sys_UserCollection" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":SaveChanges">
          <Action.Parameters>
            <ActionParameter Parameter=":SaveChanges.ShowMessageAfterSaved" Value="False" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
    </ScreenMethod>
    <ScreenMethod Name="Reset">
      <ScreenMethod.Actions>
        <Action ActionType=":ConfirmBox">
          <Action.Parameters>
            <ActionParameter Parameter=":ConfirmBox.Title" Value="'提示'" />
            <ActionParameter Parameter=":ConfirmBox.Message" Value="'是否重置密码？'" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":CustomCode">
          <Action.Parameters>
            <ActionParameter Parameter=":CustomCode.Code" Value="if(Screen.T_Sys_UserCollection.SelectedItem!=null)&#xD;&#xA;{&#xD;&#xA;&#x9;Screen.T_Sys_UserCollection.SelectedItem.Password='000';&#xD;&#xA;}" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":SaveChanges">
          <Action.Parameters>
            <ActionParameter Parameter=":SaveChanges.ShowMessageAfterSaved" Value="False" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="T_Sys_UserCollection" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":MessageBox">
          <Action.Parameters>
            <ActionParameter Parameter=":MessageBox.Title" Value="'提示'" />
            <ActionParameter Parameter=":MessageBox.Message" Value="'密码重置成功！'" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
    </ScreenMethod>
  </Screen.Methods>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem.CommandItems>
        <ContentItem BindingPath="ADD">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Add.png" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'新增'" />
          </ContentItem.Attributes>
        </ContentItem>
        <ContentItem BindingPath="Update">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Modify.png" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="Screen.T_Sys_UserCollection.SelectedItem==null" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'修改'" />
          </ContentItem.Attributes>
        </ContentItem>
        <ContentItem BindingPath="delete">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Delete.png" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="Screen.T_Sys_UserCollection.SelectedItem==null" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'删除'" />
          </ContentItem.Attributes>
        </ContentItem>
        <ContentItem BindingPath="Reset">
          <ContentItem.Attributes>
            <DisplayName Value="'重置密码'" />
          </ContentItem.Attributes>
        </ContentItem>
      </ContentItem.CommandItems>
      <ContentItem Control=":RowsLayout">
        <ContentItem BindingPath="T_Sys_UserCollection">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":DataGrid.ShowAddNewRow" Value="False" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="True" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'用户'" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem.Properties>
              <ContentItemProperty ControlProperty=":BaseControl.BrowseOnly" Value="True" />
            </ContentItem.Properties>
            <ContentItem BindingPath="Name" />
            <ContentItem BindingPath="DisplayName" />
            <ContentItem BindingPath="IsAdmin" />
            <ContentItem BindingPath="IsActive" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Popups>
    <ContentItem Control=":ScreenContainer" Name="AddNewPopup">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="Sys_User_Detail" />
        <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.HeightSizingMode" Value="'Pixels'" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <ScreenContainerParameter ParameterName="IsReadOnly" ParameterType=":Boolean" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="Id" ParameterType=":Int32" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
    <ContentItem Control=":ScreenContainer" Name="EditPopup">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="Sys_User_Detail" />
        <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.HeightSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Width" Value="600" />
        <ContentItemProperty ControlProperty=":BaseControl.Height" Value="450" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <ScreenContainerParameter ParameterName="IsReadOnly" ParameterType=":Boolean" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="Id" ParameterType=":Int32" Value="Screen.T_Sys_UserCollection.SelectedItem.Id" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
    <ContentItem Control=":ScreenContainer" Name="PopupDetail">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="Sys_User_Detail" />
        <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Width" Value="600" />
        <ContentItemProperty ControlProperty=":BaseControl.HeightSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Height" Value="450" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <ScreenContainerParameter ParameterName="IsReadOnly" ParameterType=":Boolean" Value="True" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="Id" ParameterType=":Int32" Value="Screen.T_Sys_UserCollection.SelectedItem.Id" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
  </Screen.Popups>
  <Screen.Attributes>
    <DisplayName Value="用户管理" />
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>