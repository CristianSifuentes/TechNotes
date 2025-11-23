using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using TechNotes.Domain.Notes;
using TechNotes.Infrastructure.Repositories;

namespace TechNotes.Infrastructure;

public static class DepencyInjection
{
  public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configutarion)
  {
    services.AddDbContext<ApplicationDbContext>(options =>
      options.UseSqlServer(
        configutarion.GetConnectionString("DefaultConnection"),
        b => b.MigrationsAssembly("TechNotes.Infrastructure")
      )
    );
    services.AddScoped<INoteRepository, NoteRepository>();
    return services;
  }
}
