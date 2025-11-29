# obs-upload
Github Action to upload files to OBS (Open Build Service).

## Inputs
**apiurl**  
optional, default to `https://api.opensuse.org`.

**username**  
required.

**password**  
required.

**project**  
required.

**package**  
required.

**files**  
required, space-separated glob patterns.

## Example
```yml
steps:
  - name: Upload to OBS
    uses: beavailable/obs-upload@main
    with:
      username: test-name
      password: ${{ secrets.OBS_PASSWORD }}
      project: test-project
      package: test-package
      files: ./*.txt ./*.tar.xz
```
