using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;
namespace Railway.Pages
{
    public class maneger_loginModel : PageModel
    {
        private readonly string _connectionString = "Data Source=DESKTOP-8f1CJGM;Initial Catalog=newRailWay2;Integrated Security=True"; // Replace with your actual connection string

        [BindProperty]
        public string Username { get; set; }

        [BindProperty]
        public string Password { get; set; }

        [TempData]
        public string ErrorMessage { get; set; }
        public void OnGet()
        {
        }
        public IActionResult OnPost()
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                connection.Open();

                string query = "SELECT * FROM StationManager WHERE userName = @Username AND password = @Password";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", Username);
                    command.Parameters.AddWithValue("@Password", Password);

                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            string userId = reader["id"].ToString(); // Replace 'UserId' with your column name
                            ViewData["Id"] = userId;

                            return RedirectToPage("/maneger_profile", new { id = userId });
                        }
                    }
                    else
                    {
                        ErrorMessage = "Invalid username or password";
                        return Page();
                    }
                }
            }

            ErrorMessage = ""; // Reset error message after unsuccessful login attempt
            return Page();
        }


    }

}