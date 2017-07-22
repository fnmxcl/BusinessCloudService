<Screen AllowMultipleInstances="False" ScreenKind="Details" Name="Sys_PointInfo_Detail">
  <Screen.Properties>
    <ScreenQueryProperty PropertyType="ApplicationData.T_PointInfo" Name="T_PointInfo">
      <ScreenQueryProperty.Query>
        <ScreenQuery ResultType="Single" EntityType="ApplicationData.T_PointInfo" Filter="PointCode==Screen.PointCode" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
    <ScreenLocalProperty PropertyType=":Boolean" Name="IsReadOnly">
      <ScreenLocalProperty.Attributes>
        <IsParameter />
        <Required />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
    <ScreenLocalProperty PropertyType=":String" Name="PointCode">
      <ScreenLocalProperty.Attributes>
        <IsParameter />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
    <ScreenLocalProperty PropertyType=":String" Name="SerialNumber">
      <ScreenLocalProperty.Attributes>
        <DisplayName Value="序列号" />
      </ScreenLocalProperty.Attributes>
    </ScreenLocalProperty>
    <ScreenLocalProperty PropertyType=":Image" Name="PointICO" />
    <ScreenQueryProperty PropertyType="ApplicationData.T_PointInfo$CollectionView" Name="T_PointInfoCollection">
      <ScreenQueryProperty.Query>
        <ScreenQuery EntityType="ApplicationData.T_PointInfo" Filter="PointCode==Contexts!CurrentPoint.PointCode" />
      </ScreenQueryProperty.Query>
    </ScreenQueryProperty>
  </Screen.Properties>
  <Screen.Methods>
    <ScreenMethod Name="Save">
      <ScreenMethod.Actions>
        <Action ActionType=":SaveChanges" />
      </ScreenMethod.Actions>
      <ScreenMethod.Attributes>
        <DisplayName Value="保存" />
      </ScreenMethod.Attributes>
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
      </ContentItem.CommandItems>
      <ContentItem.Properties>
        <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Top'" />
        <ContentItemProperty ControlProperty=":BaseControl.Width" Value="820" />
        <ContentItemProperty ControlProperty=":BaseControl.Height" Value="670" />
      </ContentItem.Properties>
      <ContentItem Control=":RowsLayout">
        <ContentItem.Properties>
          <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="IsReadOnly" />
          <ContentItemProperty ControlProperty=":BaseControl.AttachedLabelPosition" Value="'RightAligned'" />
          <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Top'" />
        </ContentItem.Properties>
        <ContentItem Control=":TableLayout" BindingPath="T_PointInfo">
          <ContentItem.Properties>
            <ContentItemProperty ControlProperty=":BaseControl.VerticalAlignment" Value="'Top'" />
          </ContentItem.Properties>
          <ContentItem Control=":TableColumn">
            <ContentItem BindingPath="PointCode">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.IsRequired" Value="True" />
                <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="PointName">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.IsRequired" Value="True" />
                <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="PointFullName">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.IsRequired" Value="True" />
                <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem Control=":AutoCompleteBox" BindingPath="Parent" ChoicesSource="Screen.T_PointInfoCollection">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                <ContentItemProperty ControlProperty=":BaseControl.Width" Value="290" />
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
                <ContentItemProperty ControlProperty=":BaseControl.MinHeight" Value="20" />
              </ContentItem.Properties>
              <ContentItem.Attributes>
                <DisplayName Value="'所属网点'" />
              </ContentItem.Attributes>
              <ContentItem />
            </ContentItem>
            <ContentItem BindingPath="Tel">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="Address">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="Fax">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="Summary">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="Linker">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="LinkerMobile">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="Email">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="AccountBank">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":TableColumn.ColumnSpan" Value="2" />
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="AccountNo">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="Owner">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="IsBaseBusinessUnits">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem Control=":DatePicker" BindingPath="RegisterTime">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.Width" Value="290" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="ClientId">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":TableColumn.ColumnSpan" Value="2" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="Screen.SerialNumber">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.IsReadOnly" Value="Screen.IsReadOnly" />
                <ContentItemProperty ControlProperty=":TableColumn.ColumnSpan" Value="2" />
                <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="RegisterInfo">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":TableColumn.ColumnSpan" Value="2" />
                <ContentItemProperty ControlProperty=":TableColumn.RowSpan" Value="4" />
                <ContentItemProperty ControlProperty=":TextBox.TextWrapping" Value="'Wrap'" />
                <ContentItemProperty ControlProperty=":BaseControl.Height" Value="87.24" />
                <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                <ContentItemProperty ControlProperty=":TextBox.AcceptsReturn" Value="True" />
                <ContentItemProperty ControlProperty=":BaseControl.MinHeight" Value="80" />
                <ContentItemProperty ControlProperty=":BaseControl.MaxWidth" Value="400" />
                <ContentItemProperty ControlProperty=":BaseControl.MaxHeight" Value="80" />
                <ContentItemProperty ControlProperty=":BaseControl.Width" Value="395.506226540645" />
              </ContentItem.Properties>
            </ContentItem>
          </ContentItem>
          <ContentItem Control=":TableColumn">
            <ContentItem BindingPath="ICON">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":TableColumn.RowSpan" Value="4" />
                <ContentItemProperty ControlProperty=":BaseControl.Width" Value="180" />
                <ContentItemProperty ControlProperty=":BaseControl.Height" Value="100" />
                <ContentItemProperty ControlProperty=":ImageBaseControl.Stretch" Value="'Fill'" />
                <ContentItemProperty ControlProperty=":BaseControl.WidthSizingMode" Value="'Auto'" />
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="150" />
                <ContentItemProperty ControlProperty=":BaseControl.HeightSizingMode" Value="'Auto'" />
                <ContentItemProperty ControlProperty=":BaseControl.MinHeight" Value="100" />
                <ContentItemProperty ControlProperty=":BaseControl.MaxWidth" Value="200" />
                <ContentItemProperty ControlProperty=":BaseControl.MaxHeight" Value="120" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="Mobile">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="ZipCode">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="AccountingType">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="TabOrder">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.Background" Value="'#FFFFE4E1'" />
                <ContentItemProperty ControlProperty=":BaseControl.Width" Value="290" />
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="LinkerTel">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="Web">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="Property">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem Control=":PlaceHolder" />
            <ContentItem BindingPath="TaxNo">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem BindingPath="RegisteredCapital">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.MinWidth" Value="50" />
              </ContentItem.Properties>
            </ContentItem>
            <ContentItem Control=":DatePicker" BindingPath="OpeningDate1">
              <ContentItem.Properties>
                <ContentItemProperty ControlProperty=":BaseControl.Width" Value="290" />
              </ContentItem.Properties>
              <ContentItem.Attributes>
                <DisplayName Value="'开业日期'" />
              </ContentItem.Attributes>
            </ContentItem>
            <ContentItem Control=":AutoCompleteBox" BindingPath="PointTypeR">
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
        <ActionParameter Parameter=":ChangePropertyValue.Property" Value="T_PointInfo" />
        <ActionParameter Parameter=":ChangePropertyValue.Value" Value="T_PointInfo==null?new T_PointInfo():T_PointInfo" />
      </Action.Parameters>
    </Action>
  </Screen.Initialized>
  <Screen.Attributes>
    <TargetComponent Component="System" NotifyActionRules="True" />
  </Screen.Attributes>
</Screen>