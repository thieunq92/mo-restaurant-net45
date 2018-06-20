using Portal.Modules.OrientalSails.BusinessLogic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Modules.OrientalSails.Web
{
    public partial class MenuEditing : System.Web.UI.Page
    {
        public MenuEditingBLL menuEditingBLL;
        public MenuEditingBLL MenuEditingBLL
        {
            get
            {
                if (menuEditingBLL == null)
                {
                    menuEditingBLL = new MenuEditingBLL();
                }
                return menuEditingBLL;
            }
        }
        public Domain.Menu Menu
        {
            get
            {
                var menuId = -1;
                try
                {
                    menuId = Int32.Parse(Request.QueryString["mi"]);
                }
                catch { }
                var menu = MenuEditingBLL.MenuGetById(menuId);
                if (menu.Id == -1)
                {
                    Response.Redirect("404.aspx");
                }
                return menu;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                txtName.Text = Menu.Name;
                txtDetails.Text = Menu.Details;
                txtCost.Text = Menu.Cost.ToString("0,###.##");
            }
        }
        protected void Page_Unload(object sender, EventArgs e)
        {
            if (menuEditingBLL != null)
            {
                menuEditingBLL.Dispose();
                menuEditingBLL = null;
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            Menu.Name = txtName.Text;
            var cost = 0.0;
            try
            {
                cost = Double.Parse(txtCost.Text);
            }
            catch { }
            Menu.Cost = cost;
            Menu.Details = txtDetails.Text;
            MenuEditingBLL.MenuSaveOrUpdate(Menu);
            ShowSuccess("Cập nhật menu thành công");
        }
        public void ShowWarning(string warning)
        {
            Session["WarningMessage"] = "<strong>Warning!</strong> " + warning + "<br/>" + Session["WarningMessage"];
        }

        public void ShowErrors(string error)
        {
            Session["ErrorMessage"] = "<strong>Error!</strong> " + error + "<br/>" + Session["ErrorMessage"];
        }

        public void ShowSuccess(string success)
        {
            Session["SuccessMessage"] = "<strong>Success!</strong> " + success + "<br/>" + Session["SuccessMessage"];
        }
    }
}