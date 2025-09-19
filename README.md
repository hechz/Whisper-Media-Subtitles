### NAME
`Whisper-Media-Subtitles\Start-DockerWhisperTranslation.ps1`

### SYNOPSIS
A PowerShell wrapper for use with Docker for Windows to launch `whisper-gpu:latest` against a media file and perform a translation or transcription of the media.

### SYNTAX
`C:\Users\mars\Dropbox\Whisper-Media-Subtitles\Start-DockerWhisperTranslation.ps1 [-mediaTitle] <Object> [[-mediaBase] <Object>] [[-subfolderPattern] <Object>] [[-model] <Object>] [[-task] <Object>] [[-CPUs] <Object>] [[-GPU] <Object>] [[-whisperOptions] <Object>] [-Language] <Object> [<CommonParameters>]`

### DESCRIPTION
This script launches a locally built image of whisper, using the local system's GPU for processing. It presumes that the image has been built using "docker-compose build." Options are passed as environment variables to "docker run" and are parsed from my preferred defaults.

### PARAMETERS
#### `-mediaTitle <Object>`
A double-quoted string of the path to the media file such as "The Daily Show" for that series, or "Aliens (1986)" for that film.
* Required? `true`
* Position? `1`
* Default value: None
* Accept pipeline input? `false`
* Aliases: None
* Accept wildcard characters? `false`

#### `-mediaBase <Object>`
The double-quoted drive letter and folder name where media is stored. The default value is "v:\tv", but may be edited to your preferred default, or passed as the parameter.
* Required? `false`
* Position? `2`
* Default value: `v:\tv`
* Accept pipeline input? `false`
* Aliases: None
* Accept wildcard characters? `false`

#### `-subfolderPattern <Object>`
The first-level folder pattern under the `mediaBase`. It defaults to `S*\*.*`. This may be edited, or passed as a parameter. For films, set the value to empty, such as for "Aliens (1986)", the parameter would be set to `''`.
* Required? `false`
* Position? `3`
* Default value: `*\*.*`
* Accept pipeline input? `false`
* Aliases: None
* Accept wildcard characters? `false`

#### `-model <Object>`
The whisper model to use. Defaults to "small," but may be selected from the list of supported models:
* `tiny`
* `base`
* `small`
* `medium`
* `large`
* `turbo`
* Required? `false`
* Position? `4`
* Default value: `small`
* Accept pipeline input? `false`
* Aliases: None
* Accept wildcard characters? `false`

#### `-task <Object>`
Select the action to perform: translate or transcribe. Transcribe works from any of the available languages, but translate can only translate to English. This is a limitation of whisper.
* Required? `false`
* Position? `5`
* Default value: `translate`
* Accept pipeline input? `false`
* Aliases: None
* Accept wildcard characters? `false`

#### `-CPUs <Object>`
The number of CPUs to assign to Docker and the number of threads assigned to whisper. Defaults to 4.
* Required? `false`
* Position? `6`
* Default value: `2`
* Accept pipeline input? `false`
* Aliases: None
* Accept wildcard characters? `false`

#### `-GPU <Object>`
The number of the GPU to use. Defaults to 0. To determine your GPU numbering, run these commands:
* `docker pull ubuntu:latest`
* `docker run -it --rm --gpus all ubuntu:latest nvidia-smi`
* Required? `false`
* Position? `7`
* Default value: `0`
* Accept pipeline input? `false`
* Aliases: None
* Accept wildcard characters? `false`

#### `-whisperOptions <Object>`
Pass any other options to whisper from its own help:
`usage: whisper [-h] [--model MODEL] [--model_dir MODEL_DIR] [--device DEVICE] [--output_dir OUTPUT_DIR] [--output_format
