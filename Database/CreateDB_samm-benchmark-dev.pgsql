-- ---------------------
-- Clean Up time
-- ---------------------
DROP TABLE IF EXISTS AssessorOrganization;
DROP TABLE IF EXISTS AnswerMap;
DROP TABLE IF EXISTS AssessedQuestion;
DROP TABLE IF EXISTS Answer;
DROP TABLE IF EXISTS AssessPractice;
DROP TABLE IF EXISTS QuestionResponse;
DROP TABLE IF EXISTS QuestionnaireQuestion;
DROP TABLE IF EXISTS AssessmentQuestion;
DROP TABLE IF EXISTS AnswerSet;
DROP TABLE IF EXISTS Activity;
DROP TABLE IF EXISTS PracticeLevel;
DROP TABLE IF EXISTS Stream;
DROP TABLE IF EXISTS SecurityPractice;
DROP TABLE IF EXISTS BusinessFunction;
DROP TABLE IF EXISTS MaturityLevel;
DROP TABLE IF EXISTS Assessment;
DROP TABLE IF EXISTS Assessor;
DROP TABLE IF EXISTS AssessmentMethod;
DROP TABLE IF EXISTS SAMM_Model;
DROP TABLE IF EXISTS SubOrg;
DROP TABLE IF EXISTS Organization;
DROP TABLE IF EXISTS Region;
DROP TABLE IF EXISTS Industry;


-- -----------------------------------------------------
-- Table Industry
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Industry (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(256) NOT NULL,
  description VARCHAR(1000)
  );


-- -----------------------------------------------------
-- Table Region
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Region (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(256),
  description VARCHAR(1000)
  );


-- -----------------------------------------------------
-- Table Organization
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Organization (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  industry_id INTEGER,
  region_id INTEGER,
  employee_num INTEGER,
  developer_num INTEGER,
  appsec_num INTEGER,
  public VARCHAR(64),
  CONSTRAINT fk_org_industry FOREIGN KEY(industry_id) REFERENCES Industry(id),
  CONSTRAINT fk_org_region FOREIGN KEY(region_id) REFERENCES Region(id)
  );


-- -----------------------------------------------------
-- Table SubOrg
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS SubOrg (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  organization_id INTEGER,
  employee_num INTEGER,
  developer_num INTEGER,
  appsec_num INTEGER,
  CONSTRAINT fk_so_organization FOREIGN KEY(organization_id) REFERENCES Organization(id)
  );


-- -----------------------------------------------------
-- Table SAMM_Model
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS SAMM_Model (
  id INTEGER PRIMARY KEY,
  version VARCHAR(64) NOT NULL,
  description VARCHAR(1000) NOT NULL,
  release_date DATE NOT NULL,
  retire_date DATE
  );


-- -----------------------------------------------------
-- Table AssessmentMethod
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS AssessmentMethod (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(256) NOT NULL,
  description VARCHAR(1000)
  );


-- -----------------------------------------------------
-- Table Assessor
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Assessor (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(256) NOT NULL,
  org VARCHAR(256) NOT NULL,
  description VARCHAR(1000)
  );


-- -----------------------------------------------------
-- Table Assessment
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Assessment (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  sammModel_id INTEGER NOT NULL,
  assessment_id INTEGER NOT NULL,
  assessment_date DATE NOT NULL,
  organization_id INTEGER NOT NULL,
  suborg_id INTEGER NOT NULL,
  assessor_id INTEGER NOT NULL,
  method_id INTEGER NOT NULL,
  quality_lvl VARCHAR(64),
  CONSTRAINT fk_asmt_sammmodel FOREIGN KEY(sammModel_id) REFERENCES SAMM_Model(id),
  CONSTRAINT fk_asmt_organization FOREIGN KEY(organization_id) REFERENCES Organization(id),
  CONSTRAINT fk_asmt_suborg FOREIGN KEY(suborg_id) REFERENCES SubOrg(id),
  CONSTRAINT fk_asmt_assessor FOREIGN KEY(assessor_id) REFERENCES Assessor(id),
  CONSTRAINT fk_asmt_method FOREIGN KEY(method_id) REFERENCES AssessmentMethod(id)
  );


