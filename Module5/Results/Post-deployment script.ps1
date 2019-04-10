powershell -executionpolicy RemoteSigned -WindowStyle Hidden "start dotnet MusicStore.dll"
sleep 30
write-host $(invoke-webrequest -uri "http://localhost:5000" -UseBasicParsing).statuscode
Taskkill /IM dotnet.exe /F