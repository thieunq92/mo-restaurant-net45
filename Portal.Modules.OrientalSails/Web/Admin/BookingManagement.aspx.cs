using Portal.Modules.OrientalSails.BusinessLogic;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
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
            if (!IsPostBack)
            {
                var code = Request.QueryString["c"];
                txtCode.Text = code;
                var codeIntType = -1;
                try {
                    codeIntType = Int32.Parse(code.Remove(0, 2).TrimStart('0'));
                }catch{}
                DateTime? date = null;
                try
                {
                    date = DateTime.ParseExact(Request.QueryString["d"], "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
                }
                catch { }
                if(date.HasValue){
                    txtDate.Text = date.Value.ToString("dd/MM/yyyy");
                }
                var agency = Request.QueryString["a"];
                txtAgency.Text = agency;
                var payment = -1;
                try
                {
                    payment = Int32.Parse(Request.QueryString["p"]);
                }
                catch { }
                if (payment > 2)
                {
                    payment = -1;
                }
                ddlPayment.SelectedValue = payment.ToString();
                rptBooking.DataSource = BookingManagementBLL.RestaurantBookingGetAllByCriterion(codeIntType, date, agency, payment);
                rptBooking.DataBind();
            }
        }
        protected void Page_Unload(object sender, EventArgs e)
        {
            if (bookingManagementBLL != null)
            {
                bookingManagementBLL.Dispose();
                bookingManagementBLL = null;
            }
        }

        protected void btnDisplay_Click(object sender, EventArgs e)
        {
            Response.Redirect("BookingManagement.aspx" + QueryStringBuildByCriterion());
        }

        public string QueryStringBuildByCriterion()
        {
            NameValueCollection nvcQueryString = new NameValueCollection();
            nvcQueryString.Add("NodeId", "1");
            nvcQueryString.Add("SectionId", "15");

            if (!string.IsNullOrEmpty(txtCode.Text))
            {
                nvcQueryString.Add("c", txtCode.Text);
            }

            if (!string.IsNullOrEmpty(txtDate.Text))
            {
                nvcQueryString.Add("d", txtDate.Text);
            }

            if (!string.IsNullOrEmpty(txtAgency.Text))
            {
                nvcQueryString.Add("a", txtAgency.Text);
            }

            if (ddlPayment.SelectedValue != "-1")
            {
                nvcQueryString.Add("p", ddlPayment.SelectedValue);
            }
            var criterions = (from key in nvcQueryString.AllKeys
                              from value in nvcQueryString.GetValues(key)
                              select string.Format("{0}={1}", HttpUtility.UrlEncode(key), HttpUtility.UrlEncode(value))).ToArray();

            return "?" + string.Join("&", criterions);
        }
    }
}