-- -----------------------------------------------------
-- Table MaturityLevel
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS MaturityLevel (
  id VARCHAR(128) PRIMARY KEY,
  name VARCHAR(128) NULL,
  description VARCHAR(1000) NULL,
  number INTEGER,
  ordinal INTEGER NOT NULL
  );


-- -----------------------------------------------------
-- Table BusinessFunction
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS BusinessFunction (
  id VARCHAR(128) PRIMARY KEY,
  name VARCHAR(64) NOT NULL,
  description VARCHAR(1000) NULL,
  ordinal INTEGER NOT NULL
  );


-- -----------------------------------------------------
-- Table SecurityPractice
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS SecurityPractice (
  id VARCHAR(128) PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  name_short VARCHAR(64) NULL,
  desc_short VARCHAR(1000) NULL,
  desc_long VARCHAR(2000) NULL,
  businessfunction_id VARCHAR(128) NOT NULL,
  ordinal INTEGER NOT NULL,
  CONSTRAINT fk_sp_businessfunction FOREIGN KEY(businessfunction_id) REFERENCES BusinessFunction(id)
  );


-- -----------------------------------------------------
-- Table Stream
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Stream (
  id VARCHAR(128) PRIMARY KEY,
  name VARCHAR(128) NULL,
  description VARCHAR(1000) NULL,
  code VARCHAR(45) NULL,
  ordinal INTEGER NULL
  );


-- -----------------------------------------------------
-- Table PracticeLevel
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PracticeLevel (
  id VARCHAR(128) PRIMARY KEY,
  objective VARCHAR(1000) NULL,
  description VARCHAR(1000) NULL,
  maturityLevel_id VARCHAR(128) NOT NULL,
  securityPractice_id VARCHAR(128) NOT NULL,
  CONSTRAINT fk_pl_maturity FOREIGN KEY(maturityLevel_id) REFERENCES MaturityLevel(id),
  CONSTRAINT fk_pl_securitypractice FOREIGN KEY(securityPractice_id) REFERENCES SecurityPractice(id)
  );


-- -----------------------------------------------------
-- Table Activity
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Activity (
  id VARCHAR(128) PRIMARY KEY,
  stream_id VARCHAR(128) NOT NULL,
  practiceLevel_id VARCHAR(128) NOT NULL,
  title VARCHAR(128) NULL,
  benefit VARCHAR(2000) NULL,
  desc_short VARCHAR(2000) NULL,
  desc_long VARCHAR(8000) NULL,
  code VARCHAR(45) NULL,
  ordinal INTEGER NULL,
  results VARCHAR(4000) NULL,
  metrics VARCHAR(4000) NULL,
  costs VARCHAR(4000) NULL,
  notes VARCHAR(4000) NULL,
  CONSTRAINT fk_act_practicelevel FOREIGN KEY(practiceLevel_id) REFERENCES PracticeLevel(id)
  );


-- -----------------------------------------------------
-- Table AnswerSet
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS AnswerSet (
  id VARCHAR(128) PRIMARY KEY NOT NULL,
  text VARCHAR(256),
  description VARCHAR(1000)
  );


-- -----------------------------------------------------
-- Table AssessmentQuestion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS AssessmentQuestion (
  id VARCHAR(128) PRIMARY KEY,
  question_text VARCHAR(256) NOT NULL,
  ordinal INTEGER NOT NULL,
  activity_id VARCHAR(128) NOT NULL,
  answerset_id VARCHAR(128) NOT NULL,
  question_code VARCHAR(128) NOT NULL,
  quality_description VARCHAR(1000),
  CONSTRAINT fk_aq_activity FOREIGN KEY(activity_id) REFERENCES Activity(id),
  CONSTRAINT fk_aq_answerset FOREIGN KEY(answerset_id) REFERENCES AnswerSet(id)
  );


