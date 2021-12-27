using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.AspNetCore.Identity;

namespace API.Entities
{
    public class User : IdentityUser
    {
       
        public string[] Interests { get; set; }
       
        public string ImageName { get; set; }
       

    }
}