// YourPageModel.cs
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;
using System.Data;
using System.Data.SqlClient;

namespace Railway.Pages
{
    public class BookingModel : PageModel
    {
        public string Message = "Error Happened";
        [BindProperty(SupportsGet = true)]
        public EMPInfo1 empInfo { get; set; }

        public void OnGet()
        {
            // Your initialization logic for GET requests, if needed.
        }

        public IActionResult OnPost()
        {
            string connectionString = "Data Source=DESKTOP-8f1CJGM;Initial Catalog=newRailWay2;Integrated Security=True";
            SqlConnection connection = new SqlConnection(connectionString);

            try
            {
                connection.Open();

                // Insert data into the Booking table
                string insertQuery = @"
                    INSERT INTO Booking ( firstName, lastName, Email, PhoneNumber,  TicketType,BookingDate,DepartureCity,ArrivalCity)
                    VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @TicketType,@BookingDate,@DepartCity,@ArrCity);
                ";

                using (SqlCommand command = new SqlCommand(insertQuery, connection))
                {
                    // Set parameters for the query with consistent casing

                    command.Parameters.AddWithValue("@FirstName", empInfo.firstName);
                    command.Parameters.AddWithValue("@LastName", empInfo.lastName);
                    command.Parameters.AddWithValue("@Email", empInfo.Email);
                    command.Parameters.AddWithValue("@PhoneNumber", empInfo.PhoneNumber);


                    command.Parameters.AddWithValue("@TicketType", empInfo.TicketType);
                    command.Parameters.AddWithValue("@BookingDate", empInfo.bookingDate).SqlDbType = SqlDbType.Date;
                    command.Parameters.AddWithValue("@DepartCity", empInfo.DepartureCity);
                    command.Parameters.AddWithValue("@ArrCity", empInfo.ArrivalCity);



                    command.ExecuteNonQuery();

                }
            }
            catch (Exception ex)
            {
                Message = ex.Message;
                Console.WriteLine(Message);

            }
            finally
            {
                connection.Close();
            }

            // Redirect to a confirmation page or another appropriate action
            return RedirectToPage("payment");
        }
    }

    [BindProperties(SupportsGet = true)]
    public class EMPInfo1
    {
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string DepartureCity { get; set; }
        public string ArrivalCity { get; set; }
        public string TicketType { get; set; }
        public DateTime bookingDate { get; set; }

        public int BookingId { get; set; }


    }
}
