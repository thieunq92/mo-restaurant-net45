using Portal.Modules.OrientalSails.BusinessLogic;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Modules.OrientalSails.Web.Admin
{
    public partial class RestaurantBookingByDate : System.Web.UI.Page
    {
        public RestaurantBookingByDateBLL restaurantBookingByDateBLL;
        public RestaurantBookingByDateBLL RestaurantBookingByDateBLL
        {
            get
            {
                if (restaurantBookingByDateBLL == null)
                    restaurantBookingByDateBLL = new RestaurantBookingByDateBLL();
                return restaurantBookingByDateBLL;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                txtDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                rptBooking.DataSource = RestaurantBookingByDateBLL.RestaurantBookingGetAllByDate(DateTime.ParseExact(txtDate.Text,"dd/MM/yyyy",CultureInfo.InvariantCulture));
                rptBooking.DataBind();
            }
        }
        protected void Page_Unload(object sender, EventArgs e)
        {
            if (restaurantBookingByDateBLL != null)
            {
                restaurantBookingByDateBLL.Dispose();
                restaurantBookingByDateBLL = null;
            }
        }
        protected void btnDisplay_Click(object sender, EventArgs e)
        {
            rptBooking.DataSource = RestaurantBookingByDateBLL.RestaurantBookingGetAllByDate(DateTime.ParseExact(txtDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture));
            rptBooking.DataBind();
        }
    }
}