using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BL.Model
{
    public class ContactDetails
    {
        public int ClientContactID { get; set; }
        public string ContactType { get; set; }
        public string ContactInformation { get; set; }
        public int FK_ClientID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int FK_ContactTypeID { get; set; }
    }
}
