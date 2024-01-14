// report_lost_foundModel.cshtml.cs
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;
using System.Data.SqlClient;

namespace Railway.Pages
{
    public class report_lost_foundModel : PageModel
    {
        public string Message = "Error Happened";
        [BindProperty(SupportsGet = true)]

        public lost found { get; set; }

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

                string sql = "INSERT INTO LostFound (Description, LostLocation) " +
                             "VALUES (@description, @location); ";

                using (SqlCommand command = new SqlCommand(sql, connection))
                {

                    command.Parameters.AddWithValue("@location", found.location);
                    command.Parameters.AddWithValue("@description", found.desription);





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
        public class lost
        {
            public string name { get; set; }

            public string location { get; set; }
            public string desription { get; set; }
            public string id { get; set; }


        }
    }
}