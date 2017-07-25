
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 07/25/2017 13:17:59
-- Generated from EDMX file: C:\Users\torbug\documents\visual studio 2015\Projects\BeerCollection\BeerCollection\Models\BeerModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [beer_collection];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_BeerBeerRating]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BeerRatings] DROP CONSTRAINT [FK_BeerBeerRating];
GO
IF OBJECT_ID(N'[dbo].[FK_BeerBeerType]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Beers] DROP CONSTRAINT [FK_BeerBeerType];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Beers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Beers];
GO
IF OBJECT_ID(N'[dbo].[BeerRatings]', 'U') IS NOT NULL
    DROP TABLE [dbo].[BeerRatings];
GO
IF OBJECT_ID(N'[dbo].[BeerTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[BeerTypes];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Beers'
CREATE TABLE [dbo].[Beers] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] varchar(150)  NOT NULL,
    [AverageRating] float  NULL,
    [BeerTypeId] int  NOT NULL
);
GO

-- Creating table 'BeerRatings'
CREATE TABLE [dbo].[BeerRatings] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Rating] int  NOT NULL,
    [BeerId] int  NOT NULL
);
GO

-- Creating table 'BeerTypes'
CREATE TABLE [dbo].[BeerTypes] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] varchar(150)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Beers'
ALTER TABLE [dbo].[Beers]
ADD CONSTRAINT [PK_Beers]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'BeerRatings'
ALTER TABLE [dbo].[BeerRatings]
ADD CONSTRAINT [PK_BeerRatings]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'BeerTypes'
ALTER TABLE [dbo].[BeerTypes]
ADD CONSTRAINT [PK_BeerTypes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [BeerId] in table 'BeerRatings'
ALTER TABLE [dbo].[BeerRatings]
ADD CONSTRAINT [FK_BeerBeerRating]
    FOREIGN KEY ([BeerId])
    REFERENCES [dbo].[Beers]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_BeerBeerRating'
CREATE INDEX [IX_FK_BeerBeerRating]
ON [dbo].[BeerRatings]
    ([BeerId]);
GO

-- Creating foreign key on [BeerTypeId] in table 'Beers'
ALTER TABLE [dbo].[Beers]
ADD CONSTRAINT [FK_BeerBeerType]
    FOREIGN KEY ([BeerTypeId])
    REFERENCES [dbo].[BeerTypes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_BeerBeerType'
CREATE INDEX [IX_FK_BeerBeerType]
ON [dbo].[Beers]
    ([BeerTypeId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------