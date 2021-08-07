using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace BL.API
{
    public class ApiRepository
    {
        public HttpClient client { get; set; }
        public ApiRepository()
        {
            client = new HttpClient();
            client.BaseAddress = new Uri(ConfigurationManager.AppSettings["ApiUrl"].ToString());
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
        }
        public HttpResponseMessage GetList(string url)
        {
            return client.GetAsync(url).Result;
        }
        public HttpResponseMessage Add(string url, object model)
        {
            return client.PostAsJsonAsync(url, model).Result;
        }
        public HttpResponseMessage Update(string url, object model)
        {
            return client.PutAsJsonAsync(url, model).Result;
        }
        public HttpResponseMessage Delete(string url)
        {
            return client.DeleteAsync(url).Result;
        }
    }
}
