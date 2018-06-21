using Portal.Modules.OrientalSails.Domain;
using Portal.Modules.OrientalSails.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Modules.OrientalSails.BusinessLogic
{
    public class BookingManagementBLL
    {
        public RestaurantBookingRepository RestaurantBookingRepository { get; set; }
        public BookingManagementBLL() {
            RestaurantBookingRepository = new RestaurantBookingRepository();
        }
        public void Dispose() {
            if (RestaurantBookingRepository != null) {
                RestaurantBookingRepository.Dispose();
                RestaurantBookingRepository = null;
            }
        }

        public IList<RestaurantBooking> RestaurantBookingGetAll()
        {
            return RestaurantBookingRepository.RestaurantBookingGetAll();
        }
    }
}