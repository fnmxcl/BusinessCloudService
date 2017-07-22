<Screen AllowMultipleInstances="False" ScreenKind="Details" Name="Sys_EmployeeInfo_Detail">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_EmployeeInfo" Name="T_EmployeeInfo">
      <ScreenQueryProperty.Query>
        <ScreenQuery ResultType="Single" EntityType="ApplicationData.T_EmployeeInfo" Filter="EmployeeID==Screen.EmployeeID" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenLocalProperty PropertyType=":Boolean" Name="IsReadOnly">
      <ScreenLocalProperty.Attributes>
        <IsParameter />
        <Required />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
    <ScreenLocalProperty PropertyType=":Int32" Name="EmployeeID">
      <ScreenLocalProperty.Attributes>
        <IsParameter />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
    <ScreenQueryProperty PropertyType="ApplicationData.T_PointInfo$CollectionView" Name="T_PointInfoCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_PointInfo" Filter="Parent.IsChildOrEqual(Contexts!CurrentPoint) or PointCode==Contexts!CurrentPoint.PointCode" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.Methods>
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
            <ContentItemProperty ControlProperty=":BaseControl.IsVisible" Value="IsReadOnly==false" />
          </ContentItem.Properties>
          <ContentItem.Attributes>
            <DisplayName Value="'保存'" />
          </ContentItem.Attributes>
        </ContentItem>
      </ContentItem.CommandItems>
      <ContentItem Control=":RowsLayout">
        <ContentItem.Properties>
          <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="IsReadOnly" />
        </ContentItem.Properties>
        <ContentItem Control=":TabsLayout">
          <ContentItem Control=":RowsLayout">
            <ContentItem.Attributes>
              <DisplayName Value="'基本信息'" />
            </ContentItem.Attributes>
            <ContentItem Control=":TableLayout" BindingPath="T_EmployeeInfo">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Top'" />
                <ContentItemProperty ControlProperty=":BaseControl.AttachedLabelPosition" Value="'RightAligned'" />
              </ContentItem.Properties>
              <ContentItem Control=":TableColumn">
                <ContentItem BindingPath="PointInfo" ChoicesSource="Screen.T_PointInfoCollection">
                  <ContentItem.Properties>
                    <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                  </ContentItem.Properties>
                  <ContentItem.Attributes>
                    <DisplayName Value="'所属网点'" />
                  </ContentItem.Attributes>
                  <ContentItem />
                </ContentItem>
                <ContentItem BindingPath="EmployeeCHName">
                  <ContentItem.Properties>
                    <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                    <ContentItemProperty ControlProperty=":BaseControl.Foreground" Value="'#FF000000'" />
                  </ContentItem.Properties>
                </ContentItem>
                <ContentItem Control=":AutoCompleteBox" BindingPath="PositionInfo">
                  <ContentItem.Properties>
                    <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                    <ContentItemProperty ControlProperty=":BaseControl.Foreground" Value="'#FF000000'" />
                    <ContentItemProperty ControlProperty=":BaseControl.Width" Value="280" />
                  </ContentItem.Properties>
                  <ContentItem.Attributes>
                    <DisplayName Value="'职位'" />
                  </ContentItem.Attributes>
                  <ContentItem />
                </ContentItem>
                <ContentItem Control=":DatePicker" BindingPath="EmployeeRegisterDate">
                  <ContentItem.Properties>
                    <ContentItemProperty ControlProperty=":BaseControl.Width" Value="280" />
                  </ContentItem.Properties>
                  <ContentItem.Attributes>
                    <DisplayName Value="'入职日期'" />
                  </ContentItem.Attributes>
                </ContentItem>
                <ContentItem BindingPath="EmployeeIDCardNo">
                  <ContentItem.Attributes>
                    <DisplayName Value="'身份证号'" />
                  </ContentItem.Attributes>
                </ContentItem>
                <ContentItem BindingPath="EmployeeMobile" />
                <ContentItem BindingPath="EmployeeHomeAddress">
                  <ContentItem.Properties>
                    <ContentItemProperty ControlProperty=":TableColumn.ColumnSpan" Value="2" />
                  </ContentItem.Properties>
                  <ContentItem.Attributes>
                    <DisplayName Value="'家庭住址'" />
                  </ContentItem.Attributes>
                </ContentItem>
                <ContentItem BindingPath="EmployeeDescription">
                  <ContentItem.Properties>
                    <ContentItemProperty ControlProperty=":TableColumn.ColumnSpan" Value="2" />
                  </ContentItem.Properties>
                  <ContentItem.Attributes>
                    <DisplayName Value="'备注'" />
                  </ContentItem.Attributes>
                </ContentItem>
              </ContentItem>
              <ContentItem Control=":TableColumn">
                <ContentItem BindingPath="EmployeeCode">
                  <ContentItem.Properties>
                    <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                    <ContentItemProperty ControlProperty=":BaseControl.Foreground" Value="'#FF000000'" />
                  </ContentItem.Properties>
                </ContentItem>
                <ContentItem Control=":AutoCompleteBox" BindingPath="DepartmentInfo">
                  <ContentItem.Properties>
                    <ContentItemProperty ControlProperty=":BaseControl.Width" Value="280" />
                    <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                    <ContentItemProperty ControlProperty=":BaseControl.Foreground" Value="'#FF000000'" />
                  </ContentItem.Properties>
                  <ContentItem.Attributes>
                    <DisplayName Value="'部门'" />
                  </ContentItem.Attributes>
                  <ContentItem />
                </ContentItem>
                <ContentItem BindingPath="Status">
                  <ContentItem.Properties>
                    <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                    <ContentItemProperty ControlProperty=":BaseControl.Foreground" Value="'#FF000000'" />
                    <ContentItemProperty ControlProperty=":BaseControl.Width" Value="280" />
                  </ContentItem.Properties>
                </ContentItem>
                <ContentItem Control=":DatePicker" BindingPath="EmployeeBirthday">
                  <ContentItem.Properties>
                    <ContentItemProperty ControlProperty=":BaseControl.Width" Value="280" />
                  </ContentItem.Properties>
                  <ContentItem.Attributes>
                    <DisplayName Value="'出生日期'" />
                  </ContentItem.Attributes>
                </ContentItem>
                <ContentItem BindingPath="EmployeeMobile2">
                  <ContentItem.Attributes>
                    <DisplayName Value="'紧急联系电话'" />
                  </ContentItem.Attributes>
                </ContentItem>
                <ContentItem Control=":PlaceHolder" />
                <ContentItem Control=":PlaceHolder" />
                <ContentItem Control=":PlaceHolder" />
              </ContentItem>
            </ContentItem>
          </ContentItem>
        </ContentItem>
      </ContentItem>
    </ContentItem>
  </Screen.RootContentItem>
  <Screen.Initialized>
    <Action ActionType=":ChangePropertyValue">
      <Action.Parameters>
        <ActionParameter Parameter=":ChangePropertyValue.Property" Value="T_EmployeeInfo" />
        <ActionParameter Parameter=":ChangePropertyValue.Value" Value="T_EmployeeInfo==null?new T_EmployeeInfo():T_EmployeeInfo" />
      </Action.Parameters>
    </Action>
  </Screen.Initialized>
  <Screen.Attributes>
    <DisplayName Value="员工信息" />
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>