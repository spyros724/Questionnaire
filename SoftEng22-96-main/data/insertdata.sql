USE intelliq;
ALTER DATABASE intelliq CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
INSERT IGNORE INTO `intelliq`.`questionnaire` (`questionnaireID`, `questionnaireTitle`, `NoQuestions`) 
VALUES ("42", "Football Fans", 8),
("17","Baskeeet",8),
("QQ000", "My first research questionnaire", 11),
("QQ001", "Food Questionnaire", 9),
("QQ002", "Hobbies", 9);

INSERT IGNORE INTO `intelliq`.`keyword` (`Keywords`, `questionnaireID`) 
VALUES ("sport","42"),
("football","42"),
("ball","42"),
("ball","17"),
("basket","17"),
("football", "QQ000"),
("timezone", "QQ000"),
("islands", "QQ000"),
("food", "QQ001"),
("sport", "QQ002"),
("hobby", "QQ002");

#Questionnaire 1
INSERT IGNORE INTO `intelliq`.`question` (`qID`, `qText`, `NoOptions`, `required`,`type`,`questionnaireID`) 
VALUES ("p1","Are you male or female?","2",true, "profile", "QQ001"),
("p2","Select your age group","4",true, "profile", "QQ001"),
("q1","Do you prefer homemade food or Fast-Food?","2",true, "question", "QQ001"),
("q2","Do you prefer ethnic or more bland food?","2",true, "question", "QQ001"),
("q3","Do you use seasoning when you cook your food?","2",true, "question", "QQ001"),
("q4","What is your favorite cuisine?","3",true, "question", "QQ001"),
("q5","Do you enjoy traveling the world?","2",true, "question", "QQ001"),
("q6","Do you travel to try food from different countries?","2",false, "question", "QQ001"),
("q7","Do you have any food alergies?","2",true, "question", "QQ001");

INSERT IGNORE INTO `intelliq`.`option` (`qID`, `opttxt`, `optID`, `nextqID`,`questionnaireID`)
VALUES ("p1","Man !","o1","p2","QQ001"),
("p1","Woman!","o2","p2","QQ001"),
("p2","<18","o1","q1","QQ001"),
("p2","18-35","o2","q1","QQ001"),
("p2","36-55","o3","q1","QQ001"),
("p2",">56","o4","q1","QQ001"),
("q1","Home-made","o1","q3","QQ001"),
("q1","Fast-Food","o2","q2","QQ001"),
("q2","Ethnic","o1","q4","QQ001"),
("q2","Bland","o2","q3","QQ001"),
("q3","Yes","o1","q7","QQ001"),
("q3","Not really","o2","q7","QQ001"),
("q4","Greek","o1","q5","QQ001"),
("q4","Mexican","o2","q5","QQ001"),
("q4","Chinese","o3","q5","QQ001"),
("q5","Yes","o1","q6","QQ001"),
("q5","Not really","o2","q7","QQ001"),
("q6","Yes","o1","q7","QQ001"),
("q6","No","o2","q7","QQ001"),
("q7","yes","o1","-","QQ001"),
("q7","no","o2","-","QQ001");

#Questionnaire 2
INSERT IGNORE INTO `intelliq`.`question` (`qID`, `qText`, `NoOptions`, `required`,`type`,`questionnaireID`) 
VALUES ("p1","Are you male or female?","2",true, "profile", "QQ002"),
("p2","Select your age group","4",true, "profile", "QQ002"),
("q1","Do you have free time for hobbies?","2",true, "question", "QQ002"),
("q2","Are you an athletic person?","2",true, "question", "QQ002"),
("q3","What sport do you do","4",true, "question", "QQ002"),
("q4","Are you an artistic person?","2",true, "question", "QQ002"),
("q5","Do you have art related hobbies?","2",true, "question", "QQ002"),
("q6","do you prefer company while hobbying or to be alone?","2",false, "question", "QQ002"),
("q7","What do you do with the majority of your time?","2",true, "question", "QQ002");

