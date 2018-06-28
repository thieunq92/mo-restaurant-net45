using NHibernate;
using NHibernate.Criterion;
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
            return _session.QueryOver<RestaurantBooking>()
                .Where(x => x.Date == date)
                .Future()
                .ToList();
        }

        public IList<RestaurantBooking> RestaurantBookingGetAllByDateRange(DateTime from, DateTime to, int agencyId)
        {
            var query = _session.QueryOver<RestaurantBooking>().Where(x => x.Date >= from && x.Date <= to);
            Agency agencyAlias = null;
            query = query.JoinAlias(x => x.Agency, () => agencyAlias);
            if (agencyId != -1)
            {
                query = query.Where(x => agencyAlias.Id == agencyId);
            }
            return query.Future().ToList();                
        }

        public IList<RestaurantBooking> RestaurantBookingGetAllByCriterion(int code, DateTime? date, string agency, int payment, int agencyId)
        {
            var query = _session.QueryOver<RestaurantBooking>();
            if (code != -1)
            {
                query = query.Where(x => x.Id == code);
            }
            if (date.HasValue)
            {
                query = query.Where(x => x.Date == date);
            }
            Agency agencyAlias = null;
            query = query.JoinAlias(x => x.Agency, () => agencyAlias);
            if (!String.IsNullOrEmpty(agency))
            {
                query = query.WhereRestrictionOn(x => agencyAlias.Name).IsLike(agency, MatchMode.Anywhere);
            }
            if (payment != -1)
            {
                query = query.Where(x => x.Payment == payment);
            }
            if (agencyId != -1)
            {
                query = query.Where(x => agencyAlias.Id == agencyId);
            }
            return query.Future().ToList();
        }
    }
}