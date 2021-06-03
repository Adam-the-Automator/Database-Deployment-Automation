CREATE PROCEDURE dbo.AddInventoryRecords @ServerName NVARCHAR(60) = NULL,
	@Description NVARCHAR(20) = NULL
AS
BEGIN
	SET NOCOUNT ON

	INSERT INTO dbo.DatabaseInventory (
		[servername],
		[description]
		)
	VALUES (
		@ServerName,
		@Description
		)
END
GO
