/*
  TechNotes - Identity Dummy Data + Full User Profile Query
  SQL Server script
  Safe to run multiple times (idempotent inserts/upserts).
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET ARITHABORT ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET NUMERIC_ROUNDABORT OFF;

BEGIN TRANSACTION;

/* --------------------------------------------------------------------------
   1) Roles
-------------------------------------------------------------------------- */
DECLARE @RoleAdminId  NVARCHAR(450) = ISNULL((SELECT TOP(1) Id FROM dbo.AspNetRoles WHERE NormalizedName = N'ADMIN'),  N'8f1e8d6d-8db5-4e02-9a31-001-role-admin');
DECLARE @RoleWriterId NVARCHAR(450) = ISNULL((SELECT TOP(1) Id FROM dbo.AspNetRoles WHERE NormalizedName = N'WRITER'), N'8f1e8d6d-8db5-4e02-9a31-002-role-writer');
DECLARE @RoleReaderId NVARCHAR(450) = ISNULL((SELECT TOP(1) Id FROM dbo.AspNetRoles WHERE NormalizedName = N'READER'), N'8f1e8d6d-8db5-4e02-9a31-003-role-reader');

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetRoles WHERE NormalizedName = N'ADMIN')
BEGIN
  INSERT INTO dbo.AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
  VALUES (@RoleAdminId, N'Admin', N'ADMIN', CONVERT(NVARCHAR(36), NEWID()));
END;

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetRoles WHERE NormalizedName = N'WRITER')
BEGIN
  INSERT INTO dbo.AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
  VALUES (@RoleWriterId, N'Writer', N'WRITER', CONVERT(NVARCHAR(36), NEWID()));
END;

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetRoles WHERE NormalizedName = N'READER')
BEGIN
  INSERT INTO dbo.AspNetRoles (Id, Name, NormalizedName, ConcurrencyStamp)
  VALUES (@RoleReaderId, N'Reader', N'READER', CONVERT(NVARCHAR(36), NEWID()));
END;

/* --------------------------------------------------------------------------
   2) Users (dummy)
-------------------------------------------------------------------------- */
DECLARE @TemplatePasswordHash NVARCHAR(MAX) =
(
  SELECT TOP(1) [PasswordHash]
  FROM dbo.AspNetUsers
  WHERE [PasswordHash] IS NOT NULL
);

DECLARE @UserAdminId   NVARCHAR(450) = ISNULL((SELECT TOP(1) Id FROM dbo.AspNetUsers WHERE NormalizedUserName = N'ADMIN.ALPHA'),    N'7c3c9c13-ff26-44bf-a4a4-001-user-admin');
DECLARE @UserWriterId  NVARCHAR(450) = ISNULL((SELECT TOP(1) Id FROM dbo.AspNetUsers WHERE NormalizedUserName = N'WRITER.BRAVO'),   N'7c3c9c13-ff26-44bf-a4a4-002-user-writer');
DECLARE @UserReaderId  NVARCHAR(450) = ISNULL((SELECT TOP(1) Id FROM dbo.AspNetUsers WHERE NormalizedUserName = N'READER.CHARLIE'), N'7c3c9c13-ff26-44bf-a4a4-003-user-reader');
DECLARE @UserHybridId  NVARCHAR(450) = ISNULL((SELECT TOP(1) Id FROM dbo.AspNetUsers WHERE NormalizedUserName = N'HYBRID.DELTA'),   N'7c3c9c13-ff26-44bf-a4a4-004-user-hybrid');

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetUsers WHERE NormalizedUserName = N'ADMIN.ALPHA')
BEGIN
  INSERT INTO dbo.AspNetUsers
  (
    Id, AccessFailedCount, ConcurrencyStamp, Email, EmailConfirmed, LockoutEnabled, LockoutEnd,
    NormalizedEmail, NormalizedUserName, PasswordHash, PhoneNumber, PhoneNumberConfirmed,
    SecurityStamp, TwoFactorEnabled, UserName
  )
  VALUES
  (
    @UserAdminId, 0, CONVERT(NVARCHAR(36), NEWID()), N'admin.alpha@technotes.local', 1, 1, NULL,
    N'ADMIN.ALPHA@TECHNOTES.LOCAL', N'ADMIN.ALPHA', @TemplatePasswordHash, N'+15550000001', 0,
    CONVERT(NVARCHAR(36), NEWID()), 0, N'admin.alpha'
  );