-- -----------------------------------------------------
-- Table QuestionnaireQuestion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS QuestionnaireQuestion (
  sammModel_id INTEGER NOT NULL,
  assessmentQuestion_id VARCHAR(128) NOT NULL,
  PRIMARY KEY (sammModel_id, assessmentQuestion_id),
  CONSTRAINT fk_qq_sammmodel FOREIGN KEY(sammModel_id) REFERENCES SAMM_Model(id),
  CONSTRAINT fk_qq_assessmentquestion FOREIGN KEY(assessmentQuestion_id) REFERENCES AssessmentQuestion(id)
  );


-- -----------------------------------------------------
-- Table QuestionResponse
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS QuestionResponse (
  assessmentQuestion_id VARCHAR(128) NOT NULL,
  answerSet_id VARCHAR(128) NOT NULL,
  PRIMARY KEY (assessmentQuestion_id, answerSet_id),
  CONSTRAINT fk_qr_assessmentquestion FOREIGN KEY(assessmentQuestion_id) REFERENCES AssessmentQuestion(id),
  CONSTRAINT fk_qr_answerset FOREIGN KEY(answerSet_id) REFERENCES AnswerSet(id)
  );


-- -----------------------------------------------------
-- Table AssessPractice
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS AssessPractice (
  assessment_id INTEGER NOT NULL,
  securityPractice_id VARCHAR(128) NOT NULL,
  maturityscore DECIMAL(3) NOT NULL,
  PRIMARY KEY (assessment_id, securityPractice_id),
  CONSTRAINT fk_ap_assessment FOREIGN KEY(assessment_id) REFERENCES Assessment(id),
  CONSTRAINT fk_ap_securitypractice FOREIGN KEY(securityPractice_id) REFERENCES SecurityPractice(id)
  );


-- -----------------------------------------------------
-- Table Answer
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Answer (
  id VARCHAR(128) PRIMARY KEY,
  text VARCHAR(256) NOT NULL,
  value DECIMAL(3) NOT NULL,
  weight DECIMAL(3),
  ordinal INTEGER NOT NULL
  );


-- -----------------------------------------------------
-- Table AssessedQuestion
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS AssessedQuestion (
  assessment_id INTEGER NOT NULL,
  assessmentQuestion_id VARCHAR(128) NOT NULL,
  answer_id VARCHAR(128) NOT NULL,
  priority VARCHAR(45),
  notes VARCHAR(2000),
  PRIMARY KEY (assessment_id, assessmentQuestion_id),
  CONSTRAINT fk_aq_assessment FOREIGN KEY(assessment_id) REFERENCES Assessment(id),
  CONSTRAINT fk_aq_assessmentquestion FOREIGN KEY(assessmentQuestion_id) REFERENCES AssessmentQuestion(id),
  CONSTRAINT fk_aq_answer FOREIGN KEY(answer_id) REFERENCES Answer(id)
  );


-- -----------------------------------------------------
-- Table AnswerMap
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS AnswerMap (
  answerSet_id VARCHAR(128) NOT NULL,
  answer_id VARCHAR(128) NOT NULL,
  PRIMARY KEY (answerSet_id, answer_id),
  CONSTRAINT fk_am_answerset FOREIGN KEY(answerSet_id) REFERENCES AnswerSet(id),
  CONSTRAINT fk_am_answer FOREIGN KEY(answer_id) REFERENCES Answer(id)
  );


-- -----------------------------------------------------
-- Table AssessorOrganization
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS AssessorOrganization (
  assessor_id INTEGER NOT NULL,
  organization_id INTEGER NOT NULL,
  PRIMARY KEY (assessor_id, organization_id),
  CONSTRAINT fk_ao_assessor FOREIGN KEY(assessor_id) REFERENCES Assessor(id),
  CONSTRAINT fk_ao_organization FOREIGN KEY(organization_id) REFERENCES Organization(id)
  );