INSERT IGNORE INTO `intelliq`.`option` (`qID`, `opttxt`, `optID`, `nextqID`,`questionnaireID`)
VALUES ("p1","Man !","o1","p2","QQ002"),
("p1","Woman!","o2","p2","QQ002"),
("p2","<18","o1","q1","QQ002"),
("p2","18-35","o2","q1","QQ002"),
("p2","36-55","o3","q1","QQ002"),
("p2",">56","o4","q1","QQ002"),
("q1","Yes, thankfully","o1","q2","QQ002"),
("q1","Sadly, no","o2","q7","QQ002"),
("q2","Yes","o1","q3","QQ002"),
("q2","Not really","o2","q4","QQ002"),
("q3","Football","o1","q4","QQ002"),
("q3","Basketball","o2","q4","QQ002"),
("q3","Tennis","o3","q4","QQ002"),
("q3","Other","o4","q4","QQ002"),
("q4","Yes","o1","q5","QQ002"),
("q4","No","o2","q6","QQ002"),
("q5","Painting","o1","q6","QQ002"),
("q5","Dancing","o2","q6","QQ002"),
("q5","Playing Music","o3","q6","QQ002"),
("q5","Sculpting","o4","q6","QQ002"),
("q6","Company","o1","q7","QQ002"),
("q6","Alone","o2","q7","QQ002"),
("q7","Work","o1","-","QQ002"),
("q7","Nothing","o2","-","QQ002");

#Questionnaire 3
INSERT IGNORE INTO `intelliq`.`question` (`qID`, `qText`, `NoOptions`, `required`,`type`,`questionnaireID`) 
VALUES ("p1","Are you male or female?","2",true, "profile", "42"),
("q1","Do you like Football?","2",true, "question", "42"),
("q2","Is it called Football or Soccer?","2",true, "question", "42"),
("q3","Greek Fooball or EuroCup?","2",true, "question", "42"),
("q4","IS better AEK or ASTERAS_Threepolis or PANAHAIK?","3",true, "question", "42"),
("q5","Liverpool or Something_Spanish","2",true, "question", "42"),
("q6","You say Soccer, what are you, American?","2",true, "question", "42"),
("q7","Did you have play sports with your father?","2",false, "question", "42");

INSERT IGNORE INTO `intelliq`.`option` (`qID`, `opttxt`, `optID`, `nextqID`,`questionnaireID`)
VALUES ("p1","Men !","o1","q1","42"),
("p1","Women!","o2","q1","42"),
("q1","yEs!","o1","q2","42"),
("q1","No:(","o2","q7","42"),
("q2","Football","o1","q3","42"),
("q2","Soccer","o2","q6","42"),
("q3","Elladara re","o1","q4","42"),
("q3","euromudial","o2","q5","42"),
("q4","AEKARAAAA","o1","q7","42"),
("q4","ASTERAra","o2","q7","42"),
("q4","Panahaik","o3","q7","42"),
("q5","LIver","o1","q7","42"),
("q5","Real MAdrid","o2","q7","42"),
("q6","No sir","o1","q7","42"),
("q6","USA USA USa","o2","q7","42"),
("q7","no :(","o1","-","42"),
("q7","yes :)","o2","-","42");

#Questionnaire 4
INSERT IGNORE INTO `intelliq`.`question` (`qID`, `qText`, `NoOptions`, `required`,`type`,`questionnaireID`) 
VALUES ("p1","Are you male or female","2",true, "profile", "17"),
("q1","Do you like Football?","2",true, "question", "17"),
("q2","Football or Baskeeeeeet, hmm?","2",true, "question", "17"),
("q3","What is the best shape of ball?","2",true, "question", "17"),
("q4","What kind of geometry do you live in?","3",true, "question", "17"),
("q5","optimal number of ball","2",true, "question", "17"),
("q6","are you an athlete?","2",true, "question", "17"),
("q7","did you have a mother figure in your life","2",false, "question", "17");

