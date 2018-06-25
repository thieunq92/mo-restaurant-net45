using Newtonsoft.Json;
using Portal.Modules.OrientalSails.BusinessLogic;
using Portal.Modules.OrientalSails.DataTransferObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Portal.Modules.OrientalSails.Web.Admin.WebMethod
{
    /// <summary>
    /// Summary description for BookingViewingWebMethod
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class BookingViewingWebMethod : System.Web.Services.WebService
    {
        public BookingViewingBLL bookingViewingBLL;
        public BookingViewingBLL BookingViewingBLL
        {
            get
            {
                if (bookingViewingBLL == null)
                {
                    bookingViewingBLL = new BookingViewingBLL();
                }
                return bookingViewingBLL;
            }
        }
        [WebMethod]
        public string MenuGetById(int menuId)
        {
            var menu = BookingViewingBLL.MenuGetById(menuId);
            var menuDTO = new MenuDTO()
            {
                Id = menu.Id,
                Name = menu.Name,
                Cost = menu.Cost
            };
            Dispose();
            return JsonConvert.SerializeObject(menuDTO);
        }

        public void Dispose() {
            if (bookingViewingBLL != null)
            {
                bookingViewingBLL.Dispose();
                bookingViewingBLL = null;
            }
        }
    }
}