END;

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetUsers WHERE NormalizedUserName = N'WRITER.BRAVO')
BEGIN
  INSERT INTO dbo.AspNetUsers
  (
    Id, AccessFailedCount, ConcurrencyStamp, Email, EmailConfirmed, LockoutEnabled, LockoutEnd,
    NormalizedEmail, NormalizedUserName, PasswordHash, PhoneNumber, PhoneNumberConfirmed,
    SecurityStamp, TwoFactorEnabled, UserName
  )
  VALUES
  (
    @UserWriterId, 0, CONVERT(NVARCHAR(36), NEWID()), N'writer.bravo@technotes.local', 1, 1, NULL,
    N'WRITER.BRAVO@TECHNOTES.LOCAL', N'WRITER.BRAVO', @TemplatePasswordHash, N'+15550000002', 0,
    CONVERT(NVARCHAR(36), NEWID()), 0, N'writer.bravo'
  );
END;

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetUsers WHERE NormalizedUserName = N'READER.CHARLIE')
BEGIN
  INSERT INTO dbo.AspNetUsers
  (
    Id, AccessFailedCount, ConcurrencyStamp, Email, EmailConfirmed, LockoutEnabled, LockoutEnd,
    NormalizedEmail, NormalizedUserName, PasswordHash, PhoneNumber, PhoneNumberConfirmed,
    SecurityStamp, TwoFactorEnabled, UserName
  )
  VALUES
  (
    @UserReaderId, 0, CONVERT(NVARCHAR(36), NEWID()), N'reader.charlie@technotes.local', 1, 1, NULL,
    N'READER.CHARLIE@TECHNOTES.LOCAL', N'READER.CHARLIE', @TemplatePasswordHash, N'+15550000003', 0,
    CONVERT(NVARCHAR(36), NEWID()), 0, N'reader.charlie'
  );
END;

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetUsers WHERE NormalizedUserName = N'HYBRID.DELTA')
BEGIN
  INSERT INTO dbo.AspNetUsers
  (
    Id, AccessFailedCount, ConcurrencyStamp, Email, EmailConfirmed, LockoutEnabled, LockoutEnd,
    NormalizedEmail, NormalizedUserName, PasswordHash, PhoneNumber, PhoneNumberConfirmed,
    SecurityStamp, TwoFactorEnabled, UserName
  )
  VALUES
  (
    @UserHybridId, 0, CONVERT(NVARCHAR(36), NEWID()), N'hybrid.delta@technotes.local', 1, 1, NULL,
    N'HYBRID.DELTA@TECHNOTES.LOCAL', N'HYBRID.DELTA', @TemplatePasswordHash, N'+15550000004', 0,
    CONVERT(NVARCHAR(36), NEWID()), 0, N'hybrid.delta'
  );
END;

