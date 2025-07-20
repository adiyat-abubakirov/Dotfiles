#!/bin/bash
file=$1
w=$2
h=$3
x=$4
y=$5
preview() {
	kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$1" </dev/null >/dev/tty
}
TEMPDIR=$HOME/.cache
case "$(basename "$file" | tr '[A-Z]' '[a-z]')" in
*.avi | *.mp4 | *.mkv | *.webm | *.mov | *.mpg)
	thumbnail="$TEMPDIR/thumbnail.png"
	ffmpeg -y -i "$file" -vframes 1 "$thumbnail"
	preview "$thumbnail"
	;;
*.gif)
	thumbnail="$TEMPDIR/thumbnail.png"
	gm convert "${file}[0]" "$thumbnail"
	preview "$thumbnail"
	;;
*.pdf | *.odt | *.ods | *.odp | *.odg | *.odf | *.odb | *.doc | *.docx | *.ppt | *.pptx)
  # pdf only
	# thumbnail="$TEMPDIR/thumbnail.png"
	# gs -o "$thumbnail" -sDEVICE=pngalpha -dLastPage=1 "$file" >/dev/null
	# preview "$thumbnail"
	;;
*.jpg | *.jpeg | *.png | *.bmp | *.tiff | *.heic)
	preview "$file"
	;;
*.svg)
	thumbnail="$TEMPDIR/thumbnail.png"
	convert "$file" "$thumbnail"
	preview "$thumbnail"
	;;
*)
	cat "$file"
	;;
esac
return 127 # nonzero retcode required for lf previews to reload
