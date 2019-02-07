/**************************************************************************************************/
/****************************View Based ETL for Canada Coverage Assessment*************************/
/**************************************************************************************************/

-----------------------------------TABLE OF CONTENTS------------------------------------------------
/* I. Indicator Staging */
--A. TStagingIndicator
--B. VTIndicator
--C. VTTheme
--D. VTIndicatorXTheme
--E. VTModifier
--F. VTIndicatorXModifier
--G. VTRule
--H. VTIndicatorXRule
--I. TThemeDescription


/* II. Product Staging */
--A. TProduct
--B. TIndicatorXProduct
--C. VIndicator
--D. View Overwrite



/* III. Display Data */
--A. Indicator Inventory
--B. Pivot Charts
--C. Unmapped Products
--D. High Risk Non-Conducive
--E. Rule Mapping Master
--F. Products with Data Feed
--G. Product Rule Coverage
--H. Expanded Rule Mapping
--I. Theme Description
--J. Indicators, Themes, and Products
--K. Product Risk and Rules



----------------------------------------------------------------------------------------------------


/* IV. Miscellaneous */
--A. Indicator QA
--B. Rule Priority List
--C. Ad Hoc Changes
---Prerecorded: Load Investment/Insurance Data
---Prerecorded: Update Indicator Names
---Prerecorded: Update Indicator Theme Map
---Prerecorded: Update Conducive to Monitoring As Per QA
---Prerecorded: Supplementary QA Changes
---Prerecorded: Update Indicator Rule Mapping
---12/20/2018: Updated Loan and Mortgage
---12/21/2018 Indicator Product Mapping v5.06.xlsm
---12/26/2018: Rule Updates and Post QA Changes
---12/27/2018 Fix for Duplicates - Update All Purple
---12/27/2018 FW: Proposed Rule Name
---12/27/2018 Addl. Rule Mapping
---12/27/2018 Sean's Additions
---12/28/2018: Rule and Coverage Updates
---01/04/2019: Remove Product Mappings Part 1
---01/09/2019: Change Indicator Priorty, Theme Description, and Product Mappings
---01/11/2019: Priority Change
---01/14/2019: Product Mapping/Indicator Info Changes
---01/15/2019: 20190115 Custody Rules and Indicators v1.00.xlsx
---01/15/2019: First Batch (Review, then come ask me question if not clear)
---01/15/2019: RE: Next Batch
---01/16/2019: Integrating Staging ID into TProduct
---01/16/2019: Integrating Staging ID into TProduct (Part 2)
---01/17/2019: Potential Indicator Product Mappings

/**************************************************************************************************/
/***********************************I. Indicator Staging*******************************************/
/**************************************************************************************************/

/*

This section details the process of breaking the raw indicator data (Staging Table)
into seaprate portions to apply ETL (Extract Transform Load).
Views(V) applied to most tables to automate ETL process of broken down parts.




							(V)TIndicator	
							(V)TTheme				(V)TindicatorXTheme
TIndicatorStaging  ---> 	(V)TModifier			(V)TindicatorXModifier
							(V)TRule				TIndicatorXRule
							TThemeDescription	
							
							
							
							
*/ 


/**************************************************************************************************/
--A. TStagingIndicator
/**************************************************************************************************/

/*

This staging table represents the latest raw indicator data to be imported 
and broken into separate tables.


Note: The source of this staging table was imported using Excel/Access. 
Consider the data types below prior to loading in. 

*/

--DROP TABLE [dbo].[TStagingIndicator]
CREATE TABLE [dbo].[TStagingIndicator]
(
	[Segment] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IndicatorID] [int] IDENTITY(1,1) NOT NULL,
	[IndicatorRefID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Red Flag Theme 1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Red Flag Theme 2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Red Flag Theme 3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Navigant Rule Template] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Indicator] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Priority] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsApplicableToBank] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsConduciveToAutomatedMonitoring] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OracleRule] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InOracleMVP1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CoverageInclOracleMVP1AndFortent] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Logical Scenario] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BusinessLine] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Rule ID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NavigantRule] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Rule Priority] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Modifiers] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Rule Psuedocode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProposedRuleName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FortentCoverage] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FortentRule] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Missing Parameter in Mantas Scenario, If any] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Expected Coverage] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RevisionHistory] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RuleCoverageNotes] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FortentRuleCoverageNotes] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
	[IsDuplicate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TStagingIndicator] ON;
INSERT INTO [dbo].[TStagingIndicator]
(
    Segment,
    IndicatorID,
    IndicatorRefID,
    [Red Flag Theme 1],
    [Red Flag Theme 2],
    [Red Flag Theme 3],
    [Navigant Rule Template],
    Indicator,
    Priority,
    IsApplicableToBank,
    IsConduciveToAutomatedMonitoring,
    OracleRule,
    InOracleMVP1,
    CoverageInclOracleMVP1AndFortent,
    [Logical Scenario],
    BusinessLine,
    [Rule ID],
    NavigantRule,
    [Rule Priority],
    Modifiers,
    [Rule Psuedocode],
    ProposedRuleName,
    FortentCoverage,
    FortentRule,
    [Missing Parameter in Mantas Scenario, If any],
    [Expected Coverage],
    RevisionHistory,
    RuleCoverageNotes,
    FortentRuleCoverageNotes, 
	IsDuplicate
)


SELECT
	[Segment],
	ID AS IndicatorID,
	[Indicator ID] AS IndicatorRefID,
	[Red Flag Theme 1],
	[Red Flag Theme 2],
	[Red Flag Theme 3],
	[Navigant Rule Template],
	[Indicator],
	[Priority], --Limit 1-3
	[Applicable to BNS?] AS IsApplicableToBank,
	[Conducive to Automated Monitoring?] AS IsConduciveToAutomatedMonitoring, --Limit T/F
	CONVERT(nvarchar(MAX),[Proposed Oracle Scenario]) AS OracleRule,
	[MVP1?] AS InOracleMVP1, --Limit to T/F, no N/A
	[Coverage After MVP1] AS CoverageInclOracleMVP1AndFortent,
	[Logical Scenario],
	[Business Line] AS BusinessLine,
	[Rule ID],
	[Rule Name] AS NavigantRule,
	[Rule Priority],
	[Modifiers],
	[Rule Psuedocode],
	[Proposed Rule Name] AS ProposedRuleName,
	[Current Fortent Coverage Level] AS FortentCoverage,
	[Fortent Rule (s) providing coverage] AS FortentRule,
	[Missing Parameter in Mantas Scenario, If any],
	[Expected Coverage],
	[Revision History] AS RevisionHistory,
	[Notes on Oracle Coverage] AS RuleCoverageNotes,
	[Notes on Fortent Coverage] AS FortentRuleCoverageNotes, 
	[IsDuplicate] AS IsDuplicate
--Insert Updated Base Indicator Table Here
FROM [dbo].[XTIndicatorCA20181116];

SET IDENTITY_INSERT TStagingIndicator OFF;

--SELECT * FROM TStagingIndicator;

/**************************************************************************************************/
--B. VTIndicator
/**************************************************************************************************/

/*

This view takes all indicator related information from staging
and applies transformations as necessary. Like all other views 
after it, it extracts information from the raw staging table.

*/ 

ALTER VIEW VTIndicator AS

SELECT
	IndicatorID, 
	CASE WHEN IsConduciveToAutomatedMonitoring = 'Wealth' THEN 'Retail/Wealth' ELSE Segment END AS Segment,
	--[# Indicator Row],
	CONVERT(VARCHAR(50),IndicatorRefID) AS IndicatorRefID, 
	CONVERT(NVARCHAR(2000),Indicator) AS Indicator,
	CONVERT(INT,Priority) AS [Priority], --Limit 1-3
	CASE WHEN IsApplicableToBank IN ('Y') THEN 1 WHEN IsApplicableToBank IN ('N','N/A') THEN 0 ELSE NULL END AS IsApplicableToBank,
	CASE WHEN IsConduciveToAutomatedMonitoring IN ('Y', 'Wealth') THEN 1 
		WHEN IsConduciveToAutomatedMonitoring IN ('N', 'N/A') THEN 0 END AS IsConduciveToAutomatedMonitoring, --Limit T/F
	CASE WHEN InOracleMVP1 = 'Y' THEN 1 ELSE 0 END AS InOracleMVP1, --Limit to T/F, no N/A
	CASE WHEN CoverageInclOracleMVP1AndFortent NOT IN ('Full', 'Partial') THEN NULL ELSE CoverageInclOracleMVP1AndFortent END AS CoverageInclOracleMVP1AndFortent,
	CASE WHEN FortentCoverage IN ('Full', 'Full?', 'Y') THEN 'Full' WHEN FortentCoverage IN ('Partial') THEN 'Partial' ELSE NULL END AS FortentCoverage,
	--FortentCoverageByRule,
	--[Logical Scenario] AS LogicalScenario,
	BusinessLine,
	RevisionHistory,
	RuleCoverageNotes,
	FortentRuleCoverageNotes, 
	CASE IsDuplicate WHEN 'Y' THEN 1 WHEN 'N' THEN 0 END AS IsDuplicate
FROM [dbo].[TStagingIndicator];

/**************************************************************************************************/
--C. VTTheme
/**************************************************************************************************/

/*

This view extracts all possible themes from the Red Flag Themes columns in staging.
The values are standardized and assigned an ID. 

*/ 


ALTER VIEW dbo.VTTheme AS

WITH TempData AS (
	SELECT
	DISTINCT Theme
	FROM [dbo].[TStagingIndicator]
	UNPIVOT (Theme for ThemePrior IN 
		(
		[Red Flag Theme 1], 
		[Red Flag Theme 2], 
		[Red Flag Theme 3]
		)) upvt
)

, ThemeTemp AS (

	----------------------------------------------------------------------------------------------------
	SELECT 'Watch List' AS ThemeInitial					, 'Watch Lists/Keywords' AS NewTheme UNION ALL
	SELECT 'Watch Lists'								, 'Watch Lists/Keywords' UNION ALL
	SELECT 'Watch Lists/Keywords'						, 'Watch Lists/Keywords' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT 'Structuring'								, 'Structuring/Threshold Avoidance' UNION ALL
	SELECT 'Structuring/ Threshold Avoidance'			, 'Structuring/Threshold Avoidance' UNION ALL
	SELECT 'Threshold Avoidance'						, 'Structuring/Threshold Avoidance' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT 'Third Parties'								, 'Third Party Payment' UNION ALL
	SELECT 'Third Party Payment'						, 'Third Party Payment' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT 'Loans'										, 'Loan' UNION ALL
	SELECT 'Loan '										, 'Loan' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT 'Profiling'									, 'Profiling' UNION ALL
	SELECT 'Historical Deviation'						, 'Profiling' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT 'Rapid Movement of Funds'					, 'Velocity' UNION ALL
	SELECT 'Velocity'									, 'Velocity' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT '?'											, 'N/A' UNION ALL
	SELECT 'N/A'										, 'N/A' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT 'High Risk Geography (HRG)'					, 'High Risk Geography (HRG)' UNION ALL
	SELECT 'Geography '									, 'High Risk Geography (HRG)' UNION ALL
	SELECT 'High Risk Jurisdictions'					, 'High Risk Geography (HRG)' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT 'Insurance'									, 'Insurance' UNION ALL
	SELECT 'Insurance - Borrowing Against New Policy'	, 'Insurance' UNION ALL
	SELECT 'Insurance - Canceled Policy'				, 'Insurance'
)

, RevisedTheme AS (

SELECT DISTINCT 
	COALESCE(ThemeTemp.NewTheme, TempData.Theme) AS Theme 
FROM TempData
LEFT JOIN ThemeTemp ON TempData.Theme = ThemeTemp.ThemeInitial
)

SELECT ROW_NUMBER() OVER (ORDER BY Theme) ThemeID, Theme 
FROM RevisedTheme;

--SELECT * FROM VTTheme;

/**************************************************************************************************/
--D. VTIndicatorXTheme
/**************************************************************************************************/

/*

This view ties standardized themes to the indicators. 
Theme Priority is assigned based on which Red Flag Theme field the value was pulled from. 

*/ 




ALTER VIEW dbo.VTIndicatorXTheme AS

WITH ThemeTemp AS (

	----------------------------------------------------------------------------------------------------
	SELECT 'Watch List' AS ThemeInitial					, 'Watch Lists/Keywords' AS NewTheme UNION ALL
	SELECT 'Watch Lists'								, 'Watch Lists/Keywords' UNION ALL
	SELECT 'Watch Lists/Keywords'						, 'Watch Lists/Keywords' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT 'Structuring'								, 'Structuring/Threshold Avoidance' UNION ALL
	SELECT 'Structuring/ Threshold Avoidance'			, 'Structuring/Threshold Avoidance' UNION ALL
	SELECT 'Threshold Avoidance'						, 'Structuring/Threshold Avoidance' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT 'Third Parties'								, 'Third Party Payment' UNION ALL
	SELECT 'Third Party Payment'						, 'Third Party Payment' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT 'Loans'										, 'Loan' UNION ALL
	SELECT 'Loan '										, 'Loan' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT 'Profiling'									, 'Profiling' UNION ALL
	SELECT 'Historical Deviation'						, 'Profiling' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT 'Rapid Movement of Funds'					, 'Velocity' UNION ALL
	SELECT 'Velocity'									, 'Velocity' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT '?'											, 'N/A' UNION ALL
	SELECT 'N/A'										, 'N/A' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT 'High Risk Geography (HRG)'					, 'High Risk Geography (HRG)' UNION ALL
	SELECT 'Geography '									, 'High Risk Geography (HRG)' UNION ALL
	SELECT 'High Risk Jurisdictions'					, 'High Risk Geography (HRG)' UNION ALL
	----------------------------------------------------------------------------------------------------
	SELECT 'Insurance'									, 'Insurance' UNION ALL
	SELECT 'Insurance - Borrowing Against New Policy'	, 'Insurance' UNION ALL
	SELECT 'Insurance - Canceled Policy'				, 'Insurance'
)


, TempData AS (
	SELECT
	DISTINCT IndicatorID, Theme.ThemeID, CAST(SUBSTRING(ThemePrior, 16, 1) AS int) AS Priority
	FROM [dbo].[TStagingIndicator]
	UNPIVOT (Theme for ThemePrior IN 
		(
		[Red Flag Theme 1], 
		[Red Flag Theme 2], 
		[Red Flag Theme 3]
		)) upvt
	LEFT JOIN ThemeTemp ON upvt.Theme = ThemeTemp.ThemeInitial
	LEFT JOIN VTTheme Theme ON Theme.Theme = COALESCE(ThemeTemp.NewTheme, upvt.Theme)
) 


SELECT ROW_NUMBER() OVER (ORDER BY IndicatorID, ThemeID) IndicatorXThemeID, TempData.* FROM TempData;

--SELECT * FROM VTIndicatorXTheme;

/**************************************************************************************************/
--E. VTModifier
/**************************************************************************************************/

/*

This view extracts all possible modifiers from the modifier column in staging.
Semicolons imposed to multiple modifiers per row. Subsequently split to extract full value.
The values are standardized and assigned an ID. 

*/ 



ALTER VIEW dbo.VTModifier AS

WITH TempData AS (
   SELECT --IndicatorID, 
   CONVERT(XML,'<x>'+REPLACE(REPLACE(Modifiers, ',', ';'),';','</x><x>')+'</x>') AS XMLData
   FROM [dbo].TStagingIndicator
   WHERE Modifiers IS NOT NULL
)

, Modifiers AS (
	SELECT DISTINCT --IndicatorID, 
	LTRIM(RTRIM(Element.Loc.value('.','varchar(50)'))) AS [ModifierName]
	FROM   TempData  
	CROSS APPLY XMLData.nodes('/x') as Element(Loc)
)

SELECT ROW_NUMBER() OVER (ORDER BY [ModifierName]) ModifierID, ModifierName FROM Modifiers;

--SELECT * FROM VTModifier;

/**************************************************************************************************/
--F. VTIndicatorXModifier
/**************************************************************************************************/

/*

This view ties standardized modifiers to the indicators. 

*/ 



ALTER VIEW dbo.VTIndicatorXModifier AS

WITH TempData AS
(
   SELECT 
		IndicatorID, 
		Modifiers,
   CONVERT(XML,'<x>'+REPLACE(REPLACE(Modifiers, ',', ';'),';','</x><x>')+'</x>') AS XMLData
   FROM dbo.TStagingIndicator
   WHERE Modifiers IS NOT NULL
)
--INSERT INTO dbo.TIndicatorXModifier (IndicatorID, ModifierID) 

, IndMod AS (
	SELECT 
		IndicatorID
		, LTRIM(RTRIM(Element.Loc.value('.','varchar(50)'))) as ModifierName
	FROM TempData
	CROSS APPLY XMLData.nodes('/x') as Element(Loc)
)

SELECT 
	ROW_NUMBER() OVER (ORDER BY IndicatorID, ModifierID) AS IndicatorXModifierID, 
	IndicatorID, 
	ModifierID
FROM   IndMod
LEFT JOIN VTModifier ON IndMod.ModifierName = VTModifier.ModifierName
WHERE IndMod.ModifierName IS NOT NULL;

--SELECT * FROM VTIndicatorXModifier;

/**************************************************************************************************/
--G. VTRule
/**************************************************************************************************/

/* 

This view extracts all rules from Fortent, Navigant, and Oracle in the staging table. 
Semicolons imposed to multiple rules per row. Subsequently split to extract full value.
The values are standardized, categorized (Oracle, Navigant. etc.) and assigned an ID.

The main use of this table is to identify the Oracle Template 
to apply in place of the Fortent decomission. 

*/


ALTER VIEW dbo.VTRule AS
WITH OracleRules AS (
	SELECT 'Anticipatory Profile - Expected Activity' AS RuleName					, 'Anomalies in Behavior' AS Category, 'Expected vs Actual Transactional Levels: Deviation from Profile/Expected vs Actual Transactional Levels: Large Transactions' AS ProposedTypology UNION ALL
	SELECT 'Anticipatory Profile - Income'											, 'Anomalies in Behavior'						, 'Expected vs Actual Transactional Levels: Deviation from Profile/Expected vs Actual Transactional Levels: Large Transactions' UNION ALL
	SELECT 'Anticipatory Profile - Source Of Funds'									, 'Anomalies in Behavior'						, 'Expected vs Actual Transactional Levels: Deviation from Profile' UNION ALL
	SELECT 'CIB: Foreign Activity'													, 'Anomalies in Behavior'						, 'Expected vs Actual Transactional Levels: Deviation from Profile' UNION ALL
	SELECT 'CIB: High Risk Geography Activity'										, 'Anomalies in Behavior'						, 'Change in Behavior: High Risk Geography Activity' UNION ALL
	SELECT 'CIB: Product Utilization Shift'											, 'Anomalies in Behavior'						, 'Change in Behavior: Product Channel/Utilization Shift' UNION ALL
	SELECT 'CIB: Significant Change from Previous Average Activity'					, 'Anomalies in Behavior'						, 'Change in Behavior: Significant Change from Previous Average Activity' UNION ALL
	SELECT 'CIB: Significant Change From Previous Peak Activity'					, 'Anomalies in Behavior'						, 'Change in Behavior: Significant Change from Previous Peak Activity' UNION ALL
	SELECT 'Deposits/Withdrawals in Same or Similar Amounts'						, 'Anomalies in Behavior'						, 'Flow through of Funds: Rapid Movement of Incoming / Outgoing Funds' UNION ALL
	SELECT 'Deviation From Peer Group - Product Utilization'						, 'Anomalies in Behavior'						, 'Change in Behavior: Product Channel/Utilization Shift' UNION ALL
	SELECT 'Deviation from Peer Group - Total Activity'								, 'Anomalies in Behavior'						, 'Change in Behavior: Significant Change from Previous Peak Activity' UNION ALL
	SELECT 'Escalation in Inactive Account'											, 'Anomalies in Behavior'						, 'Change in Behavior: Escalation of Inactive Account' UNION ALL
	SELECT 'Large Depreciation of Account Value'									, 'Anomalies in Behavior'						, 'Expected vs Actual Transactional Levels: Large Transactions.' UNION ALL
	SELECT 'Rapid Movement Of Funds - All Activity'									, 'Anomalies in Behavior'						, 'Flow through of Funds: Rapid Movement of Incoming / Outgoing Funds' UNION ALL
	SELECT 'Rapid Movement Of Funds - Funds Transfers'								, 'Anomalies in Behavior'						, 'Flow through of Funds: Rapid Movement of Incoming / Outgoing Funds' UNION ALL
	SELECT 'Terrorist Financing'													, 'Anomalies in Behavior'						, 'Anomalies in Behavior' UNION ALL
	SELECT 'Transactions In Round Amounts'											, 'Anomalies in Behavior'						, 'Round Amount Activity: Transactions in Round Amounts' UNION ALL
	SELECT 'Anomalies in ATM, Bank Card: Excessive Withdrawals'						, 'ATM, Debit, Bank Card, and Credit Scenarios'	, 'Change in Behavior: Product Channel/Utilization Shift' UNION ALL
	SELECT 'Anomalies In ATM, Bank Card: Foreign Transactions'						, 'ATM, Debit, Bank Card, and Credit Scenarios'	, 'Change in Behavior: High Risk Geography Activity' UNION ALL
	SELECT 'Anomalies In ATM, Bank Card: Structured Cash Deposits'					, 'ATM, Debit, Bank Card, and Credit Scenarios'	, 'Structuring: Structuring' UNION ALL
	SELECT 'Early Payoff or Paydown of a Credit Product'							, 'ATM, Debit, Bank Card, and Credit Scenarios'	, 'Early Payoff / Pay Down: Early Payoff / Paydown' UNION ALL
	SELECT 'Rapid Loading And Redemption Of Stored Value Cards'						, 'ATM, Debit, Bank Card, and Credit Scenarios'	, 'Flow through of Funds: Rapid Movement of Incoming / Outgoing Funds' UNION ALL
	SELECT 'Custom Scenario'														, 'Custom Scenario'								, 'Custom Scenario' UNION ALL
	SELECT 'Address Associated with Multiple, Recurring External Entities'			, 'Hidden Relationships'						, 'Recurring Relationship: Recurring Originators / Beneficiaries' UNION ALL
	SELECT 'External Entity Associated With Multiple, Recurring Addresses'			, 'Hidden Relationships'						, 'Recurring Relationship: Recurring Originators / Beneficiaries' UNION ALL
	SELECT 'External Entity Identifier Associated With Multiple, Recurring Names'	, 'Hidden Relationships'						, 'Recurring Relationship: Recurring Originators / Beneficiaries' UNION ALL
	SELECT 'External Entity Name Associated With Multiple, Recurring Identifiers'	, 'Hidden Relationships'						, 'Recurring Relationship: Recurring Originators / Beneficiaries' UNION ALL
	SELECT 'Journals Between Unrelated Accounts'									, 'Hidden Relationships'						, 'Transactions without Economic Value: Transactions with Unknown Purpose/Third Parties and Intermediaries: Third Party Transactions' UNION ALL
	SELECT 'Known Remitter/Beneficiary Names In Checks, Monetary Instruments'		, 'Hidden Relationships'						, 'Recurring Relationship: Recurring Originators / Beneficiaries' UNION ALL
	SELECT 'Networks Of Accounts, Entities, And Customers'							, 'Hidden Relationships'						, 'Hidden Relationship: Networks of Hidden Relationships' UNION ALL
	SELECT 'Pattern of Funds Transfers Between Correspondent Banks'					, 'Hidden Relationships'						, 'Hidden Relationship: Patterns of Funds Transfers' UNION ALL
	SELECT 'Patterns Of Funds Transfers Between Customers And External Entities'	, 'Hidden Relationships'						, 'Hidden Relationship: Patterns of Funds Transfers' UNION ALL
	SELECT 'Patterns of Funds Transfers Between Internal Accounts and Customers'	, 'Hidden Relationships'						, 'Hidden Relationship: Patterns of Funds Transfers' UNION ALL
	SELECT 'Patterns Of Recurring Originators/Beneficiaries In Funds Transfers'		, 'Hidden Relationships'						, 'Hidden Relationship: Patterns of Funds Transfers' UNION ALL
	SELECT 'Unknown Remitter/Beneficiary Names In Checks, Monetary Instruments'		, 'Hidden Relationships'						, 'Third Parties and Intermediaries: Third Party Transactions' UNION ALL
	SELECT 'High Risk Transactions: Focal High Risk Entity'							, 'High Risk Geographies and Entities'			, 'High Risk Entity: High Risk Entities' UNION ALL
	SELECT 'High Risk Transactions: High Risk Counter Party'						, 'High Risk Geographies and Entities'			, 'High Risk Entity: High Risk Entities/High Risk Geography: High Risk Geography' UNION ALL
	SELECT 'High Risk Transactions: High Risk Geography'							, 'High Risk Geographies and Entities'			, 'High Risk Geography: High Risk Geography' UNION ALL
	SELECT 'Hub and Spoke'															, 'Hub and Spoke'								, 'Hidden Relationship: Patterns of Funds Transfers' UNION ALL
	SELECT 'CIB: Inactive To Active Customers'										, 'Institutional Anti Money Laundering Scenarios', 'Change in Behavior: Escalation of Inactive Account' UNION ALL
	SELECT 'CIB: Significant Change in Trade/Transaction Activity'					, 'Institutional Anti Money Laundering Scenarios', 'CIB: Significant Change in Trade/Transaction Activity' UNION ALL
	SELECT 'Customers Engaging in Offsetting Trades'								, 'Institutional Anti Money Laundering Scenarios', 'Transactions without Economic Value: Transactions with Unknown Purpose' UNION ALL
	SELECT 'Frequent Changes To Instructions'										, 'Institutional Anti Money Laundering Scenarios', 'Instruction Amendments or Re-submissions: Frequent Changes to Instructions' UNION ALL
	SELECT 'Hidden Relationships'													, 'Institutional Anti Money Laundering Scenarios', 'Hidden Relationship: Networks of Hidden Relationships/Hidden Relationship: Patterns of Funds Transfers' UNION ALL
	SELECT 'High Risk Electronic Transfers'											, 'Institutional Anti Money Laundering Scenarios', 'High Risk Entity: High Risk Entities' UNION ALL
	SELECT 'High Risk Instructions'													, 'Institutional Anti Money Laundering Scenarios', 'Institutional Anti Money Laundering Scenarios' UNION ALL
	SELECT 'Manipulation of Account/Customer Data Followed by Instruction Changes'	, 'Institutional Anti Money Laundering Scenarios', 'Instruction Amendments or Re-submissions: Frequent Changes to Instructions' UNION ALL
	SELECT 'Movement of Funds without Corresponding Trade'							, 'Institutional Anti Money Laundering Scenarios', 'Attempt to Conceal Identity: Suspicious Business Structure Indicators' UNION ALL
	SELECT 'Trades In Securities With Near-Term Maturity, Exchange Of Assets'		, 'Institutional Anti Money Laundering Scenarios', 'Transactions without Economic Value: Trades in Securities with Near-Term Maturity, Exchange of Assets' UNION ALL
	SELECT 'Change In Beneficiary/Owner Followed By Surrender'						, 'Insurance Scenarios'							, 'Attempt to Conceal Identity: Frequent Change of Beneficiaries' UNION ALL
	SELECT 'Customer Borrowing Against New Policy'									, 'Insurance Scenarios'							, 'Insurance Scenarios' UNION ALL
	SELECT 'Insurance Policies with Refunds'										, 'Insurance Scenarios'							, 'Insurance Scenarios' UNION ALL
	SELECT 'Policies with Large Early Removal'										, 'Insurance Scenarios'							, 'Early Payoff / Pay Down: Early Payoff / Paydown' UNION ALL
	SELECT 'Externally Matched Names'												, 'Other Money Laundering Behaviors'			, 'Other Money Laundering Behaviors' UNION ALL
	SELECT 'Large Reportable Transactions'											, 'Other Money Laundering Behaviors'			, 'Expected vs Actual Transactional Levels: Large Transactions' UNION ALL
	SELECT 'Patterns of Sequentially Numbered Checks, Monetary Instruments'			, 'Other Money Laundering Behaviors'			, 'Sequentially Numbered Monetary Instruments: Sequentially Numbered Monetary Instruments' UNION ALL
	SELECT 'Single Or Multiple Cash Transactions: Large Significant Transactions'	, 'Other Money Laundering Behaviors'			, 'Expected vs Actual Transactional Levels: Large Transactions' UNION ALL
	SELECT 'Single Or Multiple Cash Transactions: Possible CTR'						, 'Other Money Laundering Behaviors'			, 'Expected vs Actual Transactional Levels: Large Transactions' UNION ALL
	SELECT 'Structuring: Avoidance of Reporting Thresholds'							, 'Other Money Laundering Behaviors'			, 'Structuring: Structuring' UNION ALL
	SELECT 'Structuring: Deposits/Withdrawals Of Mixed Monetary Instruments'		, 'Other Money Laundering Behaviors'			, 'Structuring: Structuring' UNION ALL
	SELECT 'Structuring: Potential Structuring In Cash And Equivalents'				, 'Other Money Laundering Behaviors'			, 'Structuring: Structuring'
)

, TempOracleMapping AS (
	SELECT 'CIB - Deviation from Previous Average Activity' 					AS IndicatorName, 'CIB: Significant Change From Previous Average Activity' AS OracleName UNION ALL
	SELECT 'CIB - Product Utilization Shift' 									AS IndicatorName, 'CIB: Product Utilization Shift' AS OracleName UNION ALL
	SELECT 'CIB: Product Utlization Shift' 										AS IndicatorName, 'CIB: Product Utilization Shift' AS OracleName UNION ALL
	SELECT 'Deviation from Peer Group -Total Activity' 							AS IndicatorName, 'Deviation From Peer Group - Total Activity' AS OracleName UNION ALL
	SELECT 'Deviation from Peer Group: Total Activity' 							AS IndicatorName, 'Deviation From Peer Group - Total Activity' AS OracleName UNION ALL
	SELECT 'Deviation from Peer Group: Product Utilization' 					AS IndicatorName, 'Deviation From Peer Group - Product Utilization' AS OracleName UNION ALL
	SELECT 'High Risk Transactions: High Risk Focal Entity' 					AS IndicatorName, 'High Risk Transactions: High Risk Counter Party' AS OracleName UNION ALL
	SELECT 'Large Reportable Transactions [Customer Focus]' 					AS IndicatorName, 'Large Reportable Transactions' AS OracleName UNION ALL
	SELECT ' Large Reportable Transactions'										AS IndicatorName, 'Large Reportable Transactions' AS OracleName UNION ALL
	SELECT 'Networks of Accounts, Entities and Customers' 						AS IndicatorName, 'Networks Of Accounts, Entities, And Customers' AS OracleName UNION ALL
	SELECT 'Pattern of Funds Transfers between Internal Accounts and Customers' AS IndicatorName, 'Patterns Of Funds Transfers Between Internal Accounts And Customers' AS OracleName UNION ALL
	SELECT 'Pattern of Funds Transfers between Customers and External Entities' AS IndicatorName, 'Patterns of Funds Transfers between Customers and External Entities' AS OracleName UNION ALL
	SELECT 'Rapid Movement of Funds – All Activity' 							AS IndicatorName, 'Rapid Movement Of Funds - All Activity' AS OracleName UNION ALL
	SELECT 'Rapid Movement Funds - All Activity' 								AS IndicatorName, 'Rapid Movement Of Funds - All Activity' AS OracleName UNION ALL
	SELECT '1. Patterns of Sequentially Numbered Checks, Monetary Instruments 2. Manual Control' AS IndicatorName, 'Patterns of Sequentially Numbered Checks, Monetary Instruments' AS OracleName UNION ALL
	SELECT '1. Patterns of Sequentially Numbered Checks, Monetary Instruments 2.  Manual Control' AS IndicatorName, 'Patterns of Sequentially Numbered Checks, Monetary Instruments' AS OracleName UNION ALL
	SELECT '1. Patterns of Sequentially Numbered Checks, Monetary Instruments2.  Manual Control' AS IndicatorName, 'Patterns of Sequentially Numbered Checks, Monetary Instruments' AS OracleName UNION ALL
	SELECT 'Deposits/Withdrawals in Same/Similar Amounts'						AS IndicatorName, 'Deposits/Withdrawals In Same Or Similar Amounts' AS OracleName UNION ALL
	SELECT 'Automated PUPID report' 											AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Custom' 															AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Custom Scenario' 													AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Large Credit Refunds (requires customization of scenario)' 			AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Large Positive Credit Card Balances (requires customization)' 		AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Manual control' 													AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Missing Counter Party Details (Custom Scenario)' 					AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Missing Counter Party Details (Requires Customization of Scenario)' AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Multiple Jurisdictions (custom scenario)' 							AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Multiple Jurisdictions (Requires Customization of Scenario)' 		AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Nested Correspondent Rule (Requires Customization of Scenario)' 	AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Nested Correspondent Rule  (Requires Customization of Scenario)'	AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'No corresponding Mantas scenario' 									AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Wire Structuring (Requires Customization of Scenario)' 				AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Wire Structuring  (Requires Customization of Scenario)'				AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Wire Structuring (requires customization of scenario)' 				AS IndicatorName, 'Custom Scenario' AS OracleName 
)

, RuleTempData AS (

	SELECT 'Navigant' AS Source,CONVERT(XML,'<x>'+REPLACE(NavigantRule,';','</x><x>')+'</x>') AS XMLData FROM dbo.TStagingIndicator WHERE NavigantRule IS NOT NULL UNION ALL
	SELECT 'Oracle', 			CONVERT(XML,'<x>'+REPLACE(OracleRule,';','</x><x>')+'</x>') FROM dbo.TStagingIndicator WHERE OracleRule IS NOT NULL UNION ALL
	SELECT 'Fortent', 			CONVERT(XML,'<x>'+REPLACE(FortentRule,';','</x><x>')+'</x>')FROM dbo.TStagingIndicator WHERE FortentRule IS NOT NULL

)

, CrossApply AS (
	SELECT DISTINCT
		Source, 
		REPLACE(REPLACE(LTRIM(RTRIM(Element.Loc.value('.','varchar(255)'))),CHAR(13), ''),CHAR(10),'') AS RuleName
	FROM RuleTempData
	CROSS APPLY XMLData.nodes('/x') as Element(Loc)
	WHERE Element.Loc.value('.','varchar(255)') NOT IN ('N/A', ' ')
)

, ReFiltered AS (
	SELECT DISTINCT 
		CASE WHEN CrossApply.Source = 'Oracle' THEN COALESCE(TempMap.OracleName,CrossApply.RuleName)
		ELSE CrossApply.RuleName END AS RuleName, 
		CrossApply.Source
	FROM CrossApply
	LEFT JOIN TempOracleMapping TempMap 
		ON TempMap.IndicatorName = CrossApply.RuleName AND CrossApply.Source = 'Oracle'


)

SELECT 
	ROW_NUMBER() OVER (ORDER BY OracleRules.Category, Rules.RuleName) AS RuleID
	, Rules.RuleName
	, OracleRules.Category
	, Rules.Source
	, OracleRules.ProposedTypology
FROM
	(
	SELECT RuleName, 'Oracle' AS Source FROM OracleRules UNION
	SELECT RuleName, Source 			FROM ReFiltered) Rules
LEFT JOIN OracleRules ON Rules.RuleName = OracleRules.RuleName AND Rules.Source = 'Oracle';

--SELECT * FROM dbo.VTRule;


/**************************************************************************************************/
--H. VTIndicatorXRule
/**************************************************************************************************/

/*

This table ties all sourced rules to indicators, but also assigns a proposed rule as put forward 
by the Fortent Decomission project plan wich maps to the original rules. Each of these proposed 
rules are assigned a coverage value to represent if their Oracle counterpart has been implemented.
This table also maps similar proposed rules to behavioral themes for higher level analysis. 

Notes: 
	- Due to memory issues, this code has two parts: 
		1. Update the Temp table. 
		2. Truncate and replace data. 
	- Prior to code, Excel Formula provided to convert Excel Tables 
		to SQL tables row by row for smaller tables to bypass import function.


*/



--ALTER VIEW dbo.VTIndicatorXRule AS 

--Trailing Space Excel to SQL Alignment
--="SELECT '"&A2&"'"&REPT(" ", 250-LEN(A2))&", '"&B2&"'"&REPT(" ", 100 - LEN(B2))&"UNION ALL"
--="SELECT '"&A2&"'"&REPT(" ", 75-LEN(A2))&", '"&B2&"'"&REPT(" ", 75 - LEN(B2))&", '"&C2&"'"&REPT(" ", 10-LEN(C2))&"UNION ALL"

DROP TABLE #TempMatch;

WITH TempData AS (
       
   SELECT IndicatorID 
		  , CONVERT(XML,'<x>' + REPLACE(ProposedRuleName,';','</x><x>') + '</x>') AS ProposedRuleNameXML
		  , CONVERT(XML,'<x>' + REPLACE(OracleRule,';','</x><x>') + '</x>') AS OracleRuleXML		  
		  , CONVERT(XML,'<x>' + REPLACE(NavigantRule,';','</x><x>') + '</x>') AS NavigantRuleXML
		  , CONVERT(XML,'<x>' + REPLACE(FortentRule,';','</x><x>') + '</x>') AS FortentRuleXML
		  
   FROM TStagingIndicator

)


, TempOracleMapping AS (
	SELECT 'CIB - Deviation from Previous Average Activity' 					AS IndicatorName, 'CIB: Significant Change From Previous Average Activity' AS OracleName UNION ALL
	SELECT 'CIB - Product Utilization Shift' 									AS IndicatorName, 'CIB: Product Utilization Shift' AS OracleName UNION ALL
	SELECT 'CIB: Product Utlization Shift' 										AS IndicatorName, 'CIB: Product Utilization Shift' AS OracleName UNION ALL
	SELECT 'Deviation from Peer Group -Total Activity' 							AS IndicatorName, 'Deviation From Peer Group - Total Activity' AS OracleName UNION ALL
	SELECT 'Deviation from Peer Group: Total Activity' 							AS IndicatorName, 'Deviation From Peer Group - Total Activity' AS OracleName UNION ALL
	SELECT 'Deviation from Peer Group: Product Utilization' 					AS IndicatorName, 'Deviation From Peer Group - Product Utilization' AS OracleName UNION ALL
	SELECT 'High Risk Transactions: High Risk Focal Entity' 					AS IndicatorName, 'High Risk Transactions: High Risk Counter Party' AS OracleName UNION ALL
	SELECT 'Large Reportable Transactions [Customer Focus]' 					AS IndicatorName, 'Large Reportable Transactions' AS OracleName UNION ALL
	SELECT ' Large Reportable Transactions'										AS IndicatorName, 'Large Reportable Transactions' AS OracleName UNION ALL
	SELECT 'Networks of Accounts, Entities and Customers' 						AS IndicatorName, 'Networks Of Accounts, Entities, And Customers' AS OracleName UNION ALL
	SELECT 'Pattern of Funds Transfers between Internal Accounts and Customers' AS IndicatorName, 'Patterns Of Funds Transfers Between Internal Accounts And Customers' AS OracleName UNION ALL
	SELECT 'Pattern of Funds Transfers between Customers and External Entities' AS IndicatorName, 'Patterns of Funds Transfers between Customers and External Entities' AS OracleName UNION ALL
	SELECT 'Rapid Movement of Funds – All Activity' 							AS IndicatorName, 'Rapid Movement Of Funds - All Activity' AS OracleName UNION ALL
	SELECT 'Rapid Movement Funds - All Activity' 								AS IndicatorName, 'Rapid Movement Of Funds - All Activity' AS OracleName UNION ALL
	SELECT '1. Patterns of Sequentially Numbered Checks, Monetary Instruments 2. Manual Control' AS IndicatorName, 'Patterns of Sequentially Numbered Checks, Monetary Instruments' AS OracleName UNION ALL
	SELECT '1. Patterns of Sequentially Numbered Checks, Monetary Instruments 2.  Manual Control' AS IndicatorName, 'Patterns of Sequentially Numbered Checks, Monetary Instruments' AS OracleName UNION ALL
	SELECT '1. Patterns of Sequentially Numbered Checks, Monetary Instruments2.  Manual Control' AS IndicatorName, 'Patterns of Sequentially Numbered Checks, Monetary Instruments' AS OracleName UNION ALL
	SELECT 'Deposits/Withdrawals in Same/Similar Amounts'						AS IndicatorName, 'Deposits/Withdrawals In Same Or Similar Amounts' AS OracleName UNION ALL
	SELECT 'Automated PUPID report' 											AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Custom' 															AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Custom Scenario' 													AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Large Credit Refunds (requires customization of scenario)' 			AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Large Positive Credit Card Balances (requires customization)' 		AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Manual control' 													AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Missing Counter Party Details (Custom Scenario)' 					AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Missing Counter Party Details (Requires Customization of Scenario)' AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Multiple Jurisdictions (custom scenario)' 							AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Multiple Jurisdictions (Requires Customization of Scenario)' 		AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Nested Correspondent Rule (Requires Customization of Scenario)' 	AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Nested Correspondent Rule  (Requires Customization of Scenario)'	AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'No corresponding Mantas scenario' 									AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Wire Structuring (Requires Customization of Scenario)' 				AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Wire Structuring  (Requires Customization of Scenario)'				AS IndicatorName, 'Custom Scenario' AS OracleName UNION ALL
	SELECT 'Wire Structuring (requires customization of scenario)' 				AS IndicatorName, 'Custom Scenario' AS OracleName 
)




, ProposedMapping AS (
	SELECT 'Address Associated with Multiple, Recurring External Entities' AS RuleName                                                                                                                                                                                 , 'Address Associated with Multiple, Recurring External Entities' AS ProposedName                       , 'Network of Customers' AS ProposedRuleTheme         UNION ALL
	SELECT 'Single Address for Multiple Entities'                                                                                                                                                                             										   , 'Address Associated with Multiple, Recurring External Entities'                      				   , 'Network of Customers' 					         UNION ALL
	SELECT 'All Activity In/All Activity Out [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                                  , 'All Activity In/All Activity Out'                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'All Activity In/All Activity Out'																																																						   , 'All Activity In/All Activity Out'                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'All Activity In/Cash Out'																																																								   , 'All Activity In/Cash Out'																			   , 'Velocity'                                          UNION ALL
	SELECT 'Anomalies in ATM, Bank Card: Excessive Withdrawals'                                                                                                                                                                                                        , 'Anomalies in ATM, Bank Card: Excessive Withdrawals'                                                  , 'Patterning'                                        UNION ALL
	SELECT 'Anomalies in ATM, Bank Card: Foreign Transactions'                                                                                                                                                                                                         , 'Anomalies in ATM, Bank Card: Foreign Transactions'                                                   , 'Patterning'                                        UNION ALL
	SELECT 'Anomalies in ATM, Bank Card: Foreign Transactions [note that this scenario was not recommended for Priority 1, but this indicator specifically maps to it.]'                                                                                               , 'Anomalies in ATM, Bank Card: Foreign Transactions'                                                   , 'Patterning'                                        UNION ALL
	SELECT 'Automated PUPID Report'                                                                                                                                                                                                                                    , 'Automated PUPID Report'                                                                              , 'Identity Concealment'                              UNION ALL
	SELECT 'Bearer Instrument In/Wire Out'																																																						       , 'Bearer Instrument In/Wire Out'                                                                       , 'Velocity'                                          UNION ALL
	SELECT 'Cash Deposit in Correspondent Account [using template Large Reportable Transactions]'                                                                                                                                                                      , 'Cash Deposit in Correspondent Account'                                                               , 'Patterning'                                        UNION ALL
	SELECT 'Cash In Followed by Credit Card Payment [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                           , 'Cash In/Credit Card Payment Out'                                                                     , 'Velocity'                                          UNION ALL
	SELECT 'Cash In, Cash Out [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                                                 , 'Cash In/Cash Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Cash Out [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                                                  , 'Cash In/Cash Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Cash Out'                                                                                                                                                                                  														   , 'Cash In/Cash Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Cash-Check In/Wire Out'                                                                                                                                                                                  												   , 'Cash-Check In/Wire Out'                                                                              , 'Velocity'                                          UNION ALL	
	SELECT 'Cash In/Internal Transfer Out [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                                     , 'Cash In/Internal Transfer Out'                                                                       , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Internal Transfer Out'																																																							   , 'Cash In/Internal Transfer Out'                                                                       , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Monetary Instrument Out [using Rapid Movement of Funds - All Activity template]'                                                                                                                                                                   , 'Cash In/Monetary Instrument Out'                                                                     , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Monetary Instrument Out [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                                   , 'Cash In/Monetary Instrument Out'                                                                     , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Monetary Instrument Out'                                                                                                                                                                   														   , 'Cash In/Monetary Instrument Out'                                                                     , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Monetary Instrument Purchase Out [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                          , 'Cash In/Monetary Instrument Out'                                                                     , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Wire or Transfer Out [using template Rapid Movement of Funds – All Activity]'                                                                                                                                                                      , 'Cash In/Monetary Instrument Out'                                                                     , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Wire Out'                                                                                                                                                                                                                                          , 'Cash In/Wire Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Wire Out (using template Rapid Movement of Funds - All Activity)'                                                                                                                                                                                  , 'Cash In/Wire Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Wire Out [using Rapid Movement of Funds - All Activity template]'                                                                                                                                                                                  , 'Cash In/Wire Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Wire Out [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                                                  , 'Cash In/Wire Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Wire Out [using template Rapid Movement of Funds – All Activity]'                                                                                                                                                                                  , 'Cash In/Wire Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Wire, Monetary Instrument or Cheque Out'                                                                                                                                                                                                           , 'Cash In/Wire Out; Cash In/Monetary Instrument Out'                                                   , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Wires Out [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                                                 , 'Cash In/Wire Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Cash In/Purchases Out [using template Rapid Movement of Funds - All Activity]'																																											   , 'Cash In/Monetary Instrument Out'                                                                     , 'Velocity'                                          UNION ALL
	SELECT 'Cash Purchase of Monetary Instrument [using template Rapid Movement of Funds – All Activity]'                                                                                                                                                              , 'Cash In/Monetary Instrument Out'                                                                     , 'Velocity'                                          UNION ALL
	SELECT 'CIB - Product Utilization Shift'                                                                                                                                                                                                                           , 'CIB: Product Utilization Shift'                                                                      , 'Profiling'                                         UNION ALL
	SELECT 'CIB: High Risk Geography Activity [note that this scenario was not previously recommended but maps specifically to this indicator.]'                                                                                                                       , 'CIB: High Risk Geography'                                                                            , 'High Risk Geography (HRG)'              			 UNION ALL
	SELECT 'CIB: Product Utilization Shift'                                                                                                                                                                                                                            , 'CIB: Product Utilization Shift'                                                                      , 'Profiling'                                         UNION ALL
	SELECT 'CIB: Product Utilization Shift [using template [CIB: Product Utilization Shift]'                                                                                                                                                                           , 'CIB: Product Utilization Shift'                                                                      , 'Profiling'                                         UNION ALL
	SELECT 'CIB: Product Utlization Shift'                                                                                                                                                                                                                             , 'CIB: Product Utilization Shift'                                                                      , 'Profiling'                                         UNION ALL
	SELECT 'CIB: Product Utlization Shift [using template CIB: Product Utlization Shift]'                                                                                                                                                                              , 'CIB: Product Utilization Shift'                                                                      , 'Profiling'                                         UNION ALL
	SELECT 'CIB: Significant Change from Previous Average Activity'                                                                                                                                                                                                    , 'CIB: Significant Change from Previous Average Activity'                                              , 'Profiling'                                         UNION ALL
	SELECT 'CIB: Significant Change from Previous Average Activity  CIB: Product Utilization Shift'                                                                                                                                                                    , 'CIB: Significant Change from Previous Average Activity'                                              , 'Profiling'                                         UNION ALL
	SELECT 'CIB: Significant Change from Previous Peak Activity [note that this scenario was not recommended for Priority 1, but this indicator specifically maps to it]'                                                                                              , 'CIB: Significant Change from Previous Peak Activity'                                                 , 'Profiling'                                         UNION ALL
	SELECT 'CIB: Significant Change in Trade/Transaction Activity'                                                                                                                                                                                                     , 'CIB: Significant Change in Trade/Transaction Activity'                                               , 'Profiling'                                         UNION ALL
	SELECT 'Credit Card Payment Followed by Cash Advance [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                      , 'Credit Card Payment Followed By Cash Advance'                                                        , 'Velocity'                                          UNION ALL
	SELECT 'Currency Exchange Followed by Outgoing Wire (using template Rapid Movement of Funds - All Activity)'                                                                                                                                                       , 'Currency Exchange Followed by Wire'                                                                  , 'Velocity'                                          UNION ALL
	SELECT 'Customer Borrowing Against New Policy'                                                                                                                                                                                                                     , 'Customer Borrowing Against New Policy'                                                               , 'Borrowing/Refunds'                                 UNION ALL
	SELECT 'Customers Engaging in Offsetting Trades'                                                                                                                                                                                                                   , 'Customer Engaging in Offsetting Trades'                                                              , 'Manipulation'                                      UNION ALL
	SELECT 'Deposits/Withdrawals in Same/Similar Amounts'                                                                                                                                                                                                              , 'Deposits/Withdrawals in Similar Amounts'                                                             , 'Structuring/Threshold Avoidance'                   UNION ALL
	SELECT 'Deviation from Peer Group - Product Utilization [note that this rule was not previously recommended but it maps specifically to this indicator]'                                                                                                           , 'Deviation from Peer Group: Product Utilization'                                                      , 'Profiling'                                         UNION ALL
	SELECT 'Deviation from Peer Group - Product Utilization [note that this scenario was not recommended for Priority 1, but this indicator specifically maps to it]'                                                                                                  , 'Deviation from Peer Group: Product Utilization'                                                      , 'Profiling'                                         UNION ALL
	SELECT 'Deviation from Peer Group: Product Utilization'                                                                                                  																										   , 'Deviation from Peer Group: Product Utilization'                                                      , 'Profiling'                                         UNION ALL
	SELECT 'Deviation from Peer Group: Total Activity'                                                                                                                                                                                                                 , 'Deviation from Peer Group: Total Activity'                                                           , 'Profiling'                                         UNION ALL
	SELECT 'Deviation from Peer Group - Total Activity'                                                                                                                                                                                                                , 'Deviation from Peer Group: Total Activity'                                                           , 'Profiling'                                         UNION ALL
	SELECT 'Deviation from Peer Group -Total Activity'                                                                                                                                                                                                                 , 'Deviation from Peer Group: Total Activity'                                                           , 'Profiling'                                         UNION ALL
	SELECT 'Deviation from Peer Group -Total Activity  CIB - Deviation from Previous Average Activity'                                                                                                                                                                 , 'Deviation from Peer Group: Total Activity; CIB: Significant Change from Previous Average Activity'   , 'Profiling'                                         UNION ALL
	SELECT 'Domestic Wire In/International Wire Out [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                           , 'Domestic Wire In/International Wire Out'                                                             , 'Velocity'                                          UNION ALL
	SELECT 'Early Payoff or Paydown of a Credit Product'                                                                                                                                                                                                               , 'Early Payoff of a Credit Product'                                                                    , 'Early Redemption'                                  UNION ALL
	SELECT 'Early Payoff of a Credit Product'                                                                                                                                                                                                               , 'Early Payoff of a Credit Product'																			   , 'Early Redemption'                                  UNION ALL
	SELECT 'Early Redemption'																																																										   , 'Early Redemption'																					   , 'Early Redemption'                                  UNION ALL
	SELECT 'Electronic Payment/Cheque In, Cash Out'                                                                                                                                                                                                                    , 'Electronic Payment In/Cash Out; Cheque In/Cash Out'                                                  , 'Velocity'                                          UNION ALL
	SELECT 'Escalation in Inactive Account'                                                                                                                                                                                                                            , 'Escalation in Inactive Account'                                                                      , 'Profiling'                                         UNION ALL
	SELECT 'Foreign Currency Exchange followed by Wire Out [using template Rapid Movement of Funds - All Activity]  High Risk Transactions: High Risk Geography [using template High Risk Transactions: High Risk Geography]'                                          , 'Foreign Exchange Followed by Wire Out'                                                               , 'Velocity'                                          UNION ALL
	SELECT 'Foreign Exchange followed by Wire Out [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                             , 'Foreign Exchange Followed by Wire Out'                                                               , 'Velocity'                                          UNION ALL
	SELECT 'Foreign Exchange Followed by Wire Out'																																																					   , 'Foreign Exchange Followed by Wire Out'                                                               , 'Velocity'                                          UNION ALL	
	SELECT 'Frequent ATM Deposits [using template Large Reportable Transactions]'                                                                                                                                                                                      , 'Frequent ATM Deposits'                                                                               , 'Patterning'                                        UNION ALL
	SELECT 'Hidden Relationships'                                                                                                                                                                                                                                      , 'Hidden Relationships'                                                                                , 'Network of Customers'                              UNION ALL
	SELECT 'High Risk Electronic Transfers'                                                                                                                                                                                                                            , 'High Risk Electronic Transfers'                                                                      , 'High Risk Geography (HRG)'                         UNION ALL
	SELECT 'High Risk Instructions'                                                                                                                                                                                                                                    , 'High Risk Instructions'                                                                              , 'High Risk Geography (HRG)'                         UNION ALL
	SELECT 'High Risk Transactions: High Risk Counter Party'                                                                                                                                                                                                           , 'High Risk Transactions: High Risk Counter Party'                                                     , 'High Risk Geography (HRG)'                         UNION ALL
	SELECT 'High Risk Transactions: High Risk Focal Entity'                                                                                                                                                                                                            , 'High Risk Transactions: High Risk Focal Entity'                                                      , 'High Risk Geography (HRG)'                         UNION ALL
	SELECT 'High Risk Transactions: High Risk Geography'                                                                                                                                                                                                               , 'High Risk Transactions: High Risk Geography'                                                         , 'High Risk Geography (HRG)'                         UNION ALL
	SELECT 'High Risk Transactions: High Risk Geography  Hub and Spoke'                                                                                                                                                                                                , 'High Risk Transactions: High Risk Geography; Hub and Spoke'                                          , 'High Risk Geography (HRG); Funneling'              UNION ALL
	SELECT 'High Risk Transactions: High Risk Geography [using template High Risk Transactions: High Risk Geography]'                                                                                                                                                  , 'High Risk Transactions: High Risk Geography'                                                         , 'High Risk Geography (HRG)'                         UNION ALL
	SELECT 'Hub and Spoke'                                                                                                                                                                                                                                             , 'Hub and Spoke'                                                                                       , 'Funneling'                                         UNION ALL
	SELECT 'Insurance Policies with Refunds'                                                                                                                                                                                                                           , 'Insurance Policies with Refunds'                                                                     , 'Borrowing/Refunds'                                 UNION ALL
	SELECT 'Internal Transfer In/Wire Out [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                                     , 'Internal Transfer In/Wire Out '                                                                      , 'Velocity'                                          UNION ALL
	SELECT 'Journals Between Unrelated Accounts'                                                                                                                                                                                                                       , 'Journals Between Unrelated Accounts'                                                                 , 'Network of Customers'                              UNION ALL
	SELECT 'Large Cash Transaction [using template Large Reportable Transaction]'                                                                                                                                                                                      , 'Large Cash Transactions'                                                                             , 'Patterning'                                        UNION ALL
	SELECT 'Large Cash Transactions'                                                                                                                                                                                                                                   , 'Large Cash Transactions'                                                                             , 'Patterning'                                        UNION ALL
	SELECT 'Large Cash Transactions [using template Large Reportable Transactions]'                                                                                                                                                                                    , 'Large Cash Transactions'                                                                             , 'Patterning'                                        UNION ALL
	SELECT 'Large Cash Transactions [using template Large Reportable Transactions]  Large Monetary Instrument Transactions  [using template Large Reportable Transactions]  Large International Wire Transactions  [using template Large Reportable Transactions]'     , 'Large Cash Transactions'                                                                             , 'Patterning'                                        UNION ALL
	SELECT 'Large Credit Refunds (requires customization of scenario)'                                                                                                                                                                                                 , 'Large Credit Refunds'                                                                                , 'Borrowing/Refunds'                                 UNION ALL
	SELECT 'Large Credit Refunds'                                                                                                                                                                                                 									   , 'Large Credit Refunds'                                                                                , 'Borrowing/Refunds'                                 UNION ALL
	SELECT 'Large Currency Exchange [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                                           , 'Large Currency Exchange'                                                                             , 'Patterning'                                        UNION ALL
	SELECT 'Large Currrency Exchange (using either Rapid Movement of Funds – All Activity or Large Reportable Transactions template]'                                                                                                                                  , 'Large Currency Exchange'                                                                             , 'Patterning'                                        UNION ALL
	SELECT 'Large Currrency Exchange'                                                                                                                                  																								   , 'Large Currency Exchange'                                                                             , 'Patterning'                                        UNION ALL
	SELECT 'Large Depreciation of Account Value'                                                                                                                                                                                                                       , 'Large Depreciation of Account Value'                                                                 , 'Profiling'                                         UNION ALL
	SELECT 'Large Foreign Currency Purchase [using template Large Reportable Transactions]'                                                                                                                                                                            , 'Large Currency Exchange'                                                                             , 'Patterning'                                        UNION ALL
	SELECT 'Large Hydro Bill Payment [using Large Reportable Transactions template]'                                                                                                                                                                                   , 'Large Hydro Bill Payment'                                                                            , 'Lack of Economic Purpose'                          UNION ALL
	SELECT 'Large Monetary Instrument Transactions [using template Large Reportable Transactions]'                                                                                                                                                                     , 'Large Monetary Instrument Transactions'                                                              , 'Patterning'                                        UNION ALL
	SELECT 'Large Payments to Online Payment Services [using template Large Reportable Transactions]'                                                                                                                                                                  , 'Large Payments to Online Payment Services'                                                           , 'Lack of Economic Purpose'                          UNION ALL
	SELECT 'Large Positive Credit Card Balances (requires customization)'                                                                                                                                                                                              , 'Large Positive Credit Card Balances'                                                                 , 'Lack of Economic Purpose'                          UNION ALL
	SELECT 'Large Wire Transaction [using template Large Reportable Transactions]'                                                                                                                                                                                     , 'Large Wire Transfers'                                                                                , 'Lack of Economic Purpose'                          UNION ALL
	SELECT 'Large Wire Transactions [using template Large Reportable Transactions]'                                                                                                                                                                                    , 'Large Wire Transfers'                                                                                , 'Lack of Economic Purpose'                          UNION ALL
	SELECT 'Large Wire Transfer [using template Large Reportable Transactions]'                                                                                                                                                                                        , 'Large Wire Transfers'                                                                                , 'Lack of Economic Purpose'                          UNION ALL
	SELECT 'Large Wire Transfers [using Large Reportable Transactions template]  Large Check Transactions [using Large Reportable Transactions template]'                                                                                                              , 'Large Wire Transfers'                                                                                , 'Lack of Economic Purpose'                          UNION ALL
	SELECT 'Manipulation of Account/Customer Data Followed by Instruction Changes'                                                                                                                                                                                     , 'Manipulation of Account/Customer Data Followed by Instruction Changes'                               , 'Manipulation'                                      UNION ALL
	SELECT 'Micro Structuring [using template Structuring: Potential Structuring in Cash and Equivalents]'                                                                                                                                                             , 'Micro Structuring'                                                                                   , 'Structuring/Threshold Avoidance'                   UNION ALL
	SELECT 'Missing Counter Party Details (Custom Scenario)'                                                                                                                                                                                                           , 'Missing Counter Party Details'                                                                       , 'Identity Concealment'                              UNION ALL
	SELECT 'Missing Counter Party Details (Requires Customization of Scenario)'                                                                                                                                                                                        , 'Missing Counter Party Details'                                                                       , 'Identity Concealment'                              UNION ALL
	SELECT 'Missing Counter Party Details'                                                                                                                                                                                        									   , 'Missing Counter Party Details'                                                                       , 'Identity Concealment'                              UNION ALL
	SELECT 'Monetary Instrument In/Monetary Instrument Out [using Rapid Movement of Funds - All Activity template]'                                                                                                                                                    , 'Monetary Instrument In/Monetary Instrument Out'                                                      , 'Velocity'                                          UNION ALL
	SELECT 'Monetary Instrument In/Wire Out [using Rapid Movement of Funds - All Activity template]'																																								   , 'Monetary Instrument In/Wire Out'																	   , 'Velocity'                                          UNION ALL
	SELECT 'Third Party Monetary Instrument Deposits'																																								   												   , 'Monetary Instrument In/Monetary Instrument Out'													   , 'Velocity'                                          UNION ALL
	SELECT 'Monetary Instrument Structuring [using template Deposits/Withdrawals in Same or Similar Amounts]'                                                                                                                                                          , 'Monetary Instrument Structuring'                                                                     , 'Structuring/Threshold Avoidance'                   UNION ALL
	SELECT 'Monetary Instrument Structuring'                                                                                                                                                          																   , 'Monetary Instrument Structuring'                                                                     , 'Structuring/Threshold Avoidance'                   UNION ALL
	SELECT 'Movement of Funds without Corresponding Trade'                                                                                                                                                                                                             , 'Movement of Funds without Corresponding Trade'                                                       , 'Manipulation'                                      UNION ALL
	SELECT 'Multiple Jurisdictions (custom scenario)'                                                                                                                                                                                                                  , 'Multiple Jurisdictions'                                                                              , 'High Risk Geography (HRG)'                         UNION ALL
	SELECT 'Multiple Jurisdictions (Requires Customization of Scenario)'                                                                                                                                                                                               , 'Multiple Jurisdictions'                                                                              , 'High Risk Geography (HRG)'                         UNION ALL
	SELECT 'Multiple Jurisdictions'                                                                                                                                                                                               									   , 'Multiple Jurisdictions'                                                                              , 'High Risk Geography (HRG)'                         UNION ALL
	SELECT 'Nested Correspondent Rule  (Requires Customization of Scenario)'                                                                                                                                                                                           , 'Nested Correspondent Rule'                                                                           , 'Identity Concealment'                              UNION ALL
	SELECT 'Networks of Accounts, Entities and Customers'                                                                                                                                                                                                              , 'Networks of Accounts, Entities, and Customers'                                                       , 'Network of Customers'                              UNION ALL
	SELECT 'Networks of Accounts, Entities, and Customers'                                                                                                                                                                                                             , 'Networks of Accounts, Entities, and Customers'                                                       , 'Network of Customers'                              UNION ALL
	SELECT 'Pattern of Funds Transfers Between Correspondent Banks'                                                                                                                                                                                                    , 'Pattern of Funds Transfers between Correspondent Banks'                                              , 'Exclusive Relationship'                            UNION ALL
	SELECT 'Pattern of Funds Transfers between Internal Accounts and Customers'                                                                                                                                                                                        , 'Pattern of Funds Transfers between Internal Accounts and Customers'                                  , 'Exclusive Relationship'                            UNION ALL
	SELECT 'Pattern of Funds Transfers between Customers and External Entities'                                                                                                                                                                                        , 'Pattern of Funds Transfers between Customers and External Entities'                                  , 'Exclusive Relationship'                            UNION ALL
	SELECT 'Patterns of Funds Transfers between Customers and External Entities'                                                                                                                                                                                       , 'Pattern of Funds Transfers between Customers and External Entities'                                  , 'Exclusive Relationship'                            UNION ALL
	SELECT 'Patterns of Funds Transfers Between Internal Accounts and Customers'                                                                                                                                                                                       , 'Pattern of Funds Transfers between Internal Accounts and Customers'                                  , 'Exclusive Relationship'                            UNION ALL
	SELECT 'Patterns of Recurring Originators/ Beneficiaries in Funds Transfers'                                                                                                                                                                                       , 'Pattern of Funds Transfers between Recurring Originators/Beneficiaries'                              , 'Exclusive Relationship'                            UNION ALL
	SELECT 'Patterns of Recurring Originators/Beneficiaries in Funds Transfers'                                                                                                                                                                                        , 'Pattern of Funds Transfers between Recurring Originators/Beneficiaries'                              , 'Exclusive Relationship'                            UNION ALL
	SELECT 'Patterns of Sequentially Numbered Checks, Monetary Instruments'                                                                                                                                                                                            , 'Pattern of Sequentially Numbered Checks'                                                             , 'Patterning'                                        UNION ALL
	SELECT 'Pattern of Sequentially Numbered Checks'																																																				   , 'Pattern of Sequentially Numbered Checks'                                                             , 'Patterning'                                        UNION ALL
	SELECT 'Policies with Large Early Removal'                                                                                                                                                                                                                         , 'Policies with Large Early Removal'                                                                   , 'Early Redemption'                                  UNION ALL
	SELECT 'Rapid Movement Of Funds - All Activity'                                                                                                                                                                                                                    , 'Rapid Movement of Funds – All Activity'                                                              , 'Velocity'                                          UNION ALL
	SELECT 'Rapid Movement of Funds – All Activity'                                                                                                                                                                                                                    , 'Rapid Movement of Funds – All Activity'                                                              , 'Velocity'                                          UNION ALL
	SELECT 'Return of Cheques [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                                                 , 'Return of Cheques'                                                                                   , 'Lack of Economic Purpose'                          UNION ALL
	SELECT 'Structuring: Avoidance of Reporting Thresholds'                                                                                                                                                                                                            , 'Structuring: Avoidance of Reporting Thresholds'                                                      , 'Structuring/Threshold Avoidance'                   UNION ALL
	SELECT 'Structuring: Avoidance of Reporting Thresholds [using template Structuring: Potential Structuring in Cash and Equivalents]'                                                                                                                                , 'Structuring: Avoidance of Reporting Thresholds'                                                      , 'Structuring/Threshold Avoidance'                   UNION ALL
	SELECT 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                                                                                                                , 'Structuring: Potential Structuring in Cash and Equivalents'                                          , 'Structuring/Threshold Avoidance'                   UNION ALL
	SELECT 'Structuring: Potential Structuring in Cash and Equivalents  Large Cash Transactions [using template Large Reportable Transactions]'                                                                                                                        , 'Structuring: Potential Structuring in Cash and Equivalents; Large Cash Transactions'                 , 'Structuring/Threshold Avoidance; Patterning'       UNION ALL
	SELECT 'Structuring: Potential Structuring in Cash and Equivalents [using template Structuring: Potential Structuring in Cash and Eq'                                                                                                                              , 'Structuring: Potential Structuring in Cash and Equivalents'                                          , 'Structuring/Threshold Avoidance'                   UNION ALL
	SELECT 'Structuring: Potential Structuring in Cash and Equivalents [using template Structuring: Potential Structuring in Cash and Equivalents]'                                                                                                                    , 'Structuring: Potential Structuring in Cash and Equivalents'                                          , 'Structuring/Threshold Avoidance'                   UNION ALL
	SELECT 'Terrorist Financing'                                                                                                                                                                                                                                       , 'Terrorist Financing'                                                                                 , 'Funneling'                                         UNION ALL
	SELECT 'Wire In/Cash Out [using Rapid Movement of Funds - All Activity]'                                                                                                                                                                                           , 'Wire In/Cash Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Wire In/Cash Out [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                                                  , 'Wire In/Cash Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Wire In/Cash Out'                                                                                                                                                                                  														   , 'Wire In/Cash Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Wire In/Wire or Transfer Out [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                                      , 'Wire In/Wire Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Wire In/Wire Out'                                                                                                                                                                                                                                          , 'Wire In/Wire Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Wire In/Wire Out (using template Rapid Movement of Funds – All Activity)'                                                                                                                                                                                  , 'Wire In/Wire Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Wire In/Wire Out [using template Rapid Movement of Funds - All Activity]'                                                                                                                                                                                  , 'Wire In/Wire Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Wire In/Wire Out [using template Rapid Movement of Funds - All Activity]  Cheque or Monetary Instrument In/Wire Out [using template Rapid Movement of Funds - All Activity]'                                                                               , 'Wire In/Wire Out'                                                                                    , 'Velocity'                                          UNION ALL
	SELECT 'Wire Structring [using template Deposits/Withdrawals in Same or Similar Amounts]'                                                                                                                                                                          , 'Wire Structuring'                                                                                    , 'Structuring/Threshold Avoidance'                   UNION ALL
	SELECT 'Wire Structuring [using template Deposits/Withdrawals in Same or Similar Amounts]'                                                                                                                                                                         , 'Wire Structuring'                                                                                    , 'Structuring/Threshold Avoidance'                   UNION ALL
	SELECT 'Wire Structuring'                                                                                                                                                                                                                                          , 'Wire Structuring'                                                                                    , 'Structuring/Threshold Avoidance'                   UNION ALL
	SELECT 'Wire Structuring  (Requires Customization of Scenario)'                                                                                                                                                                                                    , 'Wire Structuring'                                                                                    , 'Structuring/Threshold Avoidance'                   UNION ALL
	SELECT 'Wire Structuring (requires customization of scenario)'                                                                                                                                                                                                     , 'Wire Structuring'                                                                                    , 'Structuring/Threshold Avoidance'
)

, InitialClean AS (
		SELECT IndicatorID
		, LTRIM(RTRIM(
		REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(p.r.value('.' , 'varchar(5000)'),'1.',''),'2.',''),CHAR(13),''),CHAR(10),''),'3.',''),'4.',''))) AS [Value]
		, p.r.value('for $i in . return count(../*[. << $i]) + 1', 'int') AS Position
		FROM TempData
			  CROSS APPLY ProposedRuleNameXML.nodes('//x') P(r)
		WHERE LTRIM(RTRIM(p.r.value('.' , 'varchar(5000)'))) != '' 
) 


