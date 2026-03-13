using System.Net.Http.Json;
using TechNotes.Application.Notes;

namespace TechNotes.Client.Features.Notes;

public class NotesOverviewServiceClient : INotesOverviewService
{
  private readonly HttpClient _http;

  public NotesOverviewServiceClient(HttpClient http)
  {
    _http = http;
  }
  public async Task<List<NoteResponse>?> GetNoteByCurrentUserAsync()
  {
    return await _http.GetFromJsonAsync<List<NoteResponse>>("/api/notes");
  }

  public async Task<NoteResponse?> TogglePublishNoteAsync(int NoteId)
  {
    var result = await _http.PatchAsync($"api/notes/{NoteId}", null);
    if (result is not null && result.Content is not null)
    {
      return await result.Content.ReadFromJsonAsync<NoteResponse>();
    }
    return null;
  }
}
