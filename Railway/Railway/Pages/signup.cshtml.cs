// YourPageModel.cs
using Azure.Core;
using Azure;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace Railway.Pages
{
    public class YourPageModel : PageModel
    {
        public string Message = "Error Happened";
        [BindProperty(SupportsGet = true)]

        public EMPInfo2 empInfo { get; set; }

        public void OnGet()
        {

        }

        public IActionResult OnPost()
        {



            string connectionString = "Data Source=DESKTOP-8f1CJGM;Initial Catalog=newRailWay2;Integrated Security=True";

            SqlConnection connection = new SqlConnection(connectionString);



            try
            {


                connection.Open();

                string sql = "INSERT INTO Passenger(PassengerName, PassengerEmail) " +
                             "VALUES (@firstName, @email); ";

                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@firstName", empInfo.FirstName);

                    command.Parameters.AddWithValue("@email", empInfo.Email);


                    command.ExecuteNonQuery();
                }

            }
            catch (Exception ex)
            {
                Message = ex.Message;
                Console.WriteLine(Message);

            }
            finally { connection.Close(); }






            return RedirectToPage("/well_done");

        }
        [BindProperties(SupportsGet = true)]
        public class EMPInfo2
        {
            public int Id { get; set; }
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public string Email { get; set; }
            public string Password { get; set; }
            public string ConfirmPassword { get; set; }
        }
    }
}