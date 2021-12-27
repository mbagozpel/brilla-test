using System.Text.Json;
using API.Entities;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace API.Data
{
    public class DataContext : IdentityDbContext<User>
    {
        public DataContext(DbContextOptions options) : base(options)
        {
        }

        // public DbSet<User> Users { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            // builder.Entity<User>().Property(p => p.Interests)
            //     .HasConversion(
            //         v => JsonSerializer.Serialize(v, (JsonSerializerOptions)default),
            //         v => JsonSerializer.Deserialize<List<string>>(v, (JsonSerializerOptions)default)
            //     );
        }
    }
}