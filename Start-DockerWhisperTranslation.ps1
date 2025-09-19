<#
.SYNOPSIS
A PowerShell wrapper for use with Docker for Windows to Launch whisper-gpu:latest against a media file and perform a translation or transcription of the media

.PARAMETER mediaTitle 
A double quoted string of the path to the media file such as "The Daily Show" for that series, or "Aliens (1986)" for that film.
.PARAMETER mediaBase
The double quoted drive letter and folder name where media is stored. The default value is "v:\tv", but may be edited to your preffered default, or passed as the parameter
.PARAMETER subfolderPattern
The first-level folder pattern under the mediaBase, it defaults to "S*\*.*", this may be edited, or passed as a parameter. For films set the value to empty, such as for "Aliens (1986)", the paramter would be set to ''
.PARAMETER Language
Select the source media language, this is a selectable list from ValidateSet, and passed to whisper as this parameter:
--language {af,am,ar,as,az,ba,be,bg,bn,bo,br,bs,ca,cs,cy,da,de,el,en,es,et,eu,fa,fi,fo,fr,gl,gu,ha,haw,he,hi,hr,ht,hu,hy,id,is,it,ja,jw,ka,kk,km,kn,ko,la,lb,ln,lo,lt,lv,mg,mi,mk,ml,mn,mr,ms,mt,my,ne,nl,nn,no,oc,pa,pl,ps,pt,ro,ru,sa,sd,si,sk,sl,sn,so,sq,sr,su,sv,sw,ta,te,tg,th,tk,tl,tr,tt,uk,ur,uz,vi,yi,yo,yue,zh,Afrikaans,Albanian,Amharic,Arabic,Armenian,Assamese,Azerbaijani,Bashkir,Basque,Belarusian,Bengali,Bosnian,Breton,Bulgarian,Burmese,Cantonese,Castilian,Catalan,Chinese,Croatian,Czech,Danish,Dutch,English,Estonian,Faroese,Finnish,Flemish,French,Galician,Georgian,German,Greek,Gujarati,Haitian,Haitian Creole,Hausa,Hawaiian,Hebrew,Hindi,Hungarian,Icelandic,Indonesian,Italian,Japanese,Javanese,Kannada,Kazakh,Khmer,Korean,Lao,Latin,Latvian,Letzeburgesch,Lingala,Lithuanian,Luxembourgish,Macedonian,Malagasy,Malay,Malayalam,Maltese,Mandarin,Maori,Marathi,Moldavian,Moldovan,Mongolian,Myanmar,Nepali,Norwegian,Nynorsk,Occitan,Panjabi,Pashto,Persian,Polish,Portuguese,Punjabi,Pushto,Romanian,Russian,Sanskrit,Serbian,Shona,Sindhi,Sinhala,Sinhalese,Slovak,Slovenian,Somali,Spanish,Sundanese,Swahili,Swedish,Tagalog,Tajik,Tamil,Tatar,Telugu,Thai,Tibetan,Turkish,Turkmen,Ukrainian,Urdu,Uzbek,Valencian,Vietnamese,Welsh,Yiddish,Yoruba}
.PARAMETER model
The whisper model to use, defaults to "small", but may be selected from the list of supported models:
- tiny
- base
- small
- medium
- large
- turbo
.PARAMETER task
Select the action to perform, translate or transcribe. Transcribe works from any of the available languages, but translate can only translate to English. This is a limitation of whisper.
.PARAMETER CPUs
The number of CPUs to assign to Docker, and the number of threads assigned to whisper, defaults to 4
.PARAMETER GPU
The number of the GPU to use defaults to 0, to determine your GPU numbering, run these command:
docker pull ubuntu:latest
docker run -it --rm --gpus all  ubuntu:latest nvidia-smi
.PARAMETER whisperOptions
Pass any other options to whisper from its own help: 
usage: whisper [-h] [--model MODEL] [--model_dir MODEL_DIR] [--device DEVICE] [--output_dir OUTPUT_DIR] [--output_format {txt,vtt,srt,tsv,json,all}] [--verbose VERBOSE] [--task {transcribe,translate}]
               [--language {af,am,ar,as,az,ba,be,bg,bn,bo,br,bs,ca,cs,cy,da,de,el,en,es,et,eu,fa,fi,fo,fr,gl,gu,ha,haw,he,hi,hr,ht,hu,hy,id,is,it,ja,jw,ka,kk,km,kn,ko,la,lb,ln,lo,lt,lv,mg,mi,mk,ml,mn,mr,ms,mt,my,ne,nl,nn,no,oc,pa,pl,ps,pt,ro,ru,sa,sd,si,sk,sl,sn,so,sq,sr,su,sv,sw,ta,te,tg,th,tk,tl,tr,tt,uk,ur,uz,vi,yi,yo,yue,zh,Afrikaans,Albanian,Amharic,Arabic,Armenian,Assamese,Azerbaijani,Bashkir,Basque,Belarusian,Bengali,Bosnian,Breton,Bulgarian,Burmese,Cantonese,Castilian,Catalan,Chinese,Croatian,Czech,Danish,Dutch,English,Estonian,Faroese,Finnish,Flemish,French,Galician,Georgian,German,Greek,Gujarati,Haitian,Haitian Creole,Hausa,Hawaiian,Hebrew,Hindi,Hungarian,Icelandic,Indonesian,Italian,Japanese,Javanese,Kannada,Kazakh,Khmer,Korean,Lao,Latin,Latvian,Letzeburgesch,Lingala,Lithuanian,Luxembourgish,Macedonian,Malagasy,Malay,Malayalam,Maltese,Mandarin,Maori,Marathi,Moldavian,Moldovan,Mongolian,Myanmar,Nepali,Norwegian,Nynorsk,Occitan,Panjabi,Pashto,Persian,Polish,Portuguese,Punjabi,Pushto,Romanian,Russian,Sanskrit,Serbian,Shona,Sindhi,Sinhala,Sinhalese,Slovak,Slovenian,Somali,Spanish,Sundanese,Swahili,Swedish,Tagalog,Tajik,Tamil,Tatar,Telugu,Thai,Tibetan,Turkish,Turkmen,Ukrainian,Urdu,Uzbek,Valencian,Vietnamese,Welsh,Yiddish,Yoruba}]
               [--temperature TEMPERATURE] [--best_of BEST_OF] [--beam_size BEAM_SIZE] [--patience PATIENCE] [--length_penalty LENGTH_PENALTY] [--suppress_tokens SUPPRESS_TOKENS] [--initial_prompt INITIAL_PROMPT]
               [--carry_initial_prompt CARRY_INITIAL_PROMPT] [--condition_on_previous_text CONDITION_ON_PREVIOUS_TEXT] [--fp16 FP16] [--temperature_increment_on_fallback TEMPERATURE_INCREMENT_ON_FALLBACK]
               [--compression_ratio_threshold COMPRESSION_RATIO_THRESHOLD] [--logprob_threshold LOGPROB_THRESHOLD] [--no_speech_threshold NO_SPEECH_THRESHOLD] [--word_timestamps WORD_TIMESTAMPS] [--prepend_punctuations PREPEND_PUNCTUATIONS]
               [--append_punctuations APPEND_PUNCTUATIONS] [--highlight_words HIGHLIGHT_WORDS] [--max_line_width MAX_LINE_WIDTH] [--max_line_count MAX_LINE_COUNT] [--max_words_per_line MAX_WORDS_PER_LINE] [--threads THREADS]
               [--clip_timestamps CLIP_TIMESTAMPS] [--hallucination_silence_threshold HALLUCINATION_SILENCE_THRESHOLD]
               audio [audio ...]

