```bash
cat extensions.txt | xargs -L 1 code --install-extension
```

```powershell
Get-Content extensions.txt | ForEach-Object { code --install-extension $_ }
```
