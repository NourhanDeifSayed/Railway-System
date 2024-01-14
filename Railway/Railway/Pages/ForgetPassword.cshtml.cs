using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;
namespace Railway.Pages
{
    public class ForgetPasswordModel : PageModel
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


                string sql = "UPDATE LogIn SET UserPassword = @password WHERE UserName = @userName;";

                using (SqlCommand command = new SqlCommand(sql, connection))
                {

                    command.Parameters.AddWithValue("@userName", empInfo.UserName);

                    // Assuming you have a property named 'Password' in your EMPInfo2 class
                    command.Parameters.AddWithValue("@password", empInfo.Password);

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

        [BindProperties(SupportsGet = true)]
        public class EMPInfo2
        {
            public int Id { get; set; }
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public string Email { get; set; }
            public string Password { get; set; }
            public string ConfirmPassword { get; set; }
            public string UserName { get; set; } // Added UserName property
        }
    }
}

