using Portal.Modules.OrientalSails.Domain;
using Portal.Modules.OrientalSails.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Modules.OrientalSails.BusinessLogic
{
    public class BookingViewingBLL
    {
        public MenuRepository MenuRepository { set; get; }
        public RestaurantBookingRepository RestaurantBookingRepository { get; set; }
        public AgencyRepository AgencyRepository { get; set; }
        public BookingViewingBLL()
        {
            MenuRepository = new MenuRepository();
            RestaurantBookingRepository = new RestaurantBookingRepository();
            AgencyRepository = new AgencyRepository();
        }
        public void Dispose()
        {
            if (MenuRepository != null)
            {
                MenuRepository.Dispose();
                MenuRepository = null;
            }
            if (RestaurantBookingRepository != null)
            {
                RestaurantBookingRepository.Dispose();
                RestaurantBookingRepository = null;
            }
            if (AgencyRepository != null)
            {
                AgencyRepository.Dispose();
            }
        }

        public IList<Menu> MenuGetAll()
        {
            return MenuRepository.MenuGetAll();
        }

        public RestaurantBooking RestaurantBookingGetById(int restaurantBookingId)
        {
            return RestaurantBookingRepository.GetById(restaurantBookingId);
        }

        public void RestaurantBookingSaveOrUpdate(RestaurantBooking restaurantBooking)
        {
            RestaurantBookingRepository.SaveOrUpdate(restaurantBooking);
        }

        public Agency AgencyGetById(int agencyId)
        {
            return AgencyRepository.AgencyGetById(agencyId);
        }

        public Menu MenuGetById(int menuId)
        {
            return MenuRepository.GetById(menuId);
        }
    }
}