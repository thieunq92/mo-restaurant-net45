﻿using Portal.Modules.OrientalSails.Domain;
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
        public virtual int PartOfDay { get; set; }
        public virtual string MenuDetail { get; set; }
        public virtual AgencyContact Booker { get; set; }
        public virtual IList<PaymentHistory> ListPaymentHistory { get; set; }
        public virtual IList<Guide> ListGuide { get; set; }
        public virtual IList<Commission> ListCommission { get; set; }
        public virtual IList<ServiceOutside> ListServiceOutside { get; set; }
        public virtual String Code
        {
            get
            {
                return String.Format("HL{0:D5}", Id);
            }
        }
        public virtual bool IsPaid
        {
            get
            {
                if (TotalPrice > 0 && Receivable <= 0 || MarkIsPaid)
                {
                    return true;
                }
                return false;
            }
        }
        public virtual String NameAndPhoneOfGuides
        {
            get
            {
                var nameOfGuides = "";
                foreach (var guide in ListGuide)
                {
                    if (!String.IsNullOrEmpty(guide.Phone))
                    {
                        nameOfGuides += guide.Name + "-" + guide.Phone + "<br/>";
                    }
                    else
                    {
                        nameOfGuides += guide.Name + "<br/>";
                    }
                }
                return nameOfGuides;
            }
        }
        public virtual double ActuallyCollected
        {
            get
            {
                var totalCommission = 0.0;
                foreach (var commission in ListCommission)
                {
                    totalCommission += commission.Amount;
                }
                return TotalPrice - totalCommission;
            }
        }
    }
}