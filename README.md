
# cs-fullstack-clean-architecture

A **full‑stack, production‑grade .NET 8 course project** that walks step‑by‑step from fundamentals to advanced enterprise patterns, combining **Blazor**, **Clean Architecture**, **CQRS**, **Entity Framework Core**, **Identity**, **Tailwind CSS**, and **Cloud Deployment**.

This repository is designed both as a **learning path** and as a **real‑world reference implementation** for modern .NET applications.

---

## 📚 Table of Contents

1. [Introduction](#1-introduction)
2. [C# and .NET Fundamentals (Optional)](#2-c-and-net-fundamentals-optional)
3. [Project Creation](#3-project-creation)
4. [Clean Architecture](#4-clean-architecture)
5. [Infrastructure Layer: Database & Entity Framework Core](#5-infrastructure-layer-database--entity-framework-core)
6. [CQRS & Mediator Pattern](#6-cqrs--mediator-pattern)
7. [CRUD with CQRS and Blazor SSR](#7-crud-with-cqrs-and-blazor-ssr)
8. [Developer & User Experience Improvements](#8-developer--user-experience-improvements)
9. [Tailwind CSS & UI Enhancements](#9-tailwind-css--ui-enhancements)
10. [Authentication with ASP.NET Core Identity & Google](#10-authentication-with-aspnet-core-identity--google)
11. [Authorization with Roles](#11-authorization-with-roles)
12. [User Management with Blazor Server Interactivity](#12-user-management-with-blazor-server-interactivity)
13. [Notes Management with Blazor WebAssembly](#13-notes-management-with-blazor-webassembly)
14. [Replacing MediatR](#14-replacing-mediatr)
15. [Deployment to AWS](#15-deployment-to-aws)
16. [End of Course](#end-of-course)

---

## 1. Introduction

### Prerequisites & Tooling

You will need the following tools installed:

- **.NET SDK**
  - https://dotnet.microsoft.com/download
- **Docker**
  - https://www.docker.com/get-started/
- **Visual Studio Code**
  - https://code.visualstudio.com/
- **Git**
  - https://git-scm.com/
- **Microsoft SQL Server** (local via Docker or cloud)

### Recommended VS Code Extensions

- C# Dev Kit  
  https://marketplace.visualstudio.com/items?itemName=ms-dotnettools.csdevkit
- SQL Server (mssql)  
  https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql
- Tokyo Night Theme  
  https://marketplace.visualstudio.com/items?itemName=enkia.tokyo-night
- Better Dockerfile Syntax  
  https://marketplace.visualstudio.com/items?itemName=jeff-hykin.better-dockerfile-syntax

### Verify Installation

```bash
dotnet --version
dotnet --list-sdks
dotnet --list-runtimes
```

---

## 2. C# and .NET Fundamentals (Optional)

A fast‑track refresher for developers new to C# or .NET:

- Primitive and reference types
- Classes and interfaces
- Inheritance and polymorphism
- Adapter pattern
- Dependency Injection (DI)
- Asynchronous programming (`async` / `await`)
- Attributes (decorators)

---

## 3. Project Creation

- Create a new **Blazor .NET 8** project
- Explore the generated solution structure
- Separate UI logic from components for maintainability

> **Goal:** establish a clean, scalable baseline.

---

## 4. Clean Architecture

- Core principles of Clean Architecture
- Domain and Application layers
- Entities, interfaces, and business rules
- Dependency Injection configuration
- End‑to‑end data flow from domain to Blazor UI

---

## 5. Infrastructure Layer: Database & Entity Framework Core

- Introduction to Entity Framework Core
- Infrastructure layer implementation
- `ApplicationDbContext` configuration
- SQL Server Docker container for local development
- Connection strings and provider setup
- Base abstract entity with shared properties
- EF Core migrations and tooling
- `ApplicationDbContextFactory` for design‑time migrations
- Initial seed data and verification
- Repository implementation for Notes
- Displaying notes from the database

---

## 6. CQRS & Mediator Pattern

- What is CQRS and why it matters
- Relationship with the Mediator pattern
- Installing and configuring **MediatR**
- Implementing queries and handlers
- Replacing direct services with CQRS queries
- Using CQRS in Blazor components

---

## 7. CRUD with CQRS and Blazor SSR

- Static Server‑Side Rendering (SSR)
- Commands for creating notes
- DTO usage for clean responses
- Entity‑DTO mapping with **Mapster**
- Blazor form components
- Create, read, update note flows
- Feature‑based presentation structure
- Form refactoring and validation

📖 References:
- https://learn.microsoft.com/aspnet/core/blazor/forms
- https://learn.microsoft.com/aspnet/core/blazor/forms/input-components

---

## 8. Developer & User Experience Improvements

- `Result` and `Result<T>` pattern
- Implicit conversion operators
- Cleaner command/query responses
- Global `using` directives
- Refactoring internal logic for consistency

---

## 9. Tailwind CSS & UI Enhancements

- Tailwind CSS philosophy
- Tailwind + Blazor SSR integration
- Styling notes list
- Color‑coded note system
- Reusable design abstractions
- New layout with **HyperUI**
- Dynamic component modification via agent

---

## 10. Authentication with ASP.NET Core Identity & Google

- ASP.NET Core Identity setup
- User registration, login, logout
- Blazor authentication pages
- `AuthorizeView` usage
- Protecting sensitive routes
- Author ownership for notes

### Google Authentication

- Google Cloud Platform credentials
- External login configuration
- Custom Google login buttons

---

## 11. Authorization with Roles

- Role support in Identity
- Manual and automatic role assignment
- Role‑based UI behavior
- Secure CRUD operations
- `UserService` abstraction
- `HttpContextAccessor` usage
- Custom authorization exceptions

Roles include:
- **Admin**
- **Author**
- **Reader** (assigned for Google users)

---

## 12. User Management with Blazor Server Interactivity

- Interactive Blazor Server mode
- Admin‑only user management component
- CQRS query for users
- **QuickGrid** integration
- Role visualization and editing
- Modal dialogs for role management
- Task: role removal flow

---

## 13. Notes Management with Blazor WebAssembly

- Identity integration in existing projects
- Database migration for Identity
- Login and registration updates
- User listing refactor
- Functional testing and bug fixes

---

## 14. Replacing MediatR

- Why replace MediatR (cost, overhead, control)
- Custom request/handler interfaces
- Sender abstraction
- Custom Mediator implementation
- Full refactor away from MediatR

---

## 15. Deployment to AWS

- AWS RDS and Elastic Beanstalk overview
- RDS database creation
- Connection testing
- IAM credentials and permissions
- Elastic Beanstalk deployment
- Production validation

---

## End of Course

🎉 **Congratulations!**

You now have a **complete, cloud‑ready, enterprise‑grade .NET application**, covering:

- Clean Architecture
- CQRS
- Blazor SSR & WASM
- Authentication & Authorization
- Tailwind UI
- Cloud deployment

This repository can be used as:

- A learning reference
- A portfolio project
- A production starter template

---

**Happy coding 🚀**



<!-- # TechNotes
This is a project for learn more about blazor 


https://medium.com/@DrunknCode/clean-architecture-simplified-and-in-depth-guide-026333c54454

## Commands

dotnet ef migrations add CreateTableNotes
dotnet tool update --global dotnet-ef
dotnet ef database update

## Recovery

  "ConnectionStrings": {
    "DefaultConnection":"Server=localhost;Database=TechNotesDb;User ID=SA;Password=MyStrongPass123;TrustServerCertificate=true;MultipleActiveResultSets=true"
  }, -->