, TempProposedXML AS (       
	SELECT 
		InitialClean.IndicatorID
		, CONVERT(XML,'<x>' + REPLACE(COALESCE(ProposedMapping.ProposedName, InitialClean.Value),';','</x><x>') + '</x>') AS ProposedRuleNameXML 
		, CONVERT(XML,'<x>' + REPLACE(COALESCE(ProposedMapping.ProposedRuleTheme, InitialClean.Value),';','</x><x>') + '</x>') AS ProposedRuleThemeXML
		, Position
	FROM InitialClean
	LEFT JOIN ProposedMapping ON InitialClean.Value = ProposedMapping.RuleName
	--ORDER BY 1, 2

)

, TempProposedRule AS (
	SELECT 
		IndicatorID
		, LTRIM(RTRIM(Element.Loc.value('.' , 'varchar(5000)'))) AS Value
		, Position + Element.Loc.value('for $i in . return count(../*[. << $i]) + 1', 'int') - 1 AS Position
	FROM TempProposedXML
	CROSS APPLY ProposedRuleNameXML.nodes('//x') Element(loc)
	--ORDER BY 2,1
)

, TempProposedTheme AS (
	SELECT 
		IndicatorID
		, LTRIM(RTRIM(Element.Loc.value('.' , 'varchar(5000)'))) AS Value
		, Position + Element.Loc.value('for $i in . return count(../*[. << $i]) + 1', 'int') - 1 AS Position
	FROM TempProposedXML
	CROSS APPLY ProposedRuleThemeXML.nodes('//x') Element(loc)
	--ORDER BY 1,2
)

, TempProposedRaw AS (
	SELECT COALESCE(TempProposedRule.IndicatorID, TempProposedTheme.IndicatorID) AS IndicatorID
		 , TempProposedRule.Value AS ProposedRule
		 , TempProposedTheme.Value AS ProposedTheme
		 , CASE WHEN TempProposedTheme.Value = '' THEN TempProposedTheme.Position ELSE ISNULL(TempProposedTheme.Position,TempProposedRule.Position) END AS Position
	FROM TempProposedRule 
	FULL OUTER JOIN TempProposedTheme 
		ON TempProposedRule.IndicatorID = TempProposedTheme.IndicatorID
		AND TempProposedRule.Position = TempProposedTheme.Position
	--ORDER BY 1, 2
)

, TempProposed AS (

	SELECT TempProposedRaw.IndicatorID
		, ISNULL(TempProposedRaw.ProposedRule, TempProposedRule.Value) AS ProposedRule
		, ISNULL(TempProposedRaw.ProposedTheme, TempProposedTheme.Value) AS ProposedTheme
		, TempProposedRaw.Position
	FROM TempProposedRaw 
	LEFT OUTER JOIN TempProposedTheme 
		ON TempProposedRaw.IndicatorID = TempProposedTheme.IndicatorID
		AND TempProposedTheme.Position = 1
		AND ISNULL(TempProposedRaw.ProposedTheme, '') = ''
	LEFT OUTER JOIN TempProposedRule 
		ON TempProposedRaw.IndicatorID = TempProposedRule.IndicatorID
		AND TempProposedRule.Position = 1
		AND ISNULL(TempProposedRaw.ProposedRule, '') = ''
	--ORDER BY 1, 2

)

, TempOracleRule AS (
	SELECT IndicatorID
	, REPLACE(REPLACE(LTRIM(RTRIM(p.r.value('.' , 'varchar(5000)'))),CHAR(13), ''),CHAR(10),'') AS [Value] -- add your rule name fixes
	, p.r.value('for $i in . return count(../*[. << $i]) + 1', 'int') AS Position
	FROM TempData
		  CROSS APPLY OracleRuleXML.nodes('//x') P(r)

)

, TempMatch AS (
	SELECT COALESCE(TempProposed.IndicatorID, TempOracleRule.IndicatorID) AS IndicatorID
	, TempProposed.ProposedRule AS ProposedRuleName
	, TempProposed.ProposedTheme AS ProposedRuleTheme
	, TempProposed.Position AS ProposedPosition
	, COALESCE(TempMap.OracleName, TempOracleRule.Value) AS [OracleRuleName] --Apply Cleaning Map
	, TempOracleRule.Position AS OraclePosition
	FROM TempProposed
	FULL OUTER JOIN TempOracleRule ON TempProposed.IndicatorID = TempOracleRule.IndicatorID
			AND TempProposed.Position = TempOracleRule.Position 
	LEFT OUTER JOIN TempOracleMapping TempMap
		ON TempMap.IndicatorName = TempOracleRule.[Value]
		
)

SELECT * INTO #TempMatch FROM TempMatch;

TRUNCATE TABLE dbo.TIndicatorXRule;

SET IDENTITY_INSERT dbo.TIndicatorXRule ON;

WITH TempData AS (
       
   SELECT IndicatorID 
		  , CONVERT(XML,'<x>' + REPLACE(ProposedRuleName,';','</x><x>') + '</x>') AS ProposedRuleNameXML
		  , CONVERT(XML,'<x>' + REPLACE(OracleRule,';','</x><x>') + '</x>') AS OracleRuleXML		  
		  , CONVERT(XML,'<x>' + REPLACE(NavigantRule,';','</x><x>') + '</x>') AS NavigantRuleXML
		  , CONVERT(XML,'<x>' + REPLACE(FortentRule,';','</x><x>') + '</x>') AS FortentRuleXML
		  
   FROM TStagingIndicator

) 

, TempNavForData AS (
	SELECT DISTINCT
		IndicatorID 
		, Source 
		, REPLACE(REPLACE(LTRIM(RTRIM(Element.Loc.value('.','varchar(255)'))),CHAR(13), ''),CHAR(10),'') AS RuleName
	FROM 
		(SELECT IndicatorID, 'Fortent' AS Source, FortentRuleXML AS RuleXML FROM TempData  UNION ALL
		SELECT IndicatorID, 'Navigant' AS Source, NavigantRuleXML AS RuleXML FROM TempData ) Rules
	CROSS APPLY RuleXML.nodes('/x') as Element(Loc)
	WHERE Element.Loc.value('.','varchar(255)') NOT IN ('N/A', ' ')
		
)


, OracleFinal AS (

	SELECT TempMatch.IndicatorID
		, COALESCE(TempMatch.OracleRuleName, TempMatchOracle.OracleRuleName) AS OracleRuleNameEnhanced
		, COALESCE(TempMatch.ProposedRuleName, TempMatchProposed.ProposedRuleName) AS ProposedRuleNameEnhanced
		, COALESCE(TempMatch.ProposedRuleTheme, TempMatchProposed.ProposedRuleTheme) AS ProposedThemeNameEnhanced
		, ISNULL(TempMatch.ProposedPosition, TempMatch.OraclePosition) AS POSITION
	FROM #TempMatch TempMatch
	LEFT OUTER JOIN #TempMatch TempMatchOracle
		ON TempMatchOracle.IndicatorID = TempMatch.IndicatorID 
		AND TempMatchOracle.OraclePosition = 1 
		AND COALESCE(TempMatch.OracleRuleName, 'N/A') = 'N/A'  -- use the first position if missing
	LEFT OUTER JOIN #TempMatch TempMatchProposed 
		ON TempMatchProposed.IndicatorID = TempMatch.IndicatorID 
		AND TempMatchProposed.ProposedPosition = 1 
		AND TempMatch.ProposedRuleName IS NULL  -- use the first position if missing
) 

