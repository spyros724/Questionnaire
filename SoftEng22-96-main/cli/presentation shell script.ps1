se2296 healthcheck --format json

se2296 questionnaire --questionnaire_id QQ001 --format json

se2296 doanswer --questionnaire_id QQ001 --question_id p1 --session_id 'aaaa' --option_id o1 --format json

Write-Host -NoNewLine 'Group by session_id aaaa to view the results';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

# group by session_id aaaa

se2296 getsessionanswers --questionnaire_id QQ001 --session_id aaaa --format json

se2296 resetall --format json

Write-Host -NoNewLine 'Check out the database';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

# show db

se2296 questionnaire_upd --source serious.json --format json

Write-Host -NoNewLine 'Check out questionnaire QQ000';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

# show questionnaire QQ000

se2296 questionnaire --questionnaire_id QQ000 --format json

Write-Host -NoNewLine 'Press any key to exit';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');