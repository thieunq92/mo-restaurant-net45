using Portal.Modules.OrientalSails.BusinessLogic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Modules.OrientalSails.Web.Admin
{
    public partial class MenuManagement : System.Web.UI.Page
    {
        public MenuManagementBLL menuManagementBLL;
        public MenuManagementBLL MenuManagementBLL
        {
            get
            {
                if (menuManagementBLL == null)
                    menuManagementBLL = new MenuManagementBLL();
                return menuManagementBLL;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            rptMenuTable.DataSource = MenuManagementBLL.MenuGetAll();
            rptMenuTable.DataBind();
        }
        protected void Page_UnLoad(object sender, EventArgs e)
        {
            if (menuManagementBLL != null)
            {
                menuManagementBLL.Dispose();
                menuManagementBLL = null;
            }
        }
    }
}