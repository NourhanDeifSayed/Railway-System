using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Railway.Pages
{
    public class stuff_informationModel : PageModel
    {
        private readonly ILogger<stuff_informationModel> _logger;

        public stuff_informationModel(ILogger<stuff_informationModel> logger)
        {
            _logger = logger;
        }

        public List<EMPInfo> ListEMP { get; set; } = new List<EMPInfo>();
        public int UserCount { get; set; }

        public void OnGet()
        {
            string connectionString = "Data Source=DESKTOP-8f1CJGM;Initial Catalog=newRailWay2;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT StaffID, StaffName, StaffAddress, StaffPhone, StaffRole FROM Staff"; // Adjust the SQL query to fetch required columns
                SqlCommand command = new SqlCommand(query, connection);

                try
                {
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        EMPInfo employee = new EMPInfo();
                        employee.StaffID = (int)reader["StaffID"];
                        employee.StaffName = "" + reader.GetString(1);
                        employee.StaffAddress = "" + reader.GetString(2);
                        employee.StaffPhone = "" + reader.GetString(3);
                        employee.StaffRole = "" + reader.GetString(4);
                        ListEMP.Add(employee);
                    }
                    
                    UserCount = ListEMP.Count;
                }
                catch (Exception ex)
                {
                    // Log or handle the exception
                    _logger.LogError(ex, "Error occurred while fetching data from Staff table.");
                }
                finally
                {
                    connection.Close();
                }
            }
        }

        public IActionResult OnPost()
        {
            return RedirectToPage("/stuff_information");
        }
    }

    public class EMPInfo
    {
        public int StaffID { get; set; }
        public string StaffName { get; set; }
        public string StaffAddress { get; set; }
        public string StaffPhone { get; set; }
        public string StaffRole { get; set; }
    }
}
