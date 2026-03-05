using System;
using MediatR;
using TechNotes.Domain.Abtractions;

namespace TechNotes.Application.Abstractions.RequestHandling;

public interface IQuery<IResponse> : IRequest<Result<IResponse>>
{

}
