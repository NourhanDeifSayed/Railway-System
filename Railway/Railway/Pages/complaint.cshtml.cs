using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;
using System.Data.SqlClient;

namespace Railway.Pages
{
    public class ComplaintModel : PageModel
    {
        public string Message = "Error Happened";

        [BindProperty(SupportsGet = true)]
        public Complaint complaint { get; set; }

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

                string sql = "INSERT INTO Comp (ComplaintID, ComplaintDescription, PassengerID) " +
                             "VALUES (@ci, @cd, @pi);";  // Corrected parameter name to @pi

                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@ci", complaint.Ci);
                    command.Parameters.AddWithValue("@cd", complaint.Cd);
                    command.Parameters.AddWithValue("@pi", complaint.Pi);  // Corrected parameter name to @pi

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

            return RedirectToPage("/well_done");
        }
    }

    [BindProperties(SupportsGet = true)]
    public class Complaint
    {
        public string Pi { get; set; }
        public string Cd { get; set; }
        public string Ci { get; set; }
        public string Password { get; set; }
        public string ConfirmPassword { get; set; }
    }
}