<Screen AllowMultipleInstances="False" ScreenKind="Custom" Name="Sys_PointInfo_Manage">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_PointInfo$CollectionView" Name="T_PointInfoCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_PointInfo" Filter="Parent.IsChildOrEqual(Contexts!CurrentPoint) or PointCode==Contexts!CurrentPoint.PointCode" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.Methods>
    <ScreenMethod Name="Add">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="Popup_Add" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="T_PointInfoCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="增加" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod Name="Modify">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="Popup_Modify" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="T_PointInfoCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="修改" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod Name="Delete">
      <ScreenMethod.Actions>
        <Action ActionType=":ConfirmBox">
          <Action.Parameters>
            <ActionParameter Parameter=":ConfirmBox.Title" Value="'警告'" />
            <ActionParameter Parameter=":ConfirmBox.Message" Value="'你确实要删除当前网点？'" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":DeleteSelectedItem">
          <Action.Parameters>
            <ActionParameter Parameter=":DeleteSelectedItem.Property" Value="T_PointInfoCollection" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":SaveChanges" />
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="T_PointInfoCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="删除" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod Name="Detail">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="Popup_Detail" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="详细" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod Name="Export">
      <ScreenMethod.Actions>
        <Action ActionType=":ExportData">
          <Action.Parameters>
            <ActionParameter Parameter=":ExportData.DataSource" Value="T_PointInfoCollection" />
            <ActionParameter Parameter=":ExportData.AllowUserCustomization" Value="True" />
            <ActionParameter Parameter=":ExportData.DefaultSettings" Value="[{&quot;DisplayName&quot;: &quot;网点号&quot;, &quot;Value&quot;: &quot;PointCode&quot;}, {&quot;DisplayName&quot;: &quot;网点名称&quot;, &quot;Value&quot;: &quot;PointName&quot;}, {&quot;DisplayName&quot;: &quot;网点全称&quot;, &quot;Value&quot;: &quot;PointFullName&quot;}, {&quot;DisplayName&quot;: &quot;网点类型&quot;, &quot;Value&quot;: &quot;PointType&quot;}, {&quot;DisplayName&quot;: &quot;核算类型&quot;, &quot;Value&quot;: &quot;AccountingType&quot;}, {&quot;DisplayName&quot;: &quot;所属网点代码&quot;, &quot;Value&quot;: &quot;ParentPointCode&quot;}, {&quot;DisplayName&quot;: &quot;继承父网点配置&quot;, &quot;Value&quot;: &quot;InheritParentData&quot;}, {&quot;DisplayName&quot;: &quot;负责人&quot;, &quot;Value&quot;: &quot;Owner&quot;}, {&quot;DisplayName&quot;: &quot;地址&quot;, &quot;Value&quot;: &quot;Address&quot;}, {&quot;DisplayName&quot;: &quot;邮编&quot;, &quot;Value&quot;: &quot;ZipCode&quot;}, {&quot;DisplayName&quot;: &quot;电话&quot;, &quot;Value&quot;: &quot;Tel&quot;}, {&quot;DisplayName&quot;: &quot;传真&quot;, &quot;Value&quot;: &quot;Fax&quot;}, {&quot;DisplayName&quot;: &quot;手机&quot;, &quot;Value&quot;: &quot;Mobile&quot;}, {&quot;DisplayName&quot;: &quot;状态&quot;, &quot;Value&quot;: &quot;Status&quot;}, {&quot;DisplayName&quot;: &quot;顺序码&quot;, &quot;Value&quot;: &quot;TabOrder&quot;}, {&quot;DisplayName&quot;: &quot;是否系统数据&quot;, &quot;Value&quot;: &quot;SysFlag&quot;}, {&quot;DisplayName&quot;: &quot;联系人&quot;, &quot;Value&quot;: &quot;Linker&quot;}, {&quot;DisplayName&quot;: &quot;联系人电话&quot;, &quot;Value&quot;: &quot;LinkerTel&quot;}, {&quot;DisplayName&quot;: &quot;联系人手机&quot;, &quot;Value&quot;: &quot;LinkerMobile&quot;}, {&quot;DisplayName&quot;: &quot;网址&quot;, &quot;Value&quot;: &quot;Web&quot;}, {&quot;DisplayName&quot;: &quot;电子邮箱&quot;, &quot;Value&quot;: &quot;Email&quot;}, {&quot;DisplayName&quot;: &quot;企业性质&quot;, &quot;Value&quot;: &quot;Property&quot;}, {&quot;DisplayName&quot;: &quot;开户银行&quot;, &quot;Value&quot;: &quot;AccountBank&quot;}, {&quot;DisplayName&quot;: &quot;银行帐号&quot;, &quot;Value&quot;: &quot;AccountNo&quot;}, {&quot;DisplayName&quot;: &quot;税号&quot;, &quot;Value&quot;: &quot;TaxNo&quot;}, {&quot;DisplayName&quot;: &quot;备注&quot;, &quot;Value&quot;: &quot;Summary&quot;}, {&quot;DisplayName&quot;: &quot;是否基本经营单位&quot;, &quot;Value&quot;: &quot;IsBaseBusinessUnits&quot;}, {&quot;DisplayName&quot;: &quot;注册资金&quot;, &quot;Value&quot;: &quot;RegisteredCapital&quot;}, {&quot;DisplayName&quot;: &quot;注册日期&quot;, &quot;Value&quot;: &quot;RegisterTime&quot;}, {&quot;DisplayName&quot;: &quot;国家&quot;, &quot;Value&quot;: &quot;Country&quot;}, {&quot;DisplayName&quot;: &quot;省份&quot;, &quot;Value&quot;: &quot;Province&quot;}, {&quot;DisplayName&quot;: &quot;地区&quot;, &quot;Value&quot;: &quot;Area&quot;}, {&quot;DisplayName&quot;: &quot;是否停业&quot;, &quot;Value&quot;: &quot;IsClosure&quot;}, {&quot;DisplayName&quot;: &quot;开业日期1&quot;, &quot;Value&quot;: &quot;OpeningDate1&quot;}, {&quot;DisplayName&quot;: &quot;开业日期2&quot;, &quot;Value&quot;: &quot;OpeningDate2&quot;}, {&quot;DisplayName&quot;: &quot;城市&quot;, &quot;Value&quot;: &quot;City&quot;}, {&quot;DisplayName&quot;: &quot;节点路径&quot;, &quot;Value&quot;: &quot;NodePath&quot;}]" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="数据导出" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
  </Screen.Methods>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem.CommandItems>
        <ContentItem BindingPath="Add">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Add.png" />
          </ContentItem.Properties>
        </ContentItem>
        <ContentItem BindingPath="Modify">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Modify.png" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="T_PointInfoCollection.SelectedItem==null" />
          </ContentItem.Properties>
        </ContentItem>
        <ContentItem BindingPath="Delete">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Delete.png" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="T_PointInfoCollection.SelectedItem==null" />
          </ContentItem.Properties>
        </ContentItem>
        <ContentItem BindingPath="Detail">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="detail.png" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="T_PointInfoCollection.SelectedItem==null" />
          </ContentItem.Properties>
        </ContentItem>
        <ContentItem BindingPath="Export">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Export.png" />
          </ContentItem.Properties>
        </ContentItem>
      </ContentItem.CommandItems>
      <ContentItem.Attributes>
        <DisplayName Value="'网点信息管理'" />
      </ContentItem.Attributes>
      <ContentItem Control=":RowsLayout">
        <ContentItem BindingPath="T_PointInfoCollection">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":DataGrid.ShowAddNewRow" Value="False" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="True" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'网点信息管理'" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem.Properties>
              <ContentItemProperty ControlProperty=":BaseControl.BrowseOnly" Value="True" />
            </ContentItem.Properties>
            <ContentItem BindingPath="TabOrder" />
            <ContentItem BindingPath="PointCode" />
            <ContentItem BindingPath="PointName" />
            <ContentItem BindingPath="PointFullName" />
            <ContentItem BindingPath="PointType" />
            <ContentItem BindingPath="AccountingType" />
            <ContentItem BindingPath="Parent">
              <ContentItem.Attributes>
                <DisplayName Value="'所属网点'" />
              </ContentItem.Attributes>
            </ContentItem>
            <ContentItem BindingPath="Owner" />
            <ContentItem BindingPath="Address" />
            <ContentItem BindingPath="ZipCode" />
            <ContentItem BindingPath="Tel" />
            <ContentItem BindingPath="Fax" />
            <ContentItem BindingPath="Mobile" />
            <ContentItem BindingPath="Status" />
            <ContentItem BindingPath="Linker" />
            <ContentItem BindingPath="LinkerTel" />
            <ContentItem BindingPath="LinkerMobile" />
            <ContentItem BindingPath="Web" />
            <ContentItem BindingPath="Email" />
            <ContentItem BindingPath="Property" />
            <ContentItem BindingPath="AccountBank" />
            <ContentItem BindingPath="AccountNo" />
            <ContentItem BindingPath="TaxNo" />
            <ContentItem BindingPath="IsBaseBusinessUnits" />
            <ContentItem BindingPath="RegisteredCapital" />
            <ContentItem BindingPath="RegisterTime" />
            <ContentItem BindingPath="IsClosure" />
            <ContentItem BindingPath="OpeningDate1">
              <ContentItem.Attributes>
                <DisplayName Value="'开业日期'" />
              </ContentItem.Attributes>
            </ContentItem>
            <ContentItem BindingPath="Summary" />
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Popups>
    <ContentItem Control=":ScreenContainer" Name="Popup_Add">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="Sys_PointInfo_Detail" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <DisplayName Value="'增加'" />
        <ScreenContainerParameter ParameterName="IsReadOnly" ParameterType=":Boolean" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="PointCode" ParameterType=":String" Value="Screen.T_PointInfoCollection.SelectedItem.PointCode" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
    <ContentItem Control=":ScreenContainer" Name="Popup_Modify">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="Sys_PointInfo_Detail" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <DisplayName Value="'修改'" />
        <ScreenContainerParameter ParameterName="IsReadOnly" ParameterType=":Boolean" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="PointCode" ParameterType=":String" Value="Screen.T_PointInfoCollection.SelectedItem.PointCode" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
    <ContentItem Control=":ScreenContainer" Name="Popup_Detail">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="Sys_PointInfo_Detail" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <DisplayName Value="'详细'" />
        <ScreenContainerParameter ParameterName="IsReadOnly" ParameterType=":Boolean" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="PointCode" ParameterType=":String" Value="Screen.T_PointInfoCollection.SelectedItem.PointCode" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
  </Screen.Popups>
  <Screen.Attributes>
    <DisplayName Value="网点信息管理" />
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>