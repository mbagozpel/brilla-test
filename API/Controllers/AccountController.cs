using API.DTOs;
using API.Entities;
using API.Interfaces;
using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AccountController : ControllerBase
    {
        private readonly UserManager<User> _manager;
        private readonly SignInManager<User> _signInManager;
        private readonly ITokenService _tokenService;
         private readonly IMapper _mapper;
          private readonly IWebHostEnvironment _hostEnvironment;
        public AccountController(UserManager<User> manager, SignInManager<User> signInManager, 
       
       
            ITokenService tokenService, IMapper mapper, IWebHostEnvironment hostEnvironment)
        {
            _hostEnvironment = hostEnvironment;
            _mapper = mapper;
            _tokenService = tokenService;
            _signInManager = signInManager;
            _manager = manager;
        }

        [HttpPost("register")]

        public async Task<ActionResult<UserDTO>> Register(RegisterDTO registerDTO)
        {
            if (await UserExists(registerDTO.Email)) return BadRequest("Email is not available");
            registerDTO.ImageName = await SaveImage(registerDTO.ImageFile);
            var user = _mapper.Map<User>(registerDTO);

            var result = await _manager.CreateAsync(user, registerDTO.Password);

            if (!result.Succeeded) return BadRequest(result.Errors);

            return new UserDTO
            {
                Username = user.UserName,
                Token =  _tokenService.CreateToken(user),
                Email = user.Email,
                ImageSource = {}
            };
        }
        [HttpPost("login")]

        public async Task<ActionResult<UserDTO>> Login(LoginDTO loginDTO)
        {
            var user = await _manager.Users
                .SingleOrDefaultAsync(x => x.Email == loginDTO.EmailOrPhoneNumber);

                if (user == null) return Unauthorized("Invalid Email");

                var result = await _signInManager.CheckPasswordSignInAsync(user, loginDTO.Password, false);

                if (!result.Succeeded) return Unauthorized("Invalid Credentials");

                return new UserDTO
                {
                    Username = user.UserName,
                    Token =  _tokenService.CreateToken(user),
                    Email = user.Email,
                    ImageSource = string.Format("{0}://{1}{2}/Images/{3}", Request.Scheme, Request.Host, Request.PathBase, user.ImageName)
                };
        }

        [HttpPost("login")]

        public async Task<ActionResult<UserDTO>> LoginWithPhoneNumber(LoginDTO loginDTO)
        {
            var user = await _manager.Users
                .SingleOrDefaultAsync(x => x.PhoneNumber == loginDTO.EmailOrPhoneNumber);

                if (user == null) return Unauthorized("Invalid Email");

                var result = await _signInManager.CheckPasswordSignInAsync(user, loginDTO.Password, false);

                if (!result.Succeeded) return Unauthorized("Invalid Credentials");

                return new UserDTO
                {
                    Username = user.UserName,
                    Token =  _tokenService.CreateToken(user),
                    Email = user.Email,
                    ImageSource = string.Format("{0}://{1}{2}/Images/{3}", Request.Scheme, Request.Host, Request.PathBase, user.ImageName)
                };
        }

        private async Task<bool> UserExists(string email)
        {
            return await _manager.Users.AnyAsync(x => x.Email == email);
        }

        [NonAction]
        private async Task<string> SaveImage(IFormFile imageFile)
        {
            string imageName =new String(Path.GetFileNameWithoutExtension(imageFile.FileName).Take(10).ToArray()).Replace(' ', '-');
            imageName = imageName + DateTime.Now.ToString("yymmssfff") + Path.GetExtension(imageFile.FileName);
            var imagePath = Path.Combine(_hostEnvironment.ContentRootPath, "Images", imageName);
            using (var fileStream = new FileStream(imagePath, FileMode.Create))
            {
               await imageFile.CopyToAsync(fileStream);
            }
            return imageName;
        }
    }
}