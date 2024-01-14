using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;

namespace Railway.Pages
{


    public class discoverModel : PageModel
    {
        public Models.Booking temp { get; set; }
        public List<Models.Booking> Bookinglist { get; set; }
        public void OnGet()
        {
            string ConString = "Data Source=DESKTOP-8f1CJGM;Initial Catalog=newRailWay2;Integrated Security=True";
            SqlConnection con = new SqlConnection(ConString);

            string querystring = "SELECT TOP 13 * FROM Booking ";
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(querystring, con);
                SqlDataReader reader = cmd.ExecuteReader();
                Bookinglist = new List<Models.Booking>();

                while (reader.Read())
                {
                    Models.Booking temp = new Models.Booking();

                    temp.BookingId = int.Parse(reader[0].ToString());
                    string dateString = reader[1].ToString();
                    DateTime bookingDate;

                    if (DateTime.TryParse(dateString, out bookingDate))
                    {
                        temp.BookingDate = bookingDate;
                    }
                    else
                    {
                        // Handle the case where the conversion fails, e.g., set a default date
                        temp.BookingDate = DateTime.MinValue;
                    }

                    temp.DepartureCity = reader[8].ToString();
                    temp.ArrivalCity = reader[9].ToString();
                    Bookinglist.Add(temp);
                }

            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                con.Close();

            }

        }
    }
}