, ProposedCoverage AS 
(
	SELECT 'Address Associated with Multiple, Recurring External Entities' AS ProposedRule , 'Address Associated with Multiple, Recurring External Entities' AS OracleTemplate , 'Partial' AS InOracle UNION ALL
	SELECT 'Address Associated with Multiple, Recurring External Entities'			    , 'Customers Engaging in Offsetting Trades'									   , 'Partial'	 UNION ALL
	SELECT 'Address Associated with Multiple, Recurring External Entities'			    , 'Hub and Spoke'															   , 'Partial'   UNION ALL	
	SELECT 'All Activity In/All Activity Out'                                           , 'Rapid Movement Of Funds - All Activity'                                     , 'Partial'   UNION ALL
	SELECT 'All Activity In/Cash Out'													, 'Transactions In Round Amounts'											   , 'Partial'   UNION ALL
	SELECT 'All Activity In/Cash Out'													, 'Rapid Movement Of Funds - All Activity'									   , 'None'      UNION ALL
	SELECT 'Anomalies in ATM, Bank Card: Excessive Withdrawals'                         , 'Anomalies in ATM, Bank Card: Excessive Withdrawals'                         , 'None'      UNION ALL
	SELECT 'Anomalies in ATM, Bank Card: Foreign Transactions'                          , 'Anomalies In ATM, Bank Card: Foreign Transactions'                          , 'None'      UNION ALL
	SELECT 'Automated PUPID Report'                                                     , 'Custom Scenario'                                                            , 'Partial'   UNION ALL
	SELECT 'Bearer Instrument In/Wire Out'												, 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL
	SELECT 'Cash Deposit in Correspondent Account'                                      , 'Large Reportable Transactions'                                              , 'Full'      UNION ALL
	SELECT 'Cash In/Cash Out'                                                           , 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL
	SELECT 'Cash In/Credit Card Payment Out'                                            , 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL
	SELECT 'Cash In/Internal Transfer Out'                                              , 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL
	SELECT 'Cash In/Monetary Instrument Out'                                            , 'Rapid Movement Of Funds - All Activity'                                     , 'Full'      UNION ALL
	SELECT 'Cash In/Wire Out'                                                           , 'Rapid Movement Of Funds - All Activity'                                     , 'Full'      UNION ALL
	SELECT 'Cheque In/Cash Out'                                                         , 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL
	SELECT 'CIB: High Risk Geography'                                                   , 'CIB: High Risk Geography Activity'                                          , 'Full'      UNION ALL
	SELECT 'CIB: Product Utilization Shift'                                             , 'CIB: Product Utilization Shift'                                             , 'Full'      UNION ALL
	SELECT 'CIB: Significant Change from Previous Average Activity'                     , 'CIB: Product Utilization Shift'                                             , 'Full'      UNION ALL
	SELECT 'CIB: Significant Change from Previous Average Activity'                     , 'CIB: Significant Change from Previous Average Activity'                     , 'Full'      UNION ALL
	SELECT 'CIB: Significant Change from Previous Peak Activity'                        , 'CIB: Significant Change From Previous Peak Activity'                        , 'Full'      UNION ALL
	SELECT 'CIB: Significant Change in Trade/Transaction Activity'                      , 'CIB: Significant Change in Trade/Transaction Activity'                      , 'Full'      UNION ALL
	SELECT 'Credit Card Payment Followed By Cash Advance'                               , 'Rapid Movement Of Funds - All Activity'                                     , 'Partial'   UNION ALL
	SELECT 'Currency Exchange Followed by Wire'                                         , 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL
	SELECT 'Customer Borrowing Against New Policy'                                      , 'Customer Borrowing Against New Policy'                                      , 'None'      UNION ALL
	SELECT 'Customer Engaging in Offsetting Trades'                                     , 'Customers Engaging in Offsetting Trades'                                    , 'None'      UNION ALL
	SELECT 'Deposits/Withdrawals in Similar Amounts'                                    , 'Deposits/Withdrawals in Same or Similar Amounts'                            , 'Full'      UNION ALL
	SELECT 'Deviation from Peer Group: Product Utilization'                             , 'Deviation From Peer Group - Product Utilization'                            , 'Full'      UNION ALL
	SELECT 'Deviation from Peer Group: Total Activity'                                  , 'Deviation from Peer Group - Total Activity'                                 , 'Full'      UNION ALL
	SELECT 'Domestic Wire In/International Wire Out'                                    , 'Rapid Movement Of Funds - All Activity'                                     , 'Full'      UNION ALL
	SELECT 'Early Payoff of a Credit Product'                                           , 'Early Payoff or Paydown of a Credit Product'                                , 'None'      UNION ALL
	SELECT 'Early Redemption'															, 'Early Payoff or Paydown of a Credit Product'                                , 'None'      UNION ALL
	SELECT 'Electronic Payment In/Cash Out'                                             , 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL
	SELECT 'Escalation in Inactive Account'                                             , 'Escalation in Inactive Account'                                             , 'Full'      UNION ALL
	SELECT 'Foreign Exchange Followed by Wire Out'                                      , 'High Risk Transactions: High Risk Geography'                                , 'None'      UNION ALL
	SELECT 'Foreign Exchange Followed by Wire Out'                                      , 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL
	SELECT 'Frequent ATM Deposits'                                                      , 'Large Reportable Transactions'                                              , 'Partial'   UNION ALL
	SELECT 'Hidden Relationships'                                                       , 'Hidden Relationships'                                                       , 'None'      UNION ALL
	SELECT 'High Risk Electronic Transfers'                                             , 'High Risk Electronic Transfers'                                             , 'None'      UNION ALL
	SELECT 'High Risk Instructions'                                                     , 'High Risk Instructions'                                                     , 'None'      UNION ALL
	SELECT 'High Risk Transactions: High Risk Counter Party'                            , 'High Risk Transactions: High Risk Counter Party'                            , 'None'      UNION ALL
	SELECT 'High Risk Transactions: High Risk Focal Entity'                             , 'High Risk Transactions: High Risk Counter Party'                            , 'Partial'   UNION ALL
	SELECT 'High Risk Transactions: High Risk Geography'                                , 'High Risk Transactions: High Risk Geography'                                , 'Full'      UNION ALL
	SELECT 'Hub and Spoke'                                                              , 'Hub and Spoke'                                                              , 'Full'      UNION ALL
	SELECT 'Insurance Policies with Refunds'                                            , 'Insurance Policies with Refunds'                                            , 'None'      UNION ALL
	SELECT 'Internal Transfer In/Wire Out'                                              , 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL
	SELECT 'Journals Between Unrelated Accounts'                                        , 'Journals Between Unrelated Accounts'                                        , 'None'      UNION ALL
	SELECT 'Large Cash Transactions'                                                    , 'Large Reportable Transactions'                                              , 'Full'      UNION ALL
	SELECT 'Large Credit Refunds'                                                       , 'Custom Scenario'                                                            , 'Partial'   UNION ALL
	SELECT 'Large Currency Exchange'                                                    , 'Large Reportable Transactions'                                              , 'None'      UNION ALL
	SELECT 'Large Currency Exchange'                                                    , 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL
	SELECT 'Large Depreciation of Account Value'                                        , 'Large Depreciation of Account Value'                                        , 'None'      UNION ALL
	SELECT 'Large Hydro Bill Payment'                                                   , 'Large Reportable Transactions'                                              , 'None'      UNION ALL
	SELECT 'Large Monetary Instrument Transactions'                                     , 'Large Reportable Transactions'                                              , 'None'      UNION ALL
	SELECT 'Large Payments to Online Payment Services'                                  , 'Large Reportable Transactions'                                              , 'None'      UNION ALL
	SELECT 'Large Positive Credit Card Balances'                                        , 'Custom Scenario'                                                            , 'None'      UNION ALL
	SELECT 'Large Wire Transfers'                                                       , 'Large Reportable Transactions'                                              , 'Full'      UNION ALL
	SELECT 'Manipulation of Account/Customer Data Followed by Instruction Changes'      , 'Manipulation of Account/Customer Data Followed by Instruction Changes'      , 'None'      UNION ALL
	SELECT 'Micro Structuring'                                                          , 'Structuring: Potential Structuring in Cash and Equivalents'                 , 'Full'      UNION ALL
	SELECT 'Missing Counter Party Details'                                              , 'Custom Scenario'                                                            , 'None'      UNION ALL
	SELECT 'Monetary Instrument In/Monetary Instrument Out'                             , 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL
	SELECT 'Monetary Instrument In/Monetary Instrument Out'                             , 'Structuring: Deposits/Withdrawals Of Mixed Monetary Instruments'            , 'None'      UNION ALL
	SELECT 'Monetary Instrument In/Wire Out'											, 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL	
	SELECT 'Monetary Instrument Structuring'                                            , 'Deposits/Withdrawals in Same or Similar Amounts'                            , 'Partial'   UNION ALL
	SELECT 'Movement of Funds without Corresponding Trade'                              , 'Movement of Funds without Corresponding Trade'                              , 'None'      UNION ALL
	SELECT 'Multiple Jurisdictions'                                                     , 'Custom Scenario'                                                            , 'Partial'   UNION ALL
	SELECT 'Nested Correspondent Rule'                                                  , 'Custom Scenario'                                                            , 'Partial'   UNION ALL
	SELECT 'Networks of Accounts, Entities, and Customers'                              , 'Networks Of Accounts, Entities, And Customers'                              , 'None'      UNION ALL
	SELECT 'Pattern of Funds Transfers between Correspondent Banks'                     , 'Pattern of Funds Transfers Between Correspondent Banks'                     , 'Partial'   UNION ALL
	SELECT 'Pattern of Funds Transfers between Customers and External Entities'         , 'Patterns Of Funds Transfers Between Customers And External Entities'        , 'Full'      UNION ALL
	SELECT 'Pattern of Funds Transfers between Internal Accounts and Customers'         , 'Patterns of Funds Transfers Between Internal Accounts and Customers'        , 'Full'      UNION ALL
	SELECT 'Pattern of Funds Transfers between Recurring Originators/Beneficiaries'     , 'Patterns Of Recurring Originators/Beneficiaries In Funds Transfers'         , 'Full'      UNION ALL
	SELECT 'Pattern of Sequentially Numbered Checks'                                    , 'Patterns of Sequentially Numbered Checks, Monetary Instruments'             , 'None'      UNION ALL
	SELECT 'Policies with Large Early Removal'                                          , 'Policies with Large Early Removal'                                          , 'None'      UNION ALL
	SELECT 'Rapid Movement of Funds – All Activity'                                     , 'Custom Scenario'                                                            , 'None'      UNION ALL
	SELECT 'Rapid Movement of Funds – All Activity'                                     , 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL
	SELECT 'Return of Cheques'                                                          , 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL
	SELECT 'Structuring: Avoidance of Reporting Thresholds'                             , 'Structuring: Avoidance of Reporting Thresholds'                             , 'Full'      UNION ALL
	SELECT 'Structuring: Avoidance of Reporting Thresholds'                             , 'Structuring: Potential Structuring in Cash and Equivalents'                 , 'Full'      UNION ALL
	SELECT 'Structuring: Avoidance of Reporting Thresholds'                             , 'Escalation in Inactive Account'											   , 'Full'      UNION ALL
	SELECT 'Structuring: Avoidance of Reporting Thresholds'                             , 'Deposits/Withdrawals in Same or Similar Amounts'							   , 'Full'      UNION ALL
	SELECT 'Structuring: Potential Structuring in Cash and Equivalents'                 , 'Deposits/Withdrawals in Same or Similar Amounts'                            , 'Full'      UNION ALL
	SELECT 'Structuring: Potential Structuring in Cash and Equivalents'                 , 'Structuring: Potential Structuring in Cash and Equivalents'                 , 'Full'      UNION ALL
	SELECT 'Terrorist Financing'                                                        , 'Terrorist Financing'                                                        , 'None'      UNION ALL
	SELECT 'Wire In/Cash Out'                                                           , 'Rapid Movement Of Funds - All Activity'                                     , 'None'      UNION ALL
	SELECT 'Wire In/Wire Out'                                                           , 'Rapid Movement Of Funds - All Activity'                                     , 'Full'      UNION ALL
	SELECT 'Wire Structuring'                                                           , 'Custom Scenario'                                                            , 'Full'      UNION ALL
	SELECT 'Wire Structuring'                                                           , 'Structuring: Potential Structuring in Cash and Equivalents'                 , 'Full'		 UNION ALL 
	SELECT 'Wire Structuring'                                                           , 'Deposits/Withdrawals in Same or Similar Amounts'                            , 'Full'

)


INSERT INTO dbo.TIndicatorXRule (IndicatorXRuleID, IndicatorID, RuleID, ProposedRuleName, ProposedTheme, InOracle, Focus)
SELECT
	ROW_NUMBER() OVER (ORDER BY Rules.IndicatorID, VTRule.RuleID) AS IndicatorXRuleID
	, Rules.IndicatorID
	, VTRule.RuleID
	, Rules.ProposedRuleName
	, Rules.ProposedTheme
	, ProposedCoverage.InOracle
	, NULL 
	
	--, Rules.RuleName
	--, VTRule.Source RuleSource
	--, Rules.Source GenSource
	--, OracleTSD.Category

FROM (
	SELECT
		IndicatorID
		, OracleRuleNameEnhanced AS RuleName
		, 'Oracle' AS Source
		, ProposedRuleNameEnhanced AS ProposedRuleName
		, ProposedThemeNameEnhanced AS ProposedTheme
	FROM OracleFinal UNION ALL
	SELECT
		IndicatorID
		, RuleName
		, Source
		, NULL 
		, NULL
	FROM TempNavForData ) Rules
LEFT OUTER JOIN VTRule ON  Rules.RuleName = VTRule.RuleName
LEFT OUTER JOIN ProposedCoverage 
	ON VTRule.RuleName = ProposedCoverage.OracleTemplate AND VTRule.Source = 'Oracle'
	AND Rules.ProposedRuleName = ProposedCoverage.ProposedRule
--LEFT OUTER JOIN OracleRules ON Rules.RuleName = OracleRules.RuleName --Add in From TRule Code to QA
WHERE Rules.RuleName NOT IN ('N/A', ' ');
SET IDENTITY_INSERT dbo.TIndicatorXRule OFF;

--SELECT * FROM TIndicatorXRule;

/**************************************************************************************************/
--I. TThemeDescription
/**************************************************************************************************/

/*

This table lists all proposed rule mapped behavioral themes 
and provides a detailed description of each. 

*/ 


WITH ThemeDescription AS (
	SELECT 1 AS ThemeID , 'Borrowing/Refunds' AS ThemeName , 'Customer Borrowing against new policy, insurance policies with refunds and large credit refunds.' AS ThemeDescription                                                                                                                                                                                                                                                                                                                                                                                                                                              UNION ALL
	SELECT 2    , 'Early Redemption'                   , 'Early repayment or redemption is a behavior typically associated with long-term lending or investment products where there is a sudden, early pay off or cancellation of the product to layer and then integrate funds.'                                                                                                                                                                                                                                                                                                                                              UNION ALL
	SELECT 3    , 'Exclusive Relationship'             , 'Exclusive relationship is a behavior that is typically associated a high amount of transaction activity between those accounts which reveals a previously unknown link between unrelated accounts.'                                                                                                                                                                                                                                                                                                                                                                    UNION ALL
	SELECT 4    , 'Funneling'                          , 'Funneling is a patterning type behavior where multiple parties access funds through a single party and vice versa often giving access to funds in a different jurisdiction. This includes Many-to-One, One-to-Many, Many-to-Many complex transaction patter behaviors.'                                                                                                                                                                                                                                                                                                UNION ALL
	SELECT 5    , 'High Risk Geography (HRG)'          , 'This theme involves transactions to or from jurisdictions of concern for money laundering, offshore jurisdictions, and/or jurisdictions known to be tax havens as these locations are known for lax money laundering regulations or locations that are not transparent with regard to the originator or beneficiary of funds.'                                                                                                                                                                                                                                         UNION ALL
	SELECT 6    , 'Identity Concealment'               , 'This theme involves a pattern of behavior where the transaction originator attempts to conceal his/her identity or the beneficiary’s identity such as transactions which request payment in cash or fund transfers missing key information on the parties to the transfer. Lack of transparency into the originator, source of funds, or beneficiary is an indicia of potential money laundering.'                                                                                                                                                                     UNION ALL
	SELECT 7    , 'Lack of Economic Purpose'           , 'This pattern of behavior reflects transactions generally that appear to have little to no economic purpose.  For example, wire transfers that are directed through numerous countries, transactions which take a circuitous route (funds come in and out of the account in a circular fashion), and a party sending multiple wires to the same recipient on the same day for differing amounts rather than as part of one single transaction.'                                                                                                                       UNION ALL
	SELECT 8    , 'Manipulation'                       , 'Manipulation is typically evidenced by an effort to create misleading, artificial, or false activity in the market place for the purpose of capturing a gain in price or to avoid a loss.'                                                                                                                                                                                                                                                                                                                                                                           UNION ALL
	SELECT 9    , 'Network of Customers'               , 'This pattern of behavior involves coordinated efforts by customers to move funds or securities, such as transfers of securities between unrelated accounts or fund transfers between seemingly unrelated accounts or third parties.'                                                                                                                                                                                                                                                                                                                                   UNION ALL
	SELECT 10   , 'Patterning'                         , 'Patterning typically involves the identification of a series of general transaction behavior that is indicative of illicit activity.  For example, a domestic account that has a large number of foreign ATM deposits or withdrawals or a business account is funded through frequent large cash deposits.'                                                                                                                                                                                                                                                        UNION ALL
	SELECT 11   , 'Profiling'                          , 'This theme relates to transactions out of line with the historical or anticipated activity of the customer or customer’s peer group, which could indicate potentially illicit behavior.'                                                                                                                                                                                                                                                                                                                                                                               UNION ALL
	SELECT 12   , 'Structuring/Threshold Avoidance'    , 'Reporting thresholds have been established by regulators to create mandatory levels at which transaction activity information must be collected and reported. Any attempt to circumvent or structure transactions to avoid these reporting thresholds can be an indicia of suspicious behavior. Common examples are receiving cash deposits on two consecutive days to avoid a single day reporting threshold, or multiple low-dollar transactions sent to the same recipient that aggregate to an amount above a mandated threshold.'								 UNION ALL
	SELECT 13   , 'Velocity'                           , 'Velocity patterns typically involve transactions that occur in rapid succession, such as the request for payment in cash immediately upon the deposit or receipt of a funds transfer or transactions involving foreign exchanges followed shortly with a wiring of funds to high-risk jurisdictions. Transactions of this type typically indicate an account is being used to facilitate a transfer or act as a pass through for a transaction.'
)
SELECT * INTO dbo.TThemeDescription FROM ThemeDescription;



/**************************************************************************************************/
/***********************************II. Product Staging********************************************/
/**************************************************************************************************/

/* 

This process entails importing bank product data and merging with the indicator staging data
to create an indicator to product mapping via designated product groups. 

The final indicator view in this section collates all tables into an enhanced version
of the staging file with cleaned data. 


TProduct 			
TIndicatorStaging	-->     TIndicatorXProduct
(or Staging proxy)


Tindicator
TindicatorXModifier
TindicatorXTheme
TIndicatorXRule
TIndicatorXProduct  -->		VIndicator
TRule
TTheme
TModifier
TProduct


*/



/**************************************************************************************************/
--A. TProduct
/**************************************************************************************************/

/* 

This table represents the latest product data to be imported.

Note: 
	--The source of this staging table was imported using Excel/Access. 
	--Consider the data types below prior to loading in.
	--Products which identify with multiple Product Groupings split into separate rows.  

*/


DROP TABLE dbo.TProduct;

CREATE TABLE [dbo].[TProduct]
(
	[ProductID] [int] NOT NULL IDENTITY(1, 1),
	--[StagingID] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Segment] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BusinessUnit] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[System] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Type] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductOrService] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductOrServiceDescription] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductGrouping] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductSubGrouping] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsConduciveToAutomatedMonitoring] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	--[IsEvaluatedInCoverageAssessment] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	--[IsMVP1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UnderlyingProductTxnsToBeMonitored] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Comment] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Question] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Currency] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsProductOrService] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Inherent risk has been identified in regulatory guidance or indu] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Product has been highlighted in recent AML enforcement actions, ] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Transactions related to this product may result in cross-border ] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Product features enable unrelated or third parties to make or re] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Product features enable anonymity in the transaction] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Product features enable change in customer ownership/sponsorship] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Elevated risks are associated with the method in which the produ] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[1 Branch] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[2 ScotiaOnline] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[3 ScotiaConnect] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[4 Mobile] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[5 ABM] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[6 Night Deposit, Mail, Courier] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[7 IVR] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[8 Call Center] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[9 SWIFT Wires] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[10 Non-SWIFT Payments] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[11 Wealth Channels/PIC] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[12 Commercial Channels (RM/Fulfillment Team)] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Comments] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL, 
	[Rating] [int] 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TProduct] ON;

WITH TempData AS (
	SELECT
		[ID], 
		CONVERT(XML,'<x>' + REPLACE([Product Grouping (separate by ";" if more than one)],';','</x><x>') + '</x>') AS ProductXML
	FROM XTProduct20181220
)

, SplitGrouping AS (

	SELECT 
		[ID], 
		LTRIM(RTRIM(p.r.value('.', 'varchar(50)'))) AS ProductGrouping
	FROM TempData
	CROSS APPLY ProductXML.nodes('/x') as P(r) 
)

, ProductGroupETL AS
(
SELECT 'EFT' AS InitialGrouping				, 'Electronic Funds Transfer'		AS ProposedGrouping UNION ALL
SELECT 'Moblie/Internet Payment'			, 'Mobile/Internet Payment'		UNION ALL
SELECT 'Depository Accounts - Investment'	, 'Depository Account - Investment' 
)

INSERT INTO dbo.TProduct
(
    ProductID,
	Segment,
    BusinessUnit,
    System,
    Type,
    ProductOrService,
    ProductOrServiceDescription,
    ProductGrouping,
    ProductSubGrouping,
    IsConduciveToAutomatedMonitoring,
    --IsEvaluatedInCoverageAssessment,
    --IsMVP1,
    UnderlyingProductTxnsToBeMonitored,
    Comment,
    Question,
    Currency,
    IsProductOrService,
    [Inherent risk has been identified in regulatory guidance or indu],
    [Product has been highlighted in recent AML enforcement actions, ],
    [Transactions related to this product may result in cross-border ],
    [Product features enable unrelated or third parties to make or re],
    [Product features enable anonymity in the transaction],
    [Product features enable change in customer ownership/sponsorship],
    [Elevated risks are associated with the method in which the produ],
    [1 Branch],
    [2 ScotiaOnline],
    [3 ScotiaConnect],
    [4 Mobile],
    [5 ABM],
    [6 Night Deposit, Mail, Courier],
    [7 IVR],
    [8 Call Center],
    [9 SWIFT Wires],
    [10 Non-SWIFT Payments],
    [11 Wealth Channels/PIC],
    [12 Commercial Channels (RM/Fulfillment Team)],
    Comments, 
	Rating
)


SELECT 
	ROW_NUMBER() OVER (ORDER BY [Segment],[Product/Service],COALESCE(ProductGroupETL.ProposedGrouping,SplitGrouping.ProductGrouping)) AS ProductID,
	--Staging.ProductID AS StagingID,
	[Segment] AS Segment,
	[CB Business Unit / GBM Business Line] AS BusinessUnit,
	[System] AS System,
	[Type] AS Type,
	[Product/Service] AS ProductOrService,
	[Product/Service Description] AS ProductOrServiceDescription,
	COALESCE(ProductGroupETL.ProposedGrouping,SplitGrouping.ProductGrouping) AS ProductGrouping,
	[Product Sub-Grouping (separate by ";" if more than one)] AS ProductSubGrouping,
	[Conducive to Automated Monitoring (AML surveillance specific)?] AS IsConduciveToAutomatedMonitoring,
	--[Evaluated During Coverage Assessment?] AS IsEvaluatedInCoverageAssessment,
	--[Covered by MVP1?] AS IsMVP1,
	[Where applicable, Are Underlying Products/Transactions Monitored] AS UnderlyingProductTxnsToBeMonitored,
	[Review Comment] AS Comment,
	[Question] AS Question,
	[Currency] AS Currency,
	[Product or Service] AS IsProductOrService,
	[Inherent risk has been identified in regulatory guidance or indu],
	[Product has been highlighted in recent AML enforcement actions, ],
	[Transactions related to this product may result in cross-border ],
	[Product features enable unrelated or third parties to make or re],
	[Product features enable anonymity in the transaction],
	[Product features enable change in customer ownership/sponsorship],
	[Elevated risks are associated with the method in which the produ],
	[1 Branch],
	[2 ScotiaOnline],
	[3 ScotiaConnect],
	[4 Mobile],
	[5 ABM],
	[6 Night Deposit, Mail, Courier],
	[7 IVR],
	[8 Call Center],
	[9 SWIFT Wires],
	[10 Non-SWIFT Payments],
	[11 Wealth Channels/PIC],
	[12 Commercial Channels (RM/Fulfillment Team)],
	[Comments], 
	CASE Rating WHEN 'High' THEN 1 WHEN 'Moderate' THEN 2 WHEN 'Low' THEN 3 END AS Rating
FROM dbo.XTProduct20181220 Staging
LEFT JOIN SplitGrouping ON Staging.[ID] = SplitGrouping.[ID]
LEFT JOIN ProductGroupETL ON SplitGrouping.ProductGrouping = ProductGroupETL.InitialGrouping;
--WHERE Staging.Segment NOT IN ('GBM')
SET IDENTITY_INSERT TProduct OFF;

--SELECT * FROM TProduct;

/**************************************************************************************************/
--B. TIndicatorXProduct
/**************************************************************************************************/

/* 

This table applies product group coverage from the indicator staging table 
to the products in the product table. 

Note: 
	--The script should respond dynamically to different amounts of product groups so long as 
	the non-product group fields are specified. 


*/


--Using updated VIndicator output
DECLARE @IndStagingTable VARCHAR(100);
DECLARE @V_SQL nvarchar(max);
SET IDENTITY_INSERT TIndicatorXProduct ON;
SET @IndStagingTable = 'XTIndicator20181220'
SET @V_SQL = '
WITH OrdinalReference AS (
	SELECT * 
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = N'''+@IndStagingTable+'''
)

, Products AS (
SELECT COLUMN_NAME AS Product
FROM OrdinalReference
WHERE COLUMN_NAME NOT IN 
	(
		''IndicatorID'',
		''IndicatorRefID'',
		''Indicator'',
		''Segment'',
		''Business Line'',
		''Is Applicable To Bank'',
		''Is Conducive To Automated Monitoring'',
		''Priority'',
		''Red Flag Theme 1'',
		''Red Flag Theme 2'',
		''Red Flag Theme 3'',
		''Oracle Template'',
		''Proposed Rule Name'',
		''Navigant Template'',
		''Fortent Template'',
		''Modifier'',
		''In Oracle MVP1'',
		''Coverage Including Oracle MVP1 And Fortent'',
		''Rule Coverage Notes'',
		''Fortent Coverage'',
		''Fortent Rule Coverage Notes'',
		''Revision History'',
		''Rating'',
		''IsDuplicate''
	)
	AND ORDINAL_POSITION > 
		(SELECT ORDINAL_POSITION 
		FROM OrdinalReference 
		WHERE COLUMN_NAME = ''IsDuplicate''))
		
