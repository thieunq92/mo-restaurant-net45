using Portal.Modules.OrientalSails.BusinessLogic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Domain = Portal.Modules.OrientalSails.Domain;

namespace Portal.Modules.OrientalSails.Web.Admin
{
    public partial class MenuAdding : System.Web.UI.Page
    {
        public MenuAddingBLL menuAddingBLL;
        public MenuAddingBLL MenuAddingBLL
        {
            get
            {
                if (menuAddingBLL == null)
                    menuAddingBLL = new MenuAddingBLL();
                return menuAddingBLL;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            if (menuAddingBLL != null)
            {
                menuAddingBLL.Dispose();
                menuAddingBLL = null;
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            var cost = 0.0;
            try
            {
                cost = Double.Parse(txtCost.Text);
            }
            catch { }
            MenuAddingBLL.MenuSaveOrUpdate(new Domain.Menu()
            {
                Name = txtName.Text,
                Cost = cost,
                Details = txtDetais.Text,
            });
        }
    }
}