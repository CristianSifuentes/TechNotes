namespace TechNotes.Application.Notes;

public interface INotesOverviewService
{
  Task<NoteResponse?> TogglePublishNoteAsync(int NoteId);
  Task<List<NoteResponse>?> GetNoteByCurrentUserAsync();
}
