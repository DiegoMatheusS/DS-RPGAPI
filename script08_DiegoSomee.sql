IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [TB_PERSONAGENS] (
    [Id] int NOT NULL IDENTITY,
    [Nome] varchar(200) NOT NULL,
    [PontosVida] int NOT NULL,
    [Forca] int NOT NULL,
    [Defesa] int NOT NULL,
    [Inteligencia] int NOT NULL,
    [Classe] int NOT NULL,
    CONSTRAINT [PK_TB_PERSONAGENS] PRIMARY KEY ([Id])
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Classe', N'Defesa', N'Forca', N'Inteligencia', N'Nome', N'PontosVida') AND [object_id] = OBJECT_ID(N'[TB_PERSONAGENS]'))
    SET IDENTITY_INSERT [TB_PERSONAGENS] ON;
INSERT INTO [TB_PERSONAGENS] ([Id], [Classe], [Defesa], [Forca], [Inteligencia], [Nome], [PontosVida])
VALUES (1, 1, 23, 17, 33, 'Frodo', 100),
(2, 1, 25, 15, 30, 'Sam', 100),
(3, 3, 21, 18, 35, 'Galadriel', 100),
(4, 2, 18, 18, 37, 'Gandalf', 100),
(5, 1, 17, 20, 31, 'Hobbit', 100),
(6, 3, 13, 21, 34, 'Celeborn', 100),
(7, 2, 11, 25, 35, 'Radagast', 100);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Classe', N'Defesa', N'Forca', N'Inteligencia', N'Nome', N'PontosVida') AND [object_id] = OBJECT_ID(N'[TB_PERSONAGENS]'))
    SET IDENTITY_INSERT [TB_PERSONAGENS] OFF;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20240327010236_InitialCreate', N'8.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[TB_PERSONAGENS]') AND [c].[name] = N'Nome');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [TB_PERSONAGENS] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [TB_PERSONAGENS] ALTER COLUMN [Nome] Varchar(200) NOT NULL;
GO

CREATE TABLE [TB_ARMAS] (
    [Id] int NOT NULL IDENTITY,
    [Nome] Varchar(200) NOT NULL,
    [Dano] int NOT NULL,
    CONSTRAINT [PK_TB_ARMAS] PRIMARY KEY ([Id])
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Dano', N'Nome') AND [object_id] = OBJECT_ID(N'[TB_ARMAS]'))
    SET IDENTITY_INSERT [TB_ARMAS] ON;
INSERT INTO [TB_ARMAS] ([Id], [Dano], [Nome])
VALUES (1, 10, 'Sword'),
(2, 12, 'Axe'),
(3, 20, 'SwordFire'),
(4, 15, 'Cajado'),
(5, 55, 'Spear'),
(6, 30, 'CajadoDeath'),
(7, 100, 'Guns');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Dano', N'Nome') AND [object_id] = OBJECT_ID(N'[TB_ARMAS]'))
    SET IDENTITY_INSERT [TB_ARMAS] OFF;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20240409234114_MigracaoArma', N'8.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [TB_PERSONAGENS] ADD [FotoPersonagem] varbinary(max) NULL;
GO

ALTER TABLE [TB_PERSONAGENS] ADD [UsuarioId] int NULL;
GO

CREATE TABLE [TB_USUARIOS] (
    [Id] int NOT NULL IDENTITY,
    [Username] Varchar(200) NOT NULL,
    [PasswordHash] varbinary(max) NULL,
    [PasswordSalt] varbinary(max) NULL,
    [Foto] varbinary(max) NULL,
    [Latitude] float NULL,
    [Longitude] float NULL,
    [DataAcesso] datetime2 NULL,
    [Perfil] Varchar(200) NOT NULL DEFAULT 'Jogador',
    [Email] Varchar(200) NOT NULL,
    CONSTRAINT [PK_TB_USUARIOS] PRIMARY KEY ([Id])
);
GO

UPDATE [TB_PERSONAGENS] SET [FotoPersonagem] = NULL, [UsuarioId] = 1
WHERE [Id] = 1;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_PERSONAGENS] SET [FotoPersonagem] = NULL, [UsuarioId] = 1
WHERE [Id] = 2;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_PERSONAGENS] SET [FotoPersonagem] = NULL, [UsuarioId] = 1
WHERE [Id] = 3;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_PERSONAGENS] SET [FotoPersonagem] = NULL, [UsuarioId] = 1
WHERE [Id] = 4;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_PERSONAGENS] SET [FotoPersonagem] = NULL, [UsuarioId] = 1
WHERE [Id] = 5;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_PERSONAGENS] SET [FotoPersonagem] = NULL, [UsuarioId] = 1
WHERE [Id] = 6;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_PERSONAGENS] SET [FotoPersonagem] = NULL, [UsuarioId] = 1
WHERE [Id] = 7;
SELECT @@ROWCOUNT;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'DataAcesso', N'Email', N'Foto', N'Latitude', N'Longitude', N'PasswordHash', N'PasswordSalt', N'Perfil', N'Username') AND [object_id] = OBJECT_ID(N'[TB_USUARIOS]'))
    SET IDENTITY_INSERT [TB_USUARIOS] ON;
