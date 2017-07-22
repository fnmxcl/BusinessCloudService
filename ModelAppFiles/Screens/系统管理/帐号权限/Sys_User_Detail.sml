<Screen AllowMultipleInstances="False" ScreenKind="Custom" Name="Sys_User_Detail">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_User" Name="Sys_User">
      <ScreenQueryProperty.Query>
        <ScreenQuery ResultType="Single" EntityType="ApplicationData.T_Sys_User" Filter="Id==Screen.Id" />
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
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_UserRole$CollectionView" Name="RolesCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery Source="Sys_User.Roles" EntityType="ApplicationData.T_Sys_UserRole" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_Role$CollectionView" Name="Sys_RoleCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_Sys_Role" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenLocalProperty PropertyType="ApplicationData.T_Sys_Role" Name="Sys_Role" />
    <ScreenQueryProperty PropertyType="ApplicationData.T_Sys_UserRole$CollectionView" Name="Roles">
      <ScreenQueryProperty.Query>
        <ScreenQuery Source="Sys_User.Roles" EntityType="ApplicationData.T_Sys_UserRole" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenQueryProperty PropertyType="ApplicationData.T_EmployeeInfo$CollectionView" Name="T_EmployeeInfoCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_EmployeeInfo" Filter="PointInfo==Contexts!CurrentPoint" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenLocalProperty PropertyType=":String" Name="EmployeeCode" />
    <ScreenLocalProperty PropertyType=":String" Name="EmpolyeeName" />
    <ScreenQueryProperty PropertyType="ApplicationData.T_PointInfo$CollectionView" Name="T_PointInfoCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_PointInfo" Filter="Parent.IsChildOrEqual(Contexts!CurrentPoint) or PointCode==Contexts!CurrentPoint.PointCode" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.Methods>
    <ScreenMethod Name="add">
      <ScreenMethod.Actions>
        <Action ActionType=":SaveChanges" />
      </ScreenMethod.Actions>
    </ScreenMethod>
  </Screen.Methods>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem.CommandItems>
        <ContentItem BindingPath="add">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Save.png" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'保存'" />
          </ContentItem.Attributes>
        </ContentItem>
      </ContentItem.CommandItems>
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.HeightSizingMode" Value="'Pixels'" />
      </ContentItem.Properties>
      <ContentItem Control=":RowsLayout">
        <ContentItem.Properties>
          <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="IsReadOnly" />
        </ContentItem.Properties>
        <ContentItem Control=":TableLayout" BindingPath="Sys_User">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Top'" />
          </ContentItem.Properties>
          <ContentItem Control=":TableColumn">
            <ContentItem Control=":SearchTextBox" BindingPath="Screen.EmployeeCode">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":SearchTextBox.SearchScreen" Value="Sys_EmployeeInfo_Select" />
                <ContentItemProperty ControlProperty=":SearchTextBox.SearchParameter" Value="EmployeeCode" />
                <ContentItemProperty ControlProperty=":SearchTextBox.Filter" Value="EmployeeCode" />
                <ContentItemProperty ControlProperty=":BaseControl.AttachedLabelPosition" Value="'RightAligned'" />
                <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                <ContentItemProperty ControlProperty=":BaseControl.Foreground" Value="'#FF000000'" />
              </ContentItem.Properties>
              <ContentItem.Events>
                <ContentItemEvent ControlEvent=":SearchTextBox.ItemSelected">
                  <ContentItemEvent.Actions>
                    <Action ActionType=":CustomCode">
                      <Action.Parameters>
                        <ActionParameter Parameter=":CustomCode.Code" Value="&#xD;&#xA;&#x9;//Screen.Sys_User.EmployeeInfo=SelectedItem;&#xD;&#xA;&#x9;//Screen.EmployeeCode=SelectedItem.EmployeeCode;&#xD;&#xA;&#x9;//Screen.Sys_User.PointInfo=SelectedItem.PointCodeReference;&#xD;&#xA;&#x9;//Screen.Sys_User.Name=SelectedItem.EmployeeCode;&#xD;&#xA;&#x9;&#xD;&#xA;&#x9;&#x9;&#xD;&#xA;&#x9;Screen.Sys_User.EmployeeInfo=SelectedItem;&#xD;&#xA;&#x9;Screen.EmployeeCode=SelectedItem.EmployeeCode;&#xD;&#xA;&#x9;Screen.EmpolyeeName=SelectedItem.EmployeeCHName;&#xD;&#xA;&#x9;Screen.Sys_User.PointInfo=SelectedItem.PointInfo;&#xD;&#xA;&#x9;Screen.Sys_User.Name=SelectedItem.EmployeeCode;&#xD;&#xA;" />
                      </Action.Parameters>
                    </Action>
                  </ContentItemEvent.Actions>
                </ContentItemEvent>
              </ContentItem.Events>
              <ContentItem.Attributes>
                <DisplayName Value="'用户'" />
                <ScreenContainerParameter ParameterName="EmployeeCode" ParameterType=":String" BindingMode="TwoWay" />
                <ScreenContainerParameter ParameterName="PointCode" ParameterType=":String" BindingMode="TwoWay" />
                <ScreenContainerParameter ParameterName="EmployeeID" ParameterType=":Int32" BindingMode="TwoWay" />
              </ContentItem.Attributes>
            </ContentItem>
            <ContentItem BindingPath="Password">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.Width" Value="327" />
                <ContentItemProperty ControlProperty=":BaseControl.AttachedLabelPosition" Value="'RightAligned'" />
                <ContentItemProperty ControlProperty=":BaseControl.HorizontalAlignment" Value="'Stretch'" />
                <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                <ContentItemProperty ControlProperty=":BaseControl.Foreground" Value="'#FF000000'" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="PointInfo">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.Width" Value="327" />
                <ContentItemProperty ControlProperty=":BaseControl.AttachedLabelPosition" Value="'RightAligned'" />
                <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                <ContentItemProperty ControlProperty=":BaseControl.Foreground" Value="'#FF000000'" />
              </ContentItem.Properties>
              <ContentItem />
            </ContentItem>
          </ContentItem>
          <ContentItem Control=":TableColumn">
            <ContentItem BindingPath="DisplayName" />
            <ContentItem Control=":SearchTextBox" BindingPath="Screen.EmpolyeeName">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":SearchTextBox.SearchScreen" Value="Sys_EmployeeInfo_Select" />
                <ContentItemProperty ControlProperty=":SearchTextBox.SearchParameter" Value="EmployeeCHName" />
                <ContentItemProperty ControlProperty=":SearchTextBox.Filter" Value="EmployeeCHName" />
                <ContentItemProperty ControlProperty=":BaseControl.AttachedLabelPosition" Value="'RightAligned'" />
                <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                <ContentItemProperty ControlProperty=":BaseControl.Foreground" Value="'#FF000000'" />
              </ContentItem.Properties>
              <ContentItem.Events>
                <ContentItemEvent ControlEvent=":SearchTextBox.ItemSelected">
                  <ContentItemEvent.Actions>
                    <Action ActionType=":CustomCode">
                      <Action.Parameters>
                        <ActionParameter Parameter=":CustomCode.Code" Value="&#xD;&#xA;&#x9;Screen.Sys_User.EmployeeInfo=SelectedItem;&#xD;&#xA;&#x9;Screen.EmployeeCode=SelectedItem.EmployeeCode;&#xD;&#xA;&#x9;Screen.EmpolyeeName=SelectedItem.EmployeeCHName;&#xD;&#xA;&#x9;Screen.Sys_User.PointInfo=SelectedItem.PointInfo;&#xD;&#xA;&#x9;Screen.Sys_User.Name=SelectedItem.EmployeeCode;&#xD;&#xA;&#x9;" />
                      </Action.Parameters>
                    </Action>
                  </ContentItemEvent.Actions>
                </ContentItemEvent>
              </ContentItem.Events>
              <ContentItem.Attributes>
                <DisplayName Value="'员工'" />
                <ScreenContainerParameter ParameterName="EmployeeCode" ParameterType=":String" BindingMode="TwoWay" />
                <ScreenContainerParameter ParameterName="PointCode" ParameterType=":String" BindingMode="TwoWay" />
                <ScreenContainerParameter ParameterName="EmployeeID" ParameterType=":Int32" BindingMode="TwoWay" />
              </ContentItem.Attributes>
            </ContentItem>
            <ContentItem Control=":ColumnsLayout">
              <ContentItem BindingPath="IsActive">
                <ContentItem.Properties>
                  <ContentItemProperty ControlProperty=":BaseControl.HorizontalAlignment" Value="'Left'" />
                  <ContentItemProperty ControlProperty=":BaseControl.IsRequired" Value="True" />
                </ContentItem.Properties>
              </ContentItem>
              <ContentItem BindingPath="IsAdmin">
                <ContentItem.Properties>
                  <ContentItemProperty ControlProperty=":BaseControl.HorizontalAlignment" Value="'Left'" />
                </ContentItem.Properties>
              </ContentItem>
            </ContentItem>
          </ContentItem>
        </ContentItem>
        <ContentItem BindingPath="Screen.Roles">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":DataGrid.ShowAddNewRow" Value="False" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'角色 '" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem BindingPath="Role">
              <ContentItem />
            </ContentItem>
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Initialized>
    <Action ActionType=":ChangePropertyValue">
      <Action.Parameters>
        <ActionParameter Parameter=":ChangePropertyValue.Property" Value="Sys_User" />
        <ActionParameter Parameter=":ChangePropertyValue.Value" Value="Sys_User==null? new T_Sys_User(): Sys_User" />
      </Action.Parameters>
    </Action>
    <Action ActionType=":CustomCode">
      <Action.Parameters>
        <ActionParameter Parameter=":CustomCode.Code" Value="if(Sys_User!=null)&#xD;&#xA;{&#xD;&#xA;   if( Sys_User.Name!=null){&#xD;&#xA;&#x9;Screen.EmployeeCode=Sys_User.Name;&#xD;&#xA;&#x9; }&#xD;&#xA;    if( Sys_User.EmployeeInfo!=null){&#xD;&#xA;&#x9;Screen.EmpolyeeName=Sys_User.EmployeeInfo.EmployeeCHName;&#xD;&#xA;&#x9; }&#xD;&#xA;}" />
      </Action.Parameters>
    </Action>
  </Screen.Initialized>
  <Screen.Attributes>
    <DisplayName Value="用户明细" />
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>