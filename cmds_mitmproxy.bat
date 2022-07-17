cd %USERPROFILE%\Desktop

curl -l https://snapshots.mitmproxy.org/8.1.1/mitmproxy-8.1.1-windows-x64-installer.exe -o %TEMP%\mitmp.exe
%TEMP%\mitmp.exe --unattendedmodeui minimal --mode unattended

curl -L https://www.proxifier.com/download/ProxifierPE.zip -o %TEMP%\pf.zip
tar -xf %TEMP%\pf.zip

curl -l https://www.python.org/ftp/python/3.9.11/python-3.9.11-amd64.exe -o %TEMP%\p.exe
%TEMP%\p.exe /quiet InstallAllUsers=1 PrependPath=1

netsh advfirewall firewall add rule name="mitmdump" dir=in program="C:\Program Files\mitmproxy\bin\mitmdump.exe" profile=public action=allow
start /b "mitmproxy service" "C:\Program Files\mitmproxy\bin\mitmdump.exe" -s C:\Users\WDAGUtilityAccount\Desktop\addon.py

start "Proxifier Starter" "%USERPROFILE%\Desktop\Proxifier PE\Proxifier.exe" %USERPROFILE%\Desktop\proxyprofile.ppx :0 -clipboard -multiwindow
timeout /t 5 /nobreak
taskkill /IM Proxifier.exe
timeout /t 5 /nobreak
taskkill /IM Proxifier.exe

timeout /t 10 /nobreak

curl -x "http://localhost:8080" "http://mitm.it/cert/cer" -o mitmproxy-cert.cer
certutil.exe -addstore root mitmproxy-cert.cer