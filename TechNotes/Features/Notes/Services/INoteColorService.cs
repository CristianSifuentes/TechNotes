using System;

namespace TechNotes.Features.Notes.Services;

public interface INoteColorService
{
  string GetNoteBackgroundColor(int noteId);
  string GetNoteBoderColor(int noteId);
  string GetNoteInlineStyle(int noteId);
}
