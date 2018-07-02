using GemBox.Spreadsheet;
using Portal.Modules.OrientalSails.BusinessLogic;
using Portal.Modules.OrientalSails.Domain;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Globalization;
using System.IO;
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
        public DateTime Date
        {
            get
            {
                var date = DateTime.Now.Date;
                try
                {
                    date = DateTime.ParseExact(Request.QueryString["d"], "dd/MM/yyyy", CultureInfo.InvariantCulture);
                }
                catch { }
                return date;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                txtDate.Text = Date.ToString("dd/MM/yyyy");
                rptBooking.DataSource = RestaurantBookingByDateBLL.RestaurantBookingGetAllByDate(Date).OrderBy(x => x.PartOfDay).ThenBy(x => x.Time);
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
        double totalActuallyCollected = 0.0;
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
                var actuallyCollected = 0.0;
                try
                {
                    actuallyCollected = Convert.ToDouble(DataBinder.Eval(e.Item.DataItem, "ActuallyCollected"));
                }
                catch { }
                totalActuallyCollected += actuallyCollected;
                var rptServiceOutside = e.Item.FindControl("rptServiceOutside") as Repeater;
                rptServiceOutside.DataSource = ((IList<ServiceOutside>)DataBinder.Eval(e.Item.DataItem, "ListServiceOutside"));
                rptServiceOutside.DataBind();
            }
            else if (e.Item.ItemType == ListItemType.Footer)
            {
                var lblTotalAdult = e.Item.FindControl("lblTotalAdult") as Label;
                var lblTotalChild = e.Item.FindControl("lblTotalChild") as Label;
                var lblTotalBaby = e.Item.FindControl("lblTotalBaby") as Label;
                var lblTotalOfTotalPrice = e.Item.FindControl("lblTotalOfTotalPrice") as Label;
                var lblTotalActuallyCollected = e.Item.FindControl("lblTotalActuallyCollected") as Label;
                lblTotalAdult.Text = totalAdult.ToString();
                lblTotalChild.Text = totalChild.ToString();
                lblTotalBaby.Text = totalBaby.ToString();
                lblTotalOfTotalPrice.Text = totalOfTotalPrice.ToString("#,##0.##") + "₫";
                lblTotalActuallyCollected.Text = totalActuallyCollected.ToString("#,##0.##") + "₫";
            }
        }

        protected void btnSalesReportExport_Click(object sender, EventArgs e)
        {
            var excelFile = new ExcelFile();
            excelFile.LoadXls(Server.MapPath("/Modules/Sails/Admin/ExportTemplates/DoanhThuNgay.xlsx"));
            var workSheet = excelFile.Worksheets[0];
            workSheet.Cells["F4"].Value = Date.ToString("dd/MM/yyyy");
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "application/vnd.ms-excel";
            Response.AppendHeader("content-disposition", "attachment; filename= test.xls");
            var memoryStream = new MemoryStream();
            excelFile.SaveXls(memoryStream);
            Response.OutputStream.Write(memoryStream.GetBuffer(), 0, memoryStream.GetBuffer().Length);
            Response.OutputStream.Flush();
            Response.OutputStream.Close();
            memoryStream.Close();
            Response.End();
        }

        public string GetServiceOutsideDetail(ServiceOutside serviceOutside)
        {
            var serviceOutsideDetailString = " ";
            foreach (var serviceOutsideDetail in serviceOutside.ListServiceOutsideDetail)
            {
                serviceOutsideDetailString += String.Format("{0} : {1} x {2} = {3}", serviceOutsideDetail.Name, serviceOutsideDetail.UnitPrice.ToString("#,##0.##"), serviceOutsideDetail.Quantity, serviceOutsideDetail.TotalPrice.ToString("#,##0.##"));
            }
            return serviceOutsideDetailString;
        }
    }
}