INSERT IGNORE INTO `intelliq`.`option` (`qID`, `opttxt`, `optID`, `nextqID`,`questionnaireID`)
VALUES ("p1","i am man","o1","q1","17"),
("p1","Women!","o2","q1","17"),
("q1","yEs!","o1","q2","17"),
("q1","No:(","o2","q2","17"),
("q2","Fotball","o1","q7","17"),
("q2","Baskeballs","o2","q3","17"),
("q3","round","o1","q5","17"),
("q3","square","o2","q4","17"),
("q4","euclidean","o1","q5","17"),
("q4","hyperbolic","o2","q5","17"),
("q4","ball geometry","o3","q5","17"),
("q5","no ballz","o1","q6","17"),
("q5","1","o2","q6","17"),
("q5","five","o3","q6","17"),
("q5","27","o4","q6","17"),
("q5","6420","o5","q6","17"),
("q6","yes i am","o1","q7","17"),
("q6","not really","o2","q7","17"),
("q7","no :)","o1","-","17"),
("q7","yes :(","o2","-","17");

#Questionnaire 5
INSERT IGNORE INTO `intelliq`.`question` (`qID`, `qText`, `NoOptions`, `required`,`type`,`questionnaireID`) 
VALUES ("P00","Ποιο είναι το mail σας;","1",false, "profile", "QQ000"),
("P01","Ποια είναι η ηλικία σας;","4",true, "profile", "QQ000"),
("Q01","Ποιο είναι το αγαπημένο σας χρώμα;","3",true, "question", "QQ000"),
("Q02","Ασχολείστε με το ποδόσφαιρό;","2",true, "question", "QQ000"),
("Q03","Τι ομάδα είστε;","3",true, "question", "QQ000"),
("Q04","Έχετε ζήσει σε νησί;","2",true, "question", "QQ000"),
("Q05","Δεδομένου της απάντησή σας: Ποια είναι η σχέση σας με το θαλάσσιο σκι;","3",true, "question", "QQ000"),
("Q06","Είστε χειμερινός κολυμβητής;","2",true, "question", "QQ000"),
("Q07","Κάνετε χειμερινό σκι;","3",true, "question", "QQ000"),
("Q08","Συμφωνείτε να αλλάζειη ώρα κάθε χρόνο;","2",true, "question", "QQ000"),
("Q09","Δεδομένου της απάντησή σας: Προτιμάτε τη θερίνη ή τη χειμρεινή ώρα;","2",true, "question", "QQ000");

INSERT IGNORE INTO `intelliq`.`option` (`qID`, `opttxt`, `optID`, `nextqID`,`questionnaireID`)
VALUES ("P00","<open string>","P00TXT","P01","QQ000"),
("P01","<30","P01A1","Q01","QQ000"),
("P01","30-50","P01A2","Q01","QQ000"),
("P01","50-70","P01A3","Q01","QQ000"),
("P01",">70","P01A4","Q01","QQ000"),
("Q01","Πράσινο","Q01A1","Q02","QQ000"),
("Q01","Κόκκινο","Q01A2","Q02","QQ000"),
("Q01","Κίτρινο","Q01A3","Q02","QQ000"),
("Q02","Ναι","Q02A1","Q03","QQ000"),
("Q02","Όχι","Q02A2","Q04","QQ000"),
("Q03","Πανάθα","Q03A1","Q04","QQ000"),
("Q03","Ολυμπιακός","Q03A2","Q04","QQ000"),
("Q03","ΑΕΚ","Q03A3","Q04","QQ000"),
("Q04","Ναι","Q04A1","Q05","QQ000"),
("Q04","Όχι","Q04A2","Q06","QQ000"),
("Q05","Καμία","Q05A1","Q07","QQ000"),
("Q05","Μικρή","Q05A2","Q07","QQ000"),
("Q05","Μεγάλη","Q05A3","Q07","QQ000"),
("Q06","Ναι","Q06A1","Q07","QQ000"),
("Q06","Όχι","Q06A2","Q07","QQ000"),
("Q07","Σπάνια-καθόλου","Q07A1","Q08","QQ000"),
("Q07","Περιστασιακά","Q07A2","Q08","QQ000"),
("Q07","Τακτικά","Q07A3","Q08","QQ000"),
("Q08","Ναι","Q08A1","Q09","QQ000"),
("Q08","Όχι","Q08A2","-","QQ000"),
("Q09","Θερίνη","Q09A1","-","QQ000"),
("Q09","Χειμερινή","Q09A2","-","QQ000");



