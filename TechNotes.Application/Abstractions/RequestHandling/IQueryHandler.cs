using System;
using TechNotes.Domain.Abtractions;

namespace TechNotes.Application.Abstractions.RequestHandling;

public interface IQueryHandler<TQuery, TResponse> : IRequestHandler<TQuery, Result<TResponse>>
where TQuery : IQuery<TResponse>
{

}
