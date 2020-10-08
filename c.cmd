@echo off
if x%VY_ALIAS_BATCH_GEN_NO_DEBUG%==xtransfer GOTO label_transfer_start

REM '1st call' mode
set VY_ALIAS_BATCH_GEN_NO_DEBUG=y
if NOT x%1==xdebug GOTO label_start

REM 'debug' mode
echo Debug mode on
set VY_ALIAS_BATCH_GEN_NO_DEBUG=transfer
%0 %2 %3 %4 %5 %6 %7 %8 %9
GOTO label_exit

REM 'transfer' mode. Here we debug by setting VY_ALIAS_BATCH_GEN_NO_DEBUG=<blank>
:label_transfer_start
echo Tranferred into batchfile sub call
set VY_ALIAS_BATCH_GEN_NO_DEBUG=
if x%VY_ALIAS_BATCH_GEN_NO_DEBUG%==x echo arguments    :: (0, '%0') (1, '%1') (2, '%2') (3, '%3') (4, '%4') (5, '%5') (6, '%6') (7, '%7') (8, '%8') (9, '%9')
if x%VY_ALIAS_BATCH_GEN_NO_DEBUG%==x echo command line :: %0 %1 %2 %3 %4 %5 %6 %7 %8 %9
echo ##############################################################
GOTO label_start

##############################################################
REM Actual start of the program
:label_start

:label_Switcher
if x%VY_ALIAS_BATCH_GEN_NO_DEBUG%==x echo label_Switcher & REM (Switcher) <- (c_help)
if x%1==xh         GOTO label_c_help
if x%1==x          GOTO label_c_help
if x%1==x-h        GOTO label_c_help
if x%1==x--help    GOTO label_c_help
if x%1==xv         GOTO label_c_v
if x%1==xinfo      GOTO label_c_info
if x%1==xe         GOTO label_c_e
if x%1==xc         GOTO label_c_c
if x%1==xcn        GOTO label_c_cn
if x%1==xa         GOTO label_c_a
if x%1==xd         GOTO label_c_d
if x%1==xl         GOTO label_c_l
if x%1==xs         GOTO label_c_s
if x%1==xi         GOTO label_c_i
if x%1==xic        GOTO label_c_ic
if x%1==xidr       GOTO label_c_idr
if x%1==xu         GOTO label_c_u
if x%1==xr         GOTO label_c_r
if x%1==xdel       GOTO label_c_r
if x%1==xcon       GOTO label_c_con
GOTO label_invalid & REM (Switcher) <- (c_con)
:label_c_e
if x%VY_ALIAS_BATCH_GEN_NO_DEBUG%==x echo label_c_e & REM (c_e) <- (c_e_l)
if x%2==xl         GOTO label_c_e_l
if x%2==xr         GOTO label_c_e_r
if x%2==xrm        GOTO label_c_e_r
if x%2==xdel       GOTO label_c_e_r
GOTO label_invalid & REM (c_e) <- (c_e_r)
:label_c_con
if x%VY_ALIAS_BATCH_GEN_NO_DEBUG%==x echo label_c_con & REM (c_con) <- (c_con_ch)
if x%2==xch        GOTO label_c_con_ch
if x%2==xs         GOTO label_c_con_s
GOTO label_invalid & REM (c_con) <- (c_con_s)
:label_c_con_ch
if x%VY_ALIAS_BATCH_GEN_NO_DEBUG%==x echo label_c_con_ch & REM (c_con_ch) <- (c_con_ch_a)
if x%3==xa         GOTO label_c_con_ch_a
if x%3==xadd       GOTO label_c_con_ch_a
if x%3==xp         GOTO label_c_con_ch_p
if x%3==xprepend   GOTO label_c_con_ch_p
GOTO label_invalid & REM (c_con_ch) <- (c_con_ch_p)

##############################################################
:label_invalid
echo Invalid command. Type '%0 h' to get help
GOTO label_exit

##############################################################
:label_c_help
@echo on
@echo Command Options:
@echo   c h           : This help message
@echo   c v           : conda --version
@echo   c info        : conda info
@echo   c e l         : conda env list
@echo   c e r         : conda env remove --name ^<env_name^>
@echo   c c           : conda create --prefix .\.condaEnv
@echo   c cn          : conda create --name ^<env_name^>
@echo   c a           : conda activate ^<env_name^>
@echo   c d           : conda config --set env_prompt "({default_env}) "
@echo   c l           : conda list : packages in environment
@echo   c s           : conda search ^<package_name_pattern^>
@echo   c i           : conda install ^<package_name_1^> ^<package_name_2^> ...
@echo   c ic          : conda install -c ^<channel^> ^<package_name^>
@echo   c idr         : conda install --dry-run ^<package_name_1^> ^<package_name_2^> ...
@echo   c u           : conda update --all
@echo   c r           : conda remove ^<package_name_1^> ^<package_name_2^> ...
@echo   c con ch a    : conda config --append channels ^<channel^>
@echo   c con ch p    : conda config --prepend channels ^<channel^>
@echo   c con s       : conda config --show
@echo.
@echo off
GOTO label_exit

##############################################################
:label_c_v
@echo on
conda --version
@echo off
GOTO label_exit

##############################################################
:label_c_info
@echo on
conda info
@echo off
GOTO label_exit

##############################################################
:label_c_e_l
@echo on
conda env list
@echo off
GOTO label_exit

##############################################################
:label_c_e_r
@echo on
conda env remove --name <env_name>
@echo off
GOTO label_exit

##############################################################
:label_c_c
@echo on
conda create --prefix .\.condaEnv
conda config --set env_prompt "({name}) "
conda activate .\.condaEnv
@echo off
GOTO label_exit

##############################################################
:label_c_cn
@echo on
conda create --name <env_name>
@echo off
GOTO label_exit

##############################################################
:label_c_a
@echo on
conda activate <env_name>
@echo off
GOTO label_exit

##############################################################
:label_c_d
@echo on
conda config --set env_prompt "({default_env}) "
deactivate
@echo off
GOTO label_exit

##############################################################
:label_c_l
@echo on
conda list
@echo off
GOTO label_exit

##############################################################
:label_c_s
@echo on
conda search <package_name_pattern>
@echo off
GOTO label_exit

##############################################################
:label_c_i
@echo on
conda install <package_name_1> <package_name_2> %2 %3 %4 %5 %6 %7 %8 %9
@echo off
GOTO label_exit

##############################################################
:label_c_ic
@echo on
conda install -c %2 <package_name>
@echo off
GOTO label_exit

##############################################################
:label_c_idr
@echo on
conda install --dry-run <package_name_1> <package_name_2> %2 %3 %4 %5 %6 %7 %8 %9
@echo off
GOTO label_exit

##############################################################
:label_c_u
@echo on
conda update --all
@echo off
GOTO label_exit

##############################################################
:label_c_r
@echo on
conda remove <package_name_1> <package_name_2> %2 %3 %4 %5 %6 %7 %8 %9
@echo off
GOTO label_exit

##############################################################
:label_c_con_ch_a
@echo on
conda config --append channels %4
@echo off
GOTO label_exit

##############################################################
:label_c_con_ch_p
@echo on
conda config --prepend channels %4
@echo off
GOTO label_exit

##############################################################
:label_c_con_s
@echo on
conda config --show
@echo off
GOTO label_exit

##############################################################
:label_exit