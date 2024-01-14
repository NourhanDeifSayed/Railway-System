using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;
using Railway.Models;
using System.Data;

namespace Railway.Pages
{
    public class lost_foundModel : PageModel
    {
        private readonly ILogger<lost_foundModel> _logger;
        private readonly DB db;
        public DataTable dt { get; set; }

        public lost_foundModel(ILogger<lost_foundModel> logger, DB db)
        {
            _logger = logger;
            this.db = db;
        }

        public void OnGet()
        {
            dt = db.ReadTable("LostFound");

            // Initialization or logic for handling HTTP GET requests
        }
    }
}