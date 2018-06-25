using Portal.Modules.OrientalSails.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Modules.OrientalSails.Domain
{
    public class RestaurantBooking
    {
        public virtual int Id { get; set; }
        public virtual int Status { get; set; }
        public virtual string Time { get; set; }
        public virtual int NumberOfPaxAdult { get; set; }
        public virtual int NumberOfPaxChild { get; set; }
        public virtual int NumberOfPaxBaby { get; set; }
        public virtual double CostPerPersonAdult { get; set; }
        public virtual double CostPerPersonChild { get; set; }
        public virtual double CostPerPersonBaby { get; set; }
        public virtual int NumberOfDiscountedPaxAdult { get; set; }
        public virtual int NumberOfDiscountedPaxChild { get; set; }
        public virtual int NumberOfDiscountedPaxBaby { get; set; }
        public virtual string SpecialRequest { get; set; }
        public virtual int Payment { get; set; }
        public virtual double TotalPrice { get; set; }
        public virtual DateTime? Date { get; set; }
        public virtual Agency Agency { get; set; }
        public virtual Menu Menu { get; set; }
        public virtual double TotalPaid { get; set; }
        public virtual double Receivable { get; set; }
        public virtual bool MarkIsPaid { get; set; }
        public virtual bool VAT { get; set; }
        public virtual IList<PaymentHistory> ListPaymentHistory { get; set; }
        public virtual String Code
        {
            get
            {
                return String.Format("HL{0:D5}", Id);
            }
        }
    }
}