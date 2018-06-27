using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Modules.OrientalSails.DataTransferObject
{
    public class ServiceOutsideDTO
    {
        public int id { get; set; }
        public string service { get; set; }
        public string unitPrice { get; set; }
        public int quantity { get; set; }
        public string totalPrice { get; set; }
        public int restaurantBookingId { get; set; }
    }
}