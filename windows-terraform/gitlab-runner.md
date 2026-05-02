# GitLab Runner Install on Windows

Use these commands on the Windows Server instance to install GitLab Runner.

1. Create the runner directory and download the GitLab Runner binary:
```powershell
New-Item -ItemType Directory -Force -Path "C:\GitLab-Runner"
Invoke-WebRequest -Uri "https://s3.dualstack.us-east-1.amazonaws.com/gitlab-runner-downloads/latest/binaries/gitlab-runner-windows-amd64.exe" -OutFile "C:\GitLab-Runner\gitlab-runner.exe"
```

2. Install GitLab Runner as a service:
```powershell
& "C:\GitLab-Runner\gitlab-runner.exe" install --working-directory "C:\GitLab-Runner"
& "C:\GitLab-Runner\gitlab-runner.exe" start
```

3. Register the runner with GitLab:

### Preferred (new workflow)
Create the runner in the GitLab UI or API first, then use the runner authentication token.

```powershell
& "C:\GitLab-Runner\gitlab-runner.exe" register --non-interactive --url "https://gitlab.example.com/" --token "REPLACE_WITH_AUTH_TOKEN" --executor "shell" --shell "powershell"
```

If `pwsh` is not installed on your Windows Server Core image, use the Windows PowerShell shell instead:

```powershell
& "C:\GitLab-Runner\gitlab-runner.exe" register --non-interactive --url "https://gitlab.example.com/" --token "REPLACE_WITH_AUTH_TOKEN" --executor "shell" --shell "powershell"
```

If that still fails because `pwsh` is not available on the image, use `--shell "cmd"` instead or install PowerShell Core (`pwsh`).

### Legacy registration token (deprecated)
If you have to use the legacy registration token workflow, use `-r`/`--registration-token` rather than `-t`/`--token`:

```powershell
& "C:\GitLab-Runner\gitlab-runner.exe" register --non-interactive --url "https://gitlab.example.com/" --registration-token "REPLACE_WITH_REGISTRATION_TOKEN" --executor "shell" --shell "powershell" --description "windows-gitlab-runner" --tag-list "windows,gitlab-runner" --run-untagged="true" --locked="false"
```

Or using the short form:

```powershell
& "C:\GitLab-Runner\gitlab-runner.exe" register --non-interactive --url "https://gitlab.example.com/" -r "REPLACE_WITH_REGISTRATION_TOKEN" --executor "shell" --shell "powershell" --description "windows-gitlab-runner" --tag-list "windows,gitlab-runner" --run-untagged="true" --locked="false"
```

If that still fails because `pwsh` is not available on the image, use `--shell "cmd"` instead or install PowerShell Core (`pwsh`).

1. Verify the service is running:
```powershell
Get-Service gitlab-runner
```

## Placeholder values
- `https://gitlab.example.com/` → replace with your GitLab instance URL
- `REPLACE_WITH_AUTH_TOKEN` → replace with your runner authentication token

## Notes
- If you want to use a different executor, change `--executor "shell"` to the appropriate value, such as `powershell`, `docker`, or `docker-windows`.
- If you need to run the runner as a specific Windows user, configure the service accordingly after installation.