/* --------------------------------------------------------------------------
   3) User roles
-------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM dbo.AspNetUserRoles WHERE UserId = @UserAdminId AND RoleId = @RoleAdminId)
  INSERT INTO dbo.AspNetUserRoles (UserId, RoleId) VALUES (@UserAdminId, @RoleAdminId);

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetUserRoles WHERE UserId = @UserAdminId AND RoleId = @RoleWriterId)
  INSERT INTO dbo.AspNetUserRoles (UserId, RoleId) VALUES (@UserAdminId, @RoleWriterId);

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetUserRoles WHERE UserId = @UserWriterId AND RoleId = @RoleWriterId)
  INSERT INTO dbo.AspNetUserRoles (UserId, RoleId) VALUES (@UserWriterId, @RoleWriterId);

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetUserRoles WHERE UserId = @UserReaderId AND RoleId = @RoleReaderId)
  INSERT INTO dbo.AspNetUserRoles (UserId, RoleId) VALUES (@UserReaderId, @RoleReaderId);

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetUserRoles WHERE UserId = @UserHybridId AND RoleId = @RoleReaderId)
  INSERT INTO dbo.AspNetUserRoles (UserId, RoleId) VALUES (@UserHybridId, @RoleReaderId);

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetUserRoles WHERE UserId = @UserHybridId AND RoleId = @RoleWriterId)
  INSERT INTO dbo.AspNetUserRoles (UserId, RoleId) VALUES (@UserHybridId, @RoleWriterId);

/* --------------------------------------------------------------------------
   4) User claims
-------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM dbo.AspNetUserClaims WHERE UserId = @UserAdminId AND ClaimType = N'department' AND ClaimValue = N'Platform')
  INSERT INTO dbo.AspNetUserClaims (UserId, ClaimType, ClaimValue) VALUES (@UserAdminId, N'department', N'Platform');

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetUserClaims WHERE UserId = @UserWriterId AND ClaimType = N'department' AND ClaimValue = N'Content')
  INSERT INTO dbo.AspNetUserClaims (UserId, ClaimType, ClaimValue) VALUES (@UserWriterId, N'department', N'Content');

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetUserClaims WHERE UserId = @UserReaderId AND ClaimType = N'locale' AND ClaimValue = N'es-MX')
  INSERT INTO dbo.AspNetUserClaims (UserId, ClaimType, ClaimValue) VALUES (@UserReaderId, N'locale', N'es-MX');

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetUserClaims WHERE UserId = @UserHybridId AND ClaimType = N'timezone' AND ClaimValue = N'America/Mexico_City')
  INSERT INTO dbo.AspNetUserClaims (UserId, ClaimType, ClaimValue) VALUES (@UserHybridId, N'timezone', N'America/Mexico_City');

/* --------------------------------------------------------------------------
   5) Role claims
-------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM dbo.AspNetRoleClaims WHERE RoleId = @RoleAdminId AND ClaimType = N'permission' AND ClaimValue = N'manage_users')
  INSERT INTO dbo.AspNetRoleClaims (RoleId, ClaimType, ClaimValue) VALUES (@RoleAdminId, N'permission', N'manage_users');

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetRoleClaims WHERE RoleId = @RoleWriterId AND ClaimType = N'permission' AND ClaimValue = N'create_note')
  INSERT INTO dbo.AspNetRoleClaims (RoleId, ClaimType, ClaimValue) VALUES (@RoleWriterId, N'permission', N'create_note');

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetRoleClaims WHERE RoleId = @RoleWriterId AND ClaimType = N'permission' AND ClaimValue = N'edit_own_note')
  INSERT INTO dbo.AspNetRoleClaims (RoleId, ClaimType, ClaimValue) VALUES (@RoleWriterId, N'permission', N'edit_own_note');

IF NOT EXISTS (SELECT 1 FROM dbo.AspNetRoleClaims WHERE RoleId = @RoleReaderId AND ClaimType = N'permission' AND ClaimValue = N'read_note')
  INSERT INTO dbo.AspNetRoleClaims (RoleId, ClaimType, ClaimValue) VALUES (@RoleReaderId, N'permission', N'read_note');

/* --------------------------------------------------------------------------
   6) External logins (dummy)
-------------------------------------------------------------------------- */
MERGE dbo.AspNetUserLogins AS target
USING
(
  VALUES
    (N'Google', N'google-admin-alpha', N'Google', @UserAdminId),
    (N'Google', N'google-reader-charlie', N'Google', @UserReaderId),
    (N'GitHub', N'github-writer-bravo', N'GitHub', @UserWriterId)
) AS source (LoginProvider, ProviderKey, ProviderDisplayName, UserId)
ON target.LoginProvider = source.LoginProvider
AND target.ProviderKey = source.ProviderKey
WHEN MATCHED THEN
  UPDATE SET target.ProviderDisplayName = source.ProviderDisplayName, target.UserId = source.UserId
WHEN NOT MATCHED THEN
  INSERT (LoginProvider, ProviderKey, ProviderDisplayName, UserId)
  VALUES (source.LoginProvider, source.ProviderKey, source.ProviderDisplayName, source.UserId);

