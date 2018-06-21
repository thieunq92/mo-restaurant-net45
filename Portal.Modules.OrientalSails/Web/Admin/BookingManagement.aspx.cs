using Portal.Modules.OrientalSails.BusinessLogic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Modules.OrientalSails.Web.Admin
{
    public partial class BookingManagement : System.Web.UI.Page
    {
        public BookingManagementBLL bookingManagementBLL;
        public BookingManagementBLL BookingManagementBLL
        {
            get
            {
                if (bookingManagementBLL == null)
                    bookingManagementBLL = new BookingManagementBLL();
                return bookingManagementBLL;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            rptBooking.DataSource = BookingManagementBLL.RestaurantBookingGetAll();
            rptBooking.DataBind();
        }
        protected void Page_Unload(object sender, EventArgs e)
        {
            if (bookingManagementBLL != null)
            {
                bookingManagementBLL.Dispose();
                bookingManagementBLL = null;
            }
        }
    }
}