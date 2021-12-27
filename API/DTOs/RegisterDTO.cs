using System.ComponentModel.DataAnnotations;

namespace API.DTOs
{
    public class RegisterDTO
    {
        [Required]
        public string Email { get; set; }
        [Required]
        public string PhoneNumber { get; set; }
        [Required]
        public string Username { get; set; }
        public IEnumerable<string> Interests { get; set; }
        public IFormFile ImageFile { get; set; }
        public string ImageName { get; set; }

        [Required]
        [StringLength(20, MinimumLength =8)]
        public string Password {get; set;}
    }
}