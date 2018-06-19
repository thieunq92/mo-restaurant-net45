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
            if (!Page.IsPostBack) {
                txtName.Text = Menu.Name;
                txtDetais.Text = Menu.Details;
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

        }
    }
}