using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using TechNotes.Infrastructure.Users;


namespace TechNotes.Controllers;

[Route("account")]
public class AcoountController : Controller
{
  private readonly SignInManager<User> _signInManager;
  private readonly UserManager<User> _userManager;
  private readonly RoleManager<IdentityRole> _roleManager;

  public AcoountController(
    SignInManager<User> signInManager,
    UserManager<User> userManager,
    RoleManager<IdentityRole> roleManager)
  {
    _signInManager = signInManager;
    _userManager = userManager;
    _roleManager = roleManager;
  }

  [AllowAnonymous]
  [HttpPost("external-login")]
  public async Task<IActionResult> ExternalLogin(string provider)
  {
    var isProviderAvailable = (await _signInManager.GetExternalAuthenticationSchemesAsync())
      .Any(scheme => string.Equals(scheme.Name, provider, StringComparison.OrdinalIgnoreCase));

    if (!isProviderAvailable)
    {
      return RedirectWithError("Proveedor externo no disponible");
    }

    var redirectUrl = Url.Action(nameof(HandleExternalCallBack));
    var properties = _signInManager.ConfigureExternalAuthenticationProperties(provider, redirectUrl);
    return Challenge(properties, provider);
  }
  [AllowAnonymous]
  [HttpGet("external-callback")]
  public async Task<IActionResult> HandleExternalCallBack()
  {
    var info = await _signInManager.GetExternalLoginInfoAsync();
    if (info == null)
    {
      return RedirectWithError("Error obtiendo información de Google");
    }
    var result = await _signInManager.ExternalLoginSignInAsync(info.LoginProvider, info.ProviderKey, isPersistent: false);
    if (result.Succeeded)
    {
      return Redirect("/notes");
    }
    var email = info.Principal.FindFirstValue(ClaimTypes.Email);
    if (string.IsNullOrEmpty(email))
    {
      return RedirectWithError("No se obtuvo el email del usuario");
    }
    var user = await _userManager.FindByEmailAsync(email) ?? new User
    {
      UserName = email,
      Email = email,
      EmailConfirmed = true
    };
    await _userManager.CreateAsync(user);
    if (!await _roleManager.RoleExistsAsync("Reader"))
    {
      await _roleManager.CreateAsync(new IdentityRole("Reader"));
    }
    await _userManager.AddToRoleAsync(user, "Reader");
    await _userManager.AddLoginAsync(user, info);
    await _signInManager.SignInAsync(user, isPersistent: false);
    return Redirect("/notes");
  }
  [Authorize]
  [HttpPost("logout")]
  public async Task<IActionResult> Logout()
  {
    await _signInManager.SignOutAsync();
    return Redirect("/notes");
  }
  private IActionResult RedirectWithError(string message)
  {
    var encoded = Uri.EscapeDataString(message);
    return Redirect($"/register?error={encoded}");
  }
}
