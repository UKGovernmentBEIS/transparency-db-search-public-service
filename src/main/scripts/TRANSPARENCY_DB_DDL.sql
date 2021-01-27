
-------------------------------------------------------------------
--0. Create Sequence table
-------------------------------------------------------------------
CREATE SEQUENCE beneficiary_seq START 1;
CREATE SEQUENCE granting_authority_seq START 1;
CREATE SEQUENCE subsidy_control_seq START 10000;
CREATE SEQUENCE award_seq START 1;
CREATE SEQUENCE legal_basis_seq START 1;
CREATE SEQUENCE option_seq START 1;

-------------------------------------------------------------------
--1. Create Beneficiary table
-------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS BENEFICIARY
(
	BENEFICIARY_ID 		NUMERIC			PRIMARY KEY DEFAULT NEXTVAL('beneficiary_seq') NOT NULL,
    BENEFICIARY_NAME	VARCHAR(255)	NOT NULL,
    BENEFICIARY_TYPE	VARCHAR(255)	NOT NULL,
    NATIONAL_ID			VARCHAR(255)	NOT NULL,
    NATIONAL_ID_TYPE	VARCHAR(255)	NOT NULL,
    SIC_CODE			VARCHAR(255)	NULL,
    SIZE_OF_ORG			VARCHAR(255)	NOT NULL,
	CREATED_BY			VARCHAR(255)	DEFAULT 'SYSTEM',
	APPROVED_BY			VARCHAR(255)	DEFAULT 'SYSTEM',
	STATUS				VARCHAR(255)	DEFAULT 'DRAFT',
	CREATED_TIMESTAMP		TIMESTAMP 		WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
 	LAST_MODIFIED_TIMESTAMP	TIMESTAMP		WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);


-------------------------------------------------------------------
--2. Create Granting Authority table
-------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS GRANTING_AUTHORITY
(
	GA_ID				NUMERIC			PRIMARY KEY DEFAULT NEXTVAL('granting_authority_seq') NOT NULL,
    GA_NAME				VARCHAR(255)	UNIQUE NOT NULL,
    CREATED_BY			VARCHAR(255)	DEFAULT 'SYSTEM',
	APPROVED_BY			VARCHAR(255)	DEFAULT 'SYSTEM',
	STATUS				VARCHAR(255)	DEFAULT 'DRAFT',
	CREATED_TIMESTAMP		TIMESTAMP 		WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
 	LAST_MODIFIED_TIMESTAMP	TIMESTAMP		WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);


-------------------------------------------------------------------
--3. Create Subsidy Control table
-------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS SUBSIDY_MEASURE
(
    SC_NUMBER				VARCHAR(255)	PRIMARY KEY DEFAULT 'SC' || NEXTVAL('subsidy_control_seq') NOT NULL,
    GA_ID				NUMERIC			REFERENCES GRANTING_AUTHORITY(GA_ID) NOT NULL,
    SUBSIDY_MEASURE_TITLE	VARCHAR(255)	NOT NULL,
    START_DATE				DATE			NOT NULL,
	END_DATE				DATE			NOT NULL,
	DURATION				NUMERIC(36,0)	NOT NULL,
	BUDGET					VARCHAR(255)	NOT NULL,
	ADHOC 					BOOLEAN			NOT NULL DEFAULT FALSE,
	GA_SUBSIDY_WEBLINK		VARCHAR(255)	NOT NULL,
	PUBLISHED_MEASURE_DATE			DATE			NOT NULL,
	CREATED_BY			VARCHAR(255)	DEFAULT 'SYSTEM',
	APPROVED_BY			VARCHAR(255)	DEFAULT 'SYSTEM',
	STATUS				VARCHAR(255)	DEFAULT 'DRAFT',
	CREATED_TIMESTAMP		TIMESTAMP 		WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
 	LAST_MODIFIED_TIMESTAMP	TIMESTAMP		WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-------------------------------------------------------------------
--4. Create Award table
-------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS AWARD
(
	AWARD_NUMBER						NUMERIC	PRIMARY KEY		DEFAULT NEXTVAL('award_seq') NOT NULL,
    SC_NUMBER						VARCHAR(255)	REFERENCES SUBSIDY_MEASURE(SC_NUMBER) NOT NULL,
  	GA_ID							NUMERIC			REFERENCES GRANTING_AUTHORITY(GA_ID) NOT NULL,
	BENEFICIARY_ID					NUMERIC			REFERENCES BENEFICIARY(BENEFICIARY_ID) NOT NULL,
	SUBSIDY_ELEMENT_FULL_AMOUNT_RANGE		VARCHAR(255)	NULL,
	SUBSIDY_ELEMENT_FULL_AMOUNT_EXACT		NUMERIC(36,0)	NULL,
	SUBSIDY_OBJECTIVE				VARCHAR(255)	NOT NULL,
	GOOD_SERVICES_FILTER				VARCHAR(255)	NOT NULL,
	LEGAL_GRANTING_DATE				DATE		NOT NULL,
	PUBLISHED_AWARD_DATE				DATE 		NOT NULL,
	SPENDING_REGION					VARCHAR(255)	NOT NULL,
	SUBSIDY_INSTRUMENT				VARCHAR(255)	NOT NULL,
	SPENDING_SECTOR				VARCHAR(255)	NOT NULL,
	CREATED_BY			VARCHAR(255)	DEFAULT 'SYSTEM',
	APPROVED_BY			VARCHAR(255)	DEFAULT 'SYSTEM',
	STATUS				VARCHAR(255)	DEFAULT 'DRAFT',
	CREATED_TIMESTAMP		TIMESTAMP 		WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
 	LAST_MODIFIED_TIMESTAMP	TIMESTAMP		WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP

);
-------------------------------------------------------------------
--5. Create LEGAL BASIS table
-------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS LEGAL_BASIS
(
	LEGAL_BASIS_ID      NUMERIC			PRIMARY KEY DEFAULT NEXTVAL('legal_basis_seq') NOT NULL,
    SC_NUMBER			VARCHAR(255)	REFERENCES SUBSIDY_MEASURE(SC_NUMBER) NOT NULL,
	LEGAL_BASIS_TEXT	VARCHAR(255)	,
    CREATED_BY			VARCHAR(255)	DEFAULT 'SYSTEM',
	APPROVED_BY			VARCHAR(255)	DEFAULT 'SYSTEM',
	STATUS				VARCHAR(255)	DEFAULT 'DRAFT',
	CREATED_TIMESTAMP		TIMESTAMP 		WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
 	LAST_MODIFIED_TIMESTAMP	TIMESTAMP		WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	constraint legal_basis_txt_uq unique (SC_NUMBER,LEGAL_BASIS_TEXT)
);
------------------------------------------------------
-------------------------------------------------------------------
--6. Create OPTION table
-------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS OPTION
(
	OPTION_ID     	    NUMERIC	 DEFAULT NEXTVAL('option_seq'),
    OPTION_NAME			VARCHAR(255),
	OPTION_VALUE		VARCHAR(255),
    CREATED_BY			VARCHAR(255)	DEFAULT 'SYSTEM',
	APPROVED_BY			VARCHAR(255)	DEFAULT 'SYSTEM',
	STATUS				VARCHAR(255)	DEFAULT 'DRAFT',
	CREATED_TIMESTAMP		TIMESTAMP 		WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
 	LAST_MODIFIED_TIMESTAMP	TIMESTAMP		WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	constraint option_id_pk primary key (OPTION_ID),
	constraint option_val_uq unique (OPTION_NAME,OPTION_VALUE)
);

