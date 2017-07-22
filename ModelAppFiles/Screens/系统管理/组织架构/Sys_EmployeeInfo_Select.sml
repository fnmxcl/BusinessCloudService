<Screen AllowMultipleInstances="False" ScreenKind="Search" Name="Sys_EmployeeInfo_Select">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_EmployeeInfo$CollectionView" Name="T_EmployeeInfoCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_EmployeeInfo" Filter="(EmployeeCHName.Contains(Screen.EmployeeCHName) or Screen.EmployeeCHName==null) and (EmployeeCode=='Screen.EmployeeCode' or Screen.EmployeeCode==null) and (PointInfo.IsChildOrEqual(Contexts!CurrentPoint))" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenLocalProperty PropertyType=":String" Name="EmployeeCode">
      <ScreenLocalProperty.Attributes>
        <IsParameter />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
    <ScreenLocalProperty PropertyType=":String" Name="PointCode">
      <ScreenLocalProperty.Attributes>
        <IsParameter />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
    <ScreenLocalProperty PropertyType=":Int32" Name="EmployeeID">
      <ScreenLocalProperty.Attributes>
        <IsParameter />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
    <ScreenQueryProperty PropertyType="ApplicationData.T_EmployeeInfo" Name="SelectedItem">
      <ScreenQueryProperty.Query>
        <ScreenQuery ResultType="Single" EntityType="ApplicationData.T_EmployeeInfo" Filter="EmployeeID==Screen.EmployeeID" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenLocalProperty PropertyType=":Boolean" Name="DialogResult" />
    <ScreenLocalProperty PropertyType=":String" Name="EmployeeCHName">
      <ScreenLocalProperty.Attributes>
        <IsParameter />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
  </Screen.Properties>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem Control=":RowsLayout">
        <ContentItem BindingPath="T_EmployeeInfoCollection">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":DataGrid.ShowAddNewRow" Value="False" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="True" />
            <ContentItemProperty ControlProperty=":BaseControl.ShowCommandBar" Value="False" />
          </ContentItem.Properties>
          <ContentItem.Events>
            <ContentItemEvent ControlEvent=":DataGrid.RowDoubleClick">
              <ContentItemEvent.Actions>
                <Action ActionType=":CustomCode">
                  <Action.Parameters>
                    <ActionParameter Parameter=":CustomCode.Code" Value="SelectedItem = Screen.T_EmployeeInfoCollection.SelectedItem;&#xD;&#xA;DialogResult = True;&#xD;&#xA;this.Close(False);&#xD;&#xA;" />
                  </Action.Parameters>
                </Action>
              </ContentItemEvent.Actions>
            </ContentItemEvent>
          </ContentItem.Events>
          <ContentItem.Attributes>
            <DisplayName Value="'员工信息查询'" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem.Properties>
              <ContentItemProperty ControlProperty=":BaseControl.BrowseOnly" Value="True" />
            </ContentItem.Properties>
            <ContentItem BindingPath="EmployeeID" />
            <ContentItem BindingPath="PointCode" />
            <ContentItem BindingPath="EmployeeCode" />
            <ContentItem BindingPath="EmployeeCHName" />
            <ContentItem BindingPath="EmployeeSpellingCode" />
            <ContentItem BindingPath="EmployeeEnName" />
            <ContentItem BindingPath="EmployeePassword" />
            <ContentItem BindingPath="EmployeeAlias" />
            <ContentItem BindingPath="DepartmentID" />
            <ContentItem BindingPath="EmployeePosition" />
            <ContentItem BindingPath="EmployeeEmail" />
            <ContentItem BindingPath="EmployeeMobile" />
            <ContentItem BindingPath="EmployeeMobile2" />
            <ContentItem BindingPath="EmployeeMoveTel" />
            <ContentItem BindingPath="EmployeeOfficeTel" />
            <ContentItem BindingPath="EmployeeHomeTel" />
            <ContentItem BindingPath="EmployeeFax" />
            <ContentItem BindingPath="EmployeeHomeAddress" />
            <ContentItem BindingPath="EmployeeIDCardNo" />
            <ContentItem BindingPath="EmployeeDegree" />
            <ContentItem BindingPath="EmployeeBirthday" />
            <ContentItem BindingPath="EmployeeRegisterDate" />
            <ContentItem BindingPath="EmployeeDescription" />
            <ContentItem BindingPath="Status" />
            <ContentItem BindingPath="SysFlag" />
            <ContentItem BindingPath="Photo" />
            <ContentItem BindingPath="Skills" />
            <ContentItem BindingPath="Features" />
            <ContentItem BindingPath="Manager" />
            <ContentItem BindingPath="Stars" />
            <ContentItem BindingPath="PassWordLastModifyDate" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Attributes>
    <DisplayName Value="员工工号查询" />
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>