SELECT @ProdIn = ''''+LEFT(ProdGroup, LEN(ProdGroup)-1)+''''
FROM (
	SELECT CONVERT(VARCHAR(5000),ProdGroup) ProdGroup FROM 
		(SELECT
			(SELECT DISTINCT 
				''[''+Product+''], ''
			FROM Products
			ORDER BY 1
			FOR XML PATH('''')) ProdGroup ) ProdList
	) ListStore;'

--PRINT @V_SQL;
--EXEC (@V_SQL);
DECLARE @ProductList NVARCHAR(max);
SET @ProductList = ''
exec sp_executesql @V_SQL, N'@ProdIn nvarchar(4000) out', @ProductList OUT;
--PRINT @ProductList;

DECLARE @W_SQL NVARCHAR(MAX); 

SET @W_SQL = '
TRUNCATE TABLE TIndicatorXProduct;

WITH IndicatorMapping AS (
SELECT 
	TIndicator.[IndicatorID],
	ProductCoverage, 
	ProductType
FROM  '+@IndStagingTable+' 
UNPIVOT (ProductCoverage for ProductType IN ('+@ProductList+')) upvt 
LEFT JOIN TIndicator ON upvt.IndicatorRefID = TIndicator.IndicatorRefID AND upvt.Segment = TIndicator.Segment
WHERE ISNULL(TIndicator.IsConduciveToAutomatedMonitoring,2) <> 0
)


INSERT INTO dbo.TIndicatorXProduct (IndicatorXProductID, IndicatorID, ProductID, CoverageLevel)	
SELECT 
	ROW_NUMBER() OVER (ORDER BY IndicatorMapping.[IndicatorID], TProduct.ProductID) IndicatorXProductID
	, IndicatorMapping.[IndicatorID]
	, TProduct.ProductID
	--, IndicatorMapping.ProductType
	--, TProduct.ProductOrService
	--, TProduct.ProductGrouping
	, IndicatorMapping.ProductCoverage AS CoverageLevel
FROM IndicatorMapping
LEFT JOIN dbo.TProduct ON IndicatorMapping.ProductType = TProduct.ProductGrouping;
';

--PRINT @W_SQL;
EXEC (@W_SQL);
SET IDENTITY_INSERT TIndicatorXProduct OFF;

--SELECT * FROM TIndicatorXProduct;


/**************************************************************************************************/
--C. VIndicator
/**************************************************************************************************/

/* 

This view combines all other tables into a single view which standardizes the staging table data.


*/


DECLARE @Lists TABLE (ListType VARCHAR(50), List VARCHAR(5000));
INSERT @Lists (ListType, List)

--Create All Dynamic Lists
SELECT 'Theme', ''+LEFT(RedFlag, LEN(RedFlag)-1)+'' 
FROM (
	SELECT CONVERT(VARCHAR(1000),RedFlag) RedFlag FROM 
		(SELECT
			(SELECT DISTINCT 
				'[Red Flag Theme '+CONVERT(VARCHAR(1),Priority)+'], '
			FROM TIndicatorXTheme
			ORDER BY 1
			FOR XML PATH('')) RedFlag ) ThemeList
	) ListStore UNION ALL
--Create Product Grouping List
SELECT 'Product Group', ''+LEFT(ProdGroup, LEN(ProdGroup)-1)+'' 
FROM (
	SELECT CONVERT(VARCHAR(5000),ProdGroup) ProdGroup FROM 
		(SELECT
			(SELECT DISTINCT 
				'['+ProductGrouping+'], '
			FROM TProduct
			ORDER BY 1
			FOR XML PATH('')) ProdGroup ) ProdList
	) ListStore

DECLARE @V_SQL varchar(8000)
SET @V_SQL = '';

SET @V_SQL = @V_SQL+'ALTER VIEW dbo.VIndicator AS
WITH RuleList AS (

	SELECT 
		IndicatorID

		, (SELECT DISTINCT RuleName+'';'' 
			FROM TIndicatorXRule
			LEFT JOIN TRule ON TIndicatorXRule.RuleID = TRule.RuleID
			WHERE Source = ''Oracle'' AND TIndicatorXRule.IndicatorID = TInd.IndicatorID
			ORDER BY 1
			FOR XML PATH('''')) AS  OracleTemplate
		, (SELECT DISTINCT ProposedTheme+'';'' 
			FROM TIndicatorXRule
			WHERE TIndicatorXRule.IndicatorID = TInd.IndicatorID AND ProposedTheme <> ''''
			ORDER BY 1
			FOR XML PATH('''')) AS ProposedThemes
		, (SELECT DISTINCT ProposedRuleName+'';'' 
			FROM TIndicatorXRule
			WHERE TIndicatorXRule.IndicatorID = TInd.IndicatorID AND ProposedRuleName <> ''''
			ORDER BY 1
			FOR XML PATH('''')) AS ProposedTemplate
		,  (SELECT DISTINCT RuleName+'';'' 
			FROM TIndicatorXRule
			LEFT JOIN TRule ON TIndicatorXRule.RuleID = TRule.RuleID
			WHERE Source = ''Navigant'' AND TIndicatorXRule.IndicatorID = TInd.IndicatorID
			ORDER BY 1
			FOR XML PATH('''')) AS  NavigantTemplate
		,  (SELECT DISTINCT RuleName+'';'' 
			FROM TIndicatorXRule
			LEFT JOIN TRule ON TIndicatorXRule.RuleID = TRule.RuleID
			WHERE Source = ''Fortent'' AND TIndicatorXRule.IndicatorID = TInd.IndicatorID
			ORDER BY 1
			FOR XML PATH('''')) AS  FortentTemplate

		,   (SELECT DISTINCT ModifierName+'';'' 
			FROM TIndicatorXModifier
			LEFT JOIN TModifier ON TIndicatorXModifier.ModifierID = TModifier.ModifierID
			WHERE TIndicatorXModifier.IndicatorID = TInd.IndicatorID
			ORDER BY 1
			FOR XML PATH('''')) AS  ModifierName
	FROM TIndicator TInd
)



, CoverageSetup AS (
SELECT 
	TIndicator.*
	, TProduct.ProductGrouping
	, CoverageLevel
	, Theme
	, ''Red Flag Theme ''+CONVERT(VARCHAR(1),TIndicatorXTheme.Priority) AS FlagPriority
	, LEFT(ModifierName,LEN(ModifierName)-1) AS Modifier
	, LEFT(ProposedThemes,LEN(ProposedThemes)-1) AS ProposedThemes
	, LEFT(OracleTemplate, LEN(OracleTemplate)-1) AS OracleTemplate
	, LEFT(ProposedTemplate, LEN(ProposedTemplate)-1) AS ProposedTemplate
	, LEFT(NavigantTemplate, LEN(NavigantTemplate)-1) AS NavigantTemplate
	, LEFT(FortentTemplate, LEN(FortentTemplate)-1) AS FortentTemplate
	, MAX(TProduct.Rating) OVER (PARTITION BY TIndicator.IndicatorID) AS Rating
FROM TIndicator
LEFT JOIN RuleList ON TIndicator.IndicatorID = RuleList.IndicatorID
LEFT JOIN TIndicatorXTheme ON TIndicator.IndicatorID = TIndicatorXTheme.IndicatorID
LEFT JOIN TIndicatorXProduct ON TIndicatorXProduct.IndicatorID = TIndicator.IndicatorID
LEFT JOIN TProduct ON TIndicatorXProduct.ProductID = TProduct.ProductID
LEFT JOIN TTheme ON TIndicatorXTheme.ThemeID = TTheme.ThemeID
)

, FullView AS ( 
SELECT *
FROM CoverageSetup
PIVOT (MAX([Theme]) FOR [FlagPriority] IN ('
--Incorporating Themes

DECLARE @ThemeList VARCHAR(100)
SELECT @ThemeList = List FROM @Lists WHERE ListType = 'Theme'
SET @V_SQL = @V_SQL+@ThemeList;


SET @V_SQL = @V_SQL+')) ThemePivot

PIVOT (MAX(CoverageLevel) FOR [ProductGrouping] IN ('

--Incorporating Product Groups
DECLARE @ProductGroup VARCHAR(5000)
SELECT @ProductGroup = List FROM @Lists WHERE ListType = 'Product Group'
SET @V_SQL = @V_SQL+@ProductGroup+')) pvt
)

SELECT
	IndicatorID
     , IndicatorRefID
     , Indicator
	 , Segment

       -- Core
       , BusinessLine
       , IsApplicableToBank
       , IsConduciveToAutomatedMonitoring
       , Priority, 

		-- Red Flags
		'+@ThemeList+'
		--, [Red Flag Rule 1]
		--, [Red Flag Rule 2]
		--, [Red Flag Rule 3]

       -- Rules
     , OracleTemplate
     , ProposedTemplate AS [ProposedRuleName]
     , NavigantTemplate
     , FortentTemplate
     , ProposedThemes AS [Themes]
	 , Modifier
	 , Rating

       -- Client Specific Meta Data
       , InOracleMVP1
       , CoverageInclOracleMVP1AndFortent
       , RuleCoverageNotes

       , FortentCoverage
       , FortentRuleCoverageNotes
       
       , RevisionHistory
	   , IsDuplicate,'+ 
	   @ProductGroup+'
FROM FullView';

--PRINT @V_SQL;
EXEC (@V_SQL);

/**************************************************************************************************/
--D. View Overwrite
/**************************************************************************************************/

/* 

These series of scripts refreshes tables with ETL views in the Indicator Staging phase.

*/


TRUNCATE TABLE dbo.TIndicator;
SET IDENTITY_INSERT dbo.TIndicator ON; 
INSERT INTO dbo.TIndicator
(
    IndicatorID,
	Segment,
    IndicatorRefID,
    Indicator,
    Priority,
    IsApplicableToBank,
    IsConduciveToAutomatedMonitoring,
    InOracleMVP1,
    CoverageInclOracleMVP1AndFortent,
    FortentCoverage,
    BusinessLine,
    RevisionHistory,
    RuleCoverageNotes,
    FortentRuleCoverageNotes,
    IsDuplicate
)

SELECT * FROM dbo.VTIndicator;
SET IDENTITY_INSERT dbo.TIndicator OFF; 
/**************************************************************************************************/

TRUNCATE TABLE dbo.TTheme; 
SET IDENTITY_INSERT dbo.TTheme ON;
INSERT INTO dbo.TTheme (ThemeID, Theme)
SELECT * FROM dbo.VTTheme;
SET IDENTITY_INSERT dbo.TTheme OFF;
/**************************************************************************************************/

TRUNCATE TABLE dbo.TIndicatorXTheme; 
SET IDENTITY_INSERT dbo.TIndicatorXTheme ON;
INSERT INTO dbo.TIndicatorXTheme (IndicatorXThemeID, IndicatorID, ThemeID, PRIORITY)
SELECT * FROM dbo.VTIndicatorXTheme;
SET IDENTITY_INSERT dbo.TIndicatorXTheme OFF;
/**************************************************************************************************/

TRUNCATE TABLE dbo.TModifier; 
SET IDENTITY_INSERT dbo.TModifier ON;
INSERT INTO dbo.TModifier (ModifierID, ModifierName)
SELECT * FROM dbo.VTModifier;
SET IDENTITY_INSERT dbo.TModifier OFF;
/**************************************************************************************************/

TRUNCATE TABLE dbo.TIndicatorXModifier; 
SET IDENTITY_INSERT dbo.TIndicatorXModifier ON;
INSERT INTO dbo.TIndicatorXModifier (IndicatorXModifierID, IndicatorID, ModifierID)
SELECT * FROM dbo.VTIndicatorXModifier;
SET IDENTITY_INSERT dbo.TIndicatorXModifier OFF;
/**************************************************************************************************/

TRUNCATE TABLE dbo.TRule; 
SET IDENTITY_INSERT dbo.TRule ON;
INSERT INTO dbo.TRule (RuleID, RuleName, Category, SOURCE, ProposedTypology)
SELECT * FROM dbo.VTRule;
SET IDENTITY_INSERT dbo.TRule OFF;
/**************************************************************************************************/

TRUNCATE TABLE dbo.TIndicatorXRule; 
SET IDENTITY_INSERT dbo.TIndicatorXRule ON;
INSERT INTO dbo.TIndicatorXRule (IndicatorXRuleID, IndicatorID, RuleID, ProposedRuleName, Focus)
SELECT *, NULL FROM dbo.VTIndicatorXRule;
SET IDENTITY_INSERT dbo.TIndicatorXRule OFF;


/**************************************************************************************************/
/***********************************III. Display Data**********************************************/
/**************************************************************************************************/


/* 

The scripts below form the basis for the pivots and tables 
which populate the coverage assessment.

*/ 


/**************************************************************************************************/
--A. Indicator Inventory
/**************************************************************************************************/

--Used to Display all data at an Indicator Level. 

SELECT 
	VIndicator.[IndicatorID] AS IndicatorID,
	[IndicatorRefID] AS IndicatorRefID,
	[Indicator] AS Indicator,
	--[Segment] AS Segment,
	--[BusinessLine] AS [Business Line],
	CASE WHEN [IsApplicableToBank] = 1 THEN 'Y' WHEN [IsApplicableToBank] = 0 THEN 'N' ELSE NULL END AS [Is Applicable To Bank],
	CASE WHEN [IsConduciveToAutomatedMonitoring] = 1 THEN 'Y' WHEN [IsConduciveToAutomatedMonitoring] = 0 THEN 'N' ELSE NULL END AS [Is Conducive To Automated Monitoring],
	[Priority] AS [Indicator Priority],
	Themes, 
	--[Red Flag Theme 1] AS [Red Flag Theme 1],
	--[Red Flag Theme 2] AS [Red Flag Theme 2],
	--[Red Flag Theme 3] AS [Red Flag Theme 3],
	[OracleTemplate] AS [Oracle Template],
	[ProposedRuleName] AS [Proposed Rule Name],
	--[NavigantTemplate] AS [Navigant Template],
	--[FortentTemplate] AS [Fortent Template],
	--[Modifier] AS [Modifier],
	--CASE WHEN [InOracleMVP1] = 1 THEN 'Y' WHEN [InOracleMVP1] = 0 THEN 'N' ELSE NULL END AS [In Oracle MVP1],
	--[CoverageInclOracleMVP1AndFortent] AS [Coverage Including Oracle MVP1 And Fortent],
	--[RuleCoverageNotes] AS [Rule Coverage Notes],
	--[FortentCoverage] AS [Fortent Coverage],
	--[FortentRuleCoverageNotes] AS [Fortent Rule Coverage Notes],
	--[RevisionHistory] AS [Revision History],
	--Rating,
	CASE WHEN IsDuplicate = 1 THEN 'Y' WHEN IsDUplicate = 0 THEN 'N' ELSE NULL END AS IsDuplicate ,
	--[Advisory Service] AS [Advisory Service],
	[Cash Management] AS [Cash Management],
	[Credit Card] AS [Credit Card],
	[Custody] AS [Custody],
	[Depository Account - Investment] AS [Depository Account - Investment],
	[Depository Account] AS [Depository Account],
	[Derivative] AS [Derivative],
	[Electronic Funds Transfer] AS [Electronic Funds Transfer],
	[Foreign Exchange] AS [Foreign Exchange],
	[Insurance Non Cash Value] AS [Insurance Non Cash Value],
	[Insurance] AS [Insurance],
	[Investment] AS [Investment],
	[Loan] AS [Loan],
	[Line-Of-Credit] AS [Line-Of-Credit],
	[Mobile/Internet Payment] AS [Mobile/ Internet Payment],
	[Monetary Instrument] AS [Monetary Instrument],
	[Mortgage] AS [Mortgage],
	[Overdraft] AS [Overdraft],
	[Precious Metals] AS [Precious Metals],
	[RDC] AS [RDC],
	[Service] AS [Service],
	[Trade Finance] AS [Trade Finance],
	[Trust Services] AS [Trust Services],
	[Vostro] AS [Vostro]
FROM dbo.VIndicator
WHERE IsDuplicate = 0
ORDER BY IndicatorID;


/**************************************************************************************************/
--B. Pivot Charts
/**************************************************************************************************/

--Used to create heatmaps across Rule, Theme, and Product

WITH SegmentMapping AS (

	SELECT 'Commercial' AS Segment                                                      , 'CB - Commercial' AS ProposedSegment UNION ALL
	SELECT 'Retail'                                                                     , 'CB - Retail'         UNION ALL
	SELECT 'Global Banking and Markets (GBM)'                                           , 'GBM'                      UNION ALL
	SELECT 'Global Banking and Markets (GBM), Commercial Banking and small business'    , 'CB - Commercial'         UNION ALL
	SELECT 'Small Business'                                                             , 'CB - Small Business'         UNION ALL
	SELECT 'Financial Institutions'                                                     , 'Financial Institutions'   UNION ALL
	SELECT 'Commercial/Corp/Small Business'                                             , 'CB - Commercial'         UNION ALL
	SELECT 'Commercial/Corp'                                                            , 'CB - Commercial'         UNION ALL
	SELECT 'Retail '                                                                    , 'CB - Retail'         UNION ALL
	SELECT 'Wealth'                                                                     , 'Wealth'                   UNION ALL
	SELECT 'GBM'                                                                        , 'GBM'                      UNION ALL
	SELECT 'Group Treasury'                                                             , 'Group Treasury'
	)


, ProductSegment AS (
	SELECT DISTINCT
		TProduct.ProductGrouping,
		SegmentMapping.ProposedSegment
	FROM dbo.TProduct
	LEFT JOIN SegmentMapping ON TProduct.Segment = SegmentMapping.Segment
)

, NewSegments AS (
	SELECT DISTINCT
		ProductGrouping, 
		(
		SELECT DISTINCT ProposedSegment+'; '
		FROM ProductSegment Prod
		WHERE ProductSegment.ProductGrouping = Prod.ProductGrouping
		ORDER BY 1
		FOR XML PATH('')) AS ProposedSegment
	FROM ProductSegment
)


, TProd AS (
	SELECT DISTINCT
			TIndicator.IndicatorID, 
			Tindicator.IndicatorRefID,
			Tindicator.Indicator, 
			TIndicator.Segment,
			Tindicator.BusinessLine,
			CASE TIndicator.IsApplicableToBank WHEN 0 THEN 'N' WHEN 1 THEN 'Y' END AS IsApplicableToBank,
			CASE TIndicator.IsConduciveToAutomatedMonitoring WHEN 0 THEN 'N' WHEN 1 THEN 'Y' END AS IsConduciveToAutomatedMonitoring,
			--MIN(TIndicator.Priority) OVER (PARTITION BY ProposedRuleName) AS Priority,
			TIndicator.Priority AS [Indicator Priority],
			TIndicatorXRule.ProposedRuleName, 
			TIndicatorXRule.ProposedTheme,
			TRule.RuleName AS OracleRule,
			CASE TIndicator.IsDuplicate WHEN 1 THEN 'Y' WHEN 0 THEN 'N' END AS IsDuplicate,
			ProductOrService,
			TProduct.Rating,
			TProduct.ProductGrouping, 
			CASE TIndicatorXRule.InOracle WHEN 'Full' THEN 1 WHEN 'Partial' THEN 2 WHEN 'None' THEN 3 END AS Coverage, 
			LEFT(NewSegments.ProposedSegment,LEN(NewSegments.ProposedSegment)-1) AS [Product Segments], 
			SegmentMapping.ProposedSegment AS [Product Segment],
			TIndicatorXRule.InOracle AS [Oracle Rule Indicator]
	FROM dbo.TIndicator
	LEFT OUTER JOIN dbo.TIndicatorXProduct ON  TIndicator.IndicatorID = TIndicatorXProduct.IndicatorID  
	LEFT OUTER JOIN dbo.TIndicatorXRule ON TIndicatorXProduct.IndicatorID = TIndicatorXRule.IndicatorID
	LEFT OUTER JOIN dbo.TProduct ON TIndicatorXProduct.ProductID = TProduct.ProductID
	LEFT OUTER JOIN NewSegments ON TProduct.ProductGrouping = NewSegments.ProductGrouping
	LEFT OUTER JOIN SegmentMapping ON TProduct.Segment = SegmentMapping.Segment
	INNER JOIN TRule ON TIndicatorXRule.RuleID = TRule.RuleID AND Source = 'Oracle'

	WHERE TProduct.ProductOrService IS NOT NULL 
		AND TIndicatorXRule.ProposedRuleName IS NOT NULL 
		AND TIndicatorXRule.InOracle IS NOT NULL
)


SELECT 
	TProd.*
	, 1 AS Value
	, 'Category' AS Category
	, MIN([Indicator Priority]) OVER (PARTITION BY ProposedRuleName) AS Priority
	--, CASE WHEN AVG(TProd.Coverage) OVER (PARTITION BY [Product Segment], TProd.ProposedTheme, TProd.ProposedRuleName, TProd.ProductGrouping) < 3 THEN NCHAR(9679) END AS DotCoverage
	, CASE WHEN AVG(TProd.Coverage) OVER (PARTITION BY [Product Segment], TProd.ProposedTheme, TProd.ProposedRuleName, TProd.ProductGrouping) <= 3 THEN 1 END AS DotCoverage
FROM TProd;


/**************************************************************************************************/
--C. Unmapped Products
/**************************************************************************************************/

--All Products without Indicators

WITH VInd AS
(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'VIndicator')

, SegmentMapping AS (

	SELECT 'Commercial' AS Segment                                                      , 'CB - Commercial' AS ProposedSegment UNION ALL
	SELECT 'Retail'                                                                     , 'CB - Retail'         UNION ALL
	SELECT 'Global Banking and Markets (GBM)'                                           , 'GBM'                      UNION ALL
	SELECT 'Global Banking and Markets (GBM), Commercial Banking and small business'    , 'CB - Commercial'         UNION ALL
	SELECT 'Small Business'                                                             , 'CB - Small Business'         UNION ALL
	SELECT 'Financial Institutions'                                                     , 'Financial Institutions'   UNION ALL
	SELECT 'Commercial/Corp/Small Business'                                             , 'CB - Commercial'         UNION ALL
	SELECT 'Commercial/Corp'                                                            , 'CB - Commercial'         UNION ALL
	SELECT 'Retail '                                                                    , 'CB - Retail'         UNION ALL
	SELECT 'Wealth'                                                                     , 'Wealth'                   UNION ALL
	SELECT 'GBM'                                                                        , 'GBM'                      UNION ALL
	SELECT 'Group Treasury'                                                             , 'Group Treasury'
	)


, IndProd AS (
SELECT DISTINCT ProductGrouping, Segment
FROM TIndicatorXProduct
LEFT JOIN TProduct ON TIndicatorXProduct.ProductID = TProduct.ProductID
)

SELECT DISTINCT SegmentMapping.ProposedSegment AS Segment, VInd.COLUMN_NAME AS ProductGrouping
FROM IndProd 
FULL OUTER JOIN VInd ON VInd.COLUMN_NAME = IndProd.ProductGrouping
FULL OUTER JOIN TProduct ON VInd.COLUMN_NAME = TProduct.ProductGrouping
LEFT JOIN SegmentMapping ON TProduct.Segment = SegmentMapping.Segment
WHERE ORDINAL_POSITION > 
		(SELECT ORDINAL_POSITION 
		FROM VInd 
		WHERE COLUMN_NAME = 'RevisionHistory')
	AND IndProd.ProductGrouping IS NULL
	AND VInd.COLUMN_NAME <> 'N/A' 

/**************************************************************************************************/
--D. High Risk Non-Conducive
/**************************************************************************************************/

--All high risk products not conducive to monitoring

WITH SegmentMapping AS (

	SELECT 'Commercial' AS Segment, 'CB - Commercial' AS ProposedSegment UNION ALL
	SELECT 'Retail'                                                                     , 'CB - Retail'         UNION ALL
	SELECT 'Global Banking and Markets (GBM)'                                           , 'GBM'                      UNION ALL
	SELECT 'Global Banking and Markets (GBM), Commercial Banking and small business'    , 'CB - Commercial'         UNION ALL
	SELECT 'Small Business'                                                             , 'CB - Small Business'         UNION ALL
	SELECT 'Financial Institutions'                                                     , 'Financial Institutions'   UNION ALL
	SELECT 'Commercial/Corp/Small Business'                                             , 'CB - Commercial'         UNION ALL
	SELECT 'Commercial/Corp'                                                            , 'CB - Commercial'         UNION ALL
	SELECT 'Retail '                                                                    , 'CB - Retail'         UNION ALL
	SELECT 'Wealth'                                                                     , 'Wealth'                   UNION ALL
	SELECT 'GBM'                                                                        , 'GBM'                      UNION ALL
	SELECT 'Group Treasury'                                                             , 'Group Treasury'
	)

SELECT DISTINCT SegmentMapping.ProposedSegment, ProductGrouping, ProductOrService 
FROM dbo.TProduct 
LEFT JOIN SegmentMapping ON TProduct.Segment = SegmentMapping.Segment 
LEFT JOIN TIndicatorXProduct ON TProduct.ProductID = TIndicatorXProduct.ProductID
WHERE Rating = 1 AND IsConduciveToAutomatedMonitoring = 'N';



/**************************************************************************************************/
--E. Rule Mapping Master
/**************************************************************************************************/

--Lists important Proposed Rule Data and notes

WITH RuleComments AS (
	SELECT 'All Activity In/All Activity Out' AS ProposedRuleName                       , 'Rapid Movement Of Funds - All Activity' AS OracleTemplate                   , 'Current RMF does not do All In/All Out' AS Comment UNION ALL
	SELECT 'CIB: Product Utilization Shift'                                             , 'CIB: Product Utilization Shift'                                             , 'Fortent Decommission (Security Blanket)'           UNION ALL
	SELECT 'CIB: Significant Change from Previous Average Activity'                     , 'CIB: Product Utilization Shift'                                             , 'Fortent Decommission (Security Blanket)'           UNION ALL
	SELECT 'CIB: Significant Change from Previous Average Activity'                     , 'CIB: Significant Change from Previous Average Activity'                     , 'Fortent Decommission (Security Blanket)'           UNION ALL
	SELECT 'CIB: Significant Change from Previous Average Activity'                     , 'CIB: Significant Change From Previous Peak Activity'                        , 'Fortent Decommission (Security Blanket)'           UNION ALL
	SELECT 'CIB: Significant Change in Trade/Transaction Activity'                      , 'CIB: Significant Change in Trade/Transaction Activity'                      , 'Fortent Decommission (Security Blanket)'           UNION ALL
	SELECT 'Deposits/Withdrawals in Similar Amounts'                                    , 'Deposits/Withdrawals in Same or Similar Amounts'                            , 'Rename to the Structuring of Wires Rule'           UNION ALL
	SELECT 'Deviation from Peer Group: Product Utilization'                             , 'Deviation From Peer Group - Product Utilization'                            , 'Fortent Decommission (Security Blanket)'           UNION ALL
	SELECT 'Deviation from Peer Group: Total Activity'                                  , 'Deviation from Peer Group - Total Activity'                                 , 'Fortent Decommission (Security Blanket)'           UNION ALL
	SELECT 'Domestic Wire In/International Wire Out'                                    , 'Rapid Movement Of Funds - All Activity'                                     , 'Fortent Decommission'                              UNION ALL
	SELECT 'Escalation in Inactive Account'                                             , 'Escalation in Inactive Account'                                             , 'Fortent Decommission (Security Blanket)'           UNION ALL
	SELECT 'Foreign Exchange Followed by Wire Out'                                      , 'High Risk Transactions: High Risk Geography'                                , 'Revist Mapping'                                    UNION ALL
	SELECT 'Foreign Exchange Followed by Wire Out'                                      , 'Rapid Movement Of Funds - All Activity'                                     , 'Revist Mapping'                                    UNION ALL
	SELECT 'Frequent ATM Deposits'                                                      , 'Large Reportable Transactions'                                              , 'Large Cash Transactions'                           UNION ALL
	SELECT 'Large Hydro Bill Payment'                                                   , 'Large Reportable Transactions'                                              , 'Revisit Mapping (Conducive?)'                      UNION ALL
	SELECT 'Large Wire Transfers'                                                       , 'Large Reportable Transactions'                                              , 'Fortent Decommission'                              UNION ALL
	SELECT 'Micro Structuring'                                                          , 'Structuring: Potential Structuring in Cash and Equivalents'                 , 'Fortent 5 - AMA Custom'                            UNION ALL
	SELECT 'Monetary Instrument In/Monetary Instrument Out'                             , 'Rapid Movement Of Funds - All Activity'                                     , 'Revist Mapping'                                    UNION ALL
	SELECT 'Monetary Instrument Structuring'                                            , 'Deposits/Withdrawals in Same or Similar Amounts'                            , 'Fortent Decommission'                              UNION ALL
	SELECT 'Multiple Jurisdictions'                                                     , 'Custom Scenario'                                                            , 'Partial due to credit from GBP Tool'               UNION ALL
	SELECT 'Nested Correspondent Rule'                                                  , 'Custom Scenario'                                                            , 'Partial due to credit from GBP Tool'               UNION ALL
	SELECT 'Pattern of Sequentially Numbered Checks'                                    , 'Patterns of Sequentially Numbered Checks, Monetary Instruments'             , 'RDC Workstream'                                    UNION ALL
	SELECT 'Rapid Movement of Funds – All Activity'                                     , 'Custom Scenario'                                                            , 'Revist Mapping'                                    UNION ALL
	SELECT 'Rapid Movement of Funds – All Activity'                                     , 'Rapid Movement Of Funds - All Activity'                                     , 'Revist Mapping'                                    UNION ALL
	SELECT 'Structuring: Avoidance of Reporting Thresholds'                             , 'Structuring: Avoidance of Reporting Thresholds'                             , 'Remap to d/w template'                             UNION ALL
	SELECT 'Structuring: Potential Structuring in Cash and Equivalents'                 , 'Deposits/Withdrawals in Same or Similar Amounts'                            , 'Fortent 5 - AMA custom'                            UNION ALL
	SELECT 'Wire In/Wire Out'                                                           , 'Rapid Movement Of Funds - All Activity'                                     , 'Fortent Decommission'                              UNION ALL
	SELECT 'Wire Structuring'                                                           , 'Custom Scenario'                                                            , 'Fortent 5 - AMA custom'                            UNION ALL
	SELECT 'Wire Structuring'                                                           , 'Deposits/Withdrawals in Same or Similar Amounts'                            , 'Fortent 5 - AMA custom'
)

, AutomatedMonitoring AS (
	SELECT 'Multiple Jurisdictions' AS ProposedRuleName      , 'Custom Scenario' AS OracleTemplate , 'Y' AS [Manual/Automated Monitoring] UNION ALL
	SELECT 'Nested Correspondent Rule'   , 'Custom Scenario'  , 'Y'
)

SELECT DISTINCT
	TIndicatorXRule.ProposedTheme
	, TIndicatorXRule.ProposedRuleName
	, TRule.RuleName AS OracleRuleTemplate
	, TIndicatorXRule.InOracle
	, RuleComments.Comment
	, AutomatedMonitoring.[Manual/Automated Monitoring]
	, MIN(TIndicator.Priority) OVER (PARTITION BY TIndicatorXRule.ProposedRuleName) AS Priority
FROM TIndicatorXRule
INNER JOIN TIndicator ON TIndicatorXRule.IndicatorID = TIndicator.IndicatorID
INNER JOIN TRule ON TIndicatorXRule.RuleID = TRule.RuleID AND Source = 'Oracle'
LEFT JOIN AutomatedMonitoring ON TIndicatorXRule.ProposedRuleName = AutomatedMonitoring.ProposedRuleName 
	AND TRule.RuleName = AutomatedMonitoring.OracleTemplate
LEFT JOIN RuleComments ON TIndicatorXRule.ProposedRuleName = RuleComments.ProposedRuleName 
	AND TRule.RuleName = RuleComments.OracleTemplate
WHERE IsConduciveToAutomatedMonitoring = 1 AND IsApplicableToBank = 1 AND IsDuplicate = 0;

/**************************************************************************************************/
--F. Products with Data Feed
/**************************************************************************************************/

--Lists all products with Datafeeds

WITH SegmentMapping AS (

	SELECT 'Commercial' AS Segment                                                      , 'CB - Commercial' AS ProposedSegment UNION ALL
	SELECT 'Retail'                                                                     , 'CB - Retail'         UNION ALL
	SELECT 'Global Banking and Markets (GBM)'                                           , 'GBM'                      UNION ALL
	SELECT 'Global Banking and Markets (GBM), Commercial Banking and small business'    , 'CB - Commercial'         UNION ALL
	SELECT 'Small Business'                                                             , 'CB - Small Business'         UNION ALL
	SELECT 'Financial Institutions'                                                     , 'Financial Institutions'   UNION ALL
	SELECT 'Commercial/Corp/Small Business'                                             , 'CB - Commercial'         UNION ALL
	SELECT 'Commercial/Corp'                                                            , 'CB - Commercial'         UNION ALL
	SELECT 'Retail '                                                                    , 'CB - Retail'         UNION ALL
	SELECT 'Wealth'                                                                     , 'Wealth'                   UNION ALL
	SELECT 'GBM'                                                                        , 'GBM'                      UNION ALL
	SELECT 'Group Treasury'                                                             , 'Group Treasury'
	)


SELECT DISTINCT 
	SegmentMapping.ProposedSegment,
	DataFeed.[Type MC] AS DataColumn,
	TProduct.*
	 FROM TProduct
LEFT JOIN XTProductDataFeed20181220 DataFeed
	ON TProduct.Segment = DataFeed.Segment 
	AND TProduct.System = DataFeed.System 
	AND TProduct.BusinessUnit = DataFeed.[Business Unit]
	AND TProduct.ProductOrService = DataFeed.[Product/Service]
	AND TProduct.ProductOrServiceDescription = DataFeed.[Product/Service Description]
LEFT JOIN SegmentMapping ON TProduct.Segment = SegmentMapping.Segment 
ORDER BY 1,2,3,4,5;

/**************************************************************************************************/
--G. Product Rule Coverage
/**************************************************************************************************/

--Initally used for high level data about products and product segments,

WITH SegmentMapping AS (

	SELECT 'Commercial' AS Segment                                                      , 'CB - Commercial' AS ProposedSegment UNION ALL
	SELECT 'Retail'                                                                     , 'CB - Retail'         UNION ALL
	SELECT 'Global Banking and Markets (GBM)'                                           , 'GBM'                      UNION ALL
	SELECT 'Global Banking and Markets (GBM), Commercial Banking and small business'    , 'CB - Commercial'         UNION ALL
	SELECT 'Small Business'                                                             , 'CB - Small Business'         UNION ALL
	SELECT 'Financial Institutions'                                                     , 'Financial Institutions'   UNION ALL
	SELECT 'Commercial/Corp/Small Business'                                             , 'CB - Commercial'         UNION ALL
	SELECT 'Commercial/Corp'                                                            , 'CB - Commercial'         UNION ALL
	SELECT 'Retail '                                                                    , 'CB - Retail'         UNION ALL
	SELECT 'Wealth'                                                                     , 'Wealth'                   UNION ALL
	SELECT 'GBM'                                                                        , 'GBM'                      UNION ALL
	SELECT 'Group Treasury'                                                             , 'Group Treasury'
	)

, Initial AS (
	SELECT DISTINCT
		SegmentMapping.ProposedSegment,
		ProductGrouping, 
		ProposedRuleName, 
		ProposedTheme, 
		RuleName, 
		InOracle, 
		Source, 
		MIN(TIndicator.Priority) OVER (PARTITION BY ProposedRuleName) AS Priority,
		TIndicator.IsConduciveToAutomatedMonitoring, 
		TIndicator.IsApplicabletoBank,
		TIndicator.IsDuplicate,
		MAX(CASE TProduct.IsConduciveToAutomatedMonitoring WHEN 'Y' THEN 1 WHEN 'N' THEN 0 END) OVER (PARTITION BY ProductGrouping) AS ProductConducive,
		MAX(CASE TProduct.IsConduciveToAutomatedMonitoring WHEN 'Y' THEN 1 WHEN 'N' THEN 0 END) OVER (PARTITION BY ProductGrouping, SegmentMapping.ProposedSegment) AS ProductSegmentConducive,
		DENSE_RANK() OVER (PARTITION BY ProductGrouping ORDER BY TProduct.ProductID ASC ) +
			DENSE_RANK() OVER (PARTITION BY ProductGrouping ORDER BY TProduct.ProductID DESC) - 1 AS TotalProducts,
		DENSE_RANK() OVER (PARTITION BY ProductGrouping, SegmentMapping.ProposedSegment ORDER BY TProduct.ProductID ASC ) +
			DENSE_RANK() OVER (PARTITION BY ProductGrouping, SegmentMapping.ProposedSegment ORDER BY TProduct.ProductID DESC) - 1 AS TotalSegmentProducts,
		CASE WHEN DataFeed.[Product/Service] IS NOT NULL THEN TProduct.ProductID ELSE NULL END AS DataProdID, 
		--COUNT(DISTINCT TProduct.ProductID) OVER (PARTITION BY (ProductGrouping)) AS [Total Products], 
		--COUNT(DISTINCT (CASE WHEN DataFeed.[Product/Service] IS NOT NULL THEN TProduct.ProductID END)) OVER (PARTITION BY (ProductGrouping)) AS [Data Products],  
		MIN(CASE InOracle WHEN 'Full' THEN 1 WHEN 'Partial' THEN 2 WHEN 'None' THEN 3 ELSE 4 END) OVER (PARTITION BY ProductGrouping) AS CoverageScore, 
		MIN(Rating) OVER (PARTITION BY ProductGrouping) AS Rating, 
		MIN(Rating) OVER (PARTITION BY ProductGrouping, SegmentMapping.ProposedSegment) AS SegmentRating
	FROM TProduct
	LEFT JOIN SegmentMapping ON TProduct.Segment = SegmentMapping.Segment
	LEFT JOIN XTProductDataFeed20181220 DataFeed
	ON TProduct.Segment = DataFeed.Segment 
	AND TProduct.System = DataFeed.System 
	AND TProduct.BusinessUnit = DataFeed.[Business Unit]
	AND TProduct.ProductOrService = DataFeed.[Product/Service]
	AND TProduct.ProductOrServiceDescription = DataFeed.[Product/Service Description]
	LEFT JOIN TIndicatorXProduct ON TProduct.ProductID = TIndicatorXProduct.ProductID
	LEFT JOIN TIndicator ON TIndicatorXProduct.IndicatorID = TIndicator.IndicatorID
	LEFT JOIN TIndicatorXRule ON TIndicatorXProduct.IndicatorID = TIndicatorXRule.IndicatorID
	LEFT JOIN TRule ON TIndicatorXRule.RuleID = TRule.RuleID
	WHERE (Source IS NULL OR InOracle IS NOT NULL) 
		--AND TIndicator.IsConduciveToAutomatedMonitoring = 1 
		--AND TIndicator.IsApplicabletoBank = 1 
		--AND TIndicator.IsDuplicate = 0
)

SELECT
	*
	, DENSE_RANK() OVER (PARTITION BY ProductGrouping ORDER BY DataProdID ASC ) +
		DENSE_RANK() OVER (PARTITION BY ProductGrouping ORDER BY DataProdID DESC) - 2 AS DataProducts
	, DENSE_RANK() OVER (PARTITION BY ProductGrouping, Initial.ProposedSegment ORDER BY DataProdID ASC ) +
		DENSE_RANK() OVER (PARTITION BY ProductGrouping, Initial.ProposedSegment ORDER BY DataProdID DESC) - 2 AS DataSegmentProducts
	, CASE CoverageScore WHEN 1 THEN 'Full' WHEN 2 THEN 'Partial' WHEN 3 THEN 'None' WHEN 4 THEN 'No Rules' END AS CoverageProduct
FROM Initial;

/**************************************************************************************************/
--H. Expanded Rule Mapping
/**************************************************************************************************/

--Rule Data Responsible for generating high level charts

WITH SegmentMapping AS (

	SELECT 'Commercial' AS Segment                                                      , 'CB - Commercial' AS ProposedSegment UNION ALL
	SELECT 'Retail'                                                                     , 'CB - Retail'         UNION ALL
	SELECT 'Global Banking and Markets (GBM)'                                           , 'GBM'                      UNION ALL
	SELECT 'Global Banking and Markets (GBM), Commercial Banking and small business'    , 'CB - Commercial'         UNION ALL
	SELECT 'Small Business'                                                             , 'CB - Small Business'         UNION ALL
	SELECT 'Financial Institutions'                                                     , 'Financial Institutions'   UNION ALL
	SELECT 'Commercial/Corp/Small Business'                                             , 'CB - Commercial'         UNION ALL
	SELECT 'Commercial/Corp'                                                            , 'CB - Commercial'         UNION ALL
	SELECT 'Retail '                                                                    , 'CB - Retail'         UNION ALL
	SELECT 'Wealth'                                                                     , 'Wealth'                   UNION ALL
	SELECT 'GBM'                                                                        , 'GBM'                      UNION ALL
	SELECT 'Group Treasury'                                                             , 'Group Treasury'
	)


, ProductSegment AS (
	SELECT DISTINCT
		Total.ProductGrouping
		, SegmentMapping.ProposedSegment
		, DENSE_RANK() OVER (PARTITION BY Total.ProductGrouping ORDER BY Total.StagingID ASC) - 1 +
			DENSE_RANK() OVER (PARTITION BY Total.ProductGrouping ORDER BY Total.StagingID DESC) AS TotalProducts
		, DENSE_RANK() OVER (PARTITION BY Total.ProductGrouping ORDER BY HighRisk.StagingID ASC) - 2 +
			DENSE_RANK() OVER (PARTITION BY Total.ProductGrouping ORDER BY HighRisk.StagingID DESC) AS HighRiskProducts
		--, COUNT(Total.ProductID) OVER (PARTITION BY Total.ProductGrouping) AS TotalProductsReg
		--, COUNT(CASE WHEN Total.Rating = 1 THEN Total.ProductID END) OVER (PARTITION BY Total.ProductGrouping) AS HighRiskProductsReg
	FROM dbo.TProduct Total
	LEFT JOIN (SELECT * FROM dbo.TProduct WHERE Rating = 1) HighRisk 
		ON Total.ProductID = HighRisk.ProductID 
	LEFT JOIN SegmentMapping ON Total.Segment = SegmentMapping.Segment
)

, RawResults AS (
SELECT DISTINCT
	TProduct.ProductGrouping 
	, ProductSegment.ProposedSegment AS Segment
	, ProductSegment.TotalProducts
	, ProductSegment.HighRiskProducts
	, TIndicatorXRule.ProposedTheme
	, TIndicatorXRule.ProposedRuleName
	, TRule.RuleName AS OracleRuleTemplate
	, TIndicator.IndicatorID
	, IndicatorRefID
	, Indicator AS [Indicator Description]
	, TIndicatorXRule.InOracle
	, CASE MIN(TIndicator.Priority) OVER (PARTITION BY ProposedRuleName) WHEN 1 THEN 'Required' WHEN 2 THEN 'Suggested' WHEN 3 THEN 'Suggested' END AS HighLevelPriority
	, CASE TIndicatorXRule.InOracle WHEN 'Full' THEN 1 WHEN 'Partial' THEN 2 WHEN 'None' THEN 3 END AS Coverage
	, CASE InOracle WHEN 'Full' THEN 'Deployed' WHEN 'Partial' THEN 'Not Deployed' WHEN 'None' THEN 'Not Deployed' END AS DeployedRules
	, TIndicator.Priority AS [Indicator Priority]
	--, AVG(CASE TIndicatorXRule.InOracle WHEN 'Full' THEN 1 WHEN 'Partial' THEN 2 WHEN 'None' THEN 3 END) OVER (PARTITION BY ProductSegment.ProposedSegment, TIndicatorXRule.ProposedTheme) AS ThemeCoverage
FROM TIndicatorXRule
INNER JOIN TIndicator ON TIndicatorXRule.IndicatorID = TIndicator.IndicatorID
INNER JOIN TRule ON TIndicatorXRule.RuleID = TRule.RuleID AND Source = 'Oracle'
LEFT JOIN TIndicatorXProduct ON TIndicator.IndicatorID = TIndicatorXProduct.IndicatorID
LEFT JOIN TProduct ON TIndicatorXProduct.ProductID = TProduct.ProductID
INNER JOIN ProductSegment ON TProduct.ProductGrouping = ProductSegment.ProductGrouping 
WHERE TIndicator.IsConduciveToAutomatedMonitoring = 1 AND TIndicator.IsApplicableToBank = 1 AND TIndicator.IsDuplicate = 0
)

SELECT 
	RawResults.*
	, AVG(Coverage) OVER (PARTITION BY Segment, ProposedTheme) AS ThemeCoverageNum
	, CASE AVG(Coverage) OVER (PARTITION BY Segment, ProposedTheme) WHEN 1 THEN 'Covered' WHEN 3 THEN 'Not Covered' ELSE
		(CASE WHEN AVG(Coverage) OVER (PARTITION BY Segment, ProposedTheme) BETWEEN 1 AND 3 THEN 'Limited Coverage' END) END AS ThemeLabel
	--Product Grouping Metrics
	, DENSE_RANK() OVER (PARTITION BY ProductGrouping ORDER BY Segment ASC) - 1 +
		DENSE_RANK() OVER (PARTITION BY ProductGrouping ORDER BY Segment DESC) AS ProductSegments
	, DENSE_RANK() OVER (PARTITION BY ProductGrouping ORDER BY ProposedTheme ASC) - 1 +
		DENSE_RANK() OVER (PARTITION BY ProductGrouping ORDER BY ProposedTheme DESC) AS ProductThemes
	, DENSE_RANK() OVER (PARTITION BY ProductGrouping ORDER BY ProposedRuleName ASC) - 1 +
		DENSE_RANK() OVER (PARTITION BY ProductGrouping ORDER BY ProposedRuleName DESC) AS ProductRules
	--Segment Metrics
	, DENSE_RANK() OVER (PARTITION BY Segment ORDER BY ProductGrouping ASC) - 1 +
		DENSE_RANK() OVER (PARTITION BY Segment ORDER BY ProductGrouping DESC) AS SegmentProducts
	, DENSE_RANK() OVER (PARTITION BY Segment ORDER BY ProposedTheme ASC) - 1 +
		DENSE_RANK() OVER (PARTITION BY Segment ORDER BY ProposedTheme DESC) AS SegmentThemes
	, DENSE_RANK() OVER (PARTITION BY Segment, HighLevelPriority ORDER BY ProposedRuleName ASC) - 1 +
		DENSE_RANK() OVER (PARTITION BY Segment, HighLevelPriority ORDER BY ProposedRuleName DESC) AS SegmentRules
	--Priority Metrics
	, DENSE_RANK() OVER (PARTITION BY HighLevelPriority ORDER BY ProductGrouping ASC) - 1 +
		DENSE_RANK() OVER (PARTITION BY HighLevelPriority ORDER BY ProductGrouping DESC) AS PriorityProducts
	, DENSE_RANK() OVER (PARTITION BY HighLevelPriority ORDER BY ProposedRuleName ASC) - 1 +
		DENSE_RANK() OVER (PARTITION BY HighLevelPriority ORDER BY ProposedRuleName DESC) AS PriorityRules
	, MIN([Indicator Priority]) OVER (PARTITION BY ProposedRuleName) AS Priority
FROM RawResults;


/**************************************************************************************************/
--I. Theme Description
/**************************************************************************************************/

--Showcases Theme Descriptions as applicable to Segments

WITH SegmentMapping AS (

	SELECT 'Commercial' AS Segment                                                      , 'CB - Commercial' AS ProposedSegment UNION ALL
	SELECT 'Retail'                                                                     , 'CB - Retail'         UNION ALL
	SELECT 'Global Banking and Markets (GBM)'                                           , 'GBM'                      UNION ALL
	SELECT 'Global Banking and Markets (GBM), Commercial Banking and small business'    , 'CB - Commercial'         UNION ALL
	SELECT 'Small Business'                                                             , 'CB - Small Business'         UNION ALL
	SELECT 'Financial Institutions'                                                     , 'Financial Institutions'   UNION ALL
	SELECT 'Commercial/Corp/Small Business'                                             , 'CB - Commercial'         UNION ALL
	SELECT 'Commercial/Corp'                                                            , 'CB - Commercial'         UNION ALL
	SELECT 'Retail '                                                                    , 'CB - Retail'         UNION ALL
	SELECT 'Wealth'                                                                     , 'Wealth'                   UNION ALL
	SELECT 'GBM'                                                                        , 'GBM'                      UNION ALL
	SELECT 'Group Treasury'                                                             , 'Group Treasury'
	)


, ProductSegment AS (
	SELECT DISTINCT
		TProduct.ProductGrouping,
		SegmentMapping.ProposedSegment
	FROM dbo.TProduct
	LEFT JOIN SegmentMapping ON TProduct.Segment = SegmentMapping.Segment
)

SELECT DISTINCT 
	TThemeDescription.*
	, ProposedSegment AS Segment
	, Priority AS ThemePriority
	--, ProposedRuleName
FROM dbo.TThemeDescription
INNER JOIN TIndicatorXRule ON TIndicatorXRule.ProposedTheme = TThemeDescription.ThemeName
INNER JOIN TIndicator ON TIndicatorXRule.IndicatorID = TIndicator.IndicatorID
INNER JOIN TIndicatorXProduct ON TIndicator.IndicatorID = TIndicatorXProduct.IndicatorID
INNER JOIN TProduct ON TIndicatorXProduct.ProductID = TProduct.ProductID
INNER JOIN ProductSegment ON TProduct.ProductGrouping = ProductSegment.ProductGrouping;

/**************************************************************************************************/
--J. Indicators, Themes, and Products
/**************************************************************************************************/

--Truncated VIndicator View with essentals and only conducive indicators.

SELECT 
	--VIndicator.[IndicatorID] AS IndicatorID,
	[IndicatorRefID] AS IndicatorRefID,
	[Indicator] AS Indicator,
	[Priority] AS [Indicator Priority],
	Themes, 
	[Cash Management] AS [Cash Management],
	[Credit Card] AS [Credit Card],
	[Custody] AS [Custody],
	[Depository Account - Investment] AS [Depository Account - Investment],
	[Depository Account] AS [Depository Account],
	[Derivative] AS [Derivative],
	[Electronic Funds Transfer] AS [Electronic Funds Transfer],
	[Foreign Exchange] AS [Foreign Exchange],
	[Insurance Non Cash Value] AS [Insurance Non Cash Value],
	[Insurance] AS [Insurance],
	[Investment] AS [Investment],
	[Loan] AS [Loan],
	[Line-Of-Credit] AS [Line-Of-Credit],
	[Mobile/Internet Payment] AS [Mobile/ Internet Payment],
	[Monetary Instrument] AS [Monetary Instrument],
	[Mortgage] AS [Mortgage],
	[Overdraft] AS [Overdraft],
	[Precious Metals] AS [Precious Metals],
	[RDC] AS [RDC],
	[Service] AS [Service],
	[Trade Finance] AS [Trade Finance],
	[Trust Services] AS [Trust Services],
	[Vostro] AS [Vostro]
FROM dbo.VIndicator
WHERE IsConduciveToAutomatedMonitoring = 1 AND IsApplicableToBank = 1 AND IsDuplicate = 0
ORDER BY IndicatorID;

/**************************************************************************************************/
--K. Product Risk and Rules
/**************************************************************************************************/

--Rules to Products Mapping

SELECT DISTINCT
	--TProduct.ProductID
	TProduct.StagingID AS ProductID
	, TProduct.Segment
	, TProduct.ProductGrouping
	, TProduct.BusinessUnit
	, TProduct.ProductOrService
	, TProduct.ProductOrServiceDescription
	, TProduct.IsConduciveToAutomatedMonitoring
	, CASE TProduct.Rating WHEN 1 THEN 'High' WHEN 2 THEN 'Moderate' WHEN 3 THEN 'Low' END AS Rating
	, ProposedTheme
	, ProposedRuleName
	, RuleName AS OracleTemplate
FROM dbo.TProduct
INNER JOIN dbo.TIndicatorXProduct ON TProduct.ProductID = TIndicatorXProduct.ProductID
INNER JOIN dbo.TIndicator ON TIndicatorXProduct.IndicatorID = TIndicator.IndicatorID
INNER JOIN dbo.TIndicatorXRule ON TIndicatorXProduct.IndicatorID = TIndicatorXRule.IndicatorID AND ProposedRuleName IS NOT NULL
INNER JOIN dbo.TRule ON TIndicatorXRule.RuleID = TRule.RuleID AND TRule.Source = 'Oracle'
WHERE TIndicator.IsConduciveToAutomatedMonitoring = 1 AND IsApplicableToBank = 1 AND IsDuplicate = 0;


/**************************************************************************************************/
/***********************************IV. Miscellaneous**********************************************/
/**************************************************************************************************/


/**************************************************************************************************/
--A. Indicator QA
/**************************************************************************************************/

--Incomplete Entries
SELECT 
	ISNULL((CASE WHEN Priority IS NULL THEN 'Priority Null;' END), '')
	+ISNULL((CASE WHEN ProposedRuleName IS NULL THEN 'ProposedRuleName Null;' END),'')
	+ISNULL((CASE WHEN OracleRule IS NULL THEN 'OracleRule Null;' END), '')
	+ISNULL((CASE WHEN OracleRule LIKE '%Custom%' THEN 'OracleRule Custom' END),'') AS ERROR,
	TStagingIndicator.* 
FROM TStagingIndicator 
	WHERE IsConduciveToAutomatedMonitoring = 'Y' 
		AND (Priority IS NULL 
			OR ProposedRuleName IS NULL 
			OR OracleRule IS NULL 
			OR(OracleRule LIKE '%Custom%' AND ProposedRuleName IS NULL));
			

--Retail Deep QA			
SELECT *, 
	CASE WHEN TStagingIndicator.[Red Flag Theme 1] <> Retail.[Red Flag Theme 1] OR 
		TStagingIndicator.[Red Flag Theme 2] <> Retail.[Red Flag Theme 2] OR
		TStagingIndicator.[Red Flag Theme 3] <> Retail.[Red Flag Theme 3] THEN 'Theme Not Reconciled' ELSE 'Reconciled' END AS ThemeCheck,
	CASE WHEN TStagingIndicator.Modifiers <> Retail.Modifiers THEN 'Modifier Not Reconciled' ELSE 'Reconciled' END AS ModifierCheck,
	CASE WHEN OracleRule <> Retail.[Proposed Oracle Scenario] THEN 'Oracle Rule Not Reconiled' ELSE 'Reconciled' END AS OracleCheck, 
	CASE WHEN ProposedRuleName <> Retail.[Proposed Rule Name] THEN 'Proposed Not Reconciled' ELSE 'Reconciled' END AS ProposedCheck, 
	CASE WHEN IsConduciveToAutomatedMonitoring <> Retail.[Conducive to Automated Monitoring?] THEN 'NonConducive Not Reconciled' ELSE 'Reconciled' END AS NonConduciveCheck, 
	CASE WHEN IsApplicableToBank <> Retail.[Applicable to BNS?] THEN 'Applicability Not Reconciled' ELSE 'Reconciled' END AS ApplicableCheck, 
	CASE WHEN TStagingIndicator.Priority <> Retail.Priority THEN 'Priority Not Reconciled' ELSE 'Reconciled' END AS PriorityCheck
FROM TStagingIndicator
INNER JOIN [XTIndicatorRetail20181113] Retail 
	ON TStagingIndicator.IndicatorRefID = Retail.[Indicator ID] AND TStagingIndicator.Segment LIKE '%Retail%';

/*
Notes: 
--Indicator 1342 (FATFTBML31) originally had 'High Risk Transactions: High Risk Geography' but disappeared 

*/	
	
	
	
--Wealth Deep QA
SELECT *,
	CASE WHEN [Red Flag Theme 1] <> Wealth.[Theme 1] OR [Red Flag Theme 2] <> Wealth.[Theme 2] OR [Red Flag Theme 3] <> Wealth.[Theme 3] THEN 'Theme Not Reconciled' ELSE 'Reconciled' END AS ThemeCheck, 
	CASE WHEN Wealth.[Scenario 1]+ISNULL(';'+NULLIF(Wealth.[Scenario 2], '-'), '')+ISNULL(';'+NULLIF(Wealth.[Scenario 3], '-'), '') <> OracleRule THEN 'Oracle Not Reconciled' ELSE 'Reconciled' END AS OracleCheck,
	CASE WHEN TStagingIndicator.Priority <> Wealth.Priority THEN 'Priority Not Reconciled' ELSE 'Reconciled' END AS PriorityCheck
FROM TStagingIndicator
INNER JOIN XTIndicatorWealth20181113 Wealth
	ON TStagingIndicator.IndicatorRefID = Wealth.# AND TStagingIndicator.Segment LIKE '%Wealth%';

--Mortgage Deep QA
SELECT *, 
	CASE WHEN [Red Flag Theme 1] <> Mortgage.Theme THEN 'Theme Not Reconciled' ELSE 'Reconciled' END AS ThemeCheck, 
	CASE WHEN IsApplicableToBank <> Mortgage.[Applicable to BNS?] THEN 'Applicability Not Reconciled' ELSE 'Reconciled' END AS ApplicableCheck, 
	CASE WHEN IsConduciveToAutomatedMonitoring <> Mortgage.[Conducive to Automated Mortgage Monitoring?] THEN 'Conduciveness Not Reconciled' ELSE 'Reconciled' END AS ConduciveCheck, 
	CASE WHEN OracleRule <> Mortgage.[Recommended Oracle Scenario] THEN 'Oracle Not Reconciled' ELSE 'Reconciled' END AS OracleCheck
FROM TStagingIndicator
INNER JOIN XTIndicatorMortgage20181113 Mortgage ON TStagingIndicator.IndicatorRefID = Mortgage.ID AND Segment LIKE '%Mortgage%'

/**************************************************************************************************/
--B. Rule Priority List
/**************************************************************************************************/

SELECT
	TIndicatorXRule.ProposedRuleName,
	TIndicatorXRule.InOracle, 
	MIN(TIndicator.Priority) AS Priority 
FROM TIndicatorXRule 
LEFT JOIN TIndicator 
	ON TIndicatorXRule.IndicatorID = TIndicator.IndicatorID
INNER JOIN TRule ON TIndicatorXRule.RuleID = TRule.RuleID AND Source = 'Oracle'
WHERE IsConduciveToAutomatedMonitoring = 1 AND IsApplicableToBank = 1 AND IsDuplicate = 0
GROUP BY ProposedRuleName, InOracle
ORDER BY Priority, InOracle, ProposedRuleName;

	
/**************************************************************************************************/
--C. Ad Hoc Changes
/**************************************************************************************************/

----------------------------------------------------------------------------------------------------
----Prerecorded: Load Investment/Insurance Data
----------------------------------------------------------------------------------------------------


SELECT * INTO XTIndicatorCA20181120
FROM XTIndicatorCA20181119;

UPDATE XTIndicatorCA20181120
SET 
	Insurance = CONVERT(NVARCHAR(255), Change.Insurance),
	Investment = CONVERT(NVARCHAR(255), Change.Investment)
FROM XTIndicatorCA20181120 Base
INNER JOIN XTIndicatorXInsurInvest20181120 Change
	ON Base.[Indicator ID] = Change.IndicatorRefID;

--Checks	
SELECT SUM(Insurance), SUM(Investment) FROM XTIndicatorXInsurInvest20181120;
SELECT SUM(CONVERT(INT,Insurance)) Insurance, SUM(CONVERT(INT,Investment)) Investment  FROM XTIndicatorCA20181119;
SELECT SUM(CONVERT(INT,Insurance)) Insurance, SUM(CONVERT(INT,Investment)) Investment  FROM XTIndicatorCA20181120;

----------------------------------------------------------------------------------------------------
----Prerecorded: Update Indicator Names
----------------------------------------------------------------------------------------------------


UPDATE TStagingIndicator 
   SET TStagingIndicator.Indicator = New.Indicator
   FROM TStagingIndicator  INNER JOIN  XTIndNameCA20181113 New ON TStagingIndicator.IndicatorRefID = New.[Indicator ID];

----------------------------------------------------------------------------------------------------
----Prerecorded: Update Indicator Theme Map
----------------------------------------------------------------------------------------------------

WITH IndTemp AS
(SELECT 1175 AS IndicatorID, 'Lack of Economic Purpose' AS Theme UNION ALL
SELECT 1323 AS IndicatorID, 'PEP Trades/ Transactions' AS Theme)

UPDATE dbo.TStagingIndicator
SET TStagingIndicator.[Red Flag Theme 1] = IndTemp.Theme
FROM TStagingIndicator INNER JOIN IndTemp ON TStagingIndicator.IndicatorID = IndTemp.IndicatorID;

----------------------------------------------------------------------------------------------------
----Prerecorded: Update Conducive to Monitoring As Per QA
----------------------------------------------------------------------------------------------------

UPDATE dbo.TIndicator
SET IsConduciveToAutomatedMonitoring = 0
WHERE IndicatorRefID IN (
'FATFPEPBusinessPurpose11',
'FATFPEPBusinessPurpose12',
'FATFHumanTrafficking74 ',
'FATFTrafficking14',
'FINTRACLoan1',
'FinTRACForeign6',
'FFIECTransfersT5',
'FinTRACBiz29',
'FFIECTransfers3',
'FATFTBML31', 
'FATFPEPBusinessPurpose05',
'FATFTrafficking22'
);

----------------------------------------------------------------------------------------------------

UPDATE dbo.TIndicator
SET IndicatorRefID = 'EgmontBriberyandCorruption02, EgmonthOrganisedCrime08'
FROM dbo.TIndicator
WHERE IndicatorRefID = 'EgmontBriberyandCorruption02, EgmonthOrganisedCrim';

UPDATE dbo.TIndicator
SET IndicatorID = 1045
FROM dbo.TIndicator
WHERE IndicatorRefID = 'EgmontBriberyandCorruption02, EgmonthOrganisedCrime08';


--Rename Retail/Wealth Segment
UPDATE dbo.TStagingIndicator
SET TStagingIndicator.IndicatorID = TIndicator.IndicatorID
FROM TStagingIndicator 
INNER JOIN TIndicator ON TStagingIndicator.IndicatorRefID = TIndicator.IndicatorRefID 
	AND TStagingIndicator.Segment = REPLACE(TIndicator.Segment, 'Retail/Wealth', 'Retail')
	
	
--UPDATE dbo.TIndicator
--SET Segment = 'Retail'
--WHERE Segment = 'Retail/Wealth';

UPDATE dbo.TStagingIndicator
SET [Red Flag Theme 1] = 'Network of Customers'
WHERE IndicatorRefID = 'FATFTBML35'

----------------------------------------------------------------------------------------------------

UPDATE dbo.TIndicator
SET TIndicator.IsConduciveToAutomatedMonitoring = Wealth.IsConduciveToAutomatedMonitoring
FROM dbo.TIndicator
INNER JOIN (
	SELECT * FROM TIndicator 
	WHERE IndicatorRefID IN (
	'FinTRACMetals9',
	'FFIECProfile1',
	'FFIECReporting5',
	'FFIECOther9',
	'IIROC6',
	'FFIECOther1',
	'FFIECTransfersT5',
	'FATFFreeTradeZones31',
	'FATFSecuritiesUnusual12',
	'FATFSecuritiesMktManip02',
	'FATFSecuritiesMktManip05',
	'FATFProliferation15',
	'WolfsbergCC02')
	AND Segment = 'Wealth'
	AND IsConduciveToAutomatedMonitoring = 1) Wealth 
	ON TIndicator.IndicatorRefID = Wealth.IndicatorRefID
	AND TIndicator.Segment = 'Retail';

----------------------------------------------------------------------------------------------------
----Prerecorded: Supplementary QA Changes
----------------------------------------------------------------------------------------------------

--De-priositize Nigerian Strucutring
UPDATE dbo.TIndicator
SET TIndicator.Priority = 3
WHERE Indicator = 'Nigerian wire structuring';


--Update IsApplicable/Conducive


WITH NewVariables AS (
	SELECT 
		IndicatorID, IndicatorRefID, 
		CASE IsConduciveToAutomatedMonitoring WHEN 'Y' THEN 1 WHEN 'N' THEN 0 ELSE NULL END AS  IsConduciveToAutomatedMonitoring, 
		CASE IsApplicableToBank WHEN 'Y' THEN 1 WHEN 'N' THEN 0 ELSE NULL END AS  IsApplicableToBank
FROM dbo.XTIndicatorCA20181213
)

UPDATE dbo.TIndicator
SET 
	TIndicator.IsConduciveToAutomatedMonitoring = NewVariables.IsConduciveToAutomatedMonitoring, 
	TIndicator.IsApplicableToBank = NewVariables.IsApplicableToBank
FROM dbo.TIndicator
INNER JOIN NewVariables ON TIndicator.IndicatorID = NewVariables.IndicatorID

--Clean Proposed Rule for Wealth
UPDATE dbo.TStagingIndicator 
SET ProposedRuleName = REPLACE(OracleRule,';No corresponding Mantas scenario','')
WHERE Segment = 'Wealth' AND OracleRule <> 'No corresponding Mantas scenario';	

--Rename Product Groupings

UPDATE dbo.TProduct
SET ProductGrouping = 'Electronic Funds Transfer'
WHERE ProductGrouping = 'EFT';

UPDATE dbo.TProduct
SET ProductGrouping = 'Mobile/Internet Payment'
WHERE ProductGrouping = 'Moblie/Internet Payment';

UPDATE dbo.TProduct
SET ProductGrouping = 'Depository Account - Investment'
WHERE ProductGrouping = 'Depository Accounts - Investment';

----------------------------------------------------------------------------------------------------
----Prerecorded: Update Indicator Rule Mapping
----------------------------------------------------------------------------------------------------

WITH RuleUpdate AS (

	SELECT 'FATFBenOwnership93' AS IndicatorRefID, 'CIB: Significant Change from Previous Average Activity' AS OracleRule                                                              , 'CIB: Significant Change from Previous Average Activity' AS ProposedRule                                                                                   , 'Security Blanket' AS FortentRule UNION ALL
	SELECT 'FATFBenOwnership95'            , 'High Risk Transactions: High Risk Geography'                                                                                             , 'High Risk Transactions: High Risk Geography'                                                                                                              , NULL                              UNION ALL
	SELECT 'FATFBenOwnership92'            , 'CIB: Significant Change from Previous Average Activity'                                                                                  , 'CIB: Significant Change from Previous Average Activity'                                                                                                   , 'Security Blanket'                UNION ALL
	SELECT 'FATFBenOwnership96'            , 'High Risk Transactions: High Risk Geography'                                                                                             , 'High Risk Transactions: High Risk Geography'                                                                                                              , NULL                              UNION ALL
	SELECT 'FATFHumanTrafficking14'        , 'Rapid Movement of Funds - All Activity'                                                                                                  , 'Cash In/Cash Out [using template Rapid Movement of Funds - All Activity]; Cash In/Purchases Out [using template Rapid Movement of Funds - All Activity]'  , 'N/A'                             UNION ALL
	SELECT 'FATFHumanTrafficking15'        , 'Rapid Movement of Funds - All Activity'                                                                                                  , 'Cash In/Cash Out [using template Rapid Movement of Funds - All Activity]'                                                                                 , 'N/A'                             UNION ALL
	SELECT 'FATFHumanTrafficking24'        , 'High Risk Transactions: High Risk Geography'                                                                                             , 'High Risk Transactions: High Risk Geography'                                                                                                              , NULL                              UNION ALL
	SELECT 'FATFHumanTrafficking47'        , 'Patterns of Funds Transfers Between Customers and External Entities; Patterns of Funds Transfers Between Internal Accounts and Customers', 'Patterns of Funds Transfers Between Customers and External Entities; Patterns of Funds Transfers Between Internal Accounts and Customers'                 , 'N/A'                             UNION ALL
	SELECT 'FATFHumanTrafficking52'        , 'Rapid Movement of Funds - All Activity'                                                                                                  , NULL																																						, NULL                                
	)

UPDATE dbo.TStagingIndicator
SET TStagingIndicator.OracleRule = RuleUpdate.OracleRule, 
	TStagingIndicator.ProposedRuleName = RuleUpdate.ProposedRule, 
	TStagingIndicator.FortentRule = RuleUpdate.FortentRule
FROM dbo.TStagingIndicator 
INNER JOIN RuleUpdate ON RuleUpdate.IndicatorRefID = TStagingIndicator.IndicatorRefID
WHERE TStagingIndicator.Segment IN ('Retail', 'Retail/Wealth')

DELETE FROM dbo.TIndicatorXProduct
WHERE ProductID IN (SELECT ProductID FROM TProduct WHERE ProductGrouping IN ('Loan', 'Mortgage'));

----------------------------------------------------------------------------------------------------
----12/20/2018: Updated Loan and Mortgage
----------------------------------------------------------------------------------------------------

WITH MortgageLoanIndicators AS (

	SELECT 38 AS IndicatorID, 'FinTRACLoan7' AS IndicatorRefID, 1 AS Loan, NULL AS Mortgage UNION ALL
	SELECT 41, 'FinTRACLoan10', 1, NULL UNION ALL
	SELECT 42, 'FinTRACLoan11', 1, NULL UNION ALL
	SELECT 44, 'FinTRACLoan13', 1, NULL UNION ALL
	SELECT 45, 'FinTRACLoan14', 1, NULL UNION ALL
	SELECT 46, 'FinTRACLoan15', 1, NULL UNION ALL
	SELECT 78, 'FFIECLending1', 1, NULL UNION ALL
	SELECT 79, 'FFIECLending2', 1, NULL UNION ALL
	SELECT 178, 'FinTRACOffshore4', 1, NULL UNION ALL
	SELECT 180, 'FinTRACOffshore3', 1, NULL UNION ALL
	SELECT 208, 'FFIECLending6', 1, NULL UNION ALL
	SELECT 228, 'FinTRACLoan1', 1, NULL UNION ALL
	SELECT 229, 'FinTRACLoan3', 1, NULL UNION ALL
	SELECT 232, 'FinTRACGen18', 1, NULL UNION ALL
	SELECT 234, 'FinTRACEconPurp1', 1, NULL UNION ALL
	SELECT 261, 'FinTRACLoan2', 1, NULL UNION ALL
	SELECT 314, 'FFIECOtherT6', 1, NULL UNION ALL
	SELECT 328, 'FATFTrustCoServiceProviders03', 1, NULL UNION ALL
	SELECT 334, 'FATFTrustCoServiceProviders09', 1, NULL UNION ALL
	SELECT 422, 'FinTRACLoan16', 1, NULL UNION ALL
	SELECT 457, 'FinTRACAccting9', 1, NULL UNION ALL
	SELECT 533, 'FinTRACBCNotary23', 1, NULL UNION ALL
	SELECT 549, 'FFIECLending3', 1, NULL UNION ALL
	SELECT 550, 'FFIECLending4', 1, NULL UNION ALL
	SELECT 551, 'FFIECLending5', 1, NULL UNION ALL
	SELECT 578, 'FATFNarcotics03', 1, NULL UNION ALL
	SELECT 677, 'FATFDiamonds24', 1, NULL UNION ALL
	SELECT 678, 'FATFDiamonds25', 1, NULL UNION ALL
	SELECT 815, 'FATFFreeTradeZones33', 1, NULL UNION ALL
	SELECT 881, 'FATFSecuritiesInsurance07', 1, NULL UNION ALL
	SELECT 1053, 'EgmontDrugTrafficking16', 1, NULL UNION ALL
	SELECT 1068, 'EgmontTerrorismA12', 1, NULL UNION ALL
	SELECT 1222, 'FATFHumanTrafficking68', 1, NULL UNION ALL
	SELECT 1232, 'FATFHumanTrafficking78', 1, NULL UNION ALL
	SELECT 1305, 'FATFBenOwnership70', 1, NULL UNION ALL
	SELECT 1318, 'FATFBenOwnership83', 1, NULL UNION ALL
	SELECT 1323, 'FATFBenOwnership88', 1, NULL UNION ALL
	SELECT 1332, 'FATFBenOwnership97', 1, NULL UNION ALL
	SELECT 1365, 'FATFTrafficking21', 1, NULL UNION ALL
	SELECT 1402, 'FATFServProv06', 1, NULL UNION ALL
	SELECT 1407, 'FATFServProv11', 1, NULL UNION ALL
	SELECT 1413, 'FATFServProv17', 1, NULL UNION ALL
	SELECT 1490, 'FATFBenOwnership83', 1, 1 UNION ALL
	SELECT 1491, 'FATFBenOwnership88', 1, 1 UNION ALL
	SELECT 1492, 'FFIECLending01', 1, 1 UNION ALL
	SELECT 1493, 'FFIECLending02', 1, 1 UNION ALL
	SELECT 1494, 'FFIECLending03', 1, 1 UNION ALL
	SELECT 1495, 'FFIECLending04', 1, 1 UNION ALL
	SELECT 1496, 'FFIECLending05', 1, 1 UNION ALL
	SELECT 1497, 'FFIECLending06', 1, 1 UNION ALL
	SELECT 1498, 'FFIECLending07', 1, 1 UNION ALL
	SELECT 1499, 'FFIECLending08', NULL, 1 UNION ALL
	SELECT 1500, 'FFIECLending09', NULL, 1 UNION ALL
	SELECT 1501, 'FFIECLending10', 1, 1 UNION ALL
	SELECT 1502, 'FFIECLending11', 1, 1 UNION ALL
	SELECT 1503, 'FFIECLending12', 1, 1 UNION ALL
	SELECT 1504, 'FFIECLending13', 1, 1 UNION ALL
	SELECT 1505, 'FFIECLending14', NULL, 1 UNION ALL
	SELECT 1506, 'FINTRACLoan1', 1, 1 UNION ALL
	SELECT 1507, 'FINTRACLoan10', 1, 1 UNION ALL
	SELECT 1508, 'FINTRACLoan11', 1, 1 UNION ALL
	SELECT 1509, 'FINTRACLoan12', NULL, 1 UNION ALL
	SELECT 1510, 'FINTRACLoan13', 1, 1 UNION ALL
	SELECT 1511, 'FINTRACLoan14', 1, 1 UNION ALL
	SELECT 1512, 'FINTRACLoan15', 1, 1 UNION ALL
	SELECT 1513, 'FINTRACLoan16', 1, 1 UNION ALL
	SELECT 1514, 'FINTRACLoan2', 1, 1 UNION ALL
	SELECT 1515, 'FINTRACLoan3', 1, 1 UNION ALL
	SELECT 1516, 'FINTRACLoan4', NULL, 1 UNION ALL
	SELECT 1517, 'FINTRACLoan5', NULL, 1 UNION ALL
	SELECT 1518, 'FINTRACLoan6', NULL, 1 UNION ALL
	SELECT 1519, 'FINTRACLoan7', 1, 1 UNION ALL
	SELECT 1520, 'FINTRACLoan8', NULL, 1 UNION ALL
	SELECT 1521, 'FINTRACLoan9', NULL, 1 UNION ALL
	SELECT 1522, 'FINTRACMortgage01', NULL, 1 UNION ALL
	SELECT 1523, 'FINTRACMortgage02', 1, 1 UNION ALL
	SELECT 1524, 'FINTRACMortgage03', NULL, 1 UNION ALL
	SELECT 1525, 'FINTRACMortgage04', NULL, 1 UNION ALL
	SELECT 1526, 'FINTRACMortgage05', NULL, 1 UNION ALL
	SELECT 1527, 'FINTRACMortgage06', NULL, 1 UNION ALL
	SELECT 1528, 'FINTRACMortgage07', 1, 1 UNION ALL
	SELECT 1529, 'FINTRACMortgage08', NULL, 1 UNION ALL
	SELECT 1530, 'FINTRACMortgage09', NULL, 1 UNION ALL
	SELECT 1531, 'FINTRACMortgage10', NULL, 1 UNION ALL
	SELECT 1532, 'FINTRACMortgage11', NULL, 1 UNION ALL
	SELECT 1533, 'FINTRACMortgage12', NULL, 1 UNION ALL
	SELECT 1534, 'FINTRACMortgage13', NULL, 1 UNION ALL
	SELECT 1535, 'FINTRACMortgage14', NULL, 1 UNION ALL
	SELECT 1536, 'FINTRACMortgage15', NULL, 1 UNION ALL
	SELECT 1537, 'FINTRACMortgage16', NULL, 1 UNION ALL
	SELECT 1538, 'FINTRACMortgage17', 1, 1 UNION ALL
	SELECT 1539, 'FINTRACMortgage18', 1, 1 UNION ALL
	SELECT 1540, 'FINTRACMortgage19', 1, 1 UNION ALL
	SELECT 1541, 'FINTRACMortgage20', 1, 1 UNION ALL
	SELECT 1542, 'FINTRACMortgage21', NULL, 1 UNION ALL
	SELECT 1543, 'FINTRACMortgage22', NULL, 1 UNION ALL
	SELECT 1544, 'FINTRACMortgage23', NULL, 1 UNION ALL
	SELECT 1545, 'FINTRACMortgage24', NULL, 1 UNION ALL
	SELECT 1546, 'FINTRACMortgage25', 1, 1 UNION ALL
	SELECT 1547, 'FINTRACMortgage26', NULL, 1 UNION ALL
	SELECT 1548, 'MortgageDeveloped01', NULL, 1
)

, MortLoanUnpivot AS (
SELECT * FROM MortgageLoanIndicators UNPIVOT (Coverage FOR ProductGrouping IN (Loan, Mortgage)) upvt 
)

INSERT INTO dbo.TIndicatorXProduct (IndicatorID,ProductID,CoverageLevel)

SELECT IndicatorID, ProductID, MortLoanUnpivot.Coverage--,TProduct.ProductGrouping
FROM MortLoanUnpivot
LEFT JOIN TProduct ON MortLoanUnpivot.ProductGrouping = TProduct.ProductGrouping;

----------------------------------------------------------------------------------------------------
----12/21/2018 Indicator Product Mapping v5.06.xlsm
----------------------------------------------------------------------------------------------------

--Rule Updates
WITH RulesUpdate AS (
	SELECT 1318 AS IndicatorID, 'Large Reportable Transactions' AS Oracle, 'Large Cash Transactions' AS Proposed UNION ALL
	SELECT 1323, 'Early Payoff or Paydown of a Credit Product', 'Early Payoff or Paydown of a Credit Product' UNION ALL
	SELECT 1402, 'Custom Scenario', 'Multiple Jurisdictions' UNION ALL
	SELECT 1413, 'Custom Scenario', 'Multiple Jurisdictions'
	)
UPDATE dbo.TStagingIndicator
SET TStagingIndicator.OracleRule = RulesUpdate.Oracle, 
	TStagingIndicator.ProposedRuleName = RulesUpdate.Proposed
FROM TStagingIndicator 
INNER JOIN RulesUpdate ON TStagingIndicator.IndicatorID = RulesUpdate.IndicatorID;


WITH ProposedRules AS (
SELECT 993 AS IndicatorID, '1. Cash In/Monetary Instrument Out [using Rapid Movement of Funds - All Activity template]; 2. Cash In/Wire Out [using Rapid Movement of Funds - All Activity template];  3. Monetary Instrument In/Monetary Instrument Out [using Rapid Movement of Funds - All Activity template];  4. Monetary Instrument In/Wire Out [using Rapid Movement of Funds - All Activity template]' AS ProposedRule UNION ALL
SELECT 133, '1. Structuring: Avoidance of Reporting Thresholds [using template Structuring: Potential Structuring in Cash and Equivalents];  2. Structuring: Potential Structuring in Cash and Equivalents [using template Structuring: Potential Structuring in Cash and Equivalents];  3. Micro Structuring [using template Structuring: Potential Structuring in Cash and Equivalents];  4. Wire Structuring [using template Deposits/Withdrawals in Same or Similar Amounts]' UNION ALL
SELECT 134, '1. Structuring: Avoidance of Reporting Thresholds [using template Structuring: Potential Structuring in Cash and Equivalents];  2. Structuring: Potential Structuring in Cash and Equivalents [using template Structuring: Potential Structuring in Cash and Equivalents]' UNION ALL
SELECT 138, '1. Structuring: Avoidance of Reporting Thresholds [using template Structuring: Potential Structuring in Cash and Equivalents];  2. Structuring: Potential Structuring in Cash and Equivalents [using template Structuring: Potential Structuring in Cash and Equivalents];  3. Micro Structuring [using template Structuring: Potential Structuring in Cash and Equivalents];  4. Wire Structuring [using template Deposits/Withdrawals in Same or Similar Amounts]' UNION ALL
SELECT 1342, 'High Risk Transactions: High Risk Geography'
)

UPDATE dbo.TStagingIndicator
SET TStagingIndicator.ProposedRuleName = ProposedRules.ProposedRule
FROM TStagingIndicator 
INNER JOIN ProposedRules ON TStagingIndicator.IndicatorID = ProposedRules.IndicatorID;

UPDATE dbo.TStagingIndicator
SET OracleRule = 'High Risk Transactions: High Risk Geography'
WHERE IndicatorID = 1342;

--Update RuleCoverage
UPDATE dbo.TIndicatorXRule
SET InOracle = 'Full'
FROM dbo.TIndicatorXRule 
LEFT JOIN dbo.TRule ON TIndicatorXRule.RuleID = TRule.RuleID
WHERE ProposedRuleName = 'Wire Structuring' AND Source = 'Oracle';

----------------------------------------------------------------------------------------------------
----12/26/2018: Rule Updates and Post QA Changes
----------------------------------------------------------------------------------------------------

--More Rule Updates
WITH RuleUpdates AS (
	SELECT 358  AS IndicatorID, 'FFIECOtherT1' AS IndicatorRefID , 'Rapid Movement Of Funds - All Activity; High Risk Transactions: High Risk Geography' AS Oracle                                                                        , 'Foreign Exchange Followed by Wire Out; High Risk Transactions: High Risk Geography' AS Proposed                                                                            , 'Flow of Funds 1;High Risk Transactions: High Risk Geography' AS Navigant UNION ALL
	SELECT 1076 , 'EgmontTerrorismB05'                      , 'Rapid Movement Of Funds - All Activity; High Risk Transactions: High Risk Geography'                                                                                       , 'Foreign Exchange Followed by Wire Out; High Risk Transactions: High Risk Geography'                                                                                        , 'Flow of Funds 1;High Risk Transactions: High Risk Geography'                          UNION ALL
	SELECT 163  , 'FinTRACForeign9'                         , 'Rapid Movement Of Funds - All Activity; High Risk Transactions: High Risk Geography'                                                                                       , 'Foreign Exchange Followed by Wire Out;High Risk Transactions: High Risk Geography'                                                                                         , 'High Risk Geography (Flow of Funds 1);High Risk Transactions: High Risk Geography'    UNION ALL
	SELECT 1048 , 'EgmontDrugTrafficking03'                 , 'Hub and Spoke;Networks Of Accounts, Entities, And Customers;Patterns Of Funds Transfers Between Customers And External Entities'                                           , 'Hub and Spoke;Networks of Accounts, Entities, and Customers;Pattern of Funds Transfers between Customers and External Entities'                                            , 'Many to One'                                                                          UNION ALL
	SELECT 1432 , 'IIROC8'                                  , 'Early Payoff or Paydown of a Credit Product'                                                                                                                               , 'Early Redemption'                                                                                                                                                          , NULL UNION ALL
	SELECT 1433 , 'FATFSecuritiesUnusual12'                 , 'Early Payoff or Paydown of a Credit Product'                                                                                                                               , 'Early Redemption'                                                                                                                                                          , NULL UNION ALL
	SELECT 1438 , 'FinTRACSecur7'                           , 'Rapid Movement Of Funds - All Activity'                                                                                                                                    , 'Cash In/Internal Transfer Out'                                                                                                                                             , NULL UNION ALL
	SELECT 1472 , 'IIROC14'                                 , 'Rapid Movement Of Funds - All Activity'                                                                                                                                    , 'Bearer Instrument In/Wire Out'                                                                                                                                             , NULL UNION ALL
	SELECT 1475 , 'FATFSecuritiesMktManip21'                , 'Rapid Movement Of Funds - All Activity'                                                                                                                                    , 'Bearer Instrument In/Wire Out'                                                                                                                                             , NULL UNION ALL
	SELECT 1476 , 'IIROC3'                                  , 'Rapid Movement Of Funds - All Activity'                                                                                                                                    , 'Wire In/Wire Out'                                                                                                                                                          , NULL UNION ALL
	SELECT 1477 , 'FATFSecuritiesTransfers03'               , 'Rapid Movement Of Funds - All Activity'                                                                                                                                    , 'All Activity In/All Activity Out'                                                                                                                                          , NULL UNION ALL
	SELECT 1478 , 'FATFSecuritiesTransfers09'               , 'Rapid Movement Of Funds - All Activity'                                                                                                                                    , 'All Activity In/All Activity Out'                                                                                                                                          , NULL UNION ALL
	SELECT 1479 , 'FATFSecuritiesUnusual14'                 , 'Early Payoff or Paydown of a Credit Product'                                                                                                                               , 'Early Redemption'                                                                                                                                                          , NULL UNION ALL
	SELECT 1480 , 'FATFSecuritiesOfferingFraud04'           , 'Rapid Movement Of Funds - All Activity'                                                                                                                                    , 'All Activity In/All Activity Out'                                                                                                                                          , NULL UNION ALL
	SELECT 1481 , 'FinTRACSecur4'                           , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                                , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                                , NULL 
)

UPDATE dbo.TStagingIndicator
SET
	OracleRule = RuleUpdates.Oracle, 
	ProposedRuleName = RuleUpdates.Proposed, 
	NavigantRule = RuleUpdates.Navigant, 
	[Navigant Rule Template] = RuleUpdates.Navigant
FROM dbo.TStagingIndicator
INNER JOIN RuleUpdates ON TStagingIndicator.IndicatorID = RuleUpdates.IndicatorID AND TStagingIndicator.IndicatorRefID = RuleUpdates.IndicatorRefID;

--QA Changes
WITH ChangesViaQA AS (
	SELECT 'FATFTBML35' AS IndicatorRefID, 2 AS Priority, 'Y' AS IsConducive                                           , 'Networks of Accounts, Entities, and Customers; Hub and Spoke' AS Oracle                                                                                , 'Networks of Accounts, Entities, and Customers; Hub and Spoke' AS Proposed                                                                              UNION ALL
	SELECT 'FATFPEPBusinessPurpose08' , 2, 'Y'                                                                          , 'CIB: Significant Change from Previous Average Activity'                                                                                                , 'CIB: Significant Change from Previous Average Activity'                                                                                                UNION ALL
	SELECT 'FATFPEPBusinessPurpose09' , 2, 'Y'                                                                          , 'Escalation in Inactive Account'                                                                                                                        , 'Escalation in Inactive Account'                                                                                                                        UNION ALL
	SELECT 'FATFPEPBusinessPurpose15' , 2, 'Y'                                                                          , 'Large Reportable Transactions'                                                                                                                         , 'Large Cash Transactions'                                                                                                                               UNION ALL
	SELECT 'FATFProliferation21'      , 2, 'Y'                                                                          , 'Large Reportable Transactions'                                                                                                                         , 'Large Cash Transactions'                                                                                                                               UNION ALL
	SELECT 'FATFHumanTrafficking11'   , 2, 'N'                                                                          , NULL                                                                                                                                                    , NULL                                                                                                                                                    UNION ALL
	SELECT 'FATFBenOwnership76'       , 2, 'Y'                                                                          , 'CIB: Product Utilization Shift'                                                                                                                        , 'CIB: Product Utilization Shift'                                                                                                                        UNION ALL
	SELECT 'FATFBenOwnership83'       , 2, 'Y'                                                                          , 'Early Payoff or Paydown of a Credit Product'                                                                                                           , 'Early Payoff or Paydown of a Credit Product'                                                                                                           UNION ALL
	SELECT 'FATFTBML38'               , 2, 'Y'                                                                          , 'Anomalies in ATM, Bank Card: Foreign Transactions'                                                                                                     , 'Anomalies In ATM, Bank Card: Foreign Transactions'                                                                                                     UNION ALL
	SELECT 'FATFTBML40'               , 2, 'Y'                                                                          , 'Anomalies in ATM, Bank Card: Foreign Transactions'                                                                                                     , 'Anomalies In ATM, Bank Card: Foreign Transactions'                                                                                                     UNION ALL
	SELECT 'FATFTrafficking10'        , 2, 'N'                                                                          , 'Patterns of Funds Transfers Between Customers and External Entities; Patterns of Funds Transfers Between Internal Accounts and Customers'              , 'Patterns of Funds Transfers Between Customers and External Entities; Patterns of Funds Transfers Between Internal Accounts and Customers'              UNION ALL
	SELECT 'FATFHumanTrafficking03'   , 2, 'N'                                                                          , 'Anomalies in ATM, Bank Card: Foreign Transactions'                                                                                                     , 'Anomalies In ATM, Bank Card: Foreign Transactions'                                                                                                     UNION ALL
	SELECT 'FATFHumanTrafficking04'   , 2, 'Y'                                                                          , 'Rapid Movement of Funds - All Activity'                                                                                                                , 'Wire In/Cash Out'                                                                                                                                      UNION ALL
	SELECT 'FATFHumanTrafficking06'   , 2, 'N'                                                                          , NULL                                                                                                                                                    , NULL                                                                                                                                                    UNION ALL
	SELECT 'FATFHumanTrafficking07'   , 2, 'N'                                                                          , NULL                                                                                                                                                    , NULL                                                                                                                                                    UNION ALL
	SELECT 'FATFTrafficking35'        , 2, 'Y'                                                                          , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                            , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                            UNION ALL
	SELECT 'FATFTrafficking44'        , 2, 'Y'                                                                          , 'Large Reportable Transactions'                                                                                                                         , 'Large Cash Transactions'                                                                                                                               UNION ALL
	SELECT 'FATFHumanTrafficking14'   , 2, 'Y'                                                                          , 'Rapid Movement of Funds - All Activity'                                                                                                                , 'All Activity In/All Activity Out'                                                                                                                      UNION ALL
	SELECT 'FATFHumanTrafficking15'   , 2, 'Y'                                                                          , 'Rapid Movement of Funds - All Activity'                                                                                                                , 'Cash In/Cash Out'                                                                                                                                      UNION ALL
	SELECT 'FATFTrafficking47'        , 2, 'Y'                                                                          , 'Large Reportable Transactions'                                                                                                                         , 'Large Cash Transactions'                                                                                                                               UNION ALL
	SELECT 'FATFHumanTrafficking22'   , 2, 'Y'                                                                          , 'Networks of Accounts, Entities, and Customers'                                                                                                         , 'Networks of Accounts, Entities, and Customers'                                                                                                         UNION ALL
	SELECT 'FATFHumanTrafficking55'   , 2, 'Y'                                                                          , 'Patterns of Funds Transfers Between Customers and External Entities'                                                                                   , 'Patterns of Funds Transfers Between Customers and External Entities'                                                                                   UNION ALL
	SELECT 'FATFHumanTrafficking24'   , 2, 'Y'                                                                          , 'High Risk Transactions: High Risk Geography'                                                                                                           , 'High Risk Transactions: High Risk Geography'                                                                                                           UNION ALL
	SELECT 'FATFHumanTrafficking70'   , 2, 'Y'                                                                          , 'Hub and Spoke'                                                                                                                                         , 'Hub and Spoke'                                                                                                                                         UNION ALL
	SELECT 'FATFHumanTrafficking72'   , 2, 'Y'                                                                          , 'Journals Between Unrelated Accounts'                                                                                                                   , 'Journals Between Unrelated Accounts'                                                                                                                   UNION ALL
	SELECT 'FATFBenOwnership32'       , 2, 'Y'                                                                          , 'Patterns of Funds Transfers Between Customers and External Entities; Patterns of Funds Transfers Between Internal Accounts and Customers'              , 'Patterns of Funds Transfers Between Customers and External Entities; Patterns of Funds Transfers Between Internal Accounts and Customers'              UNION ALL
	SELECT 'FATFHumanTrafficking47'   , 2, 'Y'                                                                          , 'Patterns of Funds Transfers Between Customers and External Entities; Patterns of Funds Transfers Between Internal Accounts and Customers'              , 'Patterns of Funds Transfers Between Customers and External Entities; Patterns of Funds Transfers Between Internal Accounts and Customers'              UNION ALL
	SELECT 'FATFHumanTrafficking52'   , 2, 'Y'                                                                          , 'Hub and Spoke'                                                                                                                                         , 'Hub and Spoke'                                                                                                                                         UNION ALL
	SELECT 'FATFBenOwnership33'       , 2, 'Y'                                                                          , 'Patterns of Funds Transfers Between Customers and External Entities; Patterns of Funds Transfers Between Internal Accounts and Customers'              , 'Patterns of Funds Transfers Between Customers and External Entities; Patterns of Funds Transfers Between Internal Accounts and Customers'              UNION ALL
	SELECT 'FATFBenOwnership73'       , 2, 'Y'                                                                          , 'Patterns of Funds Transfers Between Customers and External Entities; Patterns of Funds Transfers Between Internal Accounts and Customers'              , 'Patterns of Funds Transfers Between Customers and External Entities; Patterns of Funds Transfers Between Internal Accounts and Customers'              UNION ALL
	SELECT 'FATFProliferation23'      , 1, 'Y'                                                                          , 'High Risk Transactions: High Risk Geography'                                                                                                           , 'High Risk Transactions: High Risk Geography'                                                                                                           UNION ALL
	SELECT 'FATFProliferation28'      , 1, 'Y'                                                                          , 'High Risk Transactions: High Risk Geography '                                                                                                          , 'High Risk Transactions: High Risk Geography '                                                                                                          UNION ALL
	SELECT 'FATFProliferation32'      , 1, 'Y'                                                                          , 'High Risk Transactions: High Risk Geography'                                                                                                           , 'High Risk Transactions: High Risk Geography'                                                                                                           UNION ALL
	SELECT 'FATFProliferation43'      , 1, 'Y'                                                                          , 'High Risk Transactions: High Risk Geography '                                                                                                          , 'High Risk Transactions: High Risk Geography '                                                                                                          UNION ALL
	SELECT 'FATFHumanTrafficking23'   , 1, 'Y'                                                                          , 'High Risk Transactions: High Risk Geography '                                                                                                          , 'High Risk Transactions: High Risk Geography '                                                                                                          UNION ALL
	SELECT 'FATFHumanTrafficking79'   , 2, 'N'                                                                          , NULL                                                                                                                                                    , NULL                                                                                                                                                    UNION ALL
	SELECT 'FATFBenOwnership31'       , 2, 'N'                                                                          , NULL                                                                                                                                                    , NULL                                                                                                                                                    UNION ALL
	SELECT 'FATFBenOwnership84'       , 2, 'Y'                                                                          , 'Custom Scenario'                                                                                                                                       , 'Numbered Accounts'                                                                                                                                     UNION ALL
	SELECT 'FinTRACDeveloped01'       , 1, 'Y'                                                                          , 'Structuring: Deposits/Withdrawals of Mixed Monetary Instruments'                                                                                       , 'Third Party Monetary Instrument Deposits'                                                                                                              UNION ALL
	SELECT 'FATFBenOwnership67'       , 2, 'Y'                                                                          , NULL                                                                                                                                                    , NULL                                                                                                                                                    UNION ALL
	SELECT 'FATFBenOwnership81'       , 2, 'N'                                                                          , NULL                                                                                                                                                    , NULL                                                                                                                                                    UNION ALL
	SELECT 'FATFTrafficking26'        , 2, 'Y'                                                                          , 'Address Associated with Multiple, Recurring External Entities; Hub and Spoke'                                                                          , 'Single Address for Multiple Entities'                                                                                                                  UNION ALL
	SELECT 'FATFPEPBusinessPurpose11' , 2, 'N'                                                                          , NULL                                                                                                                                                    , NULL                                                                                                                                                    UNION ALL
	SELECT 'FATFPEPBusinessPurpose12' , 2, 'N'                                                                          , NULL                                                                                                                                                    , NULL                                                                                                                                                    UNION ALL
	SELECT 'FATFHumanTrafficking09'   , 2, 'Y'                                                                          , 'Patterns of Funds Transfers Between Customers and External Entities; Patterns of Funds Transfers Between Internal Accounts and Customers'              , 'Patterns of Funds Transfers Between Customers and External Entities; Patterns of Funds Transfers Between Internal Accounts and Customers'              UNION ALL
	SELECT 'FATFHumanTrafficking26'   , 2, 'Y'                                                                          , 'CIB: Significant Change from Previous Average Activity'                                                                                                , 'CIB: Significant Change from Previous Average Activity'                                                                                                UNION ALL
	SELECT 'FATFHumanTrafficking56'   , 2, 'Y'                                                                          , 'Large Depreciation of Account Value'                                                                                                                   , 'Large Depreciation of Account Value'                                                                                                                   UNION ALL
	SELECT 'FATFHumanTrafficking58'   , 2, 'Y'                                                                          , 'CIB: Product Utilization Shift'                                                                                                                        , 'CIB: Product Utilization Shift'                                                                                                                        UNION ALL
	SELECT 'FATFHumanTrafficking59'   , 2, 'Y'                                                                          , 'CIB: Significant Change from Previous Average Activity'                                                                                                , 'CIB: Significant Change from Previous Average Activity'                                                                                                UNION ALL
	SELECT 'FATFHumanTrafficking60'   , 2, 'Y'                                                                          , 'CIB: Significant Change from Previous Average Activity'                                                                                                , 'CIB: Significant Change from Previous Average Activity'                                                                                                UNION ALL
	SELECT 'FATFHumanTrafficking65'   , 2, 'Y'                                                                          , 'CIB: Significant Change from Previous Average Activity'                                                                                                , 'CIB: Significant Change from Previous Average Activity'                                                                                                UNION ALL
	SELECT 'FATFHumanTrafficking71'   , 2, 'Y'                                                                          , 'CIB: Product Utilization Shift'                                                                                                                        , 'CIB: Product Utilization Shift'                                                                                                                        UNION ALL
	SELECT 'FATFHumanTrafficking73'   , 2, 'Y'                                                                          , 'Deviation from Peer Group: Total Activity'                                                                                                             , 'Deviation from Peer Group: Total Activity'                                                                                                             UNION ALL
	SELECT 'FATFHumanTrafficking74'   , 2, 'Y'                                                                          , 'Deviation from Peer Group: Product Utilization'                                                                                                        , 'Deviation from Peer Group: Product Utilization'                                                                                                        UNION ALL
	SELECT 'FATFBenOwnership34'       , 2, 'Y'                                                                          , 'High Risk Transactions: High Risk Geography '                                                                                                          , 'High Risk Transactions: High Risk Geography '                                                                                                          UNION ALL
	SELECT 'FATFBenOwnership38'       , 2, 'Y'                                                                          , 'CIB: Significant Change from Previous Average Activity'                                                                                                , 'CIB: Significant Change from Previous Average Activity'                                                                                                UNION ALL
	SELECT 'FATFTBML32'               , 2, 'Y'                                                                          , 'Escalation in Inactive Account'                                                                                                                        , 'Escalation in Inactive Account'                                                                                                                        UNION ALL
	SELECT 'FATFTBML34'               , 2, 'N'                                                                          , NULL                                                                                                                                                    , NULL                                                                                                                                                    UNION ALL
	SELECT 'FATFTrafficking13'        , 2, 'Y'                                                                          , 'High Risk Transactions: High Risk Geography '                                                                                                          , 'High Risk Transactions: High Risk Geography '                                                                                                          UNION ALL
	SELECT 'FATFTrafficking14'        , 2, 'N'                                                                          , NULL                                                                                                                                                    , NULL                                                                                                                                                    UNION ALL
	SELECT 'FATFTrafficking19'        , 2, 'Y'                                                                          , 'CIB: Significant Change from Previous Average Activity'                                                                                                , 'CIB: Significant Change from Previous Average Activity'                                                                                                UNION ALL
	SELECT 'FATFTrafficking45'        , 2, 'Y'                                                                          , 'CIB: Product Utilization Shift'                                                                                                                        , 'CIB: Product Utilization Shift'                                                                                                                        UNION ALL
	SELECT 'FATFBenOwnership88'       , 2, 'Y'                                                                          , 'Early Payoff or Paydown of a Credit Product'                                                                                                           , 'Early Payoff or Paydown of a Credit Product'                                                                                                           UNION ALL
	SELECT 'FATFBenOwnership92'       , 2, 'Y'                                                                          , 'CIB: Significant Change from Previous Average Activity'                                                                                                , 'CIB: Significant Change from Previous Average Activity'                                                                                                UNION ALL
	SELECT 'FATFBenOwnership93'       , 2, 'Y'                                                                          , 'CIB: Significant Change from Previous Average Activity'                                                                                                , 'CIB: Significant Change from Previous Average Activity'                                                                                                UNION ALL
	SELECT 'FATFBenOwnership95'       , 2, 'Y'                                                                          , 'High Risk Transactions: High Risk Counter Party'                                                                                                       , 'High Risk Transactions: High Risk Counter Party'                                                                                                       UNION ALL
	SELECT 'FATFBenOwnership96'       , 2, 'Y'                                                                          , 'High Risk Transactions: High Risk Geography'                                                                                                           , 'High Risk Transactions: High Risk Geography'                                                                                                           UNION ALL
	SELECT 'FATFHumanTrafficking61'   , 2, 'Y'                                                                          , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                            , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                            UNION ALL
	SELECT 'FATFTBML31'               , 2, 'Y'                                                                          , 'High Risk Transactions: High Risk Geography'                                                                                                           , 'High Risk Transactions: High Risk Geography'                                                                                                           UNION ALL
	SELECT 'FATFHumanTrafficking78'   , 2, 'Y'                                                                          , 'Deposits/Withdrawals in Same or Similar Amounts'                                                                                                       , 'Structuring: Avoidance of Reporting Thresholds'                                                                                                        UNION ALL
	SELECT 'FATFTBML30'               , 2, 'Y'                                                                          , 'Patterns of Sequentially Numbered Checks, Monetary Instruments; Deposits/Withdrawals in Same or Similar Amounts'                                       , 'Pattern of Sequentially Numbered Checks; Monetary Instrument Structuring'                                                                              UNION ALL
	SELECT 'FATFTBML36'               , 2, 'Y'                                                                          , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                            , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                            UNION ALL
	SELECT 'FATFTBML41'               , 2, 'Y'                                                                          , 'Structuring: Potential Structuring in Cash and Equivalents; Deposits/Withdrawals in Same or Similar Amounts'                                           , 'Structuring: Potential Structuring in Cash and Equivalents; Monetary Instrument Structuring'                                                           UNION ALL
	SELECT 'FATFTrafficking29'        , 2, 'Y'                                                                          , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                            , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                            UNION ALL
	SELECT 'FATFTrafficking37'        , 2, 'Y'                                                                          , 'Deposits/Withdrawals in Same or Similar Amounts'                                                                                                       , 'Wire Structuring'                                                                                                                                      UNION ALL
	SELECT 'FATFHumanTrafficking37'   , 2, 'Y'                                                                          , 'Rapid Movement of Funds - All Activity'                                                                                                                , 'All Activity In/All Activity Out'                                                                                                                      UNION ALL
	SELECT 'FATFHumanTrafficking64'   , 2, 'Y'                                                                          , 'Rapid Movement of Funds - All Activity'                                                                                                                , 'All Activity in/Cash Out'                                                                                                                              UNION ALL
	SELECT 'FATFHumanTrafficking66'   , 2, 'Y'                                                                          , 'Rapid Movement of Funds - All Activity'                                                                                                                , 'Cash In/Wire Out'                                                                                                                                      UNION ALL
	SELECT 'FATFHumanTrafficking67'   , 2, 'Y'                                                                          , 'Rapid Movement of Funds - All Activity'                                                                                                                , 'Cash In/Wire Out'                                                                                                                                      UNION ALL
	SELECT 'FATFHumanTrafficking75'   , 2, 'Y'                                                                          , 'Rapid Movement of Funds - All Activity'                                                                                                                , 'All Activity In/All Activity Out'                                                                                                                      UNION ALL
	SELECT 'FATFBenOwnership36'       , 2, 'Y'                                                                          , 'Rapid Movement of Funds - All Activity'                                                                                                                , 'All Activity In/All Activity Out'                                                                                                                      UNION ALL
	SELECT 'FATFBenOwnership37'       , 2, 'Y'                                                                          , 'Rapid Movement of Funds - All Activity'                                                                                                                , 'All Activity In/All Activity Out'                                                                                                                      UNION ALL
	SELECT 'FATFBenOwnership63'       , 2, 'Y'                                                                          , 'Rapid Movement of Funds - All Activity'                                                                                                                , 'All Activity In/All Activity Out'                                                                                                                      UNION ALL
	SELECT 'FATFBenOwnership77'       , 2, 'Y'                                                                          , 'Rapid Movement Funds - All Activity'                                                                                                                   , 'All Activity In/All Activity Out'                                                                                                                      UNION ALL
	SELECT 'FATFBenOwnership78'       , 2, 'Y'                                                                          , 'Rapid Movement Funds - All Activity'                                                                                                                   , 'All Activity In/All Activity Out'                                                                                                                      UNION ALL
	SELECT 'FATFTrafficking22'        , 2, 'Y'                                                                          , 'Anomalies in ATM, Bank Card: Excessive Withdrawals'                                                                                                    , 'Anomalies in ATM, Bank Card: Excessive Withdrawals'                                                                                                    UNION ALL
	SELECT 'FATFTrafficking23'        , 2, 'Y'                                                                          , 'Rapid Movement Funds - All Activity'                                                                                                                   , 'All Activity In/All Activity Out'                                                                                                                      UNION ALL
	SELECT 'FATFTrafficking24'        , 2, 'N'                                                                          , NULL                                                                                                                                                    , NULL                                                                                                                                                    UNION ALL
	SELECT 'FATFTrafficking33'        , 2, 'Y'                                                                          , 'Rapid Movement Funds - All Activity'                                                                                                                   , 'Cash-Check In/Wire Out'                                                                                                                                UNION ALL
	SELECT 'FATFTrafficking36'        , 2, 'Y'                                                                          , 'Rapid Movement Funds - All Activity'                                                                                                                   , 'Wire In/Wire out'                                                                                                                                      UNION ALL
	SELECT 'FATFTrafficking38'        , 2, 'Y'                                                                          , 'Rapid Movement Funds - All Activity'                                                                                                                   , 'Cash In/Wire Out'                                                                                                                                      UNION ALL
	SELECT 'FATFTrafficking39'        , 2, 'Y'                                                                          , 'Rapid Movement Funds - All Activity'                                                                                                                   , 'Cash In/Wire Out'                                                                                                                                      UNION ALL
	SELECT 'FATFTrafficking43'        , 2, 'Y'                                                                          , 'Rapid Movement Funds - All Activity'                                                                                                                   , 'All Activity In/All Activity Out'                                                                                                                      UNION ALL
	SELECT 'FATFNewPmtMethods12'      , 2, 'Y'                                                                          , 'Rapid Movement Funds - All Activity'                                                                                                                   , 'All Activity In/All Activity Out'                                                                                                                      UNION ALL
	SELECT 'FATFHumanTrafficking16'   , 2, 'Y'                                                                          , 'High Risk Transactions: High Risk Counter Party'                                                                                                       , 'High Risk Transactions: High Risk Counter Party'                                                                                                       UNION ALL
	SELECT 'FATFHumanTrafficking32'   , 2, 'Y'                                                                          , 'High Risk Transactions: High Risk Counter Party'                                                                                                       , 'High Risk Transactions: High Risk Counter Party'                                                                                                       UNION ALL
	SELECT 'FATFTrafficking48'        , 2, 'Y'                                                                          , 'CIB: Significant Change from Previous Average Activity; CIB: Product Utilization Shift; Deviation from Peer Group - Total Activity'                    , 'CIB: Significant Change from Previous Average Activity; CIB: Product Utilization Shift; Deviation from Peer Group - Total Activity'                    UNION ALL
	SELECT 'FATFTrafficking50'        , 2, 'N'                                                                          , 'CIB: Significant Change from Previous Average Activity; CIB: Product Utilization Shift'                                                                , 'CIB: Significant Change from Previous Average Activity; CIB: Product Utilization Shift'                                                                UNION ALL
	SELECT 'FATFTrafficking51'        , 2, 'Y'                                                                          , 'CIB: Significant Change from Previous Average Activity; CIB: Product Utilization Shift'                                                                , 'CIB: Significant Change from Previous Average Activity; CIB: Product Utilization Shift'                                                                UNION ALL
	SELECT 'FATFTrafficking52'        , 2, 'Y'                                                                          , 'Rapid Movement of Funds - All Activity; Rapid Movement of Funds - All Activity'                                                                        , 'Cash In/Wire Out; Cash In/Monetary Instrument Out'                                                                                                     UNION ALL
	SELECT 'FATFServProv06'           , 2, 'Y'                                                                          , 'Custom Scenario'                                                                                                                                       , 'Multiple Jurisdictions'                                                                                                                                UNION ALL
	SELECT 'FATFServProv17'           , 2, 'Y'                                                                          , 'Custom Scenario'                                                                                                                                       , 'Multiple Jurisdictions'                                                                                                                                UNION ALL
	SELECT 'FATFTrafficking42'        , 2, 'Y'                                                                          , 'High Risk Transactions: High Risk Counter Party'                                                                                                       , 'High Risk Transactions: High Risk Counter Party'                                                                                                       UNION ALL
	SELECT 'FATFNewPmtMethods14'      , 2, 'Y'                                                                          , 'Rapid Movement of Funds - All Activity'                                                                                                                , 'Wire In/Wire Out'                                                                                                                                      UNION ALL
	SELECT 'FATFNewPmtMethods15'      , 2, 'Y'                                                                          , 'Deviation from Peer Group: Product Utilization'                                                                                                        , 'Deviation from Peer Group: Product Utilization'                                                                                                        
	)

UPDATE dbo.TStagingIndicator
SET TStagingIndicator.Priority = ChangesViaQA.Priority, 
	TStagingIndicator.IsConduciveToAutomatedMonitoring = ChangesViaQA.IsConducive, 
	TStagingIndicator.OracleRule = ChangesViaQA.Oracle, 
	TStagingIndicator.ProposedRuleName = ChangesViaQA.Proposed
FROM dbo.TStagingIndicator
INNER JOIN ChangesViaQA ON TStagingIndicator.IndicatorRefID = ChangesViaQA.IndicatorRefID AND TStagingIndicator.Segment = 'Retail';
	

----------------------------------------------------------------------------------------------------
----12/27/2018 Fix for Duplicates - Update All Purple
----------------------------------------------------------------------------------------------------

--Add Duplicate Column
ALTER TABLE dbo.TStagingIndicator
ADD IsDuplicate nvarchar(1); 

UPDATE TStagingIndicator
SET TStagingIndicator.IsDuplicate = CASE TIndicator.IsDuplicate WHEN 1 THEN 'Y' WHEN 0 THEN 'N' END
FROM TStagingIndicator
INNER JOIN TIndicator ON TStagingIndicator.IndicatorID = TIndicator.IndicatorID;

--Update Duplicates
WITH DuplicateUpdate AS (

	SELECT 1035 AS IndicatorID, 'DoFinSec03' AS IndicatorRefID, 'Y' AS IsApplicable    , 'Y' AS IsConducive    , NULL AS Priority      , NULL AS Oracle      , NULL AS Proposed                                                                                                                                  , 'Y' AS IsDuplicate    UNION ALL
	SELECT 1431 , 'DoFinSec03'                    , 'Y'    , 'Y'    , 2         , 'Custom Scenario'                                                                                                                   , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1318 , 'FATFBenOwnership83'            , 'Y'    , 'Y'	, 2         , 'Early Payoff or Paydown of a Credit Product'                                                                                       , 'Early Payoff of a Credit Product'                                                                                                  , 'N'    UNION ALL
	SELECT 1490 , 'FATFBenOwnership83'            , 'Y'    , 'Y'    , 2         , 'Early Payoff or Paydown of a Credit Product'                                                                                       , 'Early Payoff of a Credit Product'                                                                                                  , 'N'    UNION ALL
	SELECT 1323 , 'FATFBenOwnership88'            , 'Y'    , 'Y'    , 2         , 'Early Payoff or Paydown of a Credit Product'                                                                                       , 'Early Payoff of a Credit Product'                                                                                                  , 'N'    UNION ALL
	SELECT 1491 , 'FATFBenOwnership88'            , 'Y'    , 'Y'    , 2         , 'Early Payoff or Paydown of a Credit Product'                                                                                       , 'Early Payoff of a Credit Product'                                                                                                  , 'N'    UNION ALL
	SELECT 1473 , 'FATFSecuritiesBearer03'        , 'Y'    , 'Y'    , 2         , 'Hidden Relationships;Journals Between Unrelated Accounts'                                                                          , 'Hidden Relationships;Journals Between Unrelated Accounts'                                                                          , 'N'    UNION ALL
	SELECT 860  , 'FATFSecuritiesBearer03'        , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1471 , 'FATFSecuritiesCDD14'           , 'Y'    , 'Y'    , 1         , 'Custom Scenario'                                                                                                                   , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 831  , 'FATFSecuritiesCDD14'           , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 833  , 'FATFSecuritiesCDD16'           , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1452 , 'FATFSecuritiesCDD16'           , 'Y'    , 'Y'    , 2         , 'Large Depreciation of Account Value'                                                                                               , 'Large Depreciation of Account Value'                                                                                               , 'N'    UNION ALL
	SELECT 1482 , 'FATFSecuritiesCDD27'           , 'Y'    , 'Y'    , 1         , 'Structuring: Avoidance of Reporting Thresholds'                                                                                    , 'Structuring: Avoidance of Reporting Thresholds'                                                                                    , 'N'    UNION ALL
	SELECT 844  , 'FATFSecuritiesCDD27'           , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1446 , 'FATFSecuritiesInsurance03'     , 'Y'    , 'Y'    , 2         , 'Policies with Large Early Removal'                                                                                                 , 'Policies with Large Early Removal'                                                                                                 , 'N'    UNION ALL
	SELECT 877  , 'FATFSecuritiesInsurance03'     , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1445 , 'FATFSecuritiesInsurance07'     , 'Y'    , 'Y'    , 2         , 'Customer Borrowing Against New Policy'                                                                                             , 'Customer Borrowing Against New Policy'                                                                                             , 'N'    UNION ALL
	SELECT 881  , 'FATFSecuritiesInsurance07'     , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 907  , 'FATFSecuritiesMktManip01'      , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1486 , 'FATFSecuritiesMktManip01'      , 'Y'    , 'Y'    , 1         , 'Customers Engaging in Offsetting Trades'                                                                                           , 'Customer Engaging in Offsetting Trades'                                                                                            , 'N'    UNION ALL
	SELECT 1464 , 'FATFSecuritiesMktManip02'      , 'Y'    , 'Y'    , 2         , 'Journals Between Unrelated Accounts;Patterns Of Funds Transfers Between Customers And External Entities'                           , 'Journals Between Unrelated Accounts;Pattern of Funds Transfers between Customers and External Entities'                            , 'N'    UNION ALL
	SELECT 908  , 'FATFSecuritiesMktManip02'      , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 909  , 'FATFSecuritiesMktManip03'      , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1437 , 'FATFSecuritiesMktManip03'      , 'Y'    , 'Y'    , 2         , 'High Risk Instructions'                                                                                                            , 'High Risk Instructions'                                                                                                            , 'N'    UNION ALL
	SELECT 910  , 'FATFSecuritiesMktManip04'      , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1470 , 'FATFSecuritiesMktManip04'      , 'Y'    , 'Y'    , 1         , 'Custom Scenario'                                                                                                                   , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1465 , 'FATFSecuritiesMktManip05'      , 'Y'    , 'Y'    , 1         , 'Journals Between Unrelated Accounts'                                                                                               , 'Journals Between Unrelated Accounts'                                                                                               , 'N'    UNION ALL
	SELECT 911  , 'FATFSecuritiesMktManip05'      , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 913  , 'FATFSecuritiesMktManip07'      , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1487 , 'FATFSecuritiesMktManip07'      , 'Y'    , 'Y'    , 2         , 'Customers Engaging in Offsetting Trades'                                                                                           , 'Customer Engaging in Offsetting Trades'                                                                                            , 'N'    UNION ALL
	SELECT 914  , 'FATFSecuritiesMktManip08'      , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1488 , 'FATFSecuritiesMktManip08'      , 'Y'    , 'Y'    , 2         , 'Customers Engaging in Offsetting Trades'                                                                                           , 'Customer Engaging in Offsetting Trades'                                                                                            , 'N'    UNION ALL
	SELECT 1474 , 'FATFSecuritiesMktManip13'      , 'Y'    , 'Y'    , 2         , 'Hidden Relationships;Journals Between Unrelated Accounts;Patterns Of Funds Transfers Between Customers And External Entities'      , 'Hidden Relationships;Journals Between Unrelated Accounts;Pattern of Funds Transfers between Customers and External Entities'       , 'N'    UNION ALL
	SELECT 919  , 'FATFSecuritiesMktManip13'      , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 920  , 'FATFSecuritiesMktManip14'      , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1469 , 'FATFSecuritiesMktManip14'      , 'Y'    , 'Y'    , 2         , 'Custom Scenario'                                                                                                                   , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 927  , 'FATFSecuritiesMktManip21'      , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1475 , 'FATFSecuritiesMktManip21'      , 'Y'    , 'Y'    , 2         , 'Rapid Movement Of Funds - All Activity'                                                                                            , 'Bearer Instrument In/Wire Out'                                                                                                     , 'N'    UNION ALL
	SELECT 928  , 'FATFSecuritiesMktManip22'      , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1467 , 'FATFSecuritiesMktManip22'      , 'Y'    , 'Y'    , 1         , 'Custom Scenario'                                                                                                                   , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 932  , 'FATFSecuritiesOfferingFraud04' , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1480 , 'FATFSecuritiesOfferingFraud04' , 'Y'    , 'Y'    , 2         , 'Rapid Movement Of Funds - All Activity'                                                                                            , 'All Activity In/All Activity Out'                                                                                                  , 'N'    UNION ALL
	SELECT 882  , 'FATFSecuritiesProfiling01'     , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1443 , 'FATFSecuritiesProfiling01'     , 'Y'    , 'Y'    , 1         , 'CIB: Significant Change from Previous Average Activity'                                                                            , 'CIB: Significant Change from Previous Average Activity'                                                                            , 'N'    UNION ALL
	SELECT 1463 , 'FATFSecuritiesProfiling02'     , 'Y'    , 'Y'    , 2         , 'Hidden Relationships;Journals Between Unrelated Accounts'                                                                          , 'Hidden Relationships;Journals Between Unrelated Accounts'                                                                          , 'N'    UNION ALL
	SELECT 883  , 'FATFSecuritiesProfiling02'     , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 885  , 'FATFSecuritiesProfiling04'     , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1450 , 'FATFSecuritiesProfiling04'     , 'Y'    , 'Y'    , 1         , 'Movement of Funds without Corresponding Trade'                                                                                     , 'Movement of Funds without Corresponding Trade'                                                                                     , 'N'    UNION ALL
	SELECT 890  , 'FATFSecuritiesProfiling09'     , 'N'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1444 , 'FATFSecuritiesProfiling09'     , 'Y'    , 'Y'    , 2         , 'CIB: Significant Change in Trade/Transaction Activity'                                                                             , 'CIB: Significant Change in Trade/Transaction Activity'                                                                             , 'N'    UNION ALL
	SELECT 847  , 'FATFSecuritiesTransfers01'     , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1436 , 'FATFSecuritiesTransfers01'     , 'Y'    , 'Y'    , 1         , 'High Risk Transactions: High Risk Geography'                                                                                       , 'High Risk Transactions: High Risk Geography'                                                                                       , 'N'    UNION ALL
	SELECT 848  , 'FATFSecuritiesTransfers02'     , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1454 , 'FATFSecuritiesTransfers02'     , 'Y'    , 'Y'    , 3         , 'Custom Scenario'                                                                                                                   , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 849  , 'FATFSecuritiesTransfers03'     , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1477 , 'FATFSecuritiesTransfers03'     , 'Y'    , 'Y'    , 2         , 'Rapid Movement Of Funds - All Activity'                                                                                            , 'All Activity In/All Activity Out'                                                                                                  , 'N'    UNION ALL
	SELECT 852  , 'FATFSecuritiesTransfers06'     , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1451 , 'FATFSecuritiesTransfers06'     , 'Y'    , 'Y'    , 1         , 'Patterns Of Funds Transfers Between Customers And External Entities'                                                               , 'Pattern of Funds Transfers between Customers and External Entities'                                                                , 'N'    UNION ALL
	SELECT 853  , 'FATFSecuritiesTransfers07'     , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1449 , 'FATFSecuritiesTransfers07'     , 'Y'    , 'Y'    , 1         , 'Movement of Funds without Corresponding Trade'                                                                                     , 'Movement of Funds without Corresponding Trade'                                                                                     , 'N'    UNION ALL
	SELECT 855  , 'FATFSecuritiesTransfers09'     , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1478 , 'FATFSecuritiesTransfers09'     , 'Y'    , 'Y'    , 1         , 'Rapid Movement Of Funds - All Activity'                                                                                            , 'All Activity In/All Activity Out'                                                                                                  , 'N'    UNION ALL
	SELECT 856  , 'FATFSecuritiesTransfers10'     , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1461 , 'FATFSecuritiesTransfers10'     , 'Y'    , 'Y'    , 1         , 'Patterns Of Funds Transfers Between Customers And External Entities'                                                               , 'Pattern of Funds Transfers between Customers and External Entities'                                                                , 'N'    UNION ALL
	SELECT 861  , 'FATFSecuritiesUnusual01'       , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1484 , 'FATFSecuritiesUnusual01'       , 'Y'    , 'Y'    , 1         , 'Customers Engaging in Offsetting Trades'                                                                                           , 'Customer Engaging in Offsetting Trades'                                                                                            , 'N'    UNION ALL
	SELECT 862  , 'FATFSecuritiesUnusual02'       , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1485 , 'FATFSecuritiesUnusual02'       , 'Y'    , 'Y'    , 1         , 'Customers Engaging in Offsetting Trades'                                                                                           , 'Customer Engaging in Offsetting Trades'                                                                                            , 'N'    UNION ALL
	SELECT 863  , 'FATFSecuritiesUnusual03'       , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1466 , 'FATFSecuritiesUnusual03'       , 'Y'    , 'Y'    , 1         , 'Custom Scenario'                                                                                                                   , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 867  , 'FATFSecuritiesUnusual07'       , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1462 , 'FATFSecuritiesUnusual07'       , 'Y'    , 'Y'    , 1         , 'Journals Between Unrelated Accounts;Manipulation of Account/Customer Data Followed by Instruction Changes'                         , 'Journals Between Unrelated Accounts;Manipulation of Account/Customer Data Followed by Instruction Changes'                         , 'N'    UNION ALL
	SELECT 868  , 'FATFSecuritiesUnusual08'       , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1442 , 'FATFSecuritiesUnusual08'       , 'Y'    , 'Y'    , 1         , 'Escalation in Inactive Account'                                                                                                    , 'Escalation in Inactive Account'                                                                                                    , 'N'    UNION ALL
	SELECT 872  , 'FATFSecuritiesUnusual12'       , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1433 , 'FATFSecuritiesUnusual12'       , 'Y'    , 'Y'    , 1         , 'Early Payoff or Paydown of a Credit Product'                                                                                       , 'Early Redemption'                                                                                                                  , 'N'    UNION ALL
	SELECT 874  , 'FATFSecuritiesUnusual14'       , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1479 , 'FATFSecuritiesUnusual14'       , 'Y'    , 'Y'    , 1         , 'Early Payoff or Paydown of a Credit Product'                                                                                       , 'Early Redemption'                                                                                                                  , 'N'    UNION ALL
	SELECT 725  , 'FATFTF09'                      , 'N'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 737  , 'FATFTF09'                      , 'N'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 228  , 'FinTRACLoan1'                  , 'Y'    , 'Y'    , 2         , 'Early Payoff or Paydown of a Credit Product'                                                                                       , 'Early Payoff of a Credit Product'                                                                                                  , 'N'    UNION ALL
	SELECT 1506 , 'FINTRACLoan1'                  , 'Y'    , 'Y'    , 2         , 'Early Payoff or Paydown of a Credit Product'                                                                                       , 'Early Payoff of a Credit Product'                                                                                                  , 'N'    UNION ALL
	SELECT 41   , 'FinTRACLoan10'                 , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1507 , 'FINTRACLoan10'                 , 'N'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 42   , 'FinTRACLoan11'                 , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1508 , 'FINTRACLoan11'                 , 'N'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 43   , 'FinTRACLoan12'                 , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1509 , 'FINTRACLoan12'                 , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 44   , 'FinTRACLoan13'                 , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1510 , 'FINTRACLoan13'                 , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 45   , 'FinTRACLoan14'                 , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1511 , 'FINTRACLoan14'                 , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 46   , 'FinTRACLoan15'                 , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1512 , 'FINTRACLoan15'                 , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 422  , 'FinTRACLoan16'                 , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1513 , 'FINTRACLoan16'                 , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 261  , 'FinTRACLoan2'                  , 'Y'    , 'Y'    , 2         , 'CIB: Significant Change from Previous Average Activity'                                                                            , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1514 , 'FINTRACLoan2'                  , 'Y'    , 'Y'    , 2         , 'CIB: Significant Change from Previous Average Activity'                                                                            , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 229  , 'FinTRACLoan3'                  , 'Y'    , 'Y'    , 2         , 'Early Payoff or Paydown of a Credit Product'                                                                                       , 'Early Payoff of a Credit Product'                                                                                                  , 'N'    UNION ALL
	SELECT 1515 , 'FINTRACLoan3'                  , 'Y'    , 'Y'    , 2         , 'Early Payoff or Paydown of a Credit Product'                                                                                       , 'Early Payoff of a Credit Product'                                                                                                  , 'N'    UNION ALL
	SELECT 262  , 'FinTRACLoan4'                  , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1516 , 'FINTRACLoan4'                  , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 420  , 'FinTRACLoan5'                  , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1517 , 'FINTRACLoan5'                  , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 421  , 'FinTRACLoan6'                  , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1518 , 'FINTRACLoan6'                  , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 38   , 'FinTRACLoan7'                  , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1519 , 'FINTRACLoan7'                  , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 39   , 'FinTRACLoan8'                  , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1520 , 'FINTRACLoan8'                  , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 40   , 'FinTRACLoan9'                  , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 1521 , 'FINTRACLoan9'                  , 'Y'    , 'N'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 225  , 'FinTRACSecur1'                 , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1439 , 'FinTRACSecur1'                 , 'Y'    , 'Y'    , 2         , 'CIB: Significant Change from Previous Average Activity'                                                                            , 'CIB: Significant Change from Previous Average Activity'                                                                            , 'N'    UNION ALL
	SELECT 202  , 'FinTRACSecur10'                , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1456 , 'FinTRACSecur10'                , 'Y'    , 'Y'    , 2         , 'Hidden Relationships'                                                                                                              , 'Hidden Relationships'                                                                                                              , 'N'    UNION ALL
	SELECT 220  , 'FinTRACSecur11'                , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1457 , 'FinTRACSecur11'                , 'Y'    , 'Y'    , 2         , 'Hidden Relationships'                                                                                                              , 'Hidden Relationships'                                                                                                              , 'N'    UNION ALL
	SELECT 152  , 'FinTRACSecur13'                , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1455 , 'FinTRACSecur13'                , 'Y'    , 'Y'    , 1         , 'Hidden Relationships;Hub and Spoke;Journals Between Unrelated Accounts'                                                            , 'Hidden Relationships;Hub and Spoke;Journals Between Unrelated Accounts'                                                            , 'N'    UNION ALL
	SELECT 362  , 'FinTRACSecur14'                , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1489 , 'FinTRACSecur14'                , 'Y'    , 'Y'    , 1         , 'High Risk Electronic Transfers'                                                                                                    , 'High Risk Electronic Transfers'                                                                                                    , 'N'    UNION ALL
	SELECT 440  , 'FinTRACSecur15'                , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1441 , 'FinTRACSecur15'                , 'Y'    , 'Y'    , 2         , 'CIB: Significant Change in Trade/Transaction Activity'                                                                             , 'CIB: Significant Change in Trade/Transaction Activity'                                                                             , 'N'    UNION ALL
	SELECT 171  , 'FinTRACSecur25'                , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1434 , 'FinTRACSecur25'                , 'Y'    , 'Y'    , 1         , 'High Risk Transactions: High Risk Geography'                                                                                       , 'High Risk Transactions: High Risk Geography'                                                                                       , 'N'    UNION ALL
	SELECT 105  , 'FinTRACSecur4'                 , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1481 , 'FinTRACSecur4'                 , 'Y'    , 'Y'    , 2         , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                        , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                        , 'N'    UNION ALL
	SELECT 266  , 'FinTRACSecur5'                 , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1447 , 'FinTRACSecur5'                 , 'Y'    , 'Y'    , 1         , 'Movement of Funds without Corresponding Trade'                                                                                     , 'Movement of Funds without Corresponding Trade'                                                                                     , 'N'    UNION ALL
	SELECT 268  , 'FinTRACSecur7'                 , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1438 , 'FinTRACSecur7'                 , 'Y'    , 'Y'    , 2         , 'Rapid Movement Of Funds - All Activity'                                                                                            , 'Cash In/Internal Transfer Out'                                                                                                     , 'N'    UNION ALL
	SELECT 305  , 'FinTRACSecur9'                 , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1453 , 'FinTRACSecur9'                 , 'Y'    , 'Y'    , 1         , 'Custom Scenario'                                                                                                                   , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 539  , 'IIROC11'                       , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1460 , 'IIROC11'                       , 'Y'    , 'Y'    , 2         , 'Journals Between Unrelated Accounts'                                                                                               , 'Journals Between Unrelated Accounts'                                                                                               , 'N'    UNION ALL
	SELECT 204  , 'IIROC13'                       , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1468 , 'IIROC13'                       , 'Y'    , 'Y'    , 1         , 'Custom Scenario'                                                                                                                   , NULL                                                                                                                                  , 'N'    UNION ALL
	SELECT 357  , 'IIROC14'                       , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1472 , 'IIROC14'                       , 'Y'    , 'Y'    , 2         , 'Rapid Movement Of Funds - All Activity'                                                                                            , 'Bearer Instrument In/Wire Out'                                                                                                     , 'N'    UNION ALL
	SELECT 306  , 'IIROC16'                       , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1483 , 'IIROC16'                       , 'Y'    , 'Y'    , 1         , 'Customers Engaging in Offsetting Trades'                                                                                           , 'Customer Engaging in Offsetting Trades'                                                                                            , 'N'    UNION ALL
	SELECT 172  , 'IIROC2'                        , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1435 , 'IIROC2'                        , 'Y'    , 'Y'    , 1         , 'High Risk Transactions: High Risk Geography'                                                                                       , 'High Risk Transactions: High Risk Geography'                                                                                       , 'N'    UNION ALL
	SELECT 355  , 'IIROC3'                        , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1476 , 'IIROC3'                        , 'Y'    , 'Y'    , 1         , 'Rapid Movement Of Funds - All Activity'                                                                                            , 'Wire In/Wire Out'                                                                                                                  , 'N'    UNION ALL
	SELECT 537  , 'IIROC5'                        , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1458 , 'IIROC5'                        , 'Y'    , 'Y'    , 2         , 'Journals Between Unrelated Accounts;Patterns Of Funds Transfers Between Customers And External Entities'                           , 'Journals Between Unrelated Accounts;Pattern of Funds Transfers between Customers and External Entities'                            , 'N'    UNION ALL
	SELECT 226  , 'IIROC6'                        , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1440 , 'IIROC6'                        , 'Y'    , 'Y'    , 1         , 'CIB: Significant Change in Trade/Transaction Activity;Escalation in Inactive Account'                                              , 'CIB: Significant Change in Trade/Transaction Activity;Escalation in Inactive Account'                                              , 'N'    UNION ALL
	SELECT 274  , 'IIROC7'                        , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1448 , 'IIROC7'                        , 'Y'    , 'Y'    , 1         , 'Movement of Funds without Corresponding Trade'                                                                                     , 'Movement of Funds without Corresponding Trade'                                                                                     , 'N'    UNION ALL
	SELECT 356  , 'IIROC8'                        , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1432 , 'IIROC8'                        , 'Y'    , 'Y'    , 1         , 'Early Payoff or Paydown of a Credit Product'                                                                                       , 'Early Redemption'                                                                                                                  , 'N'    UNION ALL
	SELECT 538  , 'IIROC9'                        , 'Y'    , 'Y'    , NULL      , NULL                                                                                                                                  , NULL                                                                                                                                  , 'Y'    UNION ALL
	SELECT 1459 , 'IIROC9'                        , 'Y'    , 'Y'    , 2         , 'Hidden Relationships;Hub and Spoke;Journals Between Unrelated Accounts'                                                            , 'Hidden Relationships;Hub and Spoke;Journals Between Unrelated Accounts'                                                            , 'N'
)

UPDATE dbo.TStagingIndicator
SET IsApplicableToBank = DuplicateUpdate.IsApplicable, 
	IsConduciveToAutomatedMonitoring = DuplicateUpdate.IsConducive, 
	Priority = DuplicateUpdate.Priority, 
	OracleRule = DuplicateUpdate.Oracle, 
	ProposedRuleName = DuplicateUpdate.Proposed, 
	IsDuplicate = DuplicateUpdate.IsDuplicate
FROM TStagingIndicator 
INNER JOIN DuplicateUpdate 
	ON TStagingIndicator.IndicatorID = DuplicateUpdate.IndicatorID 
	AND TStagingIndicator.IndicatorRefID = DuplicateUpdate.IndicatorRefID;

----------------------------------------------------------------------------------------------------
----12/27/2018 FW: Proposed Rule Name
----------------------------------------------------------------------------------------------------


--Custom Scenario remapped
WITH CustomChanges AS (

	SELECT 1431 AS IndicatorID, 'DoFinSec03' AS IndicatorRefID , 'Y' AS IsApplicable    , 'Y' AS IsConducive    , 2 AS Priority         , 'Early Redemption' AS Theme1   , 'Custom Scenario' AS Oracle     , 'Early Redemption' AS Proposed                                      UNION ALL
	SELECT 1453 , 'FinTRACSecur9'                 , 'Y'    , 'Y'    , 1         , 'Mirror Trades'            , 'Custom Scenario'     , 'Potential Mirror Trades'                               UNION ALL
	SELECT 1454 , 'FATFSecuritiesTransfers02'     , 'Y'    , 'Y'    , 3         , 'Missing Wire Details'     , 'Custom Scenario'     , 'Missing Counter Party Details'                          UNION ALL
	SELECT 1466 , 'FATFSecuritiesUnusual03'       , 'Y'    , 'Y'    , 1         , 'Non-listed securities'    , 'Custom Scenario'     , 'Large price differential in non-listed securities'    UNION ALL
	SELECT 1467 , 'FATFSecuritiesMktManip22'      , 'Y'    , 'Y'    , 1         , 'Non-listed securities'    , 'Custom Scenario'     , 'Large price differential in non-listed securities'      UNION ALL
	SELECT 1468 , 'IIROC13'                       , 'Y'    , 'Y'    , 1         , 'Penny Stocks'             , 'Custom Scenario'     , 'Activity in thinly traded securities'                  UNION ALL
	SELECT 1469 , 'FATFSecuritiesMktManip14'      , 'Y'    , 'Y'    , 2         , 'Penny Stocks'             , 'Custom Scenario'     , 'Activity in thinly traded securities'                  UNION ALL
	SELECT 1470 , 'FATFSecuritiesMktManip04'      , 'Y'    , 'Y'    , 1         , 'Penny Stocks'             , 'Custom Scenario'     , 'Activity in thinly traded securities'                  UNION ALL
	SELECT 1471 , 'FATFSecuritiesCDD14'           , 'Y'    , 'Y'    , 1         , 'PEP Trades/ Transactions' , 'Custom Scenario'     , 'Large Transactions'
)
UPDATE dbo.TStagingIndicator
SET 
	IsApplicableToBank = CustomChanges.IsApplicable, 
	IsConduciveToAutomatedMonitoring = CustomChanges.IsConducive, 
	Priority = CustomChanges.Priority, 
	[Red Flag Theme 1] = CustomChanges.Theme1, 
	OracleRule = CustomChanges.Oracle, 
	ProposedRuleName = CustomChanges.Proposed
FROM TStagingIndicator 
INNER JOIN CustomChanges 
	ON TStagingIndicator.IndicatorID = CustomChanges.IndicatorID 
	AND TStagingIndicator.IndicatorRefID = CustomChanges.IndicatorRefID;

----------------------------------------------------------------------------------------------------
----12/27/2018 Addl. Rule Mapping
----------------------------------------------------------------------------------------------------
	
--Proposed Remapped
WITH ProposedMapping AS (
	SELECT 103 AS IndicatorID  , 'FinTRACAcct17' AS IndicatorRefID            , 'Deposits/Withdrawals in Same or Similar Amounts;Structuring: Potential Structuring in Cash and Equivalents' AS Oracle     , 'Monetary Instrument Structuring;Structuring: Potential Structuring in Cash and Equivalents' AS Proposed              UNION ALL
	SELECT 133  , 'FinTRACKnow6'             , 'Deposits/Withdrawals in Same or Similar Amounts;Structuring: Potential Structuring in Cash and Equivalents; Deposits/Withdrawals in Same or Similar Amounts'     , 'Monetary Instrument Structuring;Structuring: Potential Structuring in Cash and Equivalents;Wire Structuring'   UNION ALL
	SELECT 134  , 'FinTRACKnow8'             , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                      , 'Structuring: Potential Structuring in Cash and Equivalents'                                                    UNION ALL
	SELECT 135  , 'FinTRACCash7'             , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                      , 'Structuring: Potential Structuring in Cash and Equivalents'                                                    UNION ALL
	SELECT 136  , 'FinTRACCash8'             , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                      , 'Structuring: Potential Structuring in Cash and Equivalents'                                                    UNION ALL
	SELECT 137  , 'FinTRACPersonal17'        , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                      , 'Structuring: Potential Structuring in Cash and Equivalents'                                                    UNION ALL
	SELECT 138  , 'FinTRACMetals6'           , 'Deposits/Withdrawals in Same or Similar Amounts;Structuring: Potential Structuring in Cash and Equivalents; Deposits/Withdrawals in Same or Similar Amounts'     , 'Monetary Instrument Structuring;Structuring: Potential Structuring in Cash and Equivalents;Wire Structuring'   UNION ALL
	SELECT 231  , 'FinTRACGen4'              , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                      , 'Structuring: Potential Structuring in Cash and Equivalents'                                                    UNION ALL
	SELECT 322  , 'FATFTrafficking06'        , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                      , 'Structuring: Potential Structuring in Cash and Equivalents'                                                    UNION ALL
	SELECT 390  , 'FinTRACCash6'             , 'Large Reportable Transactions;Structuring: Potential Structuring in Cash and Equivalents'                                                                        , 'Large Cash Transactions;Structuring: Potential Structuring in Cash and Equivalents'                            UNION ALL
	SELECT 398  , 'FinTRACPersonal16'        , 'Large Reportable Transactions'                                                                                                                                   , 'Large Currency Exchange'                                                                                       UNION ALL
	SELECT 987  , 'Developed02'              , 'Custom Scenario'                                                                                                                                                 , 'Country Specific Wire Structuring'                                                                             UNION ALL
	SELECT 988  , 'Developed03'              , 'Custom Scenario'                                                                                                                                                 , 'Country Specific Wire Structuring'                                                                             UNION ALL
	SELECT 990  , 'DoFinBank01'              , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                      , 'Structuring: Potential Structuring in Cash and Equivalents'                                                    UNION ALL
	SELECT 994  , 'DoFinBank05'              , 'Large Reportable Transactions'                                                                                                                                   , 'Large Currency Exchange'                                                                                       UNION ALL
	SELECT 1046 , 'EgmontDrugTrafficking01'  , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                      , 'Structuring: Potential Structuring in Cash and Equivalents'                                                    UNION ALL
	SELECT 1049 , 'EgmontDrugTrafficking05'  , 'CIB: Product Utilization Shift;CIB: Significant Change from Previous Average Activity'                                                                           , 'CIB: Product Utilization Shift;CIB: Significant Change from Previous Average Activity'                         UNION ALL
	SELECT 1069 , 'EgmontTerrorismA13'       , 'Deposits/Withdrawals in Same or Similar Amounts;Structuring: Potential Structuring in Cash and Equivalents; Deposits/Withdrawals in Same or Similar Amounts'     , 'Monetary Instrument Structuring;Structuring: Potential Structuring in Cash and Equivalents;Wire Structuring'   UNION ALL
	SELECT 1075 , 'EgmontTerrorismB04'       , 'Deposits/Withdrawals in Same or Similar Amounts'                                                                                                                 , 'Wire Structuring'                                                                                              UNION ALL
	SELECT 1215 , 'FATFHumanTrafficking61'   , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                      , 'Structuring: Potential Structuring in Cash and Equivalents'                                                    UNION ALL
	SELECT 1232 , 'FATFHumanTrafficking78'   , 'Deposits/Withdrawals in Same or Similar Amounts'                                                                                                                 , 'Wire Structuring'                                                                                              UNION ALL
	SELECT 1347 , 'FATFTBML36'               , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                      , 'Structuring: Potential Structuring in Cash and Equivalents'                                                    UNION ALL
	SELECT 1352 , 'FATFTBML41'               , 'Deposits/Withdrawals in Same or Similar Amounts;Structuring: Potential Structuring in Cash and Equivalents'                                                      , 'Monetary Instrument Structuring;Structuring: Potential Structuring in Cash and Equivalents'                    UNION ALL
	SELECT 1370 , 'FATFTrafficking26'        , 'Address Associated with Multiple, Recurring External Entities;Hub and Spoke'                                                                                     , 'Address Associated with Multiple, Recurring External Entities;Hub and Spoke'                                   UNION ALL
	SELECT 1373 , 'FATFTrafficking29'        , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                      , 'Structuring: Potential Structuring in Cash and Equivalents'                                                    UNION ALL
	SELECT 1379 , 'FATFTrafficking35'        , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                      , 'Structuring: Potential Structuring in Cash and Equivalents'                                                    UNION ALL
	SELECT 1481 , 'FinTRACSecur4'            , 'Structuring: Potential Structuring in Cash and Equivalents'                                                                                                      , 'Structuring: Potential Structuring in Cash and Equivalents'                                                    UNION ALL
	SELECT 1482 , 'FATFSecuritiesCDD27'      , 'Deposits/Withdrawals in Same or Similar Amounts;Structuring: Potential Structuring in Cash and Equivalents; Deposits/Withdrawals in Same or Similar Amounts'     , 'Monetary Instrument Structuring;Structuring: Potential Structuring in Cash and Equivalents;Wire Structuring'
	)
UPDATE dbo.TStagingIndicator
SET OracleRule = ProposedMapping.Oracle, 
	ProposedRuleName = ProposedMapping.Proposed
FROM TStagingIndicator
INNER JOIN ProposedMapping 
	ON TStagingIndicator.IndicatorID = ProposedMapping.IndicatorID 
	AND TStagingIndicator.IndicatorRefID = ProposedMapping.IndicatorRefID;
	
--Update Null Proposed Rules with Oracle Values
UPDATE dbo.TStagingIndicator
SET ProposedRuleName = OracleRule
WHERE ProposedRuleName IS NULL
	AND IsConduciveToAutomatedMonitoring = 'Y'
	AND IsApplicableToBank = 'Y'
	AND IsDuplicate = 'N';	
	
UPDATE dbo.TStagingIndicator
SET OracleRule = 'Early Payoff or Paydown of a Credit Product'
WHERE IndicatorID = 1431;

UPDATE dbo.TStagingIndicator
SET OracleRule = 'Rapid Movement Of Funds - All Activity'
WHERE IndicatorID = 1043;	

----------------------------------------------------------------------------------------------------
----12/27/2018 Sean's Additions
----------------------------------------------------------------------------------------------------


--Update lack of Rules
WITH CreatedRules AS (
	SELECT 275  AS IndicatorID, 'IIROC10' AS IndicatorRefID , 'Y' AS IsApplicable    , 'Y' AS IsConducive    , 2 AS Priority    , 'Custom Scenario' AS Oracle            , 'Activity in thinly traded securities' AS Proposed                                           UNION ALL
	SELECT 439  , 'FinTRACSecur12'                , 'Y'    , 'Y'    , 2    , 'Custom Scenario'                                                                                               , 'Activity in thinly traded securities'                                            UNION ALL
	SELECT 139  , 'FFIECReporting5'               , 'Y'    , 'Y'    , 2    , 'Anomalies in ATM, Bank Card: Structured Cash Deposits'                                                         , 'Anomalies in ATM, Bank Card: Structured Cash Deposits'                           UNION ALL
	SELECT 438  , 'FinTRACSecur8'                 , 'Y'    , 'Y'    , 1    , 'Large Reportable Transactions'                                                                                 , 'Cash Settlement'                                                                 UNION ALL
	SELECT 123  , 'FFIECProfile1'                 , 'Y'    , 'Y'    , 2    , 'CIB: Product Utilization Shift'                                                                                , 'CIB: Product Utilization Shift'                                                  UNION ALL
	SELECT 261  , 'FinTRACLoan2'                  , 'Y'    , 'Y'    , 2    , 'Early Payoff or Paydown of a Credit Product'                                                                   , 'Early Payoff of a Credit Product'                                                UNION ALL
	SELECT 1493 , 'FFIECLending02'                , 'Y'    , 'Y'    , 2    , 'Early Payoff or Paydown of a Credit Product'                                                                   , 'Early Payoff of a Credit Product'                                                UNION ALL
	SELECT 1538 , 'FINTRACMortgage17'             , 'Y'    , 'Y'    , 2    , 'Early Payoff or Paydown of a Credit Product'                                                                   , 'Early Payoff of a Credit Product'                                                UNION ALL
	SELECT 313  , 'FFIECTransfersT5'              , 'Y'    , 'Y'    , 2    , 'High Risk Transactions: High Risk Geography'                                                                   , 'High Risk Transactions: High Risk Geography'                                     UNION ALL
	SELECT 1547 , 'FINTRACMortgage26'             , 'Y'    , 'Y'    , 1    , 'High Risk Transactions: High Risk Geography'                                                                   , 'High Risk Transactions: High Risk Geography'                                     UNION ALL
	SELECT 437  , 'FinTRACSecur3'                 , 'Y'    , 'Y'    , 1    , 'Large Reportable Transactions'                                                                                 , 'Investment Purchase with Cash'                                                   UNION ALL
	SELECT 975  , 'WolfsbergCC02'                 , 'Y'    , 'Y'    , 2    , 'Early Payoff or Paydown of a Credit Product'                                                                   , 'Large Credit Refunds'                                                            UNION ALL
	SELECT 1036 , 'DoFinSec04'                    , 'Y'    , 'Y'    , 1    , 'Large Reportable Transactions'                                                                                 , 'Negotiable Instrument Settlement'                                                UNION ALL
	SELECT 1034 , 'DoFinSec02'                    , 'Y'    , 'Y'    , 2    , 'High Risk Instructions'                                                                                        , 'Non-Exchange Settlement'                                                         UNION ALL
	SELECT 891  , 'FATFSecuritiesProfiling10'     , 'Y'    , 'Y'    , 2    , 'Custom Scenario'                                                                                               , 'Originator or Beneficiary Party Country does not match Bank Country'             UNION ALL
	SELECT 1302 , 'FATFBenOwnership67'            , 'Y'    , 'Y'    , 2    , 'Pattern of Funds Transfers between Customers and External Entities'                                            , 'Pattern of Funds Transfers between Customers and External Entities'              UNION ALL
	SELECT 1546 , 'FINTRACMortgage25'             , 'Y'    , 'Y'    , 2    , 'Patterns of Sequentially Numbered Checks, Monetary Instruments'                                                , 'Patterns of Sequentially Numbered Checks, Monetary Instruments'                  UNION ALL
	SELECT 813  , 'FATFFreeTradeZones31'          , 'Y'    , 'Y'    , 2    , 'Custom Scenario'                                                                                               , 'Shell Company Rule'                                                              UNION ALL
	SELECT 141  , 'FFIECOther9'                   , 'Y'    , 'Y'    , 1    , 'Structuring: Potential Structuring in Cash and Equivalents'                                                    , 'Structuring: Potential Structuring in Cash and Equivalents'                      UNION ALL
	SELECT 1548 , 'MortgageDeveloped01'           , 'Y'    , 'Y'    , 2    , 'Deposits/Withdrawals in Same or Similar Amounts;Structuring: Potential Structuring in Cash and Equivalents'    , 'Wire Structuring;Structuring: Potential Structuring in Cash and Equivalents'     UNION ALL
	SELECT 122  , 'FinTRACMetals9'                , 'Y'    , 'N'    , 2    , NULL                                                                                                              , NULL                                                                                UNION ALL
	SELECT 308  , 'FFIECOther1'                   , 'Y'    , 'N'    , 3    , NULL                                                                                                              , NULL                                                                                UNION ALL
	SELECT 888  , 'FATFSecuritiesProfiling07'     , 'Y'    , 'N'    , 2    , NULL                                                                                                              , NULL                                                                                UNION ALL
	SELECT 949  , 'FATFProliferation15'           , 'Y'    , 'Y'    , 2    , NULL                                                                                                              , NULL                                                                                UNION ALL
	SELECT 1033 , 'DoFinSec01'                    , 'Y'    , 'N'    , 2    , NULL                                                                                                              , NULL                                                                                
	)

UPDATE dbo.TStagingIndicator
SET IsApplicableToBank = CreatedRules.IsApplicable, 
	IsConduciveToAutomatedMonitoring = CreatedRules.IsConducive, 
	Priority = CreatedRules.Priority, 
	OracleRule = CreatedRules.Oracle, 
	ProposedRuleName = CreatedRules.Proposed
FROM dbo.TStagingIndicator
INNER JOIN CreatedRules 
	ON TStagingIndicator.IndicatorID = CreatedRules.IndicatorID 
	AND TStagingIndicator.IndicatorRefID = CreatedRules.IndicatorRefID;
	
WITH IndChanges AS (
	SELECT 1154 AS IndicatorID, 'FATFProliferation46' AS IndicatorRefID      , 'Deviation from Peer Group - Total Activity' AS ProposedRuleName                                                                                                           UNION ALL
	SELECT 1500, 'FFIECLending09'           , 'Structuring: Potential Structuring in Cash and Equivalents; Structuring: Avoidance of Reporting Thresholds'                                            UNION ALL
	SELECT 876, 'FATFSecuritiesInsurance02', 'Rapid Movement of Funds – All Activity'                                                                                                                UNION ALL
	SELECT 114, 'FinTRACCash14'            , 'Deviation from Peer Group - Product Utilization; Deviation from Peer Group - Total Activity'                                                           UNION ALL
	SELECT 728, 'FATFTF12'                 , 'CIB - Product Utilization Shift; Deviation from Peer Group - Product Utilization'
)
UPDATE dbo.TStagingIndicator
SET ProposedRuleName = IndChanges.ProposedRuleName
FROM TStagingIndicator
INNER JOIN IndChanges 
	ON TStagingIndicator.IndicatorID = IndChanges.IndicatorID 
	AND TStagingIndicator.IndicatorRefID = IndChanges.IndicatorRefID;
	
UPDATE dbo.TIndicatorXRule
SET ProposedTheme = NULL 
WHERE ProposedTheme NOT IN
(
'Profiling',
'Exclusive Relationship',
'Funneling',
'Structuring/Threshold Avoidance',
'High Risk Geography (HRG)',
'Lack of Economic Purpose',
'Velocity',
'Patterning',
'Identity Concealment',
'Borrowing/Refunds',
'Network of Customers',
'Missing Counter Party Details',
'Early Redemption',
'Manipulation'
)

--Delete Oracle
DELETE
FROM dbo.TIndicatorXRule 
--LEFT JOIN TRule ON TIndicatorXRule.RuleID = TRule.RuleID
WHERE IndicatorID IN
(
163,
358,
1076,
1490,
1491,
1493,
1506,
1514,
1515,
1538,
1547,
1548
)
AND ProposedRuleName IS NULL
AND TIndicatorXRule.RuleID IN (
124,
138,
155,
176);

--Update Themes and COverage
WITH Updates AS (
	SELECT 'Cash-Check In/Wire Out' AS ProposedRule                                                              , 'Velocity' AS ProposedTheme          , 'Rapid Movement Of Funds - All Activity' AS OracleRule                                                                                                  , 'None' AS Coverage UNION ALL
	SELECT 'Activity in thinly traded securities'                                                                , 'Manipulation'                       , 'Custom Scenario'                                                                                                                                       , 'None'      UNION ALL
	SELECT 'Cash Settlement'                                                                                     , 'Patterning'                         , 'Large Reportable Transactions'                                                                                                                         , 'None'      UNION ALL
	SELECT 'Country Specific Wire Structuring'                                                                   , 'Structuring/Threshold Avoidance'    , 'Custom Scenario'                                                                                                                                       , 'Partial'   UNION ALL
	SELECT 'Customer Engaging in Offsetting Trades'                                                              , 'Manipulation'                       , 'Customers Engaging in Offsetting Trades'                                                                                                               , 'None'      UNION ALL
	SELECT 'Investment Purchase with Cash'                                                                       , 'Patterning'                         , 'Large Reportable Transactions'                                                                                                                         , 'None'      UNION ALL
	SELECT 'Large price differential in non-listed securities'                                                   , 'Manipulation'                       , 'Custom Scenario'                                                                                                                                       , 'None'      UNION ALL
	SELECT 'Large Transactions'                                                                                  , 'Patterning'                         , 'Custom Scenario'                                                                                                                                       , 'None'      UNION ALL
	SELECT 'Negotiable Instrument Settlement'                                                                    , 'Patterning'                         , 'Large Reportable Transactions'                                                                                                                         , 'None'      UNION ALL
	SELECT 'Non-Exchange Settlement'                                                                             , 'Patterning'                         , 'High Risk Instructions'                                                                                                                                , 'None'      UNION ALL
	SELECT 'Numbered Accounts'                                                                                   , 'Identity Concealment'               , 'Custom Scenario'                                                                                                                                       , 'None'      UNION ALL
	SELECT 'Originator or Beneficiary Party Country does not match Bank Country'                                 , 'Patterning'                         , 'Custom Scenario'                                                                                                                                       , 'None'      UNION ALL
	SELECT 'Potential Mirror Trades'                                                                             , 'Manipulation'                       , 'Custom Scenario'                                                                                                                                       , 'None'
	)
, RuleIDs AS (
	SELECT Updates.*, RuleID
	FROM  Updates LEFT JOIN TRule ON TRule.RuleName = Updates.OracleRule
)

UPDATE dbo.TIndicatorXRule
SET ProposedTheme = RuleIDs.ProposedTheme, 
	InOracle = RuleIDs.Coverage
FROM dbo.TIndicatorXRule
INNER JOIN RuleIDs ON TIndicatorXRule.RuleID = RuleIDs.RuleID 
	AND TIndicatorXRule.ProposedRuleName = RuleIDs.ProposedRule;

--Update New Themes	
UPDATE dbo.TIndicatorXRule
SET ProposedTheme = 'Lack of Economic Purpose'
WHERE ProposedRuleName IN 
(
'Activity in thinly traded securities',
'Large price differential in non-listed securities'
);	

--Update Oracle Rules
--SELECT * FROM TRule WHERE RuleName = 'Large Reportable Transactions' AND Source = 'Oracle';
--RuleID = 172 for Large Reportable Transactions
UPDATE dbo.TIndicatorXRule
SET RuleID = 172
WHERE ProposedRuleName IN 
(
'Large Transactions',
'Large Credit Refunds'
);

----------------------------------------------------------------------------------------------------
----12/28/2018: Rule and Coverage Updates
----------------------------------------------------------------------------------------------------


--Proposed Rule Updates
WITH ProposedUpdates AS (
	SELECT 'Monetary Instrument In/Wire Out' AS InitialProposed          , 'Velocity' AS Theme             , 'Cash and Equivalents In/Wire Out' AS ProposedRule            , 'Rapid Movement Of Funds - All Activity' AS OracleRule        UNION ALL
	SELECT 'Cash-Check In/Wire Out'                                      , 'Velocity'                      , 'Cash and Equivalents In/Wire Out'                            , 'Rapid Movement Of Funds - All Activity'                      UNION ALL
	SELECT 'Cash In/Monetary Instrument Out'                             , 'Velocity'                      , 'Cash In/Monetary Instrument Out'                             , 'Rapid Movement Of Funds - All Activity'                      UNION ALL
	SELECT 'Monetary Instrument In/Monetary Instrument Out'              , 'Velocity'                      , 'Cash In/Monetary Instrument Out'                             , 'Rapid Movement Of Funds - All Activity'                      UNION ALL
	SELECT 'Cash In/Internal Transfer Out'                               , 'Velocity'                      , 'Cash In/Wire Out'                                            , 'Rapid Movement Of Funds - All Activity'                      UNION ALL
	SELECT 'Cash In/Wire Out'                                            , 'Velocity'                      , 'Cash In/Wire Out'                                            , 'Rapid Movement Of Funds - All Activity'                      UNION ALL
	SELECT 'CIB: Significant Change from Previous Average Activity'      , 'Profiling'                     , 'CIB: Significant Change from Previous Average Activity'      , 'CIB: Significant Change From Previous Average Activity'      UNION ALL
	SELECT 'CIB: Significant Change from Previous Peak Activity'         , 'Profiling'                     , 'CIB: Significant Change from Previous Average Activity'      , 'CIB: Significant Change From Previous Average Activity'      UNION ALL
	SELECT 'High Risk Transactions: High Risk Counter Party'             , 'High Risk Geography (HRG)'     , 'High Risk Transactions: High Risk Focal Entity'              , 'High Risk Transactions: High Risk Counter Party'             UNION ALL
	SELECT 'High Risk Transactions: High Risk Focal Entity'              , 'High Risk Geography (HRG)'     , 'High Risk Transactions: High Risk Focal Entity'              , 'High Risk Transactions: High Risk Counter Party'             UNION ALL
	SELECT 'Large Hydro Bill Payment'                                    , 'Lack of Economic Purpose'      , 'Large Payment for Specific Services'                         , 'Large Reportable Transactions'                               UNION ALL
	SELECT 'Large Payments to Online Payment Services'                   , 'Lack of Economic Purpose'      , 'Large Payment for Specific Services'                         , 'Large Reportable Transactions'                               UNION ALL
	SELECT 'Cash Settlement'                                             , 'Patterning'                    , 'Unusual Settlement'                                          , 'Large Reportable Transactions'                               UNION ALL
	SELECT 'Negotiable Instrument Settlement'                            , 'Patterning'                    , 'Unusual Settlement'                                          , 'Large Reportable Transactions'                               UNION ALL
	SELECT 'Non-Exchange Settlement'                                     , 'Patterning'                    , 'Unusual Settlement'                                          , 'Large Reportable Transactions'                               UNION ALL
	SELECT 'Domestic Wire In/International Wire Out'                     , 'Velocity'                      , 'Wire In/Wire Out'                                            , 'Rapid Movement Of Funds - All Activity'                      UNION ALL
	SELECT 'Internal Transfer In/Wire Out'                               , 'Velocity'                      , 'Wire In/Wire Out'                                            , 'Rapid Movement Of Funds - All Activity'                      UNION ALL
	SELECT 'Wire In/Wire Out'                                            , 'Velocity'                      , 'Wire In/Wire Out'                                            , 'Rapid Movement Of Funds - All Activity'
	)

, AddedRuleID AS (
	SELECT ProposedUpdates.*, RuleID 
	FROM ProposedUpdates 
	INNER JOIN TRule 
		ON ProposedUpdates.OracleRule = TRule.RuleName 
		AND Source = 'Oracle'
		)
UPDATE dbo.TIndicatorXRule
SET ProposedRuleName = AddedRuleID.ProposedRule, 
	RuleID = AddedRuleID.RuleID
FROM dbo.TIndicatorXRule
INNER JOIN AddedRuleID 
	ON TIndicatorXRule.ProposedRuleName = AddedRuleID.InitialProposed 
	AND AddedRuleID.Theme = TIndicatorXRule.ProposedTheme;

--Update Coverage
WITH CoverageUpdates AS (
	SELECT 'Customer Borrowing Against New Policy' AS ProposedRule, 'None' AS Coverage UNION ALL
	SELECT 'Insurance Policies with Refunds', 'None' UNION ALL
	SELECT 'Large Credit Refunds', 'Partial' UNION ALL
	SELECT 'Early Payoff of a Credit Product', 'None' UNION ALL
	SELECT 'Early Redemption', 'None' UNION ALL
	SELECT 'Policies with Large Early Removal', 'None' UNION ALL
	SELECT 'Pattern of Funds Transfers between Correspondent Banks', 'Partial' UNION ALL
	SELECT 'Pattern of Funds Transfers between Customers and External Entities', 'Full' UNION ALL
	SELECT 'Pattern of Funds Transfers between Internal Accounts and Customers', 'Full' UNION ALL
	SELECT 'Pattern of Funds Transfers between Recurring Originators/Beneficiaries', 'Full' UNION ALL
	SELECT 'Hub and Spoke', 'Full' UNION ALL
	SELECT 'Terrorist Financing', 'None' UNION ALL
	SELECT 'CIB: High Risk Geography', 'Full' UNION ALL
	SELECT 'High Risk Electronic Transfers', 'None' UNION ALL
	SELECT 'High Risk Instructions', 'None' UNION ALL
	SELECT 'High Risk Transactions: High Risk Focal Entity', 'Partial' UNION ALL
	SELECT 'High Risk Transactions: High Risk Focal Entity', 'Partial' UNION ALL
	SELECT 'High Risk Transactions: High Risk Geography', 'Full' UNION ALL
	SELECT 'Multiple Jurisdictions', 'Partial' UNION ALL
	SELECT 'Automated PUPID Report', 'Partial' UNION ALL
	SELECT 'Missing Counter Party Details', 'None' UNION ALL
	SELECT 'Nested Correspondent Rule', 'Partial' UNION ALL
	SELECT 'Numbered Accounts', 'None' UNION ALL
	SELECT 'Activity in thinly traded securities', 'None' UNION ALL
	SELECT 'Large Payment for Specific Services', 'None' UNION ALL
	SELECT 'Large Positive Credit Card Balances', 'None' UNION ALL
	SELECT 'Large price differential in non-listed securities', 'None' UNION ALL
	SELECT 'Large Wire Transfers', 'Full' UNION ALL
	SELECT 'Return of Cheques', 'None' UNION ALL
	SELECT 'Customer Engaging in Offsetting Trades', 'None' UNION ALL
	SELECT 'Manipulation of Account/Customer Data Followed by Instruction Changes', 'None' UNION ALL
	SELECT 'Movement of Funds without Corresponding Trade', 'None' UNION ALL
	SELECT 'Potential Mirror Trades', 'None' UNION ALL
	SELECT 'Address Associated with Multiple, Recurring External Entities', 'Partial' UNION ALL
	SELECT 'Hidden Relationships', 'None' UNION ALL
	SELECT 'Journals Between Unrelated Accounts', 'None' UNION ALL
	SELECT 'Networks of Accounts, Entities, and Customers', 'None' UNION ALL
	SELECT 'Anomalies in ATM, Bank Card: Excessive Withdrawals', 'None' UNION ALL
	SELECT 'Anomalies in ATM, Bank Card: Foreign Transactions', 'None' UNION ALL
	SELECT 'Cash Deposit in Correspondent Account', 'Full' UNION ALL
	SELECT 'Frequent ATM Deposits', 'Partial' UNION ALL
	SELECT 'Investment Purchase with Cash', 'None' UNION ALL
	SELECT 'Large Cash Transactions', 'Full' UNION ALL
	SELECT 'Large Currency Exchange', 'None' UNION ALL
	SELECT 'Large Monetary Instrument Transactions', 'None' UNION ALL
	SELECT 'Large Transactions', 'None' UNION ALL
	SELECT 'Originator or Beneficiary Party Country does not match Bank Country', 'None' UNION ALL
	SELECT 'Pattern of Sequentially Numbered Checks', 'None' UNION ALL
	SELECT 'Unusual Settlement', 'None' UNION ALL
	SELECT 'CIB: Product Utilization Shift', 'Full' UNION ALL
	SELECT 'CIB: Significant Change from Previous Average Activity', 'Full' UNION ALL
	SELECT 'CIB: Significant Change from Previous Average Activity', 'Full' UNION ALL
	SELECT 'CIB: Significant Change in Trade/Transaction Activity', 'Full' UNION ALL
	SELECT 'Deviation from Peer Group: Product Utilization', 'Full' UNION ALL
	SELECT 'Deviation from Peer Group: Total Activity', 'Full' UNION ALL
	SELECT 'Escalation in Inactive Account', 'Full' UNION ALL
	SELECT 'Large Depreciation of Account Value', 'None' UNION ALL
	SELECT 'Country Specific Wire Structuring', 'Partial' UNION ALL
	SELECT 'Monetary Instrument Structuring', 'Partial' UNION ALL
	SELECT 'Structuring: Potential Structuring in Cash and Equivalents', 'Full' UNION ALL
	SELECT 'Wire Structuring', 'Full' UNION ALL
	SELECT 'All Activity In/All Activity Out', 'Partial' UNION ALL
	SELECT 'All Activity In/Cash Out', 'None' UNION ALL
	SELECT 'Bearer Instrument In/Wire Out', 'None' UNION ALL
	SELECT 'Cash and Equivalents In/Wire Out', 'None' UNION ALL
	SELECT 'Cash In/Cash Out', 'None' UNION ALL
	SELECT 'Cash In/Credit Card Payment Out', 'None' UNION ALL
	SELECT 'Cash In/Monetary Instrument Out', 'Full' UNION ALL
	SELECT 'Cash In/Monetary Instrument Out', 'Full' UNION ALL
	SELECT 'Cash In/Wire Out', 'Full' UNION ALL
	SELECT 'Cash In/Wire Out', 'Full' UNION ALL
	SELECT 'Credit Card Payment Followed By Cash Advance', 'Partial' UNION ALL
	SELECT 'Foreign Exchange Followed by Wire Out', 'None' UNION ALL
	SELECT 'Wire In/Cash Out', 'None' UNION ALL
	SELECT 'Wire In/Wire Out', 'Full' UNION ALL
	SELECT 'Wire In/Wire Out', 'Full'
	)
UPDATE dbo.TIndicatorXRule
SET InOracle = CoverageUpdates.Coverage
FROM TIndicatorXRule
INNER JOIN CoverageUpdates ON CoverageUpdates.ProposedRule = ProposedRuleName;

UPDATE dbo.TIndicatorXRule
SET InOracle = 'Full'
WHERE ProposedRuleName LIKE 'Structuring: Avoidance%';


----------------------------------------------------------------------------------------------------
----01/04/2019: Remove Product Mappings Part 1
----------------------------------------------------------------------------------------------------

--Updating TIndicatorXProduct
DELETE FROM dbo.TIndicatorXProduct 
WHERE ProductID IN (SELECT ProductID FROM dbo.TProduct WHERE ProductGrouping = 'Service');

WITH RemovedLinks AS (
	SELECT 'Credit Card' AS ProductGroup        , 'Full' AS Coverage      , 'Velocity' AS Theme      , 'Wire In/Wire Out' AS ProposedRule                            UNION ALL
	SELECT 'Credit Card'                        , 'None'      , 'Early Redemption'                   , 'Early Payoff of a Credit Product'                            UNION ALL
	SELECT 'Credit Card'                        , 'None'      , 'Patterning'                         , 'Pattern of Sequentially Numbered Checks'                     UNION ALL
	--SELECT 'Custody'                            , 'None'      , 'Early Redemption'                   , 'Early Redemption'                                            UNION ALL
	--SELECT 'Depository Account'                 , 'None'      , 'Early Redemption'                   , 'Early Redemption'                                            UNION ALL
	--SELECT 'Depository Account'                 , 'None'      , 'Early Redemption'                   , 'Early Payoff of a Credit Product'                            UNION ALL
	SELECT 'Depository Account'                 , 'None'      , 'Patterning'                         , 'Investment Purchase with Cash'                               UNION ALL
	--SELECT 'Depository Account - Investment'    , 'Full'      , 'Structuring/Threshold Avoidance'    , 'Structuring: Potential Structuring in Cash and Equivalents'  UNION ALL
	SELECT 'Depository Account - Investment'    , 'None'      , 'Velocity'                           , 'Cash In/Cash Out'                                            UNION ALL
	SELECT 'Electronic Funds Transfer'          , 'Full'      , 'Structuring/Threshold Avoidance'    , 'Structuring: Potential Structuring in Cash and Equivalents'  UNION ALL
	SELECT 'Electronic Funds Transfer'          , 'Full'      , 'Velocity'                           , 'Cash In/Monetary Instrument Out'                             UNION ALL
	SELECT 'Electronic Funds Transfer'          , 'None'      , 'Early Redemption'                   , 'Early Redemption'                                            UNION ALL
	--SELECT 'Foreign Exchange'                   , 'None'      , 'Patterning'                         , 'Pattern of Sequentially Numbered Checks'                     UNION ALL
	SELECT 'Insurance'                          , 'Partial'   , 'Identity Concealment'               , 'Automated PUPID Report'                                      UNION ALL
	--SELECT 'Insurance'                          , 'None'      , 'Early Redemption'                   , 'Early Payoff of a Credit Product'                            UNION ALL
	SELECT 'Investment'                         , 'Partial'   , 'Identity Concealment'               , 'Automated PUPID Report'                                      UNION ALL
	SELECT 'Investment'                         , 'Partial'   , 'Structuring/Threshold Avoidance'    , 'Monetary Instrument Structuring'                             UNION ALL
	SELECT 'Investment'                         , 'None'      , 'Borrowing/Refunds'                  , 'Insurance Policies with Refunds'                             UNION ALL
	--SELECT 'Line-of-Credit'                     , 'Full'      , 'Structuring/Threshold Avoidance'    , 'Structuring: Potential Structuring in Cash and Equivalents'  UNION ALL
	SELECT 'Line-of-Credit'                     , 'Partial'   , 'Identity Concealment'               , 'Automated PUPID Report'                                      UNION ALL
	--SELECT 'Line-of-Credit'                     , 'Partial'   , 'Structuring/Threshold Avoidance'    , 'Monetary Instrument Structuring'                             UNION ALL
	--SELECT 'Mobile/Internet Payment'            , 'Partial'   , 'Identity Concealment'               , 'Automated PUPID Report'                                      UNION ALL
	SELECT 'Monetary Instrument'                , 'Full'      , 'Structuring/Threshold Avoidance'    , 'Wire Structuring'                                            UNION ALL
	SELECT 'Monetary Instrument'                , 'None'      , 'Patterning'                         , 'Unusual Settlement'                                          UNION ALL
	SELECT 'RDC'                                , 'Full'      , 'Patterning'                         , 'Large Cash Transactions'                                     UNION ALL
	SELECT 'Service'                            , 'Full'      , 'Profiling'                          , 'CIB: Significant Change from Previous Average Activity'      UNION ALL
	SELECT 'Trade Finance'                      , 'Partial'   , 'Identity Concealment'               , 'Automated PUPID Report'
	)

, RemovedProductMappings AS (
	SELECT TIndicatorXProduct.*, TProduct.ProductGrouping 
	FROM dbo.TIndicatorXProduct 
	LEFT JOIN TProduct ON TIndicatorXProduct.ProductID = TProduct.ProductID
	LEFT JOIN TIndicatorXRule ON TIndicatorXProduct.IndicatorID = TIndicatorXRule.IndicatorID
	INNER JOIN RemovedLinks ON RemovedLinks.ProductGroup = TProduct.ProductGrouping AND RemovedLinks.ProposedRule = ProposedRuleName
	)
	
DELETE FROM dbo.TIndicatorXProduct WHERE IndicatorXProductID IN (SELECT IndicatorXProductID FROM RemovedProductMappings);

----------------------------------------------------------------------------------------------------
----01/09/2019: Change Indicator Priorty, Theme Description, and Product Mappings
----------------------------------------------------------------------------------------------------

--Rule and Theme Changes Changes
SELECT * FROM TIndicatorXRule
WHERE ProposedRuleName IN 
(
'High Risk Electronic Transfers',
'High Risk Instructions',
'High Risk Transactions: High Risk Counter Party',
'Large Transactions: High Risk Customer'			
--'High Risk Transactions: High Risk Focal Entity',
--'Large Transactions'
);

WITH RuleChanges AS 
(
	SELECT 'High Risk Electronic Transfers' AS RuleName		, 'High Risk Electronic Transfers' AS NewRuleName	, 'High Risk Entity' AS NewTheme UNION ALL
	SELECT 'High Risk Instructions'							, 'High Risk Instructions'							, 'High Risk Entity' UNION ALL
	SELECT 'High Risk Transactions: High Risk Focal Entity'	, 'High Risk Transactions: High Risk Counter Party'	, 'High Risk Entity' UNION ALL
	SELECT 'Large Transactions'								, 'Large Transactions: High Risk Customer'			, 'High Risk Entity'
)

UPDATE dbo.TIndicatorXRule
SET
	ProposedRuleName = RuleChanges.NewRuleName, 
	ProposedTheme = RuleChanges.NewTheme
FROM dbo.TIndicatorXRule
INNER JOIN RuleChanges ON TIndicatorXRule.ProposedRuleName = RuleChanges.RuleName;

--Indicator Priority Changes
SELECT * FROM dbo.TIndicator WHERE IndicatorRefID IN (
'FinTRACLoan1',
'FinTRACLoan3',
'FinTRACLoan2',
'FINTRACLoan1',
'FINTRACLoan3'
);

UPDATE dbo.TIndicator
SET Priority = 1
WHERE IndicatorRefID IN (
'FinTRACLoan1',
'FinTRACLoan3',
'FinTRACLoan2',
'FINTRACLoan1',
'FINTRACLoan3'
);


)

--RefID Changes
SELECT * FROM TIndicator WHERE IndicatorRefID LIKE '%EgmontBriberyandCorruption02%';

UPDATE dbo.TIndicator
SET IndicatorRefID = 'EgmontBriberyandCorruption02, EgmontOrganisedCrime08'
WHERE IndicatorRefID LIKE '%EgmontBriberyandCorruption02%';

--Specific Indicator Changes
WITH RawRemovals AS (
	SELECT 'Credit Card' AS ProductGroup, 'Escalation in Inactive Account' AS ProposedRule  , 'EgmontDrugTrafficking12' AS IndicaforRefID UNION ALL
	SELECT 'Credit Card'         , 'Escalation in Inactive Account'                         , 'FATFSecuritiesUnusual08'   UNION ALL
	SELECT 'Depository Account'  , 'Early Redemption'                                       , 'IIROC8'                    UNION ALL
	SELECT 'Depository Account'  , 'Movement of Funds without Corresponding Trade'          , 'FinTRACSecur5'             UNION ALL
	SELECT 'Depository Account'  , 'Movement of Funds without Corresponding Trade'          , 'IIROC7'                    UNION ALL
	SELECT 'Depository Account'  , 'Movement of Funds without Corresponding Trade'          , 'FATFSecuritiesTransfers07' UNION ALL
	SELECT 'Depository Account'  , 'Movement of Funds without Corresponding Trade'          , 'FATFSecuritiesProfiling04' UNION ALL
	SELECT 'Insurance'           , 'CIB: Product Utilization Shift'                         , 'FinTRACGen21'              UNION ALL
	SELECT 'Insurance'           , 'CIB: Product Utilization Shift'                         , 'FinTRACGen18'              UNION ALL
	SELECT 'Insurance'           , 'CIB: Product Utilization Shift'                         , 'FATFBenOwnership92'        UNION ALL
	SELECT 'Insurance'           , 'CIB: Product Utilization Shift'                         , 'FATFBenOwnership93'        UNION ALL
	SELECT 'Insurance'           , 'CIB: Product Utilization Shift'                         , 'FATFTBML32'                UNION ALL
	SELECT 'Insurance'           , 'CIB: Product Utilization Shift'                         , 'FinTRACSecur15'            UNION ALL
	SELECT 'Insurance'           , 'CIB: Product Utilization Shift'                         , 'FATFSecuritiesUnusual08'   UNION ALL
	SELECT 'Insurance'           , 'CIB: Product Utilization Shift'                         , 'FATFSecuritiesProfiling01' UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change from Previous Average Activity' , 'FinTRACGen21'              UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change from Previous Average Activity' , 'FinTRACGen18'              UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change from Previous Average Activity' , 'FATFBenOwnership92'        UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change from Previous Average Activity' , 'FATFBenOwnership93'        UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change from Previous Average Activity' , 'FATFTBML32'                UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change from Previous Average Activity' , 'FinTRACSecur15'            UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change from Previous Average Activity' , 'FATFSecuritiesUnusual08'   UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change from Previous Average Activity' , 'FATFSecuritiesProfiling01' UNION ALL
	SELECT 'Insurance'           , 'Escalation in Inactive Account'                         , 'FinTRACGen21'              UNION ALL
	SELECT 'Insurance'           , 'Escalation in Inactive Account'                         , 'FinTRACGen18'              UNION ALL
	SELECT 'Insurance'           , 'Escalation in Inactive Account'                         , 'FATFBenOwnership92'        UNION ALL
	SELECT 'Insurance'           , 'Escalation in Inactive Account'                         , 'FATFBenOwnership93'        UNION ALL
	SELECT 'Insurance'           , 'Escalation in Inactive Account'                         , 'FATFTBML32'                UNION ALL
	SELECT 'Insurance'           , 'Escalation in Inactive Account'                         , 'FinTRACSecur15'            UNION ALL
	SELECT 'Insurance'           , 'Escalation in Inactive Account'                         , 'FATFSecuritiesUnusual08'   UNION ALL
	SELECT 'Insurance'           , 'Escalation in Inactive Account'                         , 'FATFSecuritiesProfiling01' UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change in Trade/Transaction Activity'  , 'FinTRACGen21'              UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change in Trade/Transaction Activity'  , 'FinTRACGen18'              UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change in Trade/Transaction Activity'  , 'FATFBenOwnership92'        UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change in Trade/Transaction Activity'  , 'FATFBenOwnership93'        UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change in Trade/Transaction Activity'  , 'FATFTBML32'                UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change in Trade/Transaction Activity'  , 'FinTRACSecur15'            UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change in Trade/Transaction Activity'  , 'FATFSecuritiesUnusual08'   UNION ALL
	SELECT 'Insurance'           , 'CIB: Significant Change in Trade/Transaction Activity'  , 'FATFSecuritiesProfiling01' UNION ALL
	SELECT 'Line-Of-Credit'      , 'CIB: Significant Change in Trade/Transaction Activity'  , 'FinTRACSecur15'            UNION ALL
	SELECT 'Trade Finance'       , 'Journals Between Unrelated Accounts'                    , 'EgmontTerrorismA11'
)

, RemovalData AS (
	SELECT DISTINCT RawRemovals.*
	, TIndicatorXProduct.*, ProductGrouping 
	FROM RawRemovals
	INNER JOIN TIndicator ON RawRemovals.IndicaforRefID = TIndicator.IndicatorRefID
	INNER JOIN TIndicatorXRule ON TIndicator.IndicatorID = TIndicatorXRule.IndicatorID 
		AND RawRemovals.ProposedRule = ProposedRuleName
	INNER JOIN TIndicatorXProduct ON TIndicator.IndicatorID = TIndicatorXProduct.IndicatorID
	INNER JOIN TProduct ON TIndicatorXProduct.ProductID = TProduct.ProductID
		AND RawRemovals.ProductGroup = ProductGrouping
	ORDER BY 1, 2, 3
	)

DELETE 
FROM dbo.TIndicatorXProduct
WHERE IndicatorXProductID IN (SELECT IndicatorXProductID FROM RemovalData);

--Escalation product group indicator removals
WITH EscalationRemovals AS (
	SELECT DISTINCT 
		TIndicatorXRule.ProposedRuleName
		--, TIndicator.IndicatorID
		, TIndicator.IndicatorRefID
		, ProductGrouping
		, TIndicatorXProduct.*
	FROM TIndicator 
	INNER JOIN TIndicatorXRule ON TIndicator.IndicatorID = TIndicatorXRule.IndicatorID 
	INNER JOIN TIndicatorXProduct ON TIndicator.IndicatorID = TIndicatorXProduct.IndicatorID
	INNER JOIN TProduct ON TIndicatorXProduct.ProductID = TProduct.ProductID
	WHERE ProductGrouping IN (
	'Mobile/Internet Payment',
	'Monetary Instrument',
	'RDC',
	'Precious Metals',
	'Trade Finance')
	AND ProposedRuleName = 'Escalation in Inactive Account'
)

DELETE FROM dbo.TIndicatorXProduct
WHERE IndicatorXProductID IN (SELECT IndicatorXProductID FROM EscalationRemovals)
;

--Add New Theme
INSERT INTO dbo.TThemeDescription
(
    ThemeName,
    ThemeDescription
)

SELECT 'High Risk Entity', 'Transactions and trades involving high risk entities that have been named or sanctioned.';


--New Theme Description
UPDATE dbo.TThemeDescription
SET ThemeDescription = 'Transactions or trades involving high risk entities which are not identified on official sanctions watchlists but warrant higher scrutiny.  These include entities that may have been previously fined by a regulator, engage in nascent criminal activity, or possessing some latent indicator of risk.'
WHERE ThemeName = 'High Risk Entity';

----------------------------------------------------------------------------------------------------
----01/11/2019: Priority Change
----------------------------------------------------------------------------------------------------

UPDATE dbo.TIndicator
SET Priority = 1
WHERE IndicatorRefID IN  
(
'WolfsbergCC12',
'FinTRACPersonal10',
'FATFSecuritiesInsurance07',
'WolfsbergCC04',
'FATFTBML38',
'FATFTBML40'
);


----------------------------------------------------------------------------------------------------
----01/14/2019: Product Mapping/Indicator Info Changes
----------------------------------------------------------------------------------------------------


SELECT * FROM TIndicatorXRule 
INNER JOIN TIndicator ON TIndicatorXRule.IndicatorID = TIndicator.IndicatorID 
WHERE IndicatorRefID = 'FFIECTransfers4';

--FFIECTransfers4
UPDATE dbo.TIndicatorXRule
SET ProposedRuleName = 'All Activity In/All Activity OUT'
WHERE IndicatorXRuleID = 131 AND IndicatorID = 153; 


SELECT * FROM TIndicatorXRule 
INNER JOIN TIndicator ON TIndicatorXRule.IndicatorID = TIndicator.IndicatorID 
WHERE IndicatorRefID = 'FinTRACSecur13';


--FinTRACSecur13
DELETE FROM dbo.TIndicatorXRule
WHERE IndicatorID = 1455 AND ProposedRuleName = 'Hidden Relationships';

--Change PUPID Report Name
UPDATE dbo.TIndicatorXRule
SET ProposedRuleName = 'Payable-Upon-Proper-Identification Transactions'
WHERE ProposedRuleName = 'Automated PUPID Report';

--Update Rule Mapping for Duplicate
UPDATE dbo.TIndicatorXRule
SET IndicatorID = 261
WHERE IndicatorID = 1514 
	AND ProposedRuleName = 'CIB: Significant Change from Previous Average Activity';

--Duplicate Changes
WITH DuplicateChanges AS (
	SELECT 1318 AS IndicatorID, 'FATFBenOwnership83' AS IndicatorRefID , 0 AS Duplicate , 1 AS Conducive , 1 AS Applicable UNION ALL
	SELECT 1490 , 'FATFBenOwnership83'            , 1 , 1 , 1 UNION ALL
	SELECT 1323 , 'FATFBenOwnership88'            , 0 , 1 , 1 UNION ALL
	SELECT 1491 , 'FATFBenOwnership88'            , 1 , 1 , 1 UNION ALL
	SELECT 1444 , 'FATFSecuritiesProfiling09'     , 0 , 1 , 1 UNION ALL
	SELECT 890  , 'FATFSecuritiesProfiling09'     , 1 , 1 , 1 UNION ALL
	SELECT 228  , 'FinTRACLoan1'                  , 0 , 1 , 1 UNION ALL
	SELECT 1506 , 'FINTRACLoan1'                  , 1 , 1 , 1 UNION ALL
	SELECT 41   , 'FinTRACLoan10'                 , 0 , 0 , 1 UNION ALL
	SELECT 1507 , 'FINTRACLoan10'                 , 1 , 0 , 1 UNION ALL
	SELECT 42   , 'FinTRACLoan11'                 , 0 , 0 , 1 UNION ALL
	SELECT 1508 , 'FINTRACLoan11'                 , 1 , 0 , 1 UNION ALL
	SELECT 43   , 'FinTRACLoan12'                 , 0 , 0 , 1 UNION ALL
	SELECT 1509 , 'FINTRACLoan12'                 , 1 , 0 , 1 UNION ALL
	SELECT 1510 , 'FINTRACLoan13'                 , 1 , 0 , 1 UNION ALL
	SELECT 44   , 'FinTRACLoan13'                 , 0 , 0 , 1 UNION ALL
	SELECT 1511 , 'FINTRACLoan14'                 , 1 , 0 , 1 UNION ALL
	SELECT 45   , 'FinTRACLoan14'                 , 0 , 0 , 1 UNION ALL
	SELECT 1512 , 'FINTRACLoan15'                 , 1 , 0 , 1 UNION ALL
	SELECT 46   , 'FinTRACLoan15'                 , 0 , 0 , 1 UNION ALL
	SELECT 1513 , 'FINTRACLoan16'                 , 1 , 0 , 1 UNION ALL
	SELECT 422  , 'FinTRACLoan16'                 , 0 , 0 , 1 UNION ALL
	SELECT 261  , 'FinTRACLoan2'                  , 0 , 1 , 1 UNION ALL
	SELECT 1514 , 'FINTRACLoan2'                  , 1 , 1 , 1 UNION ALL
	SELECT 229  , 'FinTRACLoan3'                  , 0 , 1 , 1 UNION ALL
	SELECT 1515 , 'FINTRACLoan3'                  , 1 , 1 , 1 UNION ALL
	SELECT 1516 , 'FINTRACLoan4'                  , 1 , 0 , 1 UNION ALL
	SELECT 262  , 'FinTRACLoan4'                  , 0 , 0 , 1 UNION ALL
	SELECT 1517 , 'FINTRACLoan5'                  , 1 , 0 , 1 UNION ALL
	SELECT 420  , 'FinTRACLoan5'                  , 0 , 0 , 1 UNION ALL
	SELECT 1518 , 'FINTRACLoan6'                  , 1 , 0 , 1 UNION ALL
	SELECT 421  , 'FinTRACLoan6'                  , 0 , 0 , 1 UNION ALL
	SELECT 1519 , 'FINTRACLoan7'                  , 1 , 0 , 1 UNION ALL
	SELECT 38   , 'FinTRACLoan7'                  , 0 , 0 , 1 UNION ALL
	SELECT 1520 , 'FINTRACLoan8'                  , 1 , 0 , 1 UNION ALL
	SELECT 39   , 'FinTRACLoan8'                  , 0 , 0 , 1 UNION ALL
	SELECT 40   , 'FinTRACLoan9'                  , 0 , 0 , 1 UNION ALL
	SELECT 1521 , 'FINTRACLoan9'                  , 1 , 0 , 1
	)

UPDATE dbo.TIndicator
SET IsApplicableToBank = DuplicateChanges.Applicable, 
	IsConduciveToAutomatedMonitoring = DuplicateChanges.Conducive, 
	IsDuplicate = DuplicateChanges.Duplicate
FROM dbo.TIndicator
INNER JOIN DuplicateChanges 
	ON TIndicator.IndicatorID = DuplicateChanges.IndicatorID 
	AND TIndicator.IndicatorRefID = DuplicateChanges.IndicatorRefID;	
	
--Get Rid of Products that are GBM duplicates and Global Treasury	
DELETE FROM dbo.TProduct 
WHERE Segment IN 
('Global Banking and Markets (GBM)'
, 'Global Banking and Markets (GBM), Commercial Banking and small business'
, 'Group Treasury');
	
	
--Delink Credit Cards from FinTRACAcct11
WITH CreditCardDeLink AS (
	SELECT IndicatorRefID, TIndicatorXProduct.*, ProductGrouping FROM dbo.TIndicatorXProduct
	INNER JOIN TIndicator ON TIndicatorXProduct.IndicatorID = TIndicator.IndicatorID 
	INNER JOIN TProduct ON TIndicatorXProduct.ProductID = TProduct.ProductID
	WHERE IndicatorRefID = 'FinTRACAcct11' AND ProductGrouping = 'Credit Card'
)

DELETE FROM dbo.TIndicatorXProduct
WHERE IndicatorXProductID IN (SELECT IndicatorXProductID FROM CreditCardDeLink);

----------------------------------------------------------------------------------------------------
----01/15/2019: 20190115 Custody Rules and Indicators v1.00.xlsx
----------------------------------------------------------------------------------------------------

--Removing Custody and Trust
WITH RemoveCustodyTrust AS (
	SELECT TIndicatorXProduct.*, ProductGrouping 
	FROM TIndicatorXProduct 
	INNER JOIN TProduct ON TIndicatorXProduct.ProductID = TProduct.ProductID
	WHERE 
	ProductGrouping IN ('Custody', 'Trust Services') 
	AND IndicatorID IN 
	(
		1370,
		1438,
		164,
		232,
		234,
		1062,
		1068,
		1395,
		1392,
		142,
		265,
		586,
		716,
		1213,
		1214,
		1327,
		1328,
		1363,
		1439,
		1443,
		987,
		988,
		235,
		236,
		1074,
		1474,
		1057,
		1458,
		1464,
		104,
		103,
		986,
		309,
		1209,
		1451,
		1461,
		1201,
		282,
		417,
		1481,
		350,
		351,
		1059,
		1476
	) 
	)

DELETE FROM dbo.TIndicatorXProduct 
WHERE IndicatorXProductID IN (SELECT IndicatorXProductID FROM RemoveCustodyTrust);

--Removing More Trust
WITH RemoveMoreTrust AS (
	SELECT TIndicatorXProduct.*, ProductGrouping 
	FROM TIndicatorXProduct 
	INNER JOIN TProduct ON TIndicatorXProduct.ProductID = TProduct.ProductID
	WHERE 
	ProductGrouping IN ('Trust Services') 
	AND IndicatorID IN 
	(
		1273,
		1440,
		1432,
		1433,
		1479,
		102
	) 
	)
DELETE FROM dbo.TIndicatorXProduct 
WHERE IndicatorXProductID IN (SELECT IndicatorXProductID FROM RemoveMoreTrust);


----------------------------------------------------------------------------------------------------
----01/15/2019: First Batch (Review, then come ask me question if not clear)
----------------------------------------------------------------------------------------------------

--Change Rule Name
UPDATE dbo.TIndicatorXRule
SET ProposedRuleName = 'Known High Risk Securities Counter Parties'
WHERE ProposedRuleName = 'High Risk Electronic Transfers';

--Delete Specific GBM Product
DELETE FROM dbo.TProduct
WHERE Segment = 'GBM'
	AND BusinessUnit = 'Global Business Payments'
	AND ProductOrService = 'Online Foreign Currency Account'
	AND ProductOrServiceDescription = 'Non-Interest Bearing Account '
	AND ProductGrouping = 'Mobile/Internet Payment';


--Update Product Groupings	
WITH SegmentData AS (
SELECT 'Retail' AS Segment , 'Day-to-day (D2D)' AS BusinessUnit         , 'BB' AS System                  , 'U.S Dollar Daily Interest Account' AS Product            , 'For customer who travel frequently in the US to make or receive payments in US dollars' AS Description                                                                             UNION ALL
SELECT 'Retail'    , 'Day-to-day (D2D)'         , 'BB'                  , 'Euro Daily Interest Savings Account'          , 'Savings account in Euros'                                                                                                                                                                                                       UNION ALL
SELECT 'Retail'    , 'Branch'                   , NULL                    , 'Savings Account'                            , 'Product is restricted to limited number of Transactions per month, and is less attractive for Money Laundering purposes.'                        UNION ALL
SELECT 'Retail'    , 'CCC'                      , 'EDGE - Onboarding'   , 'Saving- Scotia US Dollar Interest Account'    , 'Product is the most common type of bank account and can be used to conduct multiple transactions to facilitate money laundering; additionally, corporate accounts (DDAs) facilitate greater transaction volume and values.'		UNION ALL
SELECT 'Retail'    , 'CCC'                      , 'EDGE - Onboarding'   , 'Savings-Euro Savings Account '                , 'Product is the most common type of bank account and can be used to conduct multiple transactions to facilitate money laundering; additionally, corporate accounts (DDAs) facilitate greater transaction volume and values.'		UNION ALL
SELECT 'Retail'    , 'CCC'                      , 'EDGE - Onboarding'   , 'Chequing- Scotia US Dollar Interest Account'  , 'Product is the most common type of bank account and can be used to conduct multiple transactions to facilitate money laundering; additionally, corporate accounts (DDAs) facilitate greater transaction volume and values.'		UNION ALL
SELECT 'GBM'       , 'Global Business Payments' , NULL                    , 'Online Foreign Currency Account'              , 'Non-Interest Bearing Account '
)

, ProductsInvolved AS (
SELECT TProduct.* FROM dbo.TProduct
INNER JOIN SegmentData 
	ON TProduct.Segment = SegmentData.Segment
	AND ISNULL(TProduct.System, '') = ISNULL(SegmentData.System, '')
	AND TProduct.BusinessUnit = SegmentData.BusinessUnit
	AND SegmentData.Product = ProductOrService
	--AND ProductOrServiceDescription = SegmentData.Description
)
UPDATE dbo.TProduct
SET ProductGrouping = 'Depository Account'
FROM TProduct
INNER JOIN ProductsInvolved ON TProduct.ProductID = ProductsInvolved.ProductID;	

--Update Sub Grouping	
UPDATE dbo.TProduct
SET ProductSubGrouping = 'Derivative/Swap/Future/Forward'
WHERE ProductGrouping = 'Foreign Exchange';


--Deleting Foreign Exchange Mappings
WITH DeletedMappings AS (
	SELECT TIndicatorXProduct.*, ProductGrouping 
	FROM dbo.TIndicatorXProduct
	INNER JOIN dbo.TProduct ON TIndicatorXProduct.ProductID = TProduct.ProductID 
		AND ProductGrouping = 'Foreign Exchange'
)

DELETE FROM dbo.TIndicatorXProduct
WHERE IndicatorXProductID IN (SELECT IndicatorXProductID FROM DeletedMappings);

--SELECT * FROM TIndicatorXProduct;

--Adding Foreign Exchange Mappings
WITH OverallProposed AS (
	SELECT IndicatorID
		, ProposedRuleName 
		, DENSE_RANK() OVER (PARTITION BY IndicatorID ORDER BY ProposedRuleName ASC) - 1 + 
			DENSE_RANK() OVER (PARTITION BY IndicatorID ORDER BY ProposedRuleName DESC) AS NumTotalRules 
	 FROM TIndicatorXRule
	WHERE ProposedRuleName IS NOT NULL
)

, ForexRelated AS (
	SELECT DISTINCT
		IndicatorID
		, ProposedRuleName
		, DENSE_RANK() OVER (PARTITION BY IndicatorID ORDER BY ProposedRuleName ASC) - 1 + 
			 DENSE_RANK() OVER (PARTITION BY IndicatorID ORDER BY ProposedRuleName DESC) AS NumRelevantRules 
	FROM dbo.TIndicatorXRule
	WHERE ProposedRuleName IN 
	(
	'Pattern of Funds Transfers between Customers and External Entities',
	'Pattern of Funds Transfers between Internal Accounts and Customers',
	'Pattern of Funds Transfers between Recurring Originators/Beneficiaries',
	'High Risk Electronic Transfers',
	'Large Transactions: High Risk Customer',
	'High Risk Transactions: High Risk Geography',
	'CIB: Significant Change from Previous Average Activity',
	'CIB: Significant Change in Trade/Transaction Activity',
	'High Risk Instructions',
	'High Risk Transactions: High Risk Counter Party',
	'Multiple Jurisdictions',
	'Missing Counter Party Details',
	'Numbered Accounts'
	)
	--ORDER BY IndicatorID
) 

INSERT INTO dbo.TIndicatorXProduct
(
    IndicatorID,
    ProductID,
    CoverageLevel
)

SELECT DISTINCT 
	OverallProposed.IndicatorID --, ForexRelated.NumRelevantRules, OverallProposed.NumTotalRules 
	, TProduct.ProductID
	, 1 AS CoverageLevel
FROM OverallProposed
INNER JOIN ForexRelated ON OverallProposed.IndicatorID = ForexRelated.IndicatorID
	AND OverallProposed.NumTotalRules = ForexRelated.NumRelevantRules
INNER JOIN dbo.TProduct ON 1=1 AND TProduct.ProductGrouping = 'Foreign Exchange';

----------------------------------------------------------------------------------------------------
----01/15/2019: RE: Next Batch
----------------------------------------------------------------------------------------------------

--Remove LOC Products
WITH LOCRemovals AS (
SELECT TIndicatorXProduct.*, ProductGrouping
FROM TIndicator 
INNER JOIN TIndicatorXProduct ON TIndicator.IndicatorID = TIndicatorXProduct.IndicatorID
INNER JOIN TProduct ON TIndicatorXProduct.ProductID = TProduct.ProductID AND ProductGrouping = 'Line-Of-Credit'
WHERE IndicatorRefID = 'FATFBenOwnership63'
)

DELETE FROM dbo.TIndicatorXProduct
WHERE IndicatorXProductID IN (SELECT IndicatorXProductID FROM LOCRemovals);

--Update Rule for WolfsbergCC05
WITH WrongTemplate AS (
SELECT DISTINCT TIndicatorXRule.* 
FROM dbo.TIndicator 
INNER JOIN dbo.TIndicatorXRule 
	ON TIndicator.IndicatorID = TIndicatorXRule.IndicatorID
WHERE IndicatorRefID = 'WolfsbergCC05'
AND ProposedRuleName = 'CIB: High Risk Geography'
)

, ProperTemplate AS (
	SELECT DISTINCT TRule.*, ProposedRuleName, ProposedTheme, InOracle FROM dbo.TRule 
	INNER JOIN dbo.TIndicatorXRule 
		ON TRule.RuleID = TIndicatorXRule.RuleID
	WHERE ProposedRuleName = 'High Risk Transactions: High Risk Geography'
	AND Source = 'Oracle'
	)

, NewEntry AS (
	SELECT 
		WrongTemplate.IndicatorXRuleID
		, WrongTemplate.IndicatorID
		, ProperTemplate.RuleID
		, ProperTemplate.ProposedRuleName
		, ProperTemplate.ProposedTheme
		, ProperTemplate.InOracle
	FROM WrongTemplate
	INNER JOIN ProperTemplate ON 1=1
)

UPDATE dbo.TIndicatorXRule
SET RuleID = NewEntry.RuleID
	, ProposedRuleName = NewEntry.ProposedRuleName
	, ProposedTheme = NewEntry.ProposedTheme
	, InOracle = NewEntry.InOracle
FROM dbo.TIndicatorXRule
INNER JOIN NewEntry ON TIndicatorXRule.IndicatorXRuleID = NewEntry.IndicatorXRuleID;

--719
--SELECT * FROM TIndicatorXRule WHERE IndicatorXRuleID = 719;

----------------------------------------------------------------------------------------------------
----01/16/2019: Integrating Staging ID into TProduct
----------------------------------------------------------------------------------------------------

--Adding StagingID
ALTER TABLE dbo.TProduct 
ADD StagingID nvarchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL;

--Populating with Data
WITH TempData AS (
	SELECT
		[ID], 
		CONVERT(XML,'<x>' + REPLACE([Product Grouping (separate by ";" if more than one)],';','</x><x>') + '</x>') AS ProductXML
	FROM XTProduct20181220
)

, SplitGrouping AS (

	SELECT 
		[ID], 
		LTRIM(RTRIM(p.r.value('.', 'varchar(50)'))) AS ProductGrouping
	FROM TempData
	CROSS APPLY ProductXML.nodes('/x') as P(r) 
)

, ProductGroupETL AS
(
SELECT 'EFT' AS InitialGrouping				, 'Electronic Funds Transfer'		AS ProposedGrouping UNION ALL
SELECT 'Moblie/Internet Payment'			, 'Mobile/Internet Payment'		UNION ALL
SELECT 'Depository Accounts - Investment'	, 'Depository Account - Investment' 
)

, StagingIDTable AS (
SELECT 
	ROW_NUMBER() OVER (ORDER BY [Segment],[Product/Service],COALESCE(ProductGroupETL.ProposedGrouping,SplitGrouping.ProductGrouping)) AS ProductID,
	Staging.ProductID AS StagingID
FROM dbo.XTProduct20181220 Staging
LEFT JOIN SplitGrouping ON Staging.[ID] = SplitGrouping.[ID]
LEFT JOIN ProductGroupETL ON SplitGrouping.ProductGrouping = ProductGroupETL.InitialGrouping
--WHERE Staging.Segment NOT IN ('GBM')
)

UPDATE dbo.TProduct
SET StagingID = StagingIDTable.StagingID
FROM dbo.TProduct
INNER JOIN StagingIDTable ON TProduct.ProductID = StagingIDTable.ProductID;

----------------------------------------------------------------------------------------------------
----01/16/2019: Integrating Staging ID into TProduct (Part 2)
----------------------------------------------------------------------------------------------------

UPDATE dbo.TProduct
SET ProductGrouping = 'Depository Account'
WHERE StagingID IN 
(
	'65'
	,'66'
	,'119'
	,'120'
	,'166'
	,'167'
	,'213'
	,'214'
	,'253'
	,'254'
	,'290'
	,'291'
	,'407'
	,'420'
	,'421f'
	,'423f'
	,'1472'
);

----------------------------------------------------------------------------------------------------
----01/17/2019: Potential Indicator Product Mappings
----------------------------------------------------------------------------------------------------

WITH IndicatorRules AS (
	SELECT DISTINCT TIndicator.*, ProposedRuleName FROM TIndicator 
	LEFT JOIN TIndicatorXRule ON TIndicator.IndicatorID = TIndicatorXRule.IndicatorID
	WHERE IndicatorRefID IN 
	(
	'FinTRACBiz29',
	'EgmontBriberyandCorruption02, EgmontOrganisedCrime08',
	'FATFTrafficking22'
	)
	)

SELECT DISTINCT
	IndicatorRules.IndicatorRefID
	, IndicatorRules.Indicator
	, IndicatorRules.ProposedRuleName
	, ProductGrouping
FROM IndicatorRules
INNER JOIN TIndicatorXRule ON IndicatorRules.ProposedRuleName = TIndicatorXRule.ProposedRuleName
INNER JOIN TIndicatorXProduct ON TIndicatorXRule.IndicatorID = TIndicatorXProduct.IndicatorID
INNER JOIN TProduct ON TIndicatorXProduct.ProductID = TProduct.ProductID;