INSERT INTO [TB_USUARIOS] ([Id], [DataAcesso], [Email], [Foto], [Latitude], [Longitude], [PasswordHash], [PasswordSalt], [Perfil], [Username])
VALUES (1, NULL, 'seuEmail@gamil.com', NULL, -23.520024100000001E0, -46.596497999999997E0, 0x103836457E3080AF0181E855D099E7E5356744E3ACD02AD75B934A861807395409D13680F9EB3745351615557E15B637535CEA8E1D9E815FE4E7CABE862F50FC2F34E4F740048AA37B90D368AEDC5C84A5D3E13801144C2D28B20F669D9C337857908D8CCC8C461AEE21E002A2E1FC37FE79C486AD2BFD134A1B99E50FAFC086, NULL, 'Admin', 'UsuarioAdmin');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'DataAcesso', N'Email', N'Foto', N'Latitude', N'Longitude', N'PasswordHash', N'PasswordSalt', N'Perfil', N'Username') AND [object_id] = OBJECT_ID(N'[TB_USUARIOS]'))
    SET IDENTITY_INSERT [TB_USUARIOS] OFF;
GO

CREATE INDEX [IX_TB_PERSONAGENS_UsuarioId] ON [TB_PERSONAGENS] ([UsuarioId]);
GO

ALTER TABLE [TB_PERSONAGENS] ADD CONSTRAINT [FK_TB_PERSONAGENS_TB_USUARIOS_UsuarioId] FOREIGN KEY ([UsuarioId]) REFERENCES [TB_USUARIOS] ([Id]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20240416233823_MigracaoUsuario', N'8.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [TB_PERSONAGENS] ADD [Derrotas] int NOT NULL DEFAULT 0;
GO

ALTER TABLE [TB_PERSONAGENS] ADD [Disputas] int NOT NULL DEFAULT 0;
GO

ALTER TABLE [TB_PERSONAGENS] ADD [Vitoris] int NOT NULL DEFAULT 0;
GO

ALTER TABLE [TB_ARMAS] ADD [PersonagemId] int NOT NULL DEFAULT 0;
GO

UPDATE [TB_ARMAS] SET [PersonagemId] = 1
WHERE [Id] = 1;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_ARMAS] SET [PersonagemId] = 2
WHERE [Id] = 2;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_ARMAS] SET [PersonagemId] = 3
WHERE [Id] = 3;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_ARMAS] SET [PersonagemId] = 4
WHERE [Id] = 4;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_ARMAS] SET [PersonagemId] = 5
WHERE [Id] = 5;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_ARMAS] SET [PersonagemId] = 6
WHERE [Id] = 6;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_ARMAS] SET [PersonagemId] = 7
WHERE [Id] = 7;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_PERSONAGENS] SET [Derrotas] = 0, [Disputas] = 0, [Vitoris] = 0
WHERE [Id] = 1;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_PERSONAGENS] SET [Derrotas] = 0, [Disputas] = 0, [Vitoris] = 0
WHERE [Id] = 2;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_PERSONAGENS] SET [Derrotas] = 0, [Disputas] = 0, [Vitoris] = 0
WHERE [Id] = 3;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_PERSONAGENS] SET [Derrotas] = 0, [Disputas] = 0, [Vitoris] = 0
WHERE [Id] = 4;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_PERSONAGENS] SET [Derrotas] = 0, [Disputas] = 0, [Vitoris] = 0
WHERE [Id] = 5;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_PERSONAGENS] SET [Derrotas] = 0, [Disputas] = 0, [Vitoris] = 0
WHERE [Id] = 6;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_PERSONAGENS] SET [Derrotas] = 0, [Disputas] = 0, [Vitoris] = 0
WHERE [Id] = 7;
SELECT @@ROWCOUNT;

