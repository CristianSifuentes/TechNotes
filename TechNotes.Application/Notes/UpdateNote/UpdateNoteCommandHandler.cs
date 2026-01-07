using Mapster;
using MediatR;
using TechNotes.Domain.Notes;

namespace TechNotes.Application.Notes.UpdateNote;

public class UpdateNoteCommandHandler : IRequestHandler<UpdateNoteCommand, NoteResponse?>
{
  private readonly INoteRepository _noteRepository;

  public UpdateNoteCommandHandler(INoteRepository noteRepository)
  {
    _noteRepository = noteRepository;
  }
  public async Task<NoteResponse?> Handle(UpdateNoteCommand request, CancellationToken cancellationToken)
  {
    var noteToUpdate = request.Adapt<Note>();
    var updatedNote = await _noteRepository.UpdateNoteAsync(noteToUpdate);
    if (updatedNote is null)
    {
      return null;
    }
    return updatedNote.Adapt<NoteResponse>();
  }
}
