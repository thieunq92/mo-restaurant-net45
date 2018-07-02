using Portal.Modules.OrientalSails.BusinessLogic;
using Portal.Modules.OrientalSails.Domain;
using Portal.Modules.OrientalSails.Enums.RestaurantBooking;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Portal.Modules.OrientalSails.Web
{
    public partial class BookingViewing : System.Web.UI.Page
    {
        public BookingViewingBLL bookingViewingBLL;
        public BookingViewingBLL BookingViewingBLL
        {
            get
            {
                if (bookingViewingBLL == null)
                    bookingViewingBLL = new BookingViewingBLL();
                return bookingViewingBLL;
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
                var restaurantBooking = BookingViewingBLL.RestaurantBookingGetById(restaurantBookingId);
                if (restaurantBooking.Id == -1)
                {
                    Response.Redirect("404.aspx");
                }
                return restaurantBooking;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ddlMenu.DataSource = BookingViewingBLL.MenuGetAll();
                ddlMenu.DataTextField = "Name";
                ddlMenu.DataValueField = "Id";
                ddlMenu.DataBind();
                ddlMenu.SelectedValue = "-1";
                try
                {
                    ddlMenu.SelectedValue = RestaurantBooking.Menu.Id.ToString();
                }
                catch { }
                txtDate.Text = RestaurantBooking.Date.HasValue ? RestaurantBooking.Date.Value.ToString("dd/MM/yyyy") : "";
                agencySelector.Value = "";
                try
                {
                    agencySelector.Value = RestaurantBooking.Agency.Id.ToString();
                }
                catch { }
                ddlStatus.SelectedValue = RestaurantBooking.Status.ToString();
                txtTime.Text = RestaurantBooking.Time;
                txtNumberOfPaxAdult.Text = RestaurantBooking.NumberOfPaxAdult.ToString();
                txtNumberOfPaxChild.Text = RestaurantBooking.NumberOfPaxChild.ToString();
                txtNumberOfPaxBaby.Text = RestaurantBooking.NumberOfPaxBaby.ToString();
                txtCostPerPersonAdult.Text = RestaurantBooking.CostPerPersonAdult.ToString();
                txtCostPerPersonChild.Text = RestaurantBooking.CostPerPersonChild.ToString();
                txtCostPerPersonBaby.Text = RestaurantBooking.CostPerPersonBaby.ToString();
                txtNumberOfDiscountedPaxAdult.Text = RestaurantBooking.NumberOfDiscountedPaxAdult.ToString();
                txtNumberOfDiscountedPaxChild.Text = RestaurantBooking.NumberOfDiscountedPaxChild.ToString();
                txtNumberOfDiscountedPaxBaby.Text = RestaurantBooking.NumberOfDiscountedPaxBaby.ToString();
                txtSpecialRequest.Text = RestaurantBooking.SpecialRequest;
                if (RestaurantBooking.Payment == 1)
                {
                    rbPayNow.Checked = true;
                }
                if (RestaurantBooking.Payment == 2)
                {
                    rbDebt.Checked = true;
                }
                ddlPartOfDay.SelectedValue = RestaurantBooking.PartOfDay.ToString();
            }
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            if (bookingViewingBLL != null)
            {
                bookingViewingBLL.Dispose();
                bookingViewingBLL = null;
            }
        }

        public void ShowWarning(string warning)
        {
            Session["WarningMessage"] = "<strong>Warning!</strong> " + warning + "<br/>" + Session["WarningMessage"];
        }

        public void ShowErrors(string error)
        {
            Session["ErrorMessage"] = "<strong>Error!</strong> " + error + "<br/>" + Session["ErrorMessage"];
        }

        public void ShowSuccess(string success)
        {
            Session["SuccessMessage"] = "<strong>Success!</strong> " + success + "<br/>" + Session["SuccessMessage"];
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            RestaurantBooking.Menu = BookingViewingBLL.MenuGetById(Int32.Parse(ddlMenu.SelectedValue));
            RestaurantBooking.Agency = BookingViewingBLL.AgencyGetById(Int32.Parse(agencySelector.Value));
            RestaurantBooking.Date = DateTime.ParseExact(txtDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            RestaurantBooking.Status = Int32.Parse(ddlStatus.SelectedValue);
            RestaurantBooking.Time = txtTime.Text;
            var numberOfPaxAdult = 0;
            try
            {
                numberOfPaxAdult = Int32.Parse(txtNumberOfPaxAdult.Text);
            }
            catch { }
            RestaurantBooking.NumberOfPaxAdult = numberOfPaxAdult;
            var numberOfPaxChild = 0;
            try
            {
                numberOfPaxChild = Int32.Parse(txtNumberOfPaxChild.Text);
            }
            catch { }
            RestaurantBooking.NumberOfPaxChild = numberOfPaxChild;
            var numberOfPaxBaby = 0;
            try
            {
                numberOfPaxAdult = Int32.Parse(txtNumberOfPaxBaby.Text);
            }
            catch { }
            RestaurantBooking.NumberOfPaxBaby = numberOfPaxBaby;
            var costPerPersonAdult = 0.0;
            try
            {
                costPerPersonAdult = Double.Parse(txtCostPerPersonAdult.Text);
            }
            catch { }
            RestaurantBooking.CostPerPersonAdult = costPerPersonAdult;
            var costPerPersonChild = 0.0;
            try
            {
                costPerPersonChild = Double.Parse(txtCostPerPersonChild.Text);
            }
            catch { }
            RestaurantBooking.CostPerPersonChild = costPerPersonChild;
            var costPerPersonBaby = 0.0;
            try
            {
                costPerPersonBaby = Double.Parse(txtCostPerPersonBaby.Text);
            }
            catch { }
            RestaurantBooking.CostPerPersonBaby = costPerPersonBaby;
            var numberOfDiscountedPaxAdult = 0;
            try
            {
                numberOfDiscountedPaxAdult = Int32.Parse(txtNumberOfDiscountedPaxAdult.Text);
            }
            catch { }
            RestaurantBooking.NumberOfDiscountedPaxAdult = numberOfDiscountedPaxAdult;
            var numberOfDiscountedPaxChild = 0;
            try
            {
                numberOfDiscountedPaxChild = Int32.Parse(txtNumberOfDiscountedPaxChild.Text);
            }
            catch { }
            RestaurantBooking.NumberOfDiscountedPaxChild = numberOfDiscountedPaxChild;
            var numberOfDiscountedPaxBaby = 0;
            try
            {
                numberOfDiscountedPaxBaby = Int32.Parse(txtNumberOfDiscountedPaxBaby.Text);
            }
            catch { }
            RestaurantBooking.NumberOfDiscountedPaxBaby = numberOfDiscountedPaxBaby;
            RestaurantBooking.SpecialRequest = txtSpecialRequest.Text;
            RestaurantBooking.Time = txtTime.Text;      
            if (rbPayNow.Checked)
            {
                RestaurantBooking.Payment = 1;
            }
            if (rbDebt.Checked)
            {
                RestaurantBooking.Payment = 2;
            }
            RestaurantBooking.VAT = chkVAT.Checked;
            RestaurantBooking.PartOfDay = Int32.Parse(ddlPartOfDay.SelectedValue);
            RestaurantBooking.TotalPrice = Double.Parse(txtTotalPrice.Text);
            RestaurantBooking.Receivable = RestaurantBooking.TotalPrice - RestaurantBooking.TotalPaid;
            RestaurantBooking.MenuDetail = txtMenuDetail.Text;
            BookingViewingBLL.RestaurantBookingSaveOrUpdate(RestaurantBooking);
            ShowSuccess("Cập nhật booking thành công");
        }
    }
}