GO

UPDATE [TB_USUARIOS] SET [PasswordHash] = 0xD07AE1B93ED3F72EA1C30EF839846FD8FBDFDE4BBBC416F9856B8E14B1FB9770BEB5766A78060C41B2FD9588CF5C2CAC0E34A3E1AC6BF8E061CD2D90616DC039CA637BB7589974812BA3812AAF6184373212E9A931BD354B125B3533B11C0E9D6FD8B77C19A13AA26C4FEE40C58D18727C8443D50794AF8E35EFD3EA1347468C
WHERE [Id] = 1;
SELECT @@ROWCOUNT;

GO

CREATE UNIQUE INDEX [IX_TB_ARMAS_PersonagemId] ON [TB_ARMAS] ([PersonagemId]);
GO

ALTER TABLE [TB_ARMAS] ADD CONSTRAINT [FK_TB_ARMAS_TB_PERSONAGENS_PersonagemId] FOREIGN KEY ([PersonagemId]) REFERENCES [TB_PERSONAGENS] ([Id]) ON DELETE CASCADE;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20240417010414_MigracaoUmParaUm', N'8.0.3');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [TB_HABILIDADES] (
    [Id] int NOT NULL IDENTITY,
    [Nome] Varchar(200) NOT NULL,
    [Dano] int NOT NULL,
    CONSTRAINT [PK_TB_HABILIDADES] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [TB_PERSONAGENS_HABILIDADES] (
    [PersonagemId] int NOT NULL,
    [HabilidadeId] int NOT NULL,
    CONSTRAINT [PK_TB_PERSONAGENS_HABILIDADES] PRIMARY KEY ([PersonagemId], [HabilidadeId]),
    CONSTRAINT [FK_TB_PERSONAGENS_HABILIDADES_TB_HABILIDADES_HabilidadeId] FOREIGN KEY ([HabilidadeId]) REFERENCES [TB_HABILIDADES] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_TB_PERSONAGENS_HABILIDADES_TB_PERSONAGENS_PersonagemId] FOREIGN KEY ([PersonagemId]) REFERENCES [TB_PERSONAGENS] ([Id]) ON DELETE CASCADE
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Dano', N'Nome') AND [object_id] = OBJECT_ID(N'[TB_HABILIDADES]'))
    SET IDENTITY_INSERT [TB_HABILIDADES] ON;
INSERT INTO [TB_HABILIDADES] ([Id], [Dano], [Nome])
VALUES (1, 39, 'Adormecer'),
(2, 41, 'COngelar'),
(3, 37, 'Adormecer');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Dano', N'Nome') AND [object_id] = OBJECT_ID(N'[TB_HABILIDADES]'))
    SET IDENTITY_INSERT [TB_HABILIDADES] OFF;
GO

UPDATE [TB_USUARIOS] SET [PasswordHash] = 0xB8B8A70C00E125ADB9B9D5C98E9C063E8D8A30CE5177B541F40C0EBAA35F3F04C81DE4096EEE333E410589636A3F9C06311117EAE03C238E5A65C06ED758A9355597D450B1243B7061D0CAE13ABB9E1E53C7FDFB355E88DA224CC9ACAB8E2EFF818BE016BBECDA1C887E59592A632DFD20C37817EACDB88E638498483C4D7B28
WHERE [Id] = 1;
SELECT @@ROWCOUNT;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'HabilidadeId', N'PersonagemId') AND [object_id] = OBJECT_ID(N'[TB_PERSONAGENS_HABILIDADES]'))
    SET IDENTITY_INSERT [TB_PERSONAGENS_HABILIDADES] ON;
INSERT INTO [TB_PERSONAGENS_HABILIDADES] ([HabilidadeId], [PersonagemId])
VALUES (1, 1),
(2, 1),
(2, 2),
(2, 3),
(3, 3),
(3, 4),
(1, 5),
(2, 6),
(3, 7);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'HabilidadeId', N'PersonagemId') AND [object_id] = OBJECT_ID(N'[TB_PERSONAGENS_HABILIDADES]'))
    SET IDENTITY_INSERT [TB_PERSONAGENS_HABILIDADES] OFF;
GO

CREATE INDEX [IX_TB_PERSONAGENS_HABILIDADES_HabilidadeId] ON [TB_PERSONAGENS_HABILIDADES] ([HabilidadeId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20240417013136_MigracaoMuitosParaMuitos', N'8.0.3');
GO

COMMIT;
GO

