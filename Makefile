
ps_dir = ps
a5_templates = a5_templates
a6_templates = a6_templates

# This is a command that _maybe_ could serve as a substitute for
# the MacOS and Ubuntu "open".
# %SystemRoot%\System32\rundll32.exe "%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll", ImageView_Fullscreen

# We use ghostscript to render the postscript into png files that can
# be used as Supernote templates.
GHOSTSCRIPT := gs
GS_OPTIONS := -q -sDEVICE=png16 -g1404x1872 -dBATCH -dNOPAUSE

# Pattern based rule for creation of templates.  Note the open command
# in the second line.  This will open a window that displays the image
# on Ubuntu and MacOS.  If the open command is not available on your
# system you can delete the line or comment it out.
vpath %.ps $(ps_dir)
$(a5_templates)/%.png: $(ps_dir)/%.ps Makefile
	$(GHOSTSCRIPT) $(GS_OPTIONS) -sSupernote=a5x -sOutputFile=$@ $<
	open $@

$(a6_templates)/%.png: $(ps_dir)/%.ps Makefile
	$(GHOSTSCRIPT) $(GS_OPTIONS) -sSupernote=a6x -sOutputFile=$@ $<
	open $@

# One png template exists for each ps file.  png has the same stem,
# e.g. foo.ps is rendered into foo.png.
all_templates  = $(patsubst ps/%.ps,a5_templates/%.png,$(wildcard ps/*.ps))
all_templates += $(patsubst ps/%.ps,a6_templates/%.png,$(wildcard ps/*.ps))

.PHONY: all
all: $(all_templates)

.PHONY: clean
clean:
	$(RM) $(all_templates)
