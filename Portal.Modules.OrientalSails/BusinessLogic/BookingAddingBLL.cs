using Portal.Modules.OrientalSails.Domain;
using Portal.Modules.OrientalSails.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Modules.OrientalSails.BusinessLogic
{
    public class BookingAddingBLL
    {
        RestaurantBookingRepository RestaurantBookingRepository { get; set; }
        AgencyRepository AgencyRepository { get; set; }
        public BookingAddingBLL()
        {
            RestaurantBookingRepository = new RestaurantBookingRepository();
            AgencyRepository = new AgencyRepository();
        }
        public void Dispose()
        {
            if (RestaurantBookingRepository != null)
            {
                RestaurantBookingRepository.Dispose();
                RestaurantBookingRepository = null;
            }
            if (AgencyRepository != null)
            {
                AgencyRepository.Dispose();
                AgencyRepository = null;
            }
        }

        public void RestaurantBookingSaveOrUpdate(RestaurantBooking restaurantBooking)
        {
            RestaurantBookingRepository.SaveOrUpdate(restaurantBooking);
        }

        public Agency AgencyGetById(int agencyId)
        {
            return AgencyRepository.GetById(agencyId);
        }
    }
}