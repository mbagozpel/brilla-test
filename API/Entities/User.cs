using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.Entities
{
    public class User
    {
        public string Id { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string Username { get; set; }
        public IEnumerable<string> Interests { get; set; }
        public string ImageSource { get; set; }
        public string ImageName { get; set; }
        public IFormFile ImageFile { get; set; }

    }
}