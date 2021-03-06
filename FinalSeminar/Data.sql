USE [master]
GO
/****** Object:  Database [CanteenManagement]    Script Date: 06/01/2019 16:00:18 ******/
CREATE DATABASE [CanteenManagement] ON  PRIMARY 
( NAME = N'CanteenManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLEXPRESS\MSSQL\DATA\CanteenManagement.mdf' , SIZE = 2304KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CanteenManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLEXPRESS\MSSQL\DATA\CanteenManagement_log.LDF' , SIZE = 768KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CanteenManagement] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CanteenManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CanteenManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CanteenManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CanteenManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CanteenManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CanteenManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [CanteenManagement] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [CanteenManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CanteenManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CanteenManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CanteenManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CanteenManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CanteenManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CanteenManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CanteenManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CanteenManagement] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CanteenManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CanteenManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CanteenManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CanteenManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CanteenManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CanteenManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CanteenManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CanteenManagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CanteenManagement] SET  MULTI_USER 
GO
ALTER DATABASE [CanteenManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CanteenManagement] SET DB_CHAINING OFF 
GO
USE [CanteenManagement]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END


GO
/****** Object:  Table [dbo].[Account]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL DEFAULT (N'Student'),
	[PassWord] [nvarchar](1000) NOT NULL DEFAULT ((0)),
	[Type] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Bill]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NULL,
	[AccountUserName] [nvarchar](100) NULL,
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Food]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL DEFAULT (N'Chưa đặt tên'),
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL DEFAULT (N'Chưa đặt tên'),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'KHTN', N'Student', N'1', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'Nguyên', N'Cà', N'1', 0)
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (1, N'Cơm sườn', 1, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (2, N'Hủ tiếu', 1, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (3, N'Bún riêu', 1, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (4, N'Bánh canh', 1, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (5, N'Spaghetti', 1, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (6, N'Cafe đen', 2, 10000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (7, N'Cafe sữa', 2, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (8, N'Nước ngọt', 2, 10000)
SET IDENTITY_INSERT [dbo].[Food] OFF
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (1, N'Đồ ăn')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (2, N'Đồ uống')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([AccountUserName])
REFERENCES [dbo].[Account] ([UserName])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetAccountByUserName]
@userName nvarchar(100)
AS 
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT a.UserName AS [Tên tài khoản], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b,dbo.Account AS a
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut
	AND a.UserName = b.AccountUserName
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateAndPage]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListBillByDateAndPage]
@checkIn date, @checkOut date, @page int
AS 
BEGIN
	DECLARE @pageRows INT = 10
	DECLARE @selectRows INT = @pageRows
	DECLARE @exceptRows INT = (@page - 1) * @pageRows
	
	;WITH BillShow AS( SELECT b.ID, a.UserName AS [Tên tài khoản], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b,dbo.Account AS a
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut
	AND a.UserName = b.AccountUserName)
	
	SELECT TOP (@selectRows) * FROM BillShow WHERE id NOT IN (SELECT TOP (@exceptRows) id FROM BillShow)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateForReport]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetListBillByDateForReport]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT a.UserName, b.totalPrice, DateCheckIn, DateCheckOut, discount
	FROM dbo.Bill AS b,dbo.Account AS a
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut
	AND a.UserName = b.AccountUserName
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetNumBillByDate]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetNumBillByDate]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT COUNT(*)
	FROM dbo.Bill AS b,dbo.Account AS a
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut
	AND a.UserName = b.AccountUserName
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertBill]
@accountUserName NVARCHAR(100)
AS
BEGIN
	INSERT dbo.Bill 
	        ( DateCheckIn ,
	          DateCheckOut ,
	          AccountUserName ,
	          discount
	        )
	VALUES  ( GETDATE() , -- DateCheckIn - date
	          NULL , -- DateCheckOut - date
	          @accountUserName , -- AccountUserName - nvarchar(100)
	          0
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_InsertBillInfo]
@idBill INT, @idFood INT, @count INT
AS
BEGIN

	DECLARE @isExitsBillInfo INT
	DECLARE @foodCount INT = 1
	
	SELECT @isExitsBillInfo = id, @foodCount = b.count 
	FROM dbo.BillInfo AS b 
	WHERE idBill = @idBill AND idFood = @idFood

	IF (@isExitsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @foodCount + @count
		IF (@newCount > 0)
			UPDATE dbo.BillInfo	SET count = @foodCount + @count WHERE idFood = @idFood
		ELSE
			DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood
	END
	ELSE
	BEGIN
		INSERT	dbo.BillInfo
        ( idBill, idFood, count )
		VALUES  ( @idBill, -- idBill - int
          @idFood, -- idFood - int
          @count  -- count - int
          )
	END
END

GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_Login]
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END

GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 06/01/2019 16:00:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateAccount]
@userName NVARCHAR(100), @displayName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE USERName = @userName AND PassWord = @password
	
	IF (@isRightPass = 1)
	BEGIN
		IF (@newPassword = NULL OR @newPassword = '')
		BEGIN
			UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END		
		ELSE
			UPDATE dbo.Account SET DisplayName = @displayName, PassWord = @newPassword WHERE UserName = @userName
	END
END

GO
USE [master]
GO
ALTER DATABASE [CanteenManagement] SET  READ_WRITE 
GO
