using NHibernate;
using Portal.Modules.OrientalSails.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Modules.OrientalSails.Repository
{
    public class RestaurantBookingRepository : RepositoryBase<RestaurantBooking>
    {
        public RestaurantBookingRepository() : base() { }
        public RestaurantBookingRepository(ISession session) : base(session) { }

        public IList<RestaurantBooking> RestaurantBookingGetAll()
        {
            return _session.QueryOver<RestaurantBooking>().Future().ToList();
        }

        public IList<RestaurantBooking> RestaurantBookingGetAllByDate(DateTime date)
        {
            return _session.QueryOver<RestaurantBooking>().Where(x => x.Date == date).Future().ToList();
        }
    }
}