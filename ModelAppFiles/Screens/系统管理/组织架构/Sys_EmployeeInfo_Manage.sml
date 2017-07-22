<Screen AllowMultipleInstances="False" ScreenKind="Custom" Name="Sys_EmployeeInfo_Manage">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_EmployeeInfo$CollectionView" Name="T_EmployeeInfoCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_EmployeeInfo" Filter="PointInfo==Contexts!CurrentPoint" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenLocalProperty PropertyType=":String" Name="m_para">
      <ScreenLocalProperty.Attributes>
        <IsParameter />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
    <ScreenLocalProperty PropertyType=":Boolean" Name="check">
      <ScreenLocalProperty.Attributes>
        <DefaultValue Value="True" />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
  </Screen.Properties>
  <Screen.Methods>
    <ScreenMethod Name="AddNew">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="AddNewPopup" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="T_EmployeeInfoCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="新增" />
      </ScreenMethod.Attributes>
    </ScreenMethod>
    <ScreenMethod CanExecute="T_EmployeeInfoCollection.SelectedItem!=null" Name="Modify">
      <ScreenMethod.Actions>
        <Action ActionType=":OpenPopup">
          <Action.Parameters>
            <ActionParameter Parameter=":OpenPopup.Popup" Value="EditPopup" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="T_EmployeeInfoCollection" />
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
            <ActionParameter Parameter=":ConfirmBox.Title" Value="'提示'" />
            <ActionParameter Parameter=":ConfirmBox.Message" Value="'是否删除当前员工信息'" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":SaveChanges" />
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="T_EmployeeInfoCollection" />
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
            <ActionParameter Parameter=":ExportData.DataSource" Value="T_EmployeeInfoCollection" />
            <ActionParameter Parameter=":ExportData.AllowUserCustomization" Value="" />
            <ActionParameter Parameter=":ExportData.DefaultSettings" Value="[{&quot;DisplayName&quot;: &quot;网点号&quot;, &quot;Value&quot;: &quot;PointCode&quot;}, {&quot;DisplayName&quot;: &quot;工号&quot;, &quot;Value&quot;: &quot;EmployeeCode&quot;}, {&quot;DisplayName&quot;: &quot;姓名&quot;, &quot;Value&quot;: &quot;EmployeeCHName&quot;}, {&quot;DisplayName&quot;: &quot;是否驾驶员&quot;, &quot;Value&quot;: &quot;EmployeeInfoEx.IfDriver&quot;}, {&quot;DisplayName&quot;: &quot;部门&quot;, &quot;Value&quot;: &quot;DepartmentInfo.DepartmentName&quot;}, {&quot;DisplayName&quot;: &quot;单位&quot;, &quot;Value&quot;: &quot;EmployeeInfoEx.CompanyAffiliation.CompanyName&quot;}, {&quot;DisplayName&quot;: &quot;职务&quot;, &quot;Value&quot;: &quot;PositionInfo.Position&quot;}, {&quot;DisplayName&quot;: &quot;入职时间&quot;, &quot;Value&quot;: &quot;EmployeeRegisterDate&quot;}, {&quot;DisplayName&quot;: &quot;状态&quot;, &quot;Value&quot;: &quot;Status&quot;}, {&quot;DisplayName&quot;: &quot;身份证号码&quot;, &quot;Value&quot;: &quot;EmployeeIDCardNo&quot;}, {&quot;DisplayName&quot;: &quot;性别&quot;, &quot;Value&quot;: &quot;EmployeeInfoEx.Gender&quot;}, {&quot;DisplayName&quot;: &quot;出生日期&quot;, &quot;Value&quot;: &quot;EmployeeBirthday&quot;}, {&quot;DisplayName&quot;: &quot;手机号码&quot;, &quot;Value&quot;: &quot;EmployeeMobile&quot;}, {&quot;DisplayName&quot;: &quot;紧急联系电话&quot;, &quot;Value&quot;: &quot;EmployeeMobile2&quot;}, {&quot;DisplayName&quot;: &quot;家庭住址&quot;, &quot;Value&quot;: &quot;EmployeeHomeAddress&quot;}, {&quot;DisplayName&quot;: &quot;准驾车型&quot;, &quot;Value&quot;: &quot;EmployeeInfoEx.DrivingType&quot;}, {&quot;DisplayName&quot;: &quot;首次领证日期&quot;, &quot;Value&quot;: &quot;EmployeeInfoEx.FirstLicenseDate&quot;}, {&quot;DisplayName&quot;: &quot;驾驶证有效日期&quot;, &quot;Value&quot;: &quot;EmployeeInfoEx.DrivingLicenseValidDate&quot;}, {&quot;DisplayName&quot;: &quot;驾驶证号&quot;, &quot;Value&quot;: &quot;EmployeeInfoEx.DriverLicenseNumber&quot;}, {&quot;DisplayName&quot;: &quot;驾驶证档案号&quot;, &quot;Value&quot;: &quot;EmployeeInfoEx.DriverLicenseID&quot;}, {&quot;DisplayName&quot;: &quot;备注&quot;, &quot;Value&quot;: &quot;EmployeeDescription&quot;}]" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
    </ScreenMethod>
    <ScreenMethod Name="Import">
      <ScreenMethod.Actions>
        <Action ActionType=":ImportData">
          <Action.Parameters>
            <ActionParameter Parameter=":ImportData.ColumnDefinitions" Value="[{&quot;Name&quot;: &quot;工号&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: true}, {&quot;Name&quot;: &quot;姓名&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: true}, {&quot;Name&quot;: &quot;部门&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: true}, {&quot;Name&quot;: &quot;职务&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: true}, {&quot;Name&quot;: &quot;手机号码&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: false}, {&quot;Name&quot;: &quot;紧急联系电话&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: false}, {&quot;Name&quot;: &quot;是否驾驶员&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: false}, {&quot;Name&quot;: &quot;性别&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: false}, {&quot;Name&quot;: &quot;入职时间&quot;, &quot;DataType&quot;: &quot;:DateTime&quot;, &quot;Required&quot;: false}, {&quot;Name&quot;: &quot;单位&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: false}, {&quot;Name&quot;: &quot;身份证号码&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: false}, {&quot;Name&quot;: &quot;出生日期&quot;, &quot;DataType&quot;: &quot;:DateTime&quot;, &quot;Required&quot;: false}, {&quot;Name&quot;: &quot;家庭住址&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: false}, {&quot;Name&quot;: &quot;准驾车型&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: false}, {&quot;Name&quot;: &quot;首次领证日期&quot;, &quot;DataType&quot;: &quot;:DateTime&quot;, &quot;Required&quot;: false}, {&quot;Name&quot;: &quot;驾驶证有效日期&quot;, &quot;DataType&quot;: &quot;:DateTime&quot;, &quot;Required&quot;: false}, {&quot;Name&quot;: &quot;驾驶证号&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: false}, {&quot;Name&quot;: &quot;驾驶证档案号&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: false}, {&quot;Name&quot;: &quot;备注&quot;, &quot;DataType&quot;: &quot;:String&quot;, &quot;Required&quot;: false}]" />
            <ActionParameter Parameter=":ImportData.CustomCode" Value="var GetNum=0;&#xD;&#xA;var  GetNumTrue=0;&#xD;&#xA;foreach(var item in Items)&#xD;&#xA;{ &#xD;&#xA;      Screen.check=true;&#xD;&#xA;      &#x9;if(item.工号==null)&#xD;&#xA; &#x9;{&#xD;&#xA; &#x9;&#x9;MessageBox.Show('第'+ (GetNum+1).ToString()+'行工号为空！');&#xD;&#xA;&#x9;}&#xD;&#xA;&#x9;else&#xD;&#xA;&#x9;{&#xD;&#xA;&#x9;&#x9;var employee=ApplicationData.T_EmployeeInfoSet.Where(w=&gt;w.PointCode==Contexts!CurrentPoint.PointCode&amp;&amp;w.EmployeeCode==item.工号).SingleOrDefault();&#xD;&#xA;&#x9;&#x9;//判断工号是否存在&#xD;&#xA; &#x9;&#x9;if(employee!=null)&#xD;&#xA;&#x9; &#x9;{&#xD;&#xA;&#x9; &#x9;&#x9;MessageBox.Show('第'+ (GetNum+1).ToString()+'条姓名：'+item.姓名.ToString()+'的工号已经存在！');&#xD;&#xA;&#x9; &#x9;&#x9;GetNum=GetNum+1;&#xD;&#xA;&#x9;&#x9;}&#xD;&#xA;&#x9;&#x9;else&#xD;&#xA;&#x9;&#x9;{&#xD;&#xA;&#x9; &#x9;&#x9;var Position =ApplicationData.T_PositionInfoSet.Where(w=&gt;w.PointCode==Contexts!CurrentPoint.PointCode&amp;&amp; w.Position==item.职务).FirstOrDefault();&#xD;&#xA;&#x9;&#x9; &#x9;if(Position==null)&#xD;&#xA;&#x9;&#x9; &#x9;{&#xD;&#xA;&#x9;&#x9; &#x9;&#x9;MessageBox.Show('姓名：'+item.姓名.ToString()+'的职务，不存在！');&#xD;&#xA;&#x9; &#x9;&#x9;&#x9;Screen.check=false;&#xD;&#xA;&#x9; &#x9;&#x9;&#x9;break;&#xD;&#xA;&#x9;&#x9;&#x9;}&#xD;&#xA;&#x9;&#x9;&#x9;var Department =ApplicationData.T_DepartmentInfoSet.Where(w=&gt;w.PointCode==Contexts!CurrentPoint.PointCode&amp;&amp; w.DepartmentName==item.部门).FirstOrDefault();&#xD;&#xA;&#x9;&#x9; &#x9;if(Department==null)&#xD;&#xA;&#x9;&#x9; &#x9;{&#xD;&#xA;&#x9;&#x9; &#x9;&#x9;MessageBox.Show('姓名：'+item.姓名.ToString()+'的部门，不存在！');&#xD;&#xA;&#x9; &#x9;&#x9;&#x9;Screen.check=false;&#xD;&#xA;&#x9; &#x9;&#x9;&#x9;break;&#xD;&#xA;&#x9;&#x9;&#x9;}&#xD;&#xA;&#x9;&#x9;&#x9;//插入员工信息&#xD;&#xA;&#x9;&#x9;&#x9;var EmployeeInfo= new T_EmployeeInfo();&#xD;&#xA;&#x9;&#x9;&#x9;var PointInfo=ApplicationData.T_PointInfoSet.Where(w=&gt;w.PointCode==Contexts!CurrentPoint.PointCode).SingleOrDefault();&#xD;&#xA;&#x9;&#x9;&#x9;EmployeeInfo.PointInfo=PointInfo;&#xD;&#xA;&#x9;&#x9;&#x9;EmployeeInfo.DepartmentInfo=Department;&#xD;&#xA;&#x9;&#x9;&#x9;EmployeeInfo.PositionInfo=Position;&#xD;&#xA;&#x9;&#x9;&#x9;EmployeeInfo.EmployeeCode=item.工号;&#xD;&#xA;&#x9;&#x9;&#x9;EmployeeInfo.EmployeeCHName=item.姓名;&#xD;&#xA;&#x9;&#x9;&#x9;EmployeeInfo.EmployeeMobile=item.手机号码;&#xD;&#xA;&#x9;&#x9;&#x9;EmployeeInfo.EmployeeMobile2=item.紧急联系电话;&#xD;&#xA;&#x9;&#x9;&#x9;EmployeeInfo.EmployeeIDCardNo=item.身份证号码;&#xD;&#xA;&#x9;&#x9;&#x9;EmployeeInfo.EmployeeBirthday = item.出生日期;&#xD;&#xA;&#x9;&#x9;&#x9;EmployeeInfo.EmployeeHomeAddress=item.家庭住址;&#xD;&#xA;&#x9;&#x9;&#x9;EmployeeInfo.EmployeeDescription=item.备注;&#xD;&#xA;&#x9;&#x9;&#x9;EmployeeInfo.Status=1;&#xD;&#xA;&#x9;&#x9;&#x9;EmployeeInfo.EmployeeRegisterDate=item.入职时间;&#xD;&#xA;&#x9;&#x9;&#x9;&#xD;&#xA;&#x9;&#x9;   &#x9;GetNumTrue=GetNumTrue+1;&#xD;&#xA;&#x9;&#x9;   &#x9;GetNum=GetNum+1;&#xD;&#xA;&#x9;&#x9;}&#xD;&#xA;&#x9;}&#xD;&#xA;&#x9;SaveChanges();&#xD;&#xA;}&#xD;&#xA;MessageBox.Show('成功导入'+GetNumTrue.ToString()+'条数据 ！');" />
            <ActionParameter Parameter=":ImportData.ImportType" Value="CustomCode" />
            <ActionParameter Parameter=":ImportData.UseCurrentDataWorkspace" Value="False" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":CustomCode">
          <Action.Parameters>
            <ActionParameter Parameter=":CustomCode.Code" Value="if(check==false)&#xD;&#xA;&#x9;return false;" />
          </Action.Parameters>
        </Action>
        <Action ActionType=":RefreshQuery">
          <Action.Parameters>
            <ActionParameter Parameter=":RefreshQuery.Property" Value="T_EmployeeInfoCollection" />
          </Action.Parameters>
        </Action>
      </ScreenMethod.Actions>
    </ScreenMethod>
  </Screen.Methods>
  <Screen.RootContentItem>
    <ContentItem>
      <ContentItem.CommandItems>
        <ContentItem BindingPath="AddNew">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Add.png" />
          </ContentItem.Properties>
        </ContentItem>
        <ContentItem BindingPath="Modify">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Modify.png" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="T_EmployeeInfoCollection.SelectedItem==null" />
          </ContentItem.Properties>
        </ContentItem>
        <ContentItem BindingPath="Delete">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Delete.png" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="T_EmployeeInfoCollection.SelectedItem==null" />
          </ContentItem.Properties>
        </ContentItem>
        <ContentItem BindingPath="Detail">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="detail.png" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="T_EmployeeInfoCollection.SelectedItem==null" />
          </ContentItem.Properties>
        </ContentItem>
        <ContentItem BindingPath="Export">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Export.png" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'数据导出'" />
          </ContentItem.Attributes>
        </ContentItem>
        <ContentItem BindingPath="Import">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.Image" Value="Import.png" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'数据导入'" />
          </ContentItem.Attributes>
        </ContentItem>
      </ContentItem.CommandItems>
      <ContentItem.Attributes>
        <DisplayName Value="'员工信息管理'" />
      </ContentItem.Attributes>
      <ContentItem Control=":RowsLayout">
        <ContentItem BindingPath="T_EmployeeInfoCollection">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":DataGrid.ShowAddNewRow" Value="False" />
            <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="True" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'员工信息管理'" />
          </ContentItem.Attributes>
          <ContentItem>
            <ContentItem.Properties>
              <ContentItemProperty ControlProperty=":BaseControl.BrowseOnly" Value="True" />
            </ContentItem.Properties>
            <ContentItem BindingPath="PointCode" />
            <ContentItem BindingPath="EmployeeCode" />
            <ContentItem BindingPath="EmployeeCHName" />
            <ContentItem BindingPath="DepartmentInfo">
              <ContentItem.Attributes>
                <DisplayName Value="'部门'" />
              </ContentItem.Attributes>
            </ContentItem>
            <ContentItem BindingPath="PositionInfo.Position" />
            <ContentItem BindingPath="EmployeeRegisterDate">
              <ContentItem.Attributes>
                <DisplayName Value="'入职时间'" />
              </ContentItem.Attributes>
            </ContentItem>
            <ContentItem BindingPath="Status" />
            <ContentItem BindingPath="EmployeeIDCardNo" />
            <ContentItem BindingPath="EmployeeMobile" />
            <ContentItem BindingPath="EmployeeMobile2">
              <ContentItem.Attributes>
                <DisplayName Value="'紧急联系电话'" />
              </ContentItem.Attributes>
            </ContentItem>
            <ContentItem BindingPath="EmployeeHomeAddress">
              <ContentItem.Attributes>
                <DisplayName Value="'家庭住址'" />
              </ContentItem.Attributes>
            </ContentItem>
            <ContentItem BindingPath="EmployeeDescription">
              <ContentItem.Attributes>
                <DisplayName Value="'备注'" />
              </ContentItem.Attributes>
            </ContentItem>
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Popups>
    <ContentItem Control=":ScreenContainer" Name="AddNewPopup">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="Sys_EmployeeInfo_Detail" />
        <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.HeightSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Width" Value="687" />
        <ContentItemProperty ControlProperty=":BaseControl.Height" Value="455" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <ScreenContainerParameter ParameterName="IsReadOnly" ParameterType=":Boolean" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="EmployeeID" ParameterType=":Int32" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="m_Para" ParameterType=":String" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
    <ContentItem Control=":ScreenContainer" Name="EditPopup">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="Sys_EmployeeInfo_Detail" />
        <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.HeightSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Width" Value="687" />
        <ContentItemProperty ControlProperty=":BaseControl.Height" Value="455" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <ScreenContainerParameter ParameterName="IsReadOnly" ParameterType=":Boolean" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="EmployeeID" ParameterType=":Int32" Value="Screen.T_EmployeeInfoCollection.SelectedItem.EmployeeID" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="m_Para" ParameterType=":String" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
    <ContentItem Control=":ScreenContainer" Name="Popup_Detail">
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":ScreenContainer.ScreenId" Value="Sys_EmployeeInfo_Detail" />
        <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.HeightSizingMode" Value="'Pixels'" />
        <ContentItemProperty ControlProperty=":BaseControl.Width" Value="687" />
        <ContentItemProperty ControlProperty=":BaseControl.Height" Value="455" />
      </ContentItem.Properties>
      <ContentItem.Attributes>
        <DisplayName Value="'详细'" />
        <ScreenContainerParameter ParameterName="IsReadOnly" ParameterType=":Boolean" Value="True" BindingMode="TwoWay" />
        <ScreenContainerParameter ParameterName="EmployeeID" ParameterType=":Int32" Value="Screen.T_EmployeeInfoCollection.SelectedItem.EmployeeID" BindingMode="TwoWay" />
      </ContentItem.Attributes>
    </ContentItem>
  </Screen.Popups>
  <Screen.Attributes>
    <DisplayName Value="员工信息管理" />
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>