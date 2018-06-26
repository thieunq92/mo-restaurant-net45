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
            RestaurantBooking.NumberOfPaxAdult = Int32.Parse(txtNumberOfPaxAdult.Text);
            RestaurantBooking.NumberOfPaxChild = Int32.Parse(txtNumberOfPaxChild.Text);
            RestaurantBooking.NumberOfPaxBaby = Int32.Parse(txtNumberOfPaxBaby.Text);
            RestaurantBooking.CostPerPersonAdult = Double.Parse(txtCostPerPersonAdult.Text);
            RestaurantBooking.CostPerPersonChild = Double.Parse(txtCostPerPersonChild.Text);
            RestaurantBooking.CostPerPersonBaby = Double.Parse(txtCostPerPersonBaby.Text);
            RestaurantBooking.NumberOfDiscountedPaxAdult = Int32.Parse(txtNumberOfDiscountedPaxAdult.Text);
            RestaurantBooking.NumberOfDiscountedPaxChild = Int32.Parse(txtNumberOfDiscountedPaxChild.Text);
            RestaurantBooking.NumberOfDiscountedPaxBaby = Int32.Parse(txtNumberOfDiscountedPaxBaby.Text);
            RestaurantBooking.SpecialRequest = txtSpecialRequest.Text;
            RestaurantBooking.Time = txtTime.Text;
            RestaurantBooking.Receivable = RestaurantBooking.TotalPrice - RestaurantBooking.TotalPaid;
            if (rbPayNow.Checked)
            {
                RestaurantBooking.Payment = 1;
            }
            if (rbDebt.Checked)
            {
                RestaurantBooking.Payment = 2;
            }
            RestaurantBooking.VAT = chkVAT.Checked;
            RestaurantBooking.TotalPrice =
                (RestaurantBooking.NumberOfPaxAdult - RestaurantBooking.NumberOfDiscountedPaxAdult) * RestaurantBooking.CostPerPersonAdult
                + (RestaurantBooking.NumberOfPaxChild - RestaurantBooking.NumberOfDiscountedPaxChild) * RestaurantBooking.CostPerPersonChild
                + (RestaurantBooking.NumberOfPaxBaby - RestaurantBooking.NumberOfDiscountedPaxBaby) * RestaurantBooking.CostPerPersonBaby;
            BookingViewingBLL.RestaurantBookingSaveOrUpdate(RestaurantBooking);
            ShowSuccess("Cập nhật booking thành công");
        }
    }
}