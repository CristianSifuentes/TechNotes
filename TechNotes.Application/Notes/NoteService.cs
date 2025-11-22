using System;
using TechNotes.Domain.Notes;

namespace TechNotes.Application.Notes;

public class NoteService : INoteService
{
    public List<Note> GetAllNotes()
    {
return new List<Note>
    {
      new(){
        Id=1,
        Title="first note",
        Content="Content of our first note",
        IsPublished=true,
        PublishedAt=DateTime.UtcNow,
        CreatedAt =DateTime.UtcNow
      },
      new(){
        Id=2,
        Title="second note",
        Content="Content of our second note",
        IsPublished=false,
        PublishedAt=null,
        CreatedAt =DateTime.UtcNow
      },
    };    }
}
