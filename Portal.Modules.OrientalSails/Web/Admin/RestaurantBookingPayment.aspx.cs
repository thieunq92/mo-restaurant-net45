using CMS.Core.Domain;
using Portal.Modules.OrientalSails.BusinessLogic;
using Portal.Modules.OrientalSails.BusinessLogic.Share;
using Portal.Modules.OrientalSails.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Modules.OrientalSails.Web.Admin
{
    public partial class RestaurantBookingPayment : System.Web.UI.Page
    {
        public RestaurantBookingPaymentBLL restaurantBookingPaymentBLL;
        public RestaurantBookingPaymentBLL RestaurantBookingPaymentBLL
        {
            get
            {
                if (restaurantBookingPaymentBLL == null)
                {
                    restaurantBookingPaymentBLL = new RestaurantBookingPaymentBLL();
                }
                return restaurantBookingPaymentBLL;
            }
        }
        public RestaurantBooking RestaurantBooking
        {
            get
            {
                var restaurantBookingId = -1;
                try
                {
                    restaurantBookingId = Int32.Parse(Request.QueryString["bi"]);
                }
                catch { }
                var restaurantBooking = RestaurantBookingPaymentBLL.RestaurantBookingGetById(restaurantBookingId);
                if (restaurantBooking.Id == -1)
                {
                    Response.Redirect("404.aspx");
                }
                return restaurantBooking;
            }
        }
        public UserBLL userBLL;
        public UserBLL UserBLL
        {
            get
            {
                if (userBLL == null)
                    userBLL = new UserBLL();
                return userBLL;
            }
        }

        public User CurrentUser
        {
            get
            {
                return UserBLL.UserGetCurrent();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                chkPaid.Checked = RestaurantBooking.MarkIsPaid;
                rptPaymentHistory.DataSource = RestaurantBookingPaymentBLL.PaymentHistoryGetByBookingId(RestaurantBooking.Id);
                rptPaymentHistory.DataBind();
            }
        }
        protected void Page_Unload(object sender, EventArgs e)
        {
            if (restaurantBookingPaymentBLL != null)
            {
                restaurantBookingPaymentBLL.Dispose();
                restaurantBookingPaymentBLL = null;
            }
            if (userBLL != null)
            {
                userBLL.Dispose();
                userBLL = null;
            }
        }

        protected void btnPayment_Click(object sender, EventArgs e)
        {
            var paid = 0.0;
            try
            {
                paid = Double.Parse(txtPaid.Text);
            }
            catch { }
            var paymentHistoryAmount = RestaurantBooking.Receivable;
            RestaurantBooking.TotalPaid += paid;
            if (chkPaid.Checked)
            {
                RestaurantBooking.TotalPaid += RestaurantBooking.TotalPrice - RestaurantBooking.TotalPaid;
                RestaurantBooking.Receivable = 0.0;
            }
            else
            {
                RestaurantBooking.Receivable = RestaurantBooking.TotalPrice - RestaurantBooking.TotalPaid;
            }
            RestaurantBooking.MarkIsPaid = chkPaid.Checked;
            RestaurantBookingPaymentBLL.RestaurantBookingSaveOrUpdate(RestaurantBooking);
            var paymentHistory = new PaymentHistory()
            {
                Time = DateTime.Now,
                Createdby = CurrentUser,
                Payby = RestaurantBooking.Agency,
                RestaurantBooking = RestaurantBooking,
            };
            if (chkPaid.Checked)
            {
                paymentHistory.Amount = paymentHistoryAmount;
            }
            else
            {
                paymentHistory.Amount = paid;
            }
            RestaurantBookingPaymentBLL.PaymentHistorySaveOrUpdate(paymentHistory);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ReloadReceiablesPage", "parent.location.href=parent.location.href", true);
        }
    }
}