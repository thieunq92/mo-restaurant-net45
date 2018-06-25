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
                var date = DateTime.Now.Date;
                try
                {
                    date = DateTime.ParseExact(Request.QueryString["d"], "dd/MM/yyyy", CultureInfo.InvariantCulture);
                }
                catch { }
                txtDate.Text = date.ToString("dd/MM/yyyy");
                rptBooking.DataSource = RestaurantBookingByDateBLL.RestaurantBookingGetAllByDate(date);
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
            Response.Redirect("RestaurantBookingByDate.aspx" + QueryStringBuildByCriterion());
        }
        public string QueryStringBuildByCriterion()
        {
            NameValueCollection nvcQueryString = new NameValueCollection();
            nvcQueryString.Add("NodeId", "1");
            nvcQueryString.Add("SectionId", "15");

            if (!string.IsNullOrEmpty(txtDate.Text))
            {
                nvcQueryString.Add("d", txtDate.Text);
            }

            var criterions = (from key in nvcQueryString.AllKeys
                              from value in nvcQueryString.GetValues(key)
                              select string.Format("{0}={1}", HttpUtility.UrlEncode(key), HttpUtility.UrlEncode(value))).ToArray();

            return "?" + string.Join("&", criterions);
        }

        int totalAdult = 0;
        int totalChild = 0;
        int totalBaby = 0;
        double totalOfTotalPrice = 0.0;
        protected void rptBooking_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var numberOfPaxAdult = 0;
                try
                {
                    numberOfPaxAdult = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "NumberOfPaxAdult"));
                }
                catch { }
                totalAdult += numberOfPaxAdult;
                var numberOfPaxChild = 0;
                try
                {
                    numberOfPaxChild = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "NumberOfPaxChild"));
                }
                catch { }
                totalChild += numberOfPaxChild;
                var numberOfPaxBaby = 0;
                try
                {
                    numberOfPaxBaby = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "NumberOfPaxBaby"));
                }
                catch { }
                totalBaby += numberOfPaxBaby;
                var totalPrice = 0.0;
                try
                {
                    totalPrice = Convert.ToDouble(DataBinder.Eval(e.Item.DataItem, "TotalPrice"));
                }
                catch { }
                totalOfTotalPrice += totalPrice;
            }else if(e.Item.ItemType == ListItemType.Footer){
                var lblTotalAdult = e.Item.FindControl("lblTotalAdult") as Label;
                var lblTotalChild = e.Item.FindControl("lblTotalChild") as Label;
                var lblTotalBaby = e.Item.FindControl("lblTotalBaby") as Label;
                var lblTotalOfTotalPrice = e.Item.FindControl("lblTotalOfTotalPrice") as Label;
                lblTotalAdult.Text = totalAdult.ToString();
                lblTotalChild.Text = totalChild.ToString();
                lblTotalBaby.Text = totalBaby.ToString();
                lblTotalOfTotalPrice.Text = totalOfTotalPrice.ToString("#,##0.##") + "₫";
            }
        }
    }
}