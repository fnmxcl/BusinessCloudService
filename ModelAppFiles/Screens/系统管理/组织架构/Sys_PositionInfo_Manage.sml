<Screen AllowMultipleInstances="False" ScreenKind="EditGrid" Name="Sys_PositionInfo_Manage">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_PositionInfo$CollectionView" Name="T_PositionInfoCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_PositionInfo" Filter="PointInfo.IsChildOrEqual(Contexts!CurrentPoint)">
          <ScreenQuery.SortDescriptions>
            <QuerySortDescription Property="TabOrder" SortOrder="Ascending" />
          </ScreenQuery.SortDescriptions>
        </ScreenQuery>
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.Methods>
    <ScreenMethod Name="add">
      <ScreenMethod.Actions>
        <Action ActionType=":AddNewItem">
          <Action.Parameters>
            <ActionParameter Parameter=":AddNewItem.Property" Value="T_PositionInfoCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
    </ScreenMethod>
    <ScreenMethod Name="delete">
      <ScreenMethod.Actions>
        <Action ActionType=":ConfirmBox">
          <Action.Parameters>
            <ActionParameter Parameter=":ConfirmBox.Title" Value="'提示'" />
            <ActionParameter Parameter=":ConfirmBox.Message" Value="'是否删除选中项！'" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":DeleteSelectedItem">
          <Action.Parameters>
            <ActionParameter Parameter=":DeleteSelectedItem.Property" Value="T_PositionInfoCollection" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":SaveChanges">
          <Action.Parameters>
            <ActionParameter Parameter=":SaveChanges.ShowMessageAfterSaved" Value="False" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":MessageBox">
          <Action.Parameters>
            <ActionParameter Parameter=":MessageBox.Title" Value="'提示'" />
            <ActionParameter Parameter=":MessageBox.Message" Value="'删除选择中项成功！'" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="T_PositionInfoCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
    </ScreenMethod>
    <ScreenMethod Name="Export">
      <ScreenMethod.Actions>
        <Action ActionType=":ExportData">
          <Action.Parameters>
            <ActionParameter Parameter=":ExportData.DataSource" Value="T_PositionInfoCollection" />
            <ActionParameter Parameter=":ExportData.AllowUserCustomization" Value="" />
            <ActionParameter Parameter=":ExportData.DefaultSettings" Value="[{&quot;DisplayName&quot;: &quot;网点号&quot;, &quot;Value&quot;: &quot;PointCode&quot;}, {&quot;DisplayName&quot;: &quot;顺序码&quot;, &quot;Value&quot;: &quot;TabOrder&quot;}, {&quot;DisplayName&quot;: &quot;职务&quot;, &quot;Value&quot;: &quot;Position&quot;}, {&quot;DisplayName&quot;: &quot;描述&quot;, &quot;Value&quot;: &quot;Description&quot;}]" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
    </ScreenMethod>
    <ScreenMethod Name="Save">
      <ScreenMethod.Actions>
        <Action ActionType=":SaveChanges" />
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
          <ContentItem.Attributes>
            <DisplayName Value="'保存'" />
          </ContentItem.Attributes>
        </ContentItem>
        <ContentItem BindingPath="Export">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Export.png" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'数据导出'" />
          </ContentItem.Attributes>
        </ContentItem>
      </ContentItem.CommandItems>
      <ContentItem Control=":RowsLayout">
        <ContentItem BindingPath="T_PositionInfoCollection">
          <ContentItem.CommandItems>
            <ContentItem BindingPath="Screen.add">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Add.png" />
              </ContentItem.Properties>
              <ContentItem.Attributes>
                <DisplayName Value="'新增'" />
              </ContentItem.Attributes>
            </ContentItem>
            <ContentItem BindingPath="Screen.delete">
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
            <DisplayName Value="'职务信息管理'" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem BindingPath="PointCode">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="True" />
                <ContentItemProperty ControlProperty=":BaseControl.IsRequired" Value="True" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="TabOrder" />
            <ContentItem BindingPath="Position">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.IsRequired" Value="True" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="Description" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Attributes>
    <DisplayName Value="职务信息管理" />
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>