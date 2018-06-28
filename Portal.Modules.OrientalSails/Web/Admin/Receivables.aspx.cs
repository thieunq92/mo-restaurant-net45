using Portal.Modules.OrientalSails.BusinessLogic;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Modules.OrientalSails.Web.Admin
{
    public partial class Receivables : System.Web.UI.Page
    {
        public ReceivablesBLL receivablesBLL;
        public ReceivablesBLL ReceivablesBLL
        {
            get
            {
                if (receivablesBLL == null)
                {
                    receivablesBLL = new ReceivablesBLL();
                }
                return receivablesBLL;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var firstDayOfMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                var lastDayOfMonth = firstDayOfMonth.AddMonths(1).AddDays(-1);
                var from = firstDayOfMonth;
                try
                {
                    from = DateTime.ParseExact(Request.QueryString["f"], "dd/MM/yyyy", CultureInfo.InvariantCulture);
                }
                catch { }
                var to = lastDayOfMonth;
                try
                {
                    to = DateTime.ParseExact(Request.QueryString["t"], "dd/MM/yyyy", CultureInfo.InvariantCulture);
                }
                catch { }
                txtFrom.Text = from.ToString("dd/MM/yyyy");
                txtTo.Text = to.ToString("dd/MM/yyyy");
                var agencyId = -1;
                try
                {
                    agencyId = Int32.Parse(Request.QueryString["ai"]);
                }
                catch { }
                rptReceivablesTable.DataSource = ReceivablesBLL.RestaurantBookingGetAllByDateRange(from, lastDayOfMonth, agencyId);
                rptReceivablesTable.DataBind();
            }
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            if (receivablesBLL != null)
            {
                receivablesBLL.Dispose();
                receivablesBLL = null;
            }
        }

        protected void btnDisplay_Click(object sender, EventArgs e)
        {
            Response.Redirect("Receivables.aspx" + QueryStringBuildByCriterion());
        }

        public string QueryStringBuildByCriterion()
        {
            NameValueCollection nvcQueryString = new NameValueCollection();
            nvcQueryString.Add("NodeId", "1");
            nvcQueryString.Add("SectionId", "15");

            if (!string.IsNullOrEmpty(txtFrom.Text))
            {
                nvcQueryString.Add("f", txtFrom.Text);
            }

            if (!string.IsNullOrEmpty(txtTo.Text))
            {
                nvcQueryString.Add("t", txtTo.Text);
            }

            var criterions = (from key in nvcQueryString.AllKeys
                              from value in nvcQueryString.GetValues(key)
                              select string.Format("{0}={1}", HttpUtility.UrlEncode(key), HttpUtility.UrlEncode(value))).ToArray();

            return "?" + string.Join("&", criterions);
        }
    }
}