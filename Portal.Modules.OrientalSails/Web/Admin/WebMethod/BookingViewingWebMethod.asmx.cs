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
        public string BookerGetAllByAgencyId(int agencyId)
        {
            var listBooker = BookingViewingBLL.BookerGetAllByAgencyId(agencyId);
            var listBookerDTO = new List<BookerDTO>();
            foreach (var booker in listBooker)
            {
                var bookerDTO = new BookerDTO
                {
                    id = booker.Id,
                    name = booker.Name,
                };
                listBookerDTO.Add(bookerDTO);
            }
            return JsonConvert.SerializeObject(listBookerDTO);

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
                var commissionDTORestaurantBookingId = 0;
                try
                {
                    commissionDTORestaurantBookingId = Convert.ToInt32(commissionDTO.restaurantBookingId);
                }
                catch { }
                if (commissionDTO.id <= 0)
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
        [WebMethod]
        public void ServiceOutsideSave(IList<ServiceOutsideDTO> listServiceOutsideDTO, int restaurantBookingId)
        {
            var listNewServiceOutsideId = new List<int>();
            foreach (var serviceOutsideDTO in listServiceOutsideDTO)
            {
                ServiceOutside serviceOutside = null;
                var unitPrice = 0.0;
                try
                {
                    unitPrice = Double.Parse(serviceOutsideDTO.unitPrice);
                }
                catch { }
                var quantity = 0;
                try
                {
                    quantity = Convert.ToInt32(serviceOutsideDTO.quantity);
                }
                catch { }
                var totalPrice = 0.0;
                try
                {
                    totalPrice = Double.Parse(serviceOutsideDTO.totalPrice);
                }
                catch { }
                var serviceOutsideDTORestaurantBookingId = 0;
                try
                {
                    serviceOutsideDTORestaurantBookingId = Convert.ToInt32(serviceOutsideDTO.restaurantBookingId);
                }
                catch { }
                if (serviceOutsideDTO.id <= 0)
                {
                    serviceOutside = new ServiceOutside();
                }
                else if (serviceOutsideDTO.id > 0)
                {
                    serviceOutside = BookingViewingBLL.ServiceOutsideGetById(serviceOutsideDTO.id);
                }
                serviceOutside.Service = serviceOutsideDTO.service;
                serviceOutside.UnitPrice = unitPrice;
                serviceOutside.Quantity = quantity;
                serviceOutside.TotalPrice = totalPrice;
                serviceOutside.RestaurantBooking = BookingViewingBLL.RestaurantBookingGetById(serviceOutsideDTORestaurantBookingId);
                serviceOutside.VAT = serviceOutsideDTO.vat;
                BookingViewingBLL.ServiceOutsideSaveOrUpdate(serviceOutside);
                listNewServiceOutsideId.Add(serviceOutside.Id);
                ServiceOutsideDetailSave(serviceOutsideDTO,serviceOutside);
            }
            var listServiceOutside = BookingViewingBLL.ServiceOutsideGetAllByBookingId(restaurantBookingId);
            var listIdOfServiceOutside = listServiceOutside.Select(x => x.Id).ToList();
            var listIdOfServiceOutsideDTO = listServiceOutsideDTO.Where(x => x.id > 0).Select(x => x.id).ToList();
            var listServiceOutsideIdNeedRemove = listIdOfServiceOutside.Except(listIdOfServiceOutsideDTO).Except(listNewServiceOutsideId);
            foreach (var serviceOutsideIdNeedRemove in listServiceOutsideIdNeedRemove)
            {
                var serviceOutsideNeedRemove = BookingViewingBLL.ServiceOutsideGetById(serviceOutsideIdNeedRemove);
                BookingViewingBLL.ServiceOutsideDelete(serviceOutsideNeedRemove);
            }
            Dispose();
        }
        public void ServiceOutsideDetailSave(ServiceOutsideDTO serviceOutsideDTO, ServiceOutside serviceOutside)
        {
            var listNewServiceOutsideDetailId = new List<int>();
            foreach (var serviceOutsideDetailDTO in serviceOutsideDTO.listServiceOutsideDetailDTO)
            {
                ServiceOutsideDetail serviceOutsideDetail = null;
                var unitPrice = 0.0;
                try
                {
                    unitPrice = Double.Parse(serviceOutsideDetailDTO.unitPrice);
                }
                catch { }
                var quantity = 0;
                try
                {
                    quantity = Convert.ToInt32(serviceOutsideDetailDTO.quantity);
                }
                catch { }
                var totalPrice = 0.0;
                try
                {
                    totalPrice = Double.Parse(serviceOutsideDetailDTO.totalPrice);
                }
                catch { }
                if (serviceOutsideDetailDTO.id <= 0)
                {
                    serviceOutsideDetail = new ServiceOutsideDetail();
                }
                else if (serviceOutsideDetailDTO.id > 0)
                {
                    serviceOutsideDetail = BookingViewingBLL.ServiceOutsideDetailGetById(serviceOutsideDetailDTO.id);
                }
                serviceOutsideDetail.Name = serviceOutsideDetailDTO.name;
                serviceOutsideDetail.UnitPrice = unitPrice;
                serviceOutsideDetail.Quantity = quantity;
                serviceOutside.TotalPrice = totalPrice;
                serviceOutsideDetail.ServiceOutside = serviceOutside;
                BookingViewingBLL.ServiceOutsideDetailSaveOrUpdate(serviceOutsideDetail);
                listNewServiceOutsideDetailId.Add(serviceOutsideDetail.Id);
                var listServiceOutsideDetail = BookingViewingBLL.ServiceOutsideDetailGetAllByServiceOutsideId(serviceOutside.Id);
                var listIdOfServiceOutsideDetail = listServiceOutsideDetail.Select(x => x.Id).ToList();
                var listIdOfServiceOutsideDetailDTO = serviceOutsideDTO.listServiceOutsideDetailDTO.Where(x => x.id > 0).Select(x => x.id).ToList();
                var listServiceOutsideDetailIdNeedRemove = listIdOfServiceOutsideDetail.Except(listIdOfServiceOutsideDetailDTO).Except(listNewServiceOutsideDetailId);
                foreach (var serviceOutsideDetailIdNeedRemove in listServiceOutsideDetailIdNeedRemove)
                {
                    var serviceOutsideDetailNeedRemove = BookingViewingBLL.ServiceOutsideDetailGetById(serviceOutsideDetailIdNeedRemove);
                    BookingViewingBLL.ServiceOutsideDetailDelete(serviceOutsideDetailNeedRemove);
                }
                Dispose();
            }
        }
        [WebMethod]
        public string ServiceOutsideGetAllByBookingId(int restaurantBookingId)
        {
            var listServiceOutside = BookingViewingBLL.ServiceOutsideGetAllByBookingId(restaurantBookingId);
            var listServiceOutsideDTO = new List<ServiceOutsideDTO>();
            foreach (var serviceOutside in listServiceOutside)
            {
                var serviceOutsideDTO = new ServiceOutsideDTO()
                {
                    id = serviceOutside.Id,
                    service = serviceOutside.Service,
                    unitPrice = serviceOutside.UnitPrice.ToString("#,##0.##"),
                    quantity = serviceOutside.Quantity,
                    totalPrice = serviceOutside.TotalPrice.ToString("#,##0.##"),
                    restaurantBookingId = serviceOutside.RestaurantBooking.Id,
                    vat = serviceOutside.VAT,
                };
                listServiceOutsideDTO.Add(serviceOutsideDTO);
            }
            Dispose();
            return JsonConvert.SerializeObject(listServiceOutsideDTO);
        }
        [WebMethod]
        public string ServiceOutsideDetailGetAllByServiceOutsideId(int serviceOutsideId)
        {
            var listServiceOutsideDetail = BookingViewingBLL.ServiceOutsideDetailGetAllByServiceOutsideId(serviceOutsideId);
            var listServiceOutsideDetailDTO = new List<ServiceOutsideDetailDTO>();
            foreach (var serviceOutsideDetail in listServiceOutsideDetail)
            {
                var serviceOutsideDetailDTO = new ServiceOutsideDetailDTO()
                {
                    id = serviceOutsideDetail.Id,
                    name = serviceOutsideDetail.Name,
                    unitPrice = serviceOutsideDetail.UnitPrice.ToString("#,##0.##"),
                    quantity = serviceOutsideDetail.Quantity,
                    totalPrice = serviceOutsideDetail.TotalPrice.ToString("#,##0.##"),
                };
                listServiceOutsideDetailDTO.Add(serviceOutsideDetailDTO);
            }
            Dispose();
            return JsonConvert.SerializeObject(listServiceOutsideDetailDTO);
        }
        [WebMethod]
        public void GuideSave(IList<GuideDTO> listGuideDTO, int restaurantBookingId)
        {
            var listNewGuideId = new List<int>();
            foreach (var guideDTO in listGuideDTO)
            {
                Guide guide = null;
                var guideDTORestaurantBookingId = 0;
                try
                {
                    guideDTORestaurantBookingId = Convert.ToInt32(guideDTO.restaurantBookingId);
                }
                catch { }
                if (guideDTO.id <= 0)
                {
                    guide = new Guide();
                }
                else if (guideDTO.id > 0)
                {
                    guide = BookingViewingBLL.GuideGetById(guideDTO.id);
                }
                guide.Name = guideDTO.name;
                guide.Phone = guideDTO.phone;
                guide.RestaurantBooking = BookingViewingBLL.RestaurantBookingGetById(guideDTORestaurantBookingId);
                BookingViewingBLL.GuideSaveOrUpdate(guide);
                listNewGuideId.Add(guide.Id);
            }
            var listGuide = BookingViewingBLL.GuideGetAllByBookingId(restaurantBookingId);
            var listIdOfGuide = listGuide.Select(x => x.Id).ToList();
            var listIdOfGuideDTO = listGuideDTO.Where(x => x.id > 0).Select(x => x.id).ToList();
            var listGuideIdNeedRemove = listIdOfGuide.Except(listIdOfGuideDTO).Except(listNewGuideId);
            foreach (var guideIdNeedRemove in listGuideIdNeedRemove)
            {
                var guideNeedRemove = BookingViewingBLL.GuideGetById(guideIdNeedRemove);
                BookingViewingBLL.GuideDelete(guideNeedRemove);
            }
            Dispose();
        }
        [WebMethod]
        public string GuideGetAllByBookingId(int restaurantBookingId)
        {
            var listGuide = BookingViewingBLL.GuideGetAllByBookingId(restaurantBookingId);
            var listGuideDTO = new List<GuideDTO>();
            foreach (var guide in listGuide)
            {
                var guideDTO = new GuideDTO()
                {
                    id = guide.Id,
                    name = guide.Name,
                    phone = guide.Phone,
                    restaurantBookingId = guide.RestaurantBooking.Id,
                };
                listGuideDTO.Add(guideDTO);
            }
            Dispose();
            return JsonConvert.SerializeObject(listGuideDTO);
        }
        [WebMethod]
        public void BookerSave(int bookerId, int restaurantBookingId)
        {
            var restaurantBooking = BookingViewingBLL.RestaurantBookingGetById(restaurantBookingId);
            restaurantBooking.Booker = BookingViewingBLL.BookerGetById(bookerId);
            BookingViewingBLL.RestaurantBookingSaveOrUpdate(restaurantBooking);
            Dispose();
        }
        public new void Dispose()
        {
            if (bookingViewingBLL != null)
            {
                bookingViewingBLL.Dispose();
                bookingViewingBLL = null;
            }
        }
    }
}
