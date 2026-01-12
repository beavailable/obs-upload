# obs-upload
Github Action to upload files to OBS (Open Build Service).

**Note** that it'll remove all files in a package before uploading new files.

## Inputs
**apiurl**  
Optional, default `https://api.opensuse.org`.

**username**  
Required.

**password**  
Required.

**project**  
Required.

**package**  
Required.

**pre-run**: Run some commands before everything.  
Optional, default: `""`.

**type**  
Optional, default `""`.  
Available types:
- `deb` (only `3.0 (native)` and `3.0 (quilt)` are supported formats)

**files**  
Optional, space-separated glob patterns, default `""`.

## Example
```yml
steps:
  - name: Upload to OBS
    uses: beavailable/obs-upload@main
    with:
      username: beavailable
      password: ${{ secrets.OBS_PASSWORD }}
      project: home:beavailable
      package: example-package
      files: *.txt ./example-file.*
```
