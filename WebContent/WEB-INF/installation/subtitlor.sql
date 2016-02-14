-- Database: subtitlor

-- DROP DATABASE subtitlor;

CREATE DATABASE subtitlor
  WITH OWNER = olive
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'French_France.1252'
       LC_CTYPE = 'French_France.1252'
       CONNECTION LIMIT = -1;
GRANT CONNECT, TEMPORARY ON DATABASE subtitlor TO public;
GRANT ALL ON DATABASE subtitlor TO olive;

-- Table: translatedfile

-- DROP TABLE translatedfile;

CREATE TABLE translatedfile
(
  id serial NOT NULL,
  idline character varying(35) NOT NULL,
  timevalues character varying(35) NOT NULL,
  text1 character varying(200) NOT NULL,
  text2 character varying(200) NOT NULL,
  translatedtext1 character varying(200) NOT NULL,
  translatedtext2 character varying(200) NOT NULL,
  filename character varying(50) NOT NULL,
  descriptionfile character varying(50),
  CONSTRAINT translatedfile_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE translatedfile
  OWNER TO postgres;
GRANT ALL ON DATABASE subtitlor TO olive;
GRANT ALL PRIVILEGES ON DATABASE subtitlor to olive;
GRANT ALL ON TABLE translatedfile TO postgres;
GRANT ALL ON TABLE translatedfile TO olive;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE translatedfile to olive;
GRANT ALL PRIVILEGES ON TABLE translatedfile to olive;
grant all on sequence translatedfile_id_seq to olive;
ALTER USER olive WITH PASSWORD '1234';
