<Screen AllowMultipleInstances="False" ScreenKind="EditGrid" Name="Sys_DepartmentInfo_Manage">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_DepartmentInfo$CollectionView" Name="T_DepartmentInfoCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_DepartmentInfo" Filter="PointInfo.IsChildOrEqual(Contexts!CurrentPoint)" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.Methods>
    <ScreenMethod Name="DataExport">
      <ScreenMethod.Actions>
        <Action ActionType=":ExportData">
          <Action.Parameters>
            <ActionParameter Parameter=":ExportData.DataSource" Value="T_DepartmentInfoCollection" />
            <ActionParameter Parameter=":ExportData.AllowUserCustomization" Value="True" />
            <ActionParameter Parameter=":ExportData.DefaultSettings" Value="[{&quot;DisplayName&quot;: &quot;网点号&quot;, &quot;Value&quot;: &quot;PointCode&quot;}, {&quot;DisplayName&quot;: &quot;网点名称&quot;, &quot;Value&quot;: &quot;PointInfo.PointName&quot;}, {&quot;DisplayName&quot;: &quot;部门ID&quot;, &quot;Value&quot;: &quot;DepartmentID&quot;}, {&quot;DisplayName&quot;: &quot;部门名称&quot;, &quot;Value&quot;: &quot;DepartmentName&quot;}, {&quot;DisplayName&quot;: &quot;上级部门ID&quot;, &quot;Value&quot;: &quot;ParentDepartmentID&quot;}, {&quot;DisplayName&quot;: &quot;'上级部门名称'&quot;, &quot;Value&quot;: &quot;ParentDepartment&quot;}, {&quot;DisplayName&quot;: &quot;描述&quot;, &quot;Value&quot;: &quot;DepartmentDescription&quot;}]" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="数据导出" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod Name="Save">
      <ScreenMethod.Actions>
        <Action ActionType=":SaveChanges" />
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="T_DepartmentInfoCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="保存" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod Name="ADD">
      <ScreenMethod.Actions>
        <Action ActionType=":AddNewItem">
          <Action.Parameters>
            <ActionParameter Parameter=":AddNewItem.Property" Value="T_DepartmentInfoCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
    </ScreenMethod>
    <ScreenMethod Name="DELETE">
      <ScreenMethod.Actions>
        <Action ActionType=":ConfirmBox">
          <Action.Parameters>
            <ActionParameter Parameter=":ConfirmBox.Title" Value="'提示'" />
            <ActionParameter Parameter=":ConfirmBox.Message" Value="'是否删除选中项'" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":DeleteSelectedItem">
          <Action.Parameters>
            <ActionParameter Parameter=":DeleteSelectedItem.Property" Value="T_DepartmentInfoCollection" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":MessageBox">
          <Action.Parameters>
            <ActionParameter Parameter=":MessageBox.Title" Value="'提示'" />
            <ActionParameter Parameter=":MessageBox.Message" Value="'选中数据删除成功！'" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":SaveChanges">
          <Action.Parameters>
            <ActionParameter Parameter=":SaveChanges.ShowMessageAfterSaved" Value="False" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="T_DepartmentInfoCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
    </ScreenMethod>
  </Screen.Methods>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem.CommandItems>
        <ContentItem BindingPath="Save">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Save.png" />
          </ContentItem.Properties>
        </ContentItem>
        <ContentItem BindingPath="DataExport">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Export.png" />
          </ContentItem.Properties>
        </ContentItem>
      </ContentItem.CommandItems>
      <ContentItem Control=":RowsLayout">
        <ContentItem BindingPath="T_DepartmentInfoCollection">
          <ContentItem.CommandItems>
            <ContentItem BindingPath="Screen.ADD">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Add.png" />
              </ContentItem.Properties>
              <ContentItem.Attributes>
                <DisplayName Value="'新增'" />
              </ContentItem.Attributes>
            </ContentItem>
            <ContentItem BindingPath="Screen.DELETE">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Delete.png" />
              </ContentItem.Properties>
              <ContentItem.Attributes>
                <DisplayName Value="'删除'" />
              </ContentItem.Attributes>
            </ContentItem>
          </ContentItem.CommandItems>
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":DataGrid.ShowAddNewRow" Value="False" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'部门信息管理'" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem BindingPath="PointCode">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="True" />
                <ContentItemProperty ControlProperty=":BaseControl.IsRequired" Value="True" />
                <ContentItemProperty ControlProperty=":DataGridRow.ColumnHeaderBackground" Value="'#FFFFE4E1'" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="DepartmentName">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.IsRequired" Value="True" />
                <ContentItemProperty ControlProperty=":DataGridRow.ColumnHeaderBackground" Value="'#FFFFE4E1'" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem Control=":AutoCompleteBox" BindingPath="ParentDepartment">
              <ContentItem />
            </ContentItem>
            <ContentItem BindingPath="DepartmentDescription" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Attributes>
    <DisplayName Value="部门信息管理" />
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>