<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NormCRUD.aspx.cs" Inherits="NormSoftware.NormCRUD" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee CRUD</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-light">
    <form id="form1" runat="server" class="container py-4">
        <div class="mb-3 text-end">
            <asp:Button runat="server" ID="btnAdd" Text="➕ Add New Employee" CssClass="btn btn-info" OnClick="btnAdd_Click" />
        </div>

        <asp:Panel ID="pnlForm" runat="server" Visible="false" CssClass="card shadow p-4 mb-4">
            <h4 class="text-center mb-3">Employee Details</h4>

            <div class="row g-3">
                <div class="col-md-6">
                    <label style="font-weight:bold;" style="font-weight:bold;" for="txtName" class="form-label">Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                        Display="Dynamic" ErrorMessage="This field can't be left empty." CssClass="text-danger"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revName" runat="server" ControlToValidate="txtName"
                        Display="Dynamic" ErrorMessage="Please enter alphabets and spaces" CssClass="text-danger"
                        ValidationExpression="^[A-Za-z\s]+$"></asp:RegularExpressionValidator>
                </div>

                <div class="col-md-6">
                    <label style="font-weight:bold;" class="form-label">Gender</label>
                    <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" CssClass="d-flex gap-3">
                        <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                        <asp:ListItem Text="Other" Value="O"></asp:ListItem>
                    </asp:RadioButtonList>

                    <asp:RequiredFieldValidator ID="rfvGender" runat="server" ErrorMessage="Please select a gender"
                        ControlToValidate="rblGender" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <div class="col-md-6">
                    <label style="font-weight:bold;" for="txtDOB" class="form-label">Date of Birth</label>
                    <asp:TextBox ID="txtDOB" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDob" runat="server" ControlToValidate="txtDOB"
                        ErrorMessage="This field can't be left empty." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="rvDOB" runat="server" ControlToValidate="txtDOB"
                        ErrorMessage="Age must be between 18 and 35 years." CssClass="text-danger"
                        Type="Date" Display="Dynamic"></asp:RangeValidator>
                </div>

                <div class="col-md-6">
                    <label style="font-weight:bold;" for="txtMobile" class="form-label">Mobile</label>
                    <asp:TextBox ID="txtMobile" runat="server" TextMode="Phone" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile"
                        ErrorMessage="This field can't be left empty." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtMobile"
                        ErrorMessage="Please enter a 10-digit number starting with 6-9." CssClass="text-danger"
                        ValidationExpression="^[6-9]\d{9}$" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>

                <div class="col-md-6">
                    <label style="font-weight:bold;" for="txtEmail" class="form-label">Email ID</label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                        ErrorMessage="This field can't be left empty." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                        ErrorMessage="Please enter a valid email" CssClass="text-danger"
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>

                <div class="col-md-6">
                    <label style="font-weight:bold;" for="txtCity" class="form-label">City</label>
                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity"
                        ErrorMessage="This field can't be left empty." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revCity" runat="server" ControlToValidate="txtCity"
                        ErrorMessage="Please enter alphabets and spaces" CssClass="text-danger"
                        ValidationExpression="^[A-Za-z\s]+$" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>

                <div class="col-md-6">
                    <label style="font-weight:bold;" for="ddlState" class="form-label">State</label>
                    <asp:DropDownList runat="server" ID="ddlState" CssClass="form-select">
                        <asp:ListItem Text="-Select State-" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Maharashtra"></asp:ListItem>
                        <asp:ListItem Text="Delhi"></asp:ListItem>
                        <asp:ListItem Text="Karnataka"></asp:ListItem>
                        <asp:ListItem Text="Tamil Nadu"></asp:ListItem>
                        <asp:ListItem Text="Telangana"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="ddlState"
                        ErrorMessage="Please select a state" CssClass="text-danger"
                        InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <div class="col-md-6">
                    <label style="font-weight:bold;" for="txtCode" class="form-label">Postal Code</label>
                    <asp:TextBox ID="txtCode" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCode" runat="server" ControlToValidate="txtCode"
                        ErrorMessage="This field can't be left empty." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revCode" runat="server" ControlToValidate="txtCode"
                        ErrorMessage="Please enter only 6 digit number" CssClass="text-danger"
                        ValidationExpression="\d{6}" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>

                <div class="col-md-6">
                    <label style="font-weight:bold;" for="ddlDepartment" class="form-label">Department</label>
                    <asp:DropDownList runat="server" ID="ddlDepartment" CssClass="form-select">
                        <asp:ListItem Text="-Select Department-" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvDept" runat="server" ControlToValidate="ddlDepartment"
                        ErrorMessage="Please select a department" CssClass="text-danger"
                        InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="text-center mt-4">
                <asp:Button runat="server" ID="btnSave" Text="💾 Save" CssClass="btn btn-primary me-2" OnClick="btnSave_Click" CausesValidation="true" />
                <asp:Button runat="server" ID="btnClear" Text="🧹 Clear" CssClass="btn btn-warning me-2" OnClick="btnClear_Click" CausesValidation="false" />
                <asp:Button runat="server" ID="btnCancel" Text="❌ Cancel" CssClass="btn btn-danger" OnClick="btnCancel_Click" CausesValidation="false" />
            </div>
        </asp:Panel>

        <div class="card shadow p-3">
            <h4 class="text-center mb-3">Employee Records</h4>
            <asp:GridView runat="server" ID="gv" AutoGenerateColumns="False" CssClass="table table-bordered table-striped"
                DataKeyNames="city,state,postalCode" OnRowCommand="gv_RowCommand">
                <Columns>
                    <asp:BoundField HeaderText="Name" DataField="Name" />
                    <asp:BoundField HeaderText="Gender" DataField="Gender" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField HeaderText="DOB" DataField="DOB" DataFormatString="{0:yyyy-MM-dd}" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField HeaderText="Mobile" DataField="Mobile" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField HeaderText="Email" DataField="Email" />
                    <asp:TemplateField HeaderText="Address" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <%# Eval("City") + "," + Eval("State") + "," + Eval("PostalCode") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Department" DataField="DeptNo" ItemStyle-HorizontalAlign="Center" />

                    <asp:TemplateField HeaderText="Actions" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" ID="btnEdit" Text="✏ Edit" CommandName="EditRow"
                                CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-sm btn-outline-primary me-2" CausesValidation="false"></asp:LinkButton>
                            <asp:LinkButton runat="server" ID="btnDelete" Text="🗑 Delete" CommandName="DeleteRow"
                                CommandArgument="<%# Container.DataItemIndex %>" CssClass="btn btn-sm btn-outline-danger"
                                OnClientClick="return confirm('Are you sure to delete this record?');" CausesValidation="false"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <asp:HiddenField runat="server" ID="hfEmpId" />
    </form>
</body>
</html>

