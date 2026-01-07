using System;
using MediatR;
using TechNotes.Domain.Notes;

namespace TechNotes.Application.Notes.DeleteNote;

public class DeleteNoteCommandeHandler : IRequestHandler<DeleteNoteCommand, bool>
{
  private readonly INoteRepository _noteRepository;
  public DeleteNoteCommandeHandler(INoteRepository noteRepository)
  {
    _noteRepository = noteRepository;
  }
  public async Task<bool> Handle(DeleteNoteCommand request, CancellationToken cancellationToken)
  {
    return await _noteRepository.DeleteNoteAsync(request.Id);
  }
}
