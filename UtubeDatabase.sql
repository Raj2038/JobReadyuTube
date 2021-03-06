USE [master]
GO
/****** Object:  Database [MyUtubeDatabase]    Script Date: 2/02/2017 9:56:31 AM ******/
CREATE DATABASE [MyUtubeDatabase]
 CONTAINMENT = NONE
 --ON  PRIMARY 
--( NAME = N'MyUtubeDatabase', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\MyUtubeDatabase.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
-- LOG ON 
--( NAME = N'MyUtubeDatabase_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\MyUtubeDatabase_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
--GO
ALTER DATABASE [MyUtubeDatabase] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyUtubeDatabase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyUtubeDatabase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyUtubeDatabase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyUtubeDatabase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MyUtubeDatabase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyUtubeDatabase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MyUtubeDatabase] SET  MULTI_USER 
GO
ALTER DATABASE [MyUtubeDatabase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyUtubeDatabase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MyUtubeDatabase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MyUtubeDatabase] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [MyUtubeDatabase] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MyUtubeDatabase', N'ON'
GO
USE [MyUtubeDatabase]
GO
/****** Object:  Table [dbo].[Channel]    Script Date: 2/02/2017 9:56:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Channel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[UserId] [int] NULL,
 CONSTRAINT [PK_Channel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comment]    Script Date: 2/02/2017 9:56:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](50) NULL,
	[UserId] [int] NULL,
	[VideoId] [int] NULL,
	[ParentId] [int] NULL,
 CONSTRAINT [PK_Comment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 2/02/2017 9:56:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](20) NULL,
	[LastName] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[Password] [nvarchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Video]    Script Date: 2/02/2017 9:56:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Video](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[URL] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[UserId] [int] NULL,
	[ChannelId] [int] NULL,
 CONSTRAINT [PK_Video] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Channel]  WITH CHECK ADD  CONSTRAINT [FK_Channel_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Channel] CHECK CONSTRAINT [FK_Channel_User]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Comment] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Comment] ([Id])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Comment]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_User]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Video] FOREIGN KEY([VideoId])
REFERENCES [dbo].[Video] ([Id])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Video]
GO
ALTER TABLE [dbo].[Video]  WITH CHECK ADD  CONSTRAINT [FK_Video_Channel] FOREIGN KEY([ChannelId])
REFERENCES [dbo].[Channel] ([Id])
GO
ALTER TABLE [dbo].[Video] CHECK CONSTRAINT [FK_Video_Channel]
GO
ALTER TABLE [dbo].[Video]  WITH CHECK ADD  CONSTRAINT [FK_Video_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Video] CHECK CONSTRAINT [FK_Video_User]
GO
USE [master]
GO
ALTER DATABASE [MyUtubeDatabase] SET  READ_WRITE 
GO

use MyUtubeDatabase;
Go

insert into [User] (Username,Email,FirstName,IsActive,Password) values ('guest','guest@gmail.com','guest',1,'guest');

insert into Channel (Name,Description,UserId) values ('Entertainment','Entertainment Desc',1); 

insert into Video (Name,URL,Description,IsActive,UserId,ChannelId) values('FunnyVideo','YTOZBSOMNsk','Funny Video',1,1,1);

insert into Comment (Content,UserId,VideoId) values ('test',1,1);

