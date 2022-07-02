cd %USERPROFILE%\Desktop\
mkdir PolarProxy
curl -L https://www.netresec.com/?download=PolarProxy_win-x64 -o %TEMP%\pp.zip
tar -C PolarProxy -xf %TEMP%\pp.zip
curl -L https://www.netresec.com/?download=NetworkMiner -o %TEMP%\nm.zip
tar -xf %TEMP%\nm.zip
curl -L https://www.proxifier.com/download/ProxifierPE.zip -o %TEMP%\pf.zip
tar -xf %TEMP%\pf.zip
curl -L https://download.visualstudio.microsoft.com/download/pr/df4372ca-82c8-4bfa-acf9-c49e27279e7e/6bddefd26964017ff520dc1443029e04/dotnet-runtime-6.0.1-win-x64.exe -o %TEMP%\dotnet-runtime.exe
%TEMP%\dotnet-runtime.exe /install /quiet /norestart
start cmd /c "%USERPROFILE%\Desktop\PolarProxy\PolarProxy.exe --pcapoverip 57012 -x ./proxyroot.cer --socks 1080 --httpconnect 8080 --allownontls -p 443,80 --insecure"
powershell "dir -Path $home\Desktop -filter *.cer | Import-Certificate -CertStoreLocation cert:\localmachine\root"