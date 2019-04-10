MusicStore (test application)
=============================

AppVeyor: [![AppVeyor][appveyor-badge]][appveyor-build]

Travis:   [![Travis][travis-badge]][travis-build]

[appveyor-badge]: https://ci.appveyor.com/api/projects/status/ja8a7j6jscj7k3xa/branch/dev?svg=true
[appveyor-build]: https://ci.appveyor.com/project/aspnetci/MusicStore/branch/dev
[travis-badge]: https://travis-ci.org/aspnet/MusicStore.svg?branch=dev
[travis-build]: https://travis-ci.org/aspnet/MusicStore

This project is part of ASP.NET Core. You can find samples, documentation and getting started instructions for ASP.NET Core at the [Home](https://github.com/aspnet/home) repo.

## About this repo

This repository is a test application used for ASP.NET Core internal test processes.
It is not intended to be a representative sample of how to use ASP.NET Core.

Samples and docs for ASP.NET Core can be found here: <https://docs.asp.net>.

## Deploying MusicStore app via Octopus

![It works!](https://github.com/astepchenko/DevOps2019/blob/task5/stuff/deploy.gif)

## Useful commands

### Install choco
```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

### Install packages
```
choco install dotnetcore-sdk --version 2.0 -y
choco install dotnetfx -y
choco install sql-server-express -y
choco install sql-server-management-studio -y
choco install octopusdeploy -y
choco install octopusdeploy.tentacle -y
choco install octopustools -y
choco install jenkins -y
choco install git -y
```

### Build app
```
dotnet publish --framework netcoreapp2.0 --output app
octo pack app --id=MusicStore --format=Zip --version=0.0.1 --basePath=.\samples\MusicStore\app
octo push --package MusicStore.0.0.1.zip --replace-existing --server http://localhost --apiKey API-OYYHRF0SLURPH4JGJALFODDW3FY
octo create-release --project MusicStore Project --server http://localhost --apiKey API-OYYHRF0SLURPH4JGJALFODDW3FY
```

### Run app
```
cd .\samples\MusicStore\bin\Debug\netcoreapp2.0\publish
dotnet MusicStore.dll
```