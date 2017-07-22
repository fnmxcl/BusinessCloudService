<Screen AllowMultipleInstances="False" ScreenKind="Custom" Name="ClientDetails">
  <Screen.Properties>
    <ScreenQueryProperty ShowDeletedItems="False" PropertyType="ApplicationData.Client" Name="Client">
      <ScreenQueryProperty.Query>
        <ScreenQuery ResultType="Single" EntityType="ApplicationData.Client" Filter="Id==Screen.Id" />
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
        <ContentItem Control=":TableLayout" BindingPath="Client">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Top'" />
          </ContentItem.Properties>
          <ContentItem Control=":TableColumn">
            <ContentItem BindingPath="No" />
            <ContentItem BindingPath="ConnectionString">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":TableColumn.ColumnSpan" Value="2" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="DataSource">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":DetailsDataGridPicker.ShowStyle" Value="'ListStyle'" />
              </ContentItem.Properties>
              <ContentItem>
                <ContentItem BindingPath="Id" />
                <ContentItem BindingPath="Name" />
                <ContentItem BindingPath="Description" />
              </ContentItem>
            </ContentItem>
          </ContentItem>
          <ContentItem Control=":TableColumn">
            <ContentItem BindingPath="Name" />
            <ContentItem BindingPath="Database" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Initialized>
    <Action ActionType=":ChangePropertyValue">
      <Action.Parameters>
        <ActionParameter Parameter=":ChangePropertyValue.Property" Value="Client" />
        <ActionParameter Parameter=":ChangePropertyValue.Value" Value="Client==null?new Client():Client" />
      </Action.Parameters>
    </Action>
  </Screen.Initialized>
  <Screen.Attributes>
    <DisplayName Value="客户明细" />
  </Screen.Attributes>
</Screen>