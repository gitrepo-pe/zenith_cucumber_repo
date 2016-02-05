rem Get date time to set in filename
set "param1=%1"
rem set "param2=%2"
setlocal EnableDelayedExpansion
if "!param1!"=="" ( set UserRole='CSMAdmin' ) else (set UserRole='%param1%')
rem if "!param2!"=="" ( set tagname=@SuccessPlanFeature ) else (set tagname=%param2%)
set _my_datetime=%date%_%time%
set _my_datetime=%_my_datetime: =_%
set _my_datetime=%_my_datetime::=%
set _my_datetime=%_my_datetime:/=_%
set _my_datetime=%_my_datetime:.=_%
rem set filename for results file
set _filename=Result\result%_my_datetime%.html
rem set _errfilename=temp\result%_my_datetime%.html

rem navigage to the directory where the batch file and scripts exists
cd /d %~dp0
 cucumber feature -r feature --format html --out %_filename% --tags @US-003041_1,@US-003081_1,@US-003042_1,@US-003044_1,@US-003047,@US-003048,@US-003050,@US-003053_1,@US-003055_1,@US-003056_1,@US-003057_1,@US-003054_1,@US-003052,@US-003082,@US-003058_1,@US-003057_1,@US-003040,@US-003045_1,@US-003046_1,@US-003057_1,@US-003054_1,@US-003052,@US-003082,US-003043_1,US-003043_2,@US-002978_1,@US-003060,@US-003061,@US-003062  UserRole='Operations Rep'

