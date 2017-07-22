<Screen AllowMultipleInstances="False" ScreenKind="Custom" Name="BizTemplateDetails">
  <Screen.Properties>
    <ScreenQueryProperty ShowDeletedItems="False" PropertyType="ApplicationData.BizTemplate" Name="BizTemplate">
      <ScreenQueryProperty.Query>
        <ScreenQuery ResultType="Single" EntityType="ApplicationData.BizTemplate" Filter="Id==Screen.Id" />
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
    <ScreenQueryProperty ShowDeletedItems="False" PropertyType="ApplicationData.BizTemplateDataSource$CollectionView" Name="BizTemplateDataSourcesCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery Source="BizTemplate.BizTemplateDataSources" EntityType="ApplicationData.BizTemplateDataSource" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.Methods>
    <ScreenMethod Name="Save">
      <ScreenMethod.Actions>
        <Action ActionType=":SaveChanges">
          <Action.Parameters>
            <ActionParameter Parameter=":SaveChanges.ShowMessageAfterSaved" Value="False" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="保存" />
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
  </Screen.Methods>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem.CommandItems>
        <ContentItem BindingPath="Save">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Save1.png" />
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
        <ContentItem.Properties>
          <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="IsReadOnly" />
        </ContentItem.Properties>
        <ContentItem Control=":TableLayout" BindingPath="BizTemplate">
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
          <ContentItem Control=":ColumnsLayout">
            <ContentItem.Attributes>
              <DisplayName Value="'数据源'" />
            </ContentItem.Attributes>
            <ContentItem BindingPath="BizTemplateDataSourcesCollection">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.HorizontalAlignment" Value="'Left'" />
                <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Pixels'" />
                <ContentItemProperty ControlProperty=":BaseControl.Width" Value="240" />
              </ContentItem.Properties>
              <ContentItem.Attributes>
                <DisplayName Value="'数据源'" />
              </ContentItem.Attributes>
              <ContentItem>
                <ContentItem BindingPath="DataSource">
                  <ContentItem.Properties>
                    <ContentItemProperty ControlProperty=":DataGridRow.ColumnWidth" Value="'*'" />
                  </ContentItem.Properties>
                  <ContentItem>
                    <ContentItem BindingPath="Id" />
                    <ContentItem BindingPath="No" />
                    <ContentItem BindingPath="Name" />
                    <ContentItem BindingPath="Description" />
                  </ContentItem>
                </ContentItem>
              </ContentItem>
            </ContentItem>
            <ContentItem Control=":RowsLayout">
              <ContentItem BindingPath="BizTemplateDataSourcesCollection.SelectedItem.DataSource">
                <ContentItem />
              </ContentItem>
              <ContentItem Control=":UserControl">
                <ContentItem.Properties>
                  <ContentItemProperty ControlProperty=":UserControl.ClassName" Value="SBE.CloudCodeEditor.CloudCodeEditor, SBE.CloudCodeEditor, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null" />
                  <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Stretch'" />
                  <ContentItemProperty ControlProperty=":BaseControl.AttachedLabelPosition" Value="'Collapsed'" />
                </ContentItem.Properties>
                <ContentItem.Attributes>
                  <UserControlProperty Property="DataSource" Value="BizTemplateDataSourcesCollection.SelectedItem.DataSource.No" />
                  <UserControlProperty Property="Code" Value="BizTemplateDataSourcesCollection.SelectedItem.CustomCode" />
                </ContentItem.Attributes>
              </ContentItem>
            </ContentItem>
          </ContentItem>
        </ContentItem>
        <ContentItem Control=":ColumnsLayout">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Top'" />
          </ContentItem.Properties>
          <ContentItem Control=":Label" BindingPath="BizTemplate.CreateTime" />
          <ContentItem Control=":Label" BindingPath="BizTemplate.UpdateTime" />
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Initialized>
    <Action ActionType=":ChangePropertyValue">
      <Action.Parameters>
        <ActionParameter Parameter=":ChangePropertyValue.Property" Value="BizTemplate" />
        <ActionParameter Parameter=":ChangePropertyValue.Value" Value="BizTemplate==null?new BizTemplate():BizTemplate" />
      </Action.Parameters>
    </Action>
  </Screen.Initialized>
  <Screen.Attributes>
    <DisplayName Value="业务模板明细配置" />
  </Screen.Attributes>
</Screen>