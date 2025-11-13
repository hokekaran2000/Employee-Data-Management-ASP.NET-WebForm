using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.EnterpriseServices.CompensatingResourceManager;

namespace NormSoftware
{
    public partial class NormCRUD : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["conStr"].ConnectionString;
            con = new SqlConnection(connStr);
            if(!IsPostBack)
            {
                rvDOB.Type = ValidationDataType.Date;
                rvDOB.MinimumValue = DateTime.Now.AddYears(-35).ToString("yyyy-MM-dd");
                rvDOB.MaximumValue = DateTime.Now.AddYears(-18).ToString("yyyy-MM-dd");

                cmd = new SqlCommand("Select_Departments", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                ddlDepartment.DataSource = dr;
                ddlDepartment.DataTextField = "DeptName";
                ddlDepartment.DataValueField = "DeptId";
                ddlDepartment.DataBind();
                ddlDepartment.Items.Insert(0, new ListItem("-Select Department-", "0"));
                con.Close();
                LoadData();
            }
        }

        private void LoadData()
        {
            cmd = new SqlCommand("select Name,Gender,DOB,Mobile,Email,City,State,PostalCode,DeptNo from employees",con);
            if(con.State != ConnectionState.Open)
            {
                con.Open();
            }
            SqlDataReader dr = cmd.ExecuteReader();
            gv.DataSource = dr;
            gv.DataBind();
            con.Close();
        }

        private void Clear()
        {
            txtName.Text = txtDOB.Text = txtEmail.Text = txtMobile.Text = txtCity.Text = txtCode.Text = "";
            rblGender.ClearSelection();
            ddlDepartment.SelectedIndex = 0;
            ddlState.SelectedItem.Text = "-Select State-";
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Clear();
            pnlForm.Visible = true;
            hfEmpId.Value = "";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (hfEmpId.Value == "")
            {
                cmd = new SqlCommand("Insert_Employees", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
            }
            else
            {
                cmd = new SqlCommand("Update_Employees", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@empId", hfEmpId.Value);
            }
            cmd.Parameters.AddWithValue("@name",txtName.Text);
            string gen = rblGender.SelectedValue;
            cmd.Parameters.AddWithValue("@gender", gen);
            cmd.Parameters.AddWithValue("@dob", txtDOB.Text);
            cmd.Parameters.AddWithValue("@mobile", txtMobile.Text);
            cmd.Parameters.AddWithValue("@email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@city", txtCity.Text);
            cmd.Parameters.AddWithValue("@state", ddlState.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@postalCode", txtCode.Text);
            cmd.Parameters.AddWithValue("@deptNo", ddlDepartment.SelectedItem.Value);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Clear();
            hfEmpId.Value = "";
            pnlForm.Visible = false;
            LoadData();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Clear();
            pnlForm.Visible = false;
        }

        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = gv.Rows[rowIndex];

                if (e.CommandName == "EditRow")
                {
                    string name = row.Cells[0].Text;
                    string gender = row.Cells[1].Text;
                    string dob = row.Cells[2].Text;
                    string mobile = row.Cells[3].Text;
                    string email = row.Cells[4].Text;
                    string address = row.Cells[5].Text;
                    string city = gv.DataKeys[rowIndex].Values["city"].ToString();
                    string state = gv.DataKeys[rowIndex].Values["state"].ToString();
                    string code = gv.DataKeys[rowIndex].Values["postalCode"].ToString();
                    string deptno = row.Cells[6].Text;
                    pnlForm.Visible = true;
                    txtName.Text = name;
                    rblGender.SelectedValue = gender;
                    txtDOB.Text = dob;
                    txtMobile.Text = mobile;
                    txtEmail.Text = email;
                    txtCity.Text = city;
                    ddlState.SelectedItem.Text = state;
                    ddlDepartment.SelectedValue = deptno;
                    txtCode.Text = code;
                    cmd = new SqlCommand("GetEmployee", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@mobile", mobile);
                    cmd.Parameters.AddWithValue("@email", email);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    con.Close();
                    hfEmpId.Value = result.ToString();
                }
                else if (e.CommandName == "DeleteRow")
                {
                    string mobile = gv.Rows[rowIndex].Cells[3].Text;
                    string email = gv.Rows[rowIndex].Cells[4].Text;
                    cmd = new SqlCommand("GetEmployee", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@mobile", mobile);
                    cmd.Parameters.AddWithValue("@email", email);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    con.Close();
                    hfEmpId.Value = result.ToString();
                    if (result != null)
                    {
                        cmd = new SqlCommand("Delete_Employees", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@empId", hfEmpId.Value);
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                    hfEmpId.Value = "";
                    LoadData();
                }
            }
            catch(Exception ex)
            {
                Response.Write(ex.ToString());
            }
            finally
            {
                con.Close();
            }
        }
    }
}




