using Microsoft.AspNetCore.Mvc;

namespace Railway.Models
{
    [BindProperties(SupportsGet = true)]
    public class Booking
    {
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string DepartureCity { get; set; }
        public string ArrivalCity { get; set; }
        public string TicketType { get; set; }
        public DateTime BookingDate { get; set; }

        public int BookingId { get; set; }
    }
}