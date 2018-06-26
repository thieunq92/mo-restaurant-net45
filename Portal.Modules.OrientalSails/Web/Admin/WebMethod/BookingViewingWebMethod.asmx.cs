using Newtonsoft.Json;
using Portal.Modules.OrientalSails.BusinessLogic;
using Portal.Modules.OrientalSails.DataTransferObject;
using Portal.Modules.OrientalSails.Domain;
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
        [WebMethod]
        public void CommissionSave(IList<CommissionDTO> listCommissionDTO, int restaurantBookingId)
        {
            var listNewCommissionId = new List<int>();
            foreach (var commissionDTO in listCommissionDTO)
            {
                Commission commission = null;
                var amount = 0.0;
                try
                {
                    amount = Double.Parse(commissionDTO.amount);
                }
                catch { }
                if (commissionDTO.id == -1)
                {
                    commission = new Commission();
                }
                else if (commissionDTO.id > 0)
                {
                    commission = BookingViewingBLL.CommissionGetById(commissionDTO.id);

                }
                commission.PayFor = commissionDTO.payFor;
                commission.Amount = amount;
                commission.RestaurantBooking = BookingViewingBLL.RestaurantBookingGetById(commissionDTO.restaurantBookingId);
                BookingViewingBLL.CommissionSaveOrUpdate(commission);
                listNewCommissionId.Add(commission.Id);
            }
            var listCommission = BookingViewingBLL.CommissionGetAllByBookingId(restaurantBookingId);
            var listIdOfCommission = listCommission.Select(x => x.Id).ToList();
            var listIdOfCommissionDTO = listCommissionDTO.Where(x => x.id > 0).Select(x => x.id).ToList();
            var listCommissionIdNeedRemove = listIdOfCommission.Except(listIdOfCommissionDTO).Except(listNewCommissionId);
            foreach (var commissionIdNeedRemove in listCommissionIdNeedRemove)
            {
                var commissionNeedRemove = BookingViewingBLL.CommissionGetById(commissionIdNeedRemove);
                BookingViewingBLL.CommissionDelete(commissionNeedRemove);
            }
            Dispose();
        }
        [WebMethod]
        public string CommissionGetAllByBookingId(int restaurantBookingId)
        {
            var listCommission = BookingViewingBLL.CommissionGetAllByBookingId(restaurantBookingId);
            var listCommissionDTO = new List<CommissionDTO>();
            foreach (var commission in listCommission)
            {
                var commissionDTO = new CommissionDTO()
                {
                    id = commission.Id,
                    payFor = commission.PayFor,
                    amount = commission.Amount.ToString("#,##0.##"),
                    restaurantBookingId = commission.RestaurantBooking.Id,
                };
                listCommissionDTO.Add(commissionDTO);
            }
            Dispose();
            return JsonConvert.SerializeObject(listCommissionDTO);
        }
        public void Dispose()
        {
            if (bookingViewingBLL != null)
            {
                bookingViewingBLL.Dispose();
                bookingViewingBLL = null;
            }
        }
    }
}
