using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace API.DTOs
{
    public class LoginDTO
    {
        public string Password { get; set; }
        public string EmailOrPhoneNumber{ get; set; }
    }
}