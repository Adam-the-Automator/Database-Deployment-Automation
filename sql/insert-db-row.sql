CREATE PROCEDURE dbo.AddInventoryRecords @ServerName NVARCHAR(60) = NULL,
	@Description NVARCHAR(20) = NULL,
	@Environment NVARCHAR(20) = NULL,
	@IsManaged BIT = 0,
	@IsPatched BIT = 0
AS
BEGIN
	SET NOCOUNT ON

	INSERT INTO dbo.DatabaseInventory (
		[servername],
		[description],
		[environment],
		[ismanaged],
		[IsPatched]
		)
	VALUES (
		@ServerName,
		@Description,
		@Environment,
		@IsManaged,
		@IsPatched
		)
END
GO


EXEC [dbo].[AddInventoryRecords]
		@ServerName = N'your sql express server',
		@Description = N'Express instance',
		@Environment = N'Test',
		@IsManaged = 0,
		@IsPatched = 0