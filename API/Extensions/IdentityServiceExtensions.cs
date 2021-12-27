using System.Text;
using API.Data;
using API.Entities;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;

namespace API.Extensions
{
    public static class IdentityServiceExtensions
    {
        public static IServiceCollection AddIdentityServices(this IServiceCollection services, IConfiguration config)
        {
            services.AddIdentityCore<User>(opt =>
                    {
                        opt.Password.RequireNonAlphanumeric = false;
                        opt.SignIn.RequireConfirmedAccount = true;
                    })
                    .AddSignInManager<SignInManager<User>>()
                    .AddEntityFrameworkStores<DataContext>();
                    
                    services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                        .AddJwtBearer(options =>
                        {
                            options.TokenValidationParameters = new TokenValidationParameters
                            {
                                ValidateIssuerSigningKey = true,
                                IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(config["TokenKey"])),
                                ValidateIssuer = false,
                                ValidateAudience = false

                            };
                        });
                        return services;
        }
    }
}