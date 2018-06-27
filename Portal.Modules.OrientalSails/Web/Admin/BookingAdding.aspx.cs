using Portal.Modules.OrientalSails.BusinessLogic;
using Portal.Modules.OrientalSails.Domain;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Modules.OrientalSails.Web.Admin
{
    public partial class BookingAdding : System.Web.UI.Page
    {
        public BookingAddingBLL bookingAddingBLL;
        public BookingAddingBLL BookingAddingBLL
        {
            get
            {
                if (bookingAddingBLL == null)
                    bookingAddingBLL = new BookingAddingBLL();
                return bookingAddingBLL;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Page_Unload(object sender, EventArgs e)
        {
            if (bookingAddingBLL != null)
            {
                bookingAddingBLL.Dispose();
                bookingAddingBLL = null;
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            DateTime? date = null;
            try
            {
                date = DateTime.ParseExact(txtDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            }
            catch { }
            var agencyId = -1;
            try
            {
                agencyId = Int32.Parse(agencySelector.Value);
            }
            catch { }
            var agency = BookingAddingBLL.AgencyGetById(agencyId);
            var restaurantBooking = new RestaurantBooking()
            {
                Date = date,
                Agency = agency,
                Status = 1,
                PartOfDay = 1,
            };
            BookingAddingBLL.RestaurantBookingSaveOrUpdate(restaurantBooking);
            Response.Redirect("BookingViewing.aspx?NodeId=1&SectionId=15&bi="+restaurantBooking.Id);
        }
    }
}