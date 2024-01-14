using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data;
using System.Data.SqlClient;

namespace Railway.Pages
{
    public class maneger_profileModel : PageModel
    {
        private readonly string _connectionString = "Data Source=DESKTOP-8F1CJGM;Initial Catalog=newRailWay2;Integrated Security=True"; // Replace with your actual connection string

        [BindProperty(SupportsGet = true)]
        //public string Id { get; set; } // The user's ID received as a query parameter

        // Properties to store user-specific data

        public string UserName { get; set; }
        [BindProperty(SupportsGet = true)]
        public string Email { get; set; }
        [BindProperty(SupportsGet = true)]
        public string PhoneNumber { get; set; }
        [BindProperty(SupportsGet = true)]
        public string PassID { get; set; }
        [BindProperty(SupportsGet = true)]
        public string role { get; set; }


        public IActionResult OnGet(int? id)
        {

            Console.WriteLine(ViewData["Id"]);

            if (id is null)
            {
                // Redirect to an error page or handle the scenario where Id is not provided
                return RedirectToPage("/Error");
            }

            try
            {
                using (SqlConnection connection = new SqlConnection(_connectionString))
                {
                    connection.Open();

                    string query = "SELECT id,  name, phone,role, email FROM StationManager WHERE id =@id"; // Replace with your table and columns

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@id", id);


                        DataTable dt = new DataTable();
                        dt.Load(command.ExecuteReader());
                        foreach (DataRow row in dt.Rows)
                        {
                            UserName = row["name"].ToString();
                            Email = row["email"].ToString();
                            PhoneNumber = row["phone"].ToString();
                            PassID = row["id"].ToString();
                            role = row["role"].ToString();

                        }

                    }
                }

                return Page(); // Return the profile page with retrieved data
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                // Log the exception for debugging purposes
                // You can handle the exception according to your application's needs
                // For example, displaying an error message on the page
                //return RedirectToPage("/Error");
                return Page();
            }
        }
    }
}
