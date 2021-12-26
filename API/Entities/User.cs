using Microsoft.AspNetCore.Identity;

namespace API.Entities
{
    public class User : IdentityUser
    {
       
        public IEnumerable<string> Interests { get; set; }
        public string ImageSource { get; set; }
        public string ImageName { get; set; }
        public IFormFile ImageFile { get; set; }

    }
}