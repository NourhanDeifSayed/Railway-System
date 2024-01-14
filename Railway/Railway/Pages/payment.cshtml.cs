using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;
using Railway.Models;
using System.Data;
using System.Reflection;

namespace Railway.Pages
{
    public class PaymentModel : PageModel
    {
        private readonly ILogger<PaymentModel> _logger;
        private readonly DB _dbb;

        public DataTable dtt { get; set; }

        public PaymentModel(ILogger<PaymentModel> logger, DB db)
        {
            _logger = logger;
            _dbb = db;
        }

        public void OnGet()
        {

            dtt = _dbb.ReadTable("Booking");
            var filteredRows = dtt.AsEnumerable().Take(15).CopyToDataTable();


            // Initialization or logic for handling HTTP GET requests
        }
    }
}