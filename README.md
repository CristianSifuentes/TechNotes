# TechNotes
This is a project for learn more about blazor 


https://medium.com/@DrunknCode/clean-architecture-simplified-and-in-depth-guide-026333c54454

## Commands

dotnet ef migrations add CreateTableNotes
dotnet tool update --global dotnet-ef
dotnet ef database update

## Recovery

  "ConnectionStrings": {
    "DefaultConnection":"Server=localhost;Database=TechNotesDb;User ID=SA;Password=MyStrongPass123;TrustServerCertificate=true;MultipleActiveResultSets=true"
  },