INSERT IGNORE INTO `intelliq`.`session` (`sessionID`, `questionnaireID`) 
values ("asd3", "QQ001"),
("ad67", "QQ001"),
("KFI3", "QQ001"),
("Akf5", "QQ001"),
("aKE7", "QQ001"),
("ay45", "QQ001"),
("af63", "QQ001"),
("TUC3", "QQ001"),
("EG56", "QQ001"),
("Afr4", "QQ001"),
("Lkd5", "QQ001"),
("H4Yd", "QQ001"),
("kH34", "QQ001"),
("aK94", "QQ001"),
("qp4U", "QQ001"),
("1234", "QQ001");


# asd3
INSERT IGNORE INTO `intelliq`.`answer` (`sessionID`, `optID`, `qID`, `questionnaireID`)
values ("asd3", "o1", "p1", "QQ001"),
("asd3", "o1", "p2", "QQ001"),
("asd3", "o1", "q1", "QQ001"),
("asd3", "o2", "q3", "QQ001"),
("asd3", "o1", "q7", "QQ001");
 
# KFI3
INSERT IGNORE INTO `intelliq`.`answer` (`sessionID`, `optID`, `qID`, `questionnaireID`)
values ("KFI3", "o2", "p1", "QQ001"),
("KFI3", "o1", "p2", "QQ001"),
("KFI3", "o1", "q1", "QQ001"),
("KFI3", "o1", "q3", "QQ001"),
("KFI3", "o2", "q7", "QQ001");

# Akf5
INSERT IGNORE INTO `intelliq`.`answer` (`sessionID`, `optID`, `qID`, `questionnaireID`)
values ("Akf5", "o2", "p1", "QQ001"),
("Akf5", "o2", "p2", "QQ001"),
("Akf5", "o2", "q1", "QQ001"),
("Akf5", "o1", "q2", "QQ001"),
("Akf5", "o2", "q4", "QQ001"),
("Akf5", "o1", "q5", "QQ001"),
("Akf5", "o2", "q6", "QQ001"),
("Akf5", "o2", "q7", "QQ001");

# aKE7
INSERT IGNORE INTO `intelliq`.`answer` (`sessionID`, `optID`, `qID`, `questionnaireID`)
values ("aKE7", "o1", "p1", "QQ001"),
("aKE7", "o2", "p2", "QQ001"),
("aKE7", "o2", "q1", "QQ001"),
("aKE7", "o2", "q2", "QQ001"),
("aKE7", "o1", "q3", "QQ001"),
("aKE7", "o2", "q7", "QQ001");

# ay45
INSERT IGNORE INTO `intelliq`.`answer` (`sessionID`, `optID`, `qID`, `questionnaireID`)
values ("ay45", "o2", "p1", "QQ001"),
("ay45", "o3", "p2", "QQ001"),
("ay45", "o2", "q1", "QQ001"),
("ay45", "o1", "q2", "QQ001"),
("ay45", "o3", "q4", "QQ001"),
("ay45", "o1", "q5", "QQ001"),
("ay45", "o1", "q6", "QQ001"),
("ay45", "o1", "q7", "QQ001");

# af63
INSERT IGNORE INTO `intelliq`.`answer` (`sessionID`, `optID`, `qID`, `questionnaireID`)
values ("af63", "o1", "p1", "QQ001"),
("af63", "o4", "p2", "QQ001"),
("af63", "o2", "q1", "QQ001"),
("af63", "o1", "q2", "QQ001"),
("af63", "o3", "q4", "QQ001"),
("af63", "o1", "q5", "QQ001"),
("af63", "o1", "q6", "QQ001"),
("af63", "o1", "q7", "QQ001");

