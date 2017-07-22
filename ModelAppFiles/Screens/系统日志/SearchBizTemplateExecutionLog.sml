<Screen AllowMultipleInstances="False" ScreenKind="Custom" Name="SearchBizTemplateExecutionLog">
  <Screen.Properties>
    <ScreenQueryProperty ShowDeletedItems="False" PropertyType="ApplicationData.BizTemplateExecutionLog$CollectionView" Name="BizTemplateExecutionLogCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.BizTemplateExecutionLog" Filter="(BizTemplate==Screen.BizTemplate or Screen.BizTemplate==null) and (Client==Screen.Client or Screen.Client==null)" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenLocalProperty PropertyType="ApplicationData.BizTemplate" Name="BizTemplate" />
    <ScreenLocalProperty PropertyType="ApplicationData.Client" Name="Client" />
  </Screen.Properties>
  <Screen.Methods>
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
    <ScreenMethod Name="重试">
      <ScreenMethod.Actions>
        <Action ActionType=":CustomCode">
          <Action.Parameters>
            <ActionParameter Parameter=":CustomCode.Code" Value="BizTemplateExecutionLogCollection.SelectedItem.RetryCount=0;" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
    </ScreenMethod>
  </Screen.Methods>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem.CommandItems>
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
        <ContentItem BindingPath="重试">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="BizTemplateExecutionLogCollection.SelectedItem==null" />
          </ContentItem.Properties>
        </ContentItem>
      </ContentItem.CommandItems>
      <ContentItem Control=":RowsLayout">
        <ContentItem Control=":GroupBox">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Top'" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'查询条件'" />
          </ContentItem.Attributes>
          <ContentItem Control=":ColumnsLayout">
            <ContentItem.Attributes>
              <DisplayName Value="'业务模板执行日志查看'" />
            </ContentItem.Attributes>
            <ContentItem BindingPath="BizTemplate">
              <ContentItem.Attributes>
                <DisplayName Value="'业务模板'" />
              </ContentItem.Attributes>
              <ContentItem>
                <ContentItem BindingPath="No" />
                <ContentItem BindingPath="Name" />
                <ContentItem BindingPath="CreateTime" />
                <ContentItem BindingPath="UpdateTime" />
              </ContentItem>
            </ContentItem>
            <ContentItem BindingPath="Client">
              <ContentItem.Attributes>
                <DisplayName Value="'客户'" />
              </ContentItem.Attributes>
              <ContentItem>
                <ContentItem BindingPath="No" />
                <ContentItem BindingPath="Name" />
              </ContentItem>
            </ContentItem>
          </ContentItem>
        </ContentItem>
        <ContentItem BindingPath="BizTemplateExecutionLogCollection">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":DataGrid.ShowAddNewRow" Value="False" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="True" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'业务模板执行日志'" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem.Properties>
              <ContentItemProperty ControlProperty=":BaseControl.BrowseOnly" Value="True" />
            </ContentItem.Properties>
            <ContentItem BindingPath="BeginExecutionTime" />
            <ContentItem BindingPath="EndExecutionTime" />
            <ContentItem BindingPath="Parameters" />
            <ContentItem BindingPath="Result" />
            <ContentItem BindingPath="Status" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Attributes>
    <DisplayName Value="业务模板执行日志查看" />
  </Screen.Attributes>
</Screen>