/* --------------------------------------------------------------------------
   7) User tokens (dummy)
-------------------------------------------------------------------------- */
MERGE dbo.AspNetUserTokens AS target
USING
(
  VALUES
    (@UserAdminId,  N'Google', N'refresh_token', N'dummy-refresh-admin-alpha'),
    (@UserWriterId, N'GitHub', N'access_token',  N'dummy-access-writer-bravo'),
    (@UserReaderId, N'Google', N'access_token',  N'dummy-access-reader-charlie')
) AS source (UserId, LoginProvider, [Name], [Value])
ON target.UserId = source.UserId
AND target.LoginProvider = source.LoginProvider
AND target.[Name] = source.[Name]
WHEN MATCHED THEN
  UPDATE SET target.[Value] = source.[Value]
WHEN NOT MATCHED THEN
  INSERT (UserId, LoginProvider, [Name], [Value])
  VALUES (source.UserId, source.LoginProvider, source.[Name], source.[Value]);

COMMIT TRANSACTION;

PRINT 'Dummy Identity data seeded/updated successfully.';

/* ==========================================================================
   FULL USER PROFILE QUERY (single-row, all details as JSON columns)
   Replace @UserId with the user you want to inspect.
========================================================================== */
DECLARE @UserId NVARCHAR(450) = N'7c3c9c13-ff26-44bf-a4a4-001-user-admin';

SELECT
  u.Id,
  u.UserName,
  u.NormalizedUserName,
  u.Email,
  u.NormalizedEmail,
  u.EmailConfirmed,
  u.PhoneNumber,
  u.PhoneNumberConfirmed,
  u.TwoFactorEnabled,
  u.LockoutEnabled,
  u.LockoutEnd,
  u.AccessFailedCount,
  ISNULL(rs.RoleList, N'') AS RolesCsv,
  ISNULL(rj.RolesJson, N'[]') AS RolesJson,
  ISNULL(ucj.UserClaimsJson, N'[]') AS UserClaimsJson,
  ISNULL(ulj.UserLoginsJson, N'[]') AS UserLoginsJson,
  ISNULL(utj.UserTokensJson, N'[]') AS UserTokensJson,
  ISNULL(rcj.RoleClaimsJson, N'[]') AS RoleClaimsJson
FROM dbo.AspNetUsers AS u
OUTER APPLY
(
  SELECT STRING_AGG(r.Name, N', ') WITHIN GROUP (ORDER BY r.Name) AS RoleList
  FROM dbo.AspNetUserRoles ur
  INNER JOIN dbo.AspNetRoles r ON r.Id = ur.RoleId
  WHERE ur.UserId = u.Id
) AS rs
OUTER APPLY
(
  SELECT r.Id, r.Name, r.NormalizedName
  FROM dbo.AspNetUserRoles ur
  INNER JOIN dbo.AspNetRoles r ON r.Id = ur.RoleId
  WHERE ur.UserId = u.Id
  ORDER BY r.Name
  FOR JSON PATH
) AS rj(RolesJson)
OUTER APPLY
(
  SELECT uc.Id, uc.ClaimType, uc.ClaimValue
  FROM dbo.AspNetUserClaims uc
  WHERE uc.UserId = u.Id
  ORDER BY uc.Id
  FOR JSON PATH
) AS ucj(UserClaimsJson)
OUTER APPLY
(
  SELECT ul.LoginProvider, ul.ProviderKey, ul.ProviderDisplayName
  FROM dbo.AspNetUserLogins ul
  WHERE ul.UserId = u.Id
  ORDER BY ul.LoginProvider, ul.ProviderKey
  FOR JSON PATH
) AS ulj(UserLoginsJson)
OUTER APPLY
(
  SELECT ut.LoginProvider, ut.[Name], ut.[Value]
  FROM dbo.AspNetUserTokens ut
  WHERE ut.UserId = u.Id
  ORDER BY ut.LoginProvider, ut.[Name]
  FOR JSON PATH
) AS utj(UserTokensJson)
OUTER APPLY
(
  SELECT DISTINCT
    rc.Id,
    r.Name AS RoleName,
    rc.ClaimType,
    rc.ClaimValue
  FROM dbo.AspNetUserRoles ur
  INNER JOIN dbo.AspNetRoles r ON r.Id = ur.RoleId
  INNER JOIN dbo.AspNetRoleClaims rc ON rc.RoleId = r.Id
  WHERE ur.UserId = u.Id
  ORDER BY r.Name, rc.Id
  FOR JSON PATH
) AS rcj(RoleClaimsJson)
WHERE u.Id = @UserId;