# TUC3
INSERT IGNORE INTO `intelliq`.`answer` (`sessionID`, `optID`, `qID`, `questionnaireID`)
values ("TUC3", "o2", "p1", "QQ001"),
("TUC3", "o2", "p2", "QQ001"),
("TUC3", "o2", "q1", "QQ001"),
("TUC3", "o1", "q2", "QQ001"),
("TUC3", "o1", "q4", "QQ001"),
("TUC3", "o1", "q5", "QQ001"),
("TUC3", "o2", "q6", "QQ001"),
("TUC3", "o1", "q7", "QQ001");

# EG56
INSERT IGNORE INTO `intelliq`.`answer` (`sessionID`, `optID`, `qID`, `questionnaireID`)
values ("EG56", "o2", "p1", "QQ001"),
("EG56", "o1", "p2", "QQ001"),
("EG56", "o2", "q1", "QQ001"),
("EG56", "o1", "q2", "QQ001"),
("EG56", "o1", "q4", "QQ001"),
("EG56", "o1", "q5", "QQ001"),
("EG56", "o2", "q6", "QQ001"),
("EG56", "o2", "q7", "QQ001");

# Afr4
INSERT IGNORE INTO `intelliq`.`answer` (`sessionID`, `optID`, `qID`, `questionnaireID`)
values ("Afr4", "o2", "p1", "QQ001"),
("Afr4", "o2", "p2", "QQ001"),
("Afr4", "o1", "q1", "QQ001"),
("Afr4", "o2", "q3", "QQ001"),
("Afr4", "o2", "q7", "QQ001");

# Lkd5
INSERT IGNORE INTO `intelliq`.`answer` (`sessionID`, `optID`, `qID`, `questionnaireID`)
values ("Lkd5", "o1", "p1", "QQ001"),
("Lkd5", "o3", "p2", "QQ001"),
("Lkd5", "o1", "q1", "QQ001"),
("Lkd5", "o1", "q3", "QQ001"),
("Lkd5", "o1", "q7", "QQ001");

# H4Yd
INSERT IGNORE INTO `intelliq`.`answer` (`sessionID`, `optID`, `qID`, `questionnaireID`)
values ("H4Yd", "o2", "p1", "QQ001"),
("H4Yd", "o2", "p2", "QQ001"),
("H4Yd", "o1", "q1", "QQ001"),
("H4Yd", "o1", "q3", "QQ001"),
("H4Yd", "o1", "q7", "QQ001");

# kH34
INSERT IGNORE INTO `intelliq`.`answer` (`sessionID`, `optID`, `qID`, `questionnaireID`)
values ("kH34", "o2", "p1", "QQ001"),
("kH34", "o3", "p2", "QQ001"),
("kH34", "o1", "q1", "QQ001"),
("kH34", "o2", "q3", "QQ001"),
("kH34", "o1", "q7", "QQ001");

# aK94
INSERT IGNORE INTO `intelliq`.`answer` (`sessionID`, `optID`, `qID`, `questionnaireID`)
values ("aK94", "o2", "p1", "QQ001"),
("aK94", "o3", "p2", "QQ001"),
("aK94", "o1", "q1", "QQ001"),
("aK94", "o1", "q3", "QQ001"),
("aK94", "o1", "q7", "QQ001");

# qp4U
INSERT IGNORE INTO `intelliq`.`answer` (`sessionID`, `optID`, `qID`, `questionnaireID`)
values ("qp4U", "o2", "p1", "QQ001"),
("qp4U", "o3", "p2", "QQ001"),
("qp4U", "o1", "q1", "QQ001"),
("qp4U", "o1", "q3", "QQ001"),
("qp4U", "o2", "q7", "QQ001");
