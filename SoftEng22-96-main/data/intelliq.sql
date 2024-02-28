DROP DATABASE if exists intelliq;
CREATE DATABASE if not exists intelliq;
USE intelliq;
CREATE TABLE if not exists `intelliq`.`questionnaire` (
    `questionnaireID` VARCHAR(45) NOT NULL,
    `questionnaireTitle` VARCHAR(255) NULL,
    `NoQuestions` INT NULL,
    PRIMARY KEY (`questionnaireID`)
);

CREATE TABLE if not exists `intelliq`.`keyword`(
    #`keywordID` int NOT NULL AUTO_INCREMENT,
    `Keywords` VARCHAR(45) NULL,
    `questionnaireID` VARCHAR(45),
    PRIMARY KEY (`Keywords`,`questionnaireID`),
    CONSTRAINT `FK_questionnaire_keyword` FOREIGN KEY (`questionnaireID`)
    REFERENCES `questionnaire`(`questionnaireID`)
);

CREATE TABLE if not exists `intelliq`.`question`(
    `questionnaireID` VARCHAR(45) NOT NULL,
    `qID` VARCHAR(45) NOT NULL,
    `qText` VARCHAR(255) NULL,
    `type` VARCHAR(8) NULL,
    `NoOptions`  INT NULL,
    `required` VARCHAR(5) NOT NULL,
    PRIMARY KEY (`qID`,`questionnaireID`),
    CONSTRAINT `FK_questionnaire_question` FOREIGN KEY (`questionnaireID`)
    REFERENCES `questionnaire`(`questionnaireID`)
);

CREATE TABLE if not exists `intelliq`.`option`(
    `questionnaireID` VARCHAR(45) NOT NULL,
    `qID` VARCHAR(45) NOT NULL,
    `optID` VARCHAR(45) NOT NULL,
    `opttxt`  VARCHAR(255) NOT NULL,
    `nextqID` VARCHAR(45) NULL,
    PRIMARY KEY (`optID`, `qID`,`questionnaireID`),
    CONSTRAINT `FK_question_option_questionnaireID` FOREIGN KEY (`questionnaireID`)
    REFERENCES `question`(`questionnaireID`),
    CONSTRAINT `FK_question_option_qID` FOREIGN KEY (`qID`)
    REFERENCES `question`(`qID`)
);

CREATE TABLE if not exists `intelliq`.`session`(
	`sessionID` VARCHAR(45) NOT NULL,
    `questionnaireID` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`sessionID`,`questionnaireID`),
    CONSTRAINT `FK_questionnaire_session_questionnaireID` FOREIGN KEY (`questionnaireID`)
    REFERENCES `questionnaire`(`questionnaireID`)
);

CREATE TABLE if not exists `intelliq`.`answer`(
	`answerID` INT NOT NULL AUTO_INCREMENT,
    `sessionID` VARCHAR(45) NOT NULL,
    `optID` VARCHAR(45) NOT NULL,
    `questionnaireID` VARCHAR(45) NOT NULL,
    `qID` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`answerID`,`sessionID`,`optID`,`questionnaireID`),
    CONSTRAINT `FK_option_answer_questionnaireID` FOREIGN KEY (`questionnaireID`)
    REFERENCES `option`(`questionnaireID`),
    CONSTRAINT `FK_option_answer_qID` FOREIGN KEY (`qID`)
    REFERENCES `option`(`qID`),
	CONSTRAINT `FK_option_answer_optID` FOREIGN KEY (`optID`)
    REFERENCES `option`(`optID`),
    CONSTRAINT `FK_session_answer_optID` FOREIGN KEY (`sessionID`)
    REFERENCES `session`(`sessionID`)
);

-- TRUNCATE `intelliq`.`keyword`;
-- TRUNCATE `intelliq`.`answer`;
-- DELETE FROM `intelliq`.`option`;
-- DELETE FROM `intelliq`.`question`;
-- DELETE FROM `intelliq`.`questionnaire`;




