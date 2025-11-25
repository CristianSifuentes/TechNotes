using System;
using System.Threading.Tasks;
using TechNotes.Domain.Notes;

namespace TechNotes.Application.Notes;

public class NoteService : INoteService
{
  private readonly INoteRepository _noteRepository;

  public NoteService(INoteRepository noteRepository)
  {
    _noteRepository = noteRepository;
  }
  public async Task<List<Note>> GetAllNotesAsync()
  {
    return await _noteRepository.GetAllNotesAsync();
  }
}
