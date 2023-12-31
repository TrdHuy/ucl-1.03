@echo // Copyright (C) 1996-2004 Markus F.X.J. Oberhumer
@echo //
@echo //   Windows 64-bit (AMD64 or Itanium)
@echo //   Microsoft Visual C/C++ (DLL)
@echo //
@call b\prepare.bat
@if "%BECHO%"=="n" echo off


set CC=cl -nologo -MD
set CF=-O2 -GF -W4 %CFI%
set LF=%BLIB%

%CC% %CF% -D__UCL_EXPORT1#__declspec(dllexport) -c @b\src.rsp
@if errorlevel 1 goto error1
%CC% -LD -Fe%BDLL% @b\win64\vc.rsp /link /map /def:b\win64\vc_dll.def
@if errorlevel 1 goto error2

%CC% %CF% examples\simple.c %LF%
@if errorlevel 1 goto error3
%CC% %CF% examples\uclpack.c %LF%
@if errorlevel 1 goto error4


@call b\done.bat
@goto end

:error1
@echo ERROR during compilation of source files!
@goto end

:error2
@echo ERROR during linking of static library!
@goto end

:error3
@echo ERROR during compilation of examples\simple.c!
@goto end

:error4
@echo ERROR during compilation of examples\uclpack.c!
@goto end

:end
@call b\unset.bat
