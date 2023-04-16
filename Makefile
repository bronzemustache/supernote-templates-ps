
# We use ghostscript to render the postscript into png files that can
# be used as Supernote templates.
GHOSTSCRIPT := gs
GS_OPTIONS := -q -sDEVICE=png16 -g1404x1872 -dBATCH -dNOPAUSE

# Pattern based rule for creation of templates.
%.png: %.ps Makefile
	$(GHOSTSCRIPT) $(GS_OPTIONS) -sOutputFile=$@ $<
	open $@

# One png template exists for each ps file.  png has the same stem,
# e.g. foo.ps is rendered into foo.png.
templates = $(patsubst %.ps,%.png,$(wildcard *.ps))

.PHONY: all
all: $(templates)

.PHONY: clean
clean:
	$(RM) $(templates)
