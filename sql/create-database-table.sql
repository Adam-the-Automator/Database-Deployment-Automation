IF NOT EXISTS (
		SELECT *
		FROM sys.objects
		WHERE object_id = OBJECT_ID(N'[dbo].[DatabaseInventory]')
			AND type IN (N'U')
		)
	CREATE TABLE [dbo].[DatabaseInventory] (
		[ID] [int] IDENTITY(1, 1) NOT NULL,
		[ServerName] NVARCHAR NOT NULL, /* Specifies the server name either on-premise or in the cloud */
		[Description] NVARCHAR NULL, /* Specifies the description of the server */
		[Environment] NVARCHAR NOT NULL, /* Specifies the environment the server is used for, example "Test" */
		[IsManaged] [bit] DEFAULT 0 NULL, /* Boolean value to check whether the server is managed by your team */
		[IsPatched] [bit] DEFAULT 0 NULL, /* Boolean value to check whether the server is patched by your team */
		[CreationTime] [date] DEFAULT GETDATE() NULL,
		CONSTRAINT [PK_ID] PRIMARY KEY CLUSTERED ([id] ASC) WITH (
			PAD_INDEX = OFF,
			STATISTICS_NORECOMPUTE = OFF,
			IGNORE_DUP_KEY = OFF,
			ALLOW_ROW_LOCKS = ON,
			ALLOW_PAGE_LOCKS = ON
			) ON [PRIMARY]
		) ON [PRIMARY]
GO


