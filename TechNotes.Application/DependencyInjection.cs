using System;
using Microsoft.Extensions.DependencyInjection;
using TechNotes.Application.Notes;

namespace TechNotes.Application;

// a static class to register dependencies
// static is used to avoid instantiation
// extension methods are used to add methods to existing types
// without modifying the original type
// this class will contain extension methods for IServiceCollection
// to register application services
// this class will be used in Program.cs to register services
// in the DI container
public static class DependencyInjection
{
  public static IServiceCollection AddApplication(this IServiceCollection services)
  {
    services.AddMediatR(configuration =>
    {
      configuration.RegisterServicesFromAssembly(typeof(DependencyInjection).Assembly);
    });
    // services.AddScoped<INoteService, NoteService>();
    return services;
  }

}
