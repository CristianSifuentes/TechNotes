using System;
using Microsoft.AspNetCore.Identity;
using TechNotes.Application.Authentication;
using TechNotes.Infrastructure.Users;

namespace TechNotes.Infrastructure.Authentication;

public class AuthenticationService : IAuthenticationService
{
  private readonly SignInManager<User> _signInManager;
  private readonly UserManager<User> _userManager;
  private readonly RoleManager<IdentityRole> _roleManager;

  public AuthenticationService(
    SignInManager<User> signInManager,
    UserManager<User> userManager,
    RoleManager<IdentityRole> roleManager)
  {
    _signInManager = signInManager;
    _userManager = userManager;
    _roleManager = roleManager;
  }
  public async Task<bool> LoginUserAsync(string userName, string password)
  {
    var result = await _signInManager.PasswordSignInAsync(userName, password, isPersistent: false, lockoutOnFailure: false);
    return result.Succeeded;
  }

  public async Task<RegisterUserResponse> RegisterUserAsync(string userName, string email, string password)
  {
    var user = new User
    {
      UserName = userName,
      Email = email,
      EmailConfirmed = true
    };
    var result = await _userManager.CreateAsync(user, password);
    if (result.Succeeded)
    {
      if (!await _roleManager.RoleExistsAsync("Reader"))
      {
        await _roleManager.CreateAsync(new IdentityRole("Reader"));
      }
      await _userManager.AddToRoleAsync(user, "Reader");
    }
    return new RegisterUserResponse
    {
      Succeeded = result.Succeeded,
      Errors = result.Errors.Select(e => e.Description).ToList()
    };
  }
}
