all: png

png: img/eruptions.png

img/eruptions.png:
	Rscript -e "targets::tar_make()"
