using MediatR;
using TechNotes.Domain.Abtractions;

namespace TechNotes.Application.Abstractions.RequestHandling;

public interface ICommand : IRequest<Result>
{

}
public interface ICommand<TResponse> : IRequest<Result<TResponse>>
{

}