positional arguments:
  audio                 audio file(s) to transcribe

options:
  -h, --help            show this help message and exit
  --model MODEL         name of the Whisper model to use (default: turbo)
  --model_dir MODEL_DIR
                        the path to save model files; uses ~/.cache/whisper by default (default: None)
  --device DEVICE       device to use for PyTorch inference (default: cuda)
  --output_dir OUTPUT_DIR, -o OUTPUT_DIR
                        directory to save the outputs (default: .)
  --output_format {txt,vtt,srt,tsv,json,all}, -f {txt,vtt,srt,tsv,json,all}
                        format of the output file; if not specified, all available formats will be produced (default: all)
  --verbose VERBOSE     whether to print out the progress and debug messages (default: True)
  --task {transcribe,translate}
                        whether to perform X->X speech recognition ('transcribe') or X->English translation ('translate') (default: transcribe)
  --language {af,am,ar,as,az,ba,be,bg,bn,bo,br,bs,ca,cs,cy,da,de,el,en,es,et,eu,fa,fi,fo,fr,gl,gu,ha,haw,he,hi,hr,ht,hu,hy,id,is,it,ja,jw,ka,kk,km,kn,ko,la,lb,ln,lo,lt,lv,mg,mi,mk,ml,mn,mr,ms,mt,my,ne,nl,nn,no,oc,pa,pl,ps,pt,ro,ru,sa,sd,si,sk,sl,sn,so,sq,sr,su,sv,sw,ta,te,tg,th,tk,tl,tr,tt,uk,ur,uz,vi,yi,yo,yue,zh,Afrikaans,Albanian,Amharic,Arabic,Armenian,Assamese,Azerbaijani,Bashkir,Basque,Belarusian,Bengali,Bosnian,Breton,Bulgarian,Burmese,Cantonese,Castilian,Catalan,Chinese,Croatian,Czech,Danish,Dutch,English,Estonian,Faroese,Finnish,Flemish,French,Galician,Georgian,German,Greek,Gujarati,Haitian,Haitian Creole,Hausa,Hawaiian,Hebrew,Hindi,Hungarian,Icelandic,Indonesian,Italian,Japanese,Javanese,Kannada,Kazakh,Khmer,Korean,Lao,Latin,Latvian,Letzeburgesch,Lingala,Lithuanian,Luxembourgish,Macedonian,Malagasy,Malay,Malayalam,Maltese,Mandarin,Maori,Marathi,Moldavian,Moldovan,Mongolian,Myanmar,Nepali,Norwegian,Nynorsk,Occitan,Panjabi,Pashto,Persian,Polish,Portuguese,Punjabi,Pushto,Romanian,Russian,Sanskrit,Serbian,Shona,Sindhi,Sinhala,Sinhalese,Slovak,Slovenian,Somali,Spanish,Sundanese,Swahili,Swedish,Tagalog,Tajik,Tamil,Tatar,Telugu,Thai,Tibetan,Turkish,Turkmen,Ukrainian,Urdu,Uzbek,Valencian,Vietnamese,Welsh,Yiddish,Yoruba}
                        language spoken in the audio, specify None to perform language detection (default: None)
  --temperature TEMPERATURE
                        temperature to use for sampling (default: 0)
  --best_of BEST_OF     number of candidates when sampling with non-zero temperature (default: 5)
  --beam_size BEAM_SIZE
                        number of beams in beam search, only applicable when temperature is zero (default: 5)
  --patience PATIENCE   optional patience value to use in beam decoding, as in https://arxiv.org/abs/2204.05424, the default (1.0) is equivalent to conventional beam search (default: None)
  --length_penalty LENGTH_PENALTY
                        optional token length penalty coefficient (alpha) as in https://arxiv.org/abs/1609.08144, uses simple length normalization by default (default: None)
  --suppress_tokens SUPPRESS_TOKENS
                        comma-separated list of token ids to suppress during sampling; '-1' will suppress most special characters except common punctuations (default: -1)
  --initial_prompt INITIAL_PROMPT
                        optional text to provide as a prompt for the first window. (default: None)
  --carry_initial_prompt CARRY_INITIAL_PROMPT
                        if True, prepend initial_prompt to every internal decode() call. May reduce the effectiveness of condition_on_previous_text (default: False)
  --condition_on_previous_text CONDITION_ON_PREVIOUS_TEXT
                        if True, provide the previous output of the model as a prompt for the next window; disabling may make the text inconsistent across windows, but the model becomes less prone to getting stuck in a failure loop (default:
                        True)
  --fp16 FP16           whether to perform inference in fp16; True by default (default: True)
  --temperature_increment_on_fallback TEMPERATURE_INCREMENT_ON_FALLBACK
                        temperature to increase when falling back when the decoding fails to meet either of the thresholds below (default: 0.2)
  --compression_ratio_threshold COMPRESSION_RATIO_THRESHOLD
                        if the gzip compression ratio is higher than this value, treat the decoding as failed (default: 2.4)
  --logprob_threshold LOGPROB_THRESHOLD
                        if the average log probability is lower than this value, treat the decoding as failed (default: -1.0)
  --no_speech_threshold NO_SPEECH_THRESHOLD
                        if the probability of the <|nospeech|> token is higher than this value AND the decoding has failed due to `logprob_threshold`, consider the segment as silence (default: 0.6)
  --word_timestamps WORD_TIMESTAMPS
                        (experimental) extract word-level timestamps and refine the results based on them (default: False)
  --prepend_punctuations PREPEND_PUNCTUATIONS
                        if word_timestamps is True, merge these punctuation symbols with the next word (default: "'“¿([{-)
  --append_punctuations APPEND_PUNCTUATIONS
                        if word_timestamps is True, merge these punctuation symbols with the previous word (default: "'.。,，!！?？:：”)]}、)
  --highlight_words HIGHLIGHT_WORDS
                        (requires --word_timestamps True) underline each word as it is spoken in srt and vtt (default: False)
  --max_line_width MAX_LINE_WIDTH
                        (requires --word_timestamps True) the maximum number of characters in a line before breaking the line (default: None)
  --max_line_count MAX_LINE_COUNT
                        (requires --word_timestamps True) the maximum number of lines in a segment (default: None)
  --max_words_per_line MAX_WORDS_PER_LINE
                        (requires --word_timestamps True, no effect with --max_line_width) the maximum number of words in a segment (default: None)
  --threads THREADS     number of threads used by torch for CPU inference; supercedes MKL_NUM_THREADS/OMP_NUM_THREADS (default: 0)
  --clip_timestamps CLIP_TIMESTAMPS
                        comma-separated list start,end,start,end,... timestamps (in seconds) of clips to process, where the last end timestamp defaults to the end of the file (default: 0)
  --hallucination_silence_threshold HALLUCINATION_SILENCE_THRESHOLD
                        (requires --word_timestamps True) skip silent periods longer than this threshold (in seconds) when a possible hallucination is detected (default: None)

.DESCRIPTION
This script launches a locally built image of whisper, using the local systems GPU for processing.
It presumes that the image has been built using "docker-compuose build". Options are passed as environment variables to "docker run" and are parsed from my preferred defaults.

.INPUTS
None 

.OUTPUTS
Standar out put from docker, shows a timestamp when the container starts, the whisper command-line, then the text of the transcription/translation followed by the renaming of the SRT file to a new name including the language.

.LINK


#>

Param(
	[parameter(Mandatory=$True)]  $mediaTitle,
	[parameter(Mandatory=$False)] $mediaBase='v:\tv',
	[parameter(Mandatory=$False)] $subfolderPattern='*\*.*',
	[parameter(Mandatory=$false)]
	[ValidateSet(
		'tiny',
		'base',
		'small',
		'medium',
		'large',
		'turbo'

	)] $model='small',
	[parameter(Mandatory=$False)]
	[ValidateSet('translate','transcribe')] $task="translate",
	[parameter(Mandatory=$False)] $CPUs=2,
	[parameter(Mandatory=$False)] $GPU=0,
	[parameter(Mandatory=$false)] $whisperOptions,
	[parameter(Mandatory=$True)]
	[ValidateSet(
		'af',
		'am',
		'ar',
		'as',
		'az',
		'ba',
		'be',
		'bg',
		'bn',
		'bo',
		'br',
		'bs',
		'ca',
		'cs',
		'cy',
		'da',
		'de',
		'el',
		'en',
		'es',
		'et',
		'eu',
		'fa',
		'fi',
		'fo',
		'fr',
		'gl',
		'gu',
		'ha',
		'haw',
		'he',
		'hi',
		'hr',
		'ht',
		'hu',
		'hy',
		'id',
		'is',
		'it',
		'ja',
		'jw',
		'ka',
		'kk',
		'km',
		'kn',
		'ko',
		'la',
		'lb',
		'ln',
		'lo',
		'lt',
		'lv',
		'mg',
		'mi',
		'mk',
		'ml',
		'mn',
		'mr',
		'ms',
		'mt',
		'my',
		'ne',
		'nl',
		'nn',
		'no',
		'oc',
		'pa',
		'pl',
		'ps',
		'pt',
		'ro',
		'ru',
		'sa',
		'sd',
		'si',
		'sk',
		'sl',
		'sn',
		'so',
		'sq',
		'sr',
		'su',
		'sv',
		'sw',
		'ta',
		'te',
		'tg',
		'th',
		'tk',
		'tl',
		'tr',
		'tt',
		'uk',
		'ur',
		'uz',
		'vi',
		'yi',
		'yo',
		'yue',
		'zh',
		'Afrikaans',
		'Albanian',
		'Amharic',
		'Arabic',
		'Armenian',
		'Assamese',
		'Azerbaijani',
		'Bashkir',
		'Basque',
		'Belarusian',
		'Bengali',
		'Bosnian',
		'Breton',
		'Bulgarian',
		'Burmese',
		'Cantonese',
		'Castilian',
		'Catalan',
		'Chinese',
		'Croatian',
		'Czech',
		'Danish',
		'Dutch',
		'English',
		'Estonian',
		'Faroese',
		'Finnish',
		'Flemish',
		'French',
		'Galician',
		'Georgian',
		'German',
		'Greek',
		'Gujarati',
		'Haitian',
		'Haitian Creole',
		'Hausa',
		'Hawaiian',
		'Hebrew',
		'Hindi',
		'Hungarian',
		'Icelandic',
		'Indonesian',
		'Italian',
		'Japanese',
		'Javanese',
		'Kannada',
		'Kazakh',
		'Khmer',
		'Korean',
		'Lao',
		'Latin',
		'Latvian',
		'Letzeburgesch',
		'Lingala',
		'Lithuanian',
		'Luxembourgish',
		'Macedonian',
		'Malagasy',
		'Malay',
		'Malayalam',
		'Maltese',
		'Mandarin',
		'Maori',
		'Marathi',
		'Moldavian',
		'Moldovan',
		'Mongolian',
		'Myanmar',
		'Nepali',
		'Norwegian',
		'Nynorsk',
		'Occitan',
		'Panjabi',
		'Pashto',
		'Persian',
		'Polish',
		'Portuguese',
		'Punjabi',
		'Pushto',
		'Romanian',
		'Russian',
		'Sanskrit',
		'Serbian',
		'Shona',
		'Sindhi',
		'Sinhala',
		'Sinhalese',
		'Slovak',
		'Slovenian',
		'Somali',
		'Spanish',
		'Sundanese',
		'Swahili',
		'Swedish',
		'Tagalog',
		'Tajik',
		'Tamil',
		'Tatar',
		'Telugu',
		'Thai',
		'Tibetan',
		'Turkish',
		'Turkmen',
		'Ukrainian',
		'Urdu',
		'Uzbek',
		'Valencian',
		'Vietnamese',
		'Welsh',
		'Yiddish',
		'Yoruba'
	)] $Language
)

$showFiles=Get-ChildItem -ea SilentlyContinue "$mediaBase\$mediaTitle\$subfolderPattern"
$videoFiles = $showFiles | Where-Object -Property Name -match '\.avi$|\.mkv$|\.mp4$'
if ( -not $videoFiles ){
	Write-Warning "No files of type mp4, mkv, or avi found for '$mediaBase\${mediaTitle}\$subFolderPattern'"
	return
}
$processingArguments= $videoFiles | Select-Object -Property `
	FullName,`
	@{N="SRT";E={ $_.FullName -replace "(.+)\.\w+$","`$1.$Language.srt"}},
	@{N="containerPath";E={ $( $_.FullName -replace '\\','/') -replace 'V:','' }},`
	@{N="containerName";E={  $( $_.Name -replace '\s+','_' -replace '^',"${task}_${Language}_subs_" -replace '\.\w+$'  -replace '\p{Cc}|\p{Cf}|\p{Cn}|\p{Co}|\p{Cs}|\p{Mc}|\p{Me}|\p{Mn}|\p{Pe}|\p{Pf}|\p{Pi}|\p{Po}|\p{Ps}|\p{Sc}|\p{Sk}|\p{Sm}|\p{So}' ).Normalize('FormD') -replace '\p{M}'  }  } 

$processingArguments | ForEach-Object { 
	$fn=$_.containerPath;
	$cn=$_.containerName
	$srt=$_.SRT;
	$guid=New-Guid
	if ( $exists=Get-Item -ea SilentlyContinue "$srt" ){
		Write-Host -ForegroundColor Yellow "Skipping: '$fn' since '$exists' exists"
		return
	}else{
		Write-Host "Starting translation on '/app${fn}' to '$srt' with container '$cn'";
		Start-Process -FilePath  C:\programs\Docker\Docker\resources\bin\docker.exe -ArgumentList "run --rm --gpus device=$GPU --cpus $cpus --hostname whisper-$guid -t --mount source=nas-video,target=/app  -eSMB=0 -eFILE=`"$fn`" -eMODEL=$model -eSOURCE_LANG=$Language -eTASK=$task -eOMP_NUM_THREADS=$cpus --name=`"$cn`" -eWHISPER_OPTS=`"$whisperOptions`" whisper-gpu:latest" -NoNewWindow -Wait
	}
}
