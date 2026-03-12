using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.DependencyInjection;

namespace TechNotes.Infrastructure;

public static class IdentityRoleSeeder
{
  private static readonly string[] DefaultRoles = ["Admin", "Writer", "Reader"];

  public static async Task SeedDefaultRolesAsync(this IServiceProvider services)
  {
    using var scope = services.CreateScope();
    var roleManager = scope.ServiceProvider.GetRequiredService<RoleManager<IdentityRole>>();

    foreach (var roleName in DefaultRoles)
    {
      if (await roleManager.RoleExistsAsync(roleName))
      {
        continue;
      }

      var createResult = await roleManager.CreateAsync(new IdentityRole(roleName));
      if (!createResult.Succeeded)
      {
        var errors = string.Join(", ", createResult.Errors.Select(e => e.Description));
        throw new InvalidOperationException($"Could not create identity role '{roleName}': {errors}");
      }
    }
  }
}
