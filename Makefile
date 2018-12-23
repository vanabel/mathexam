# You want latexmk to *always* run,
# because make does not have all the info.
# Also, include non-file targets in .PHONY
# so they are run regardless of any
# file of the given name existing.
.PHONY : main pkg doc clean all FORCE_MAKE

NAME = mathexam
VER= v1.0.0
UTREE = $(shell kpsewhich --var-value TEXMFHOME)
LOCAL = $(shell kpsewhich --var-value TEXMFLOCAL)
# make without parameter will use make main
# rule of make: target can be object file or a label
# 	prerequisites are the target dependence (file or label)
# 	if prerequisites are newer than target use command to rebuilt
# target : prerequisites
# command

# latexmk: figure out all the LaTeX-related stuff
# -use-make: relying on the Makefile for the Non-LaTeX-related stuff
main : pkg FORCE_MAKE
	latexmk -xelatex -shell-escape -use-make

all : main doc

pkg : $(NAME).sty

doc : $(NAME).pdf

# '$@' is a variable holding the name of the target, and
# '$<' is a variable holding the (first) dependency of a rule.
$(NAME).sty: $(NAME).dtx
	xetex $<

$(NAME).pdf : $(NAME).dtx FORCE_MAKE
	latexmk -xelatex $<

clean :
	latexmk -c
	latexmk -c $(NAME).dtx
	rm -f $(NAME)-main.{nav,snm,vrb,xdv}

distclean : 
	latexmk -C
	latexmk -C $(NAME).dtx
	rm $(NAME)-main.* $(NAME).sty $(NAME).ins 

zip : pkg doc main
	mkdir -p $(NAME)-$(VER) 
	cp -r $(NAME).{dtx,sty,pdf} \
	  README.md $(NAME)-main.{tex,pdf} \
	  .latexmkrc Makefile $(NAME)-$(VER)
	cp -r tractrix.pdf $(NAME)-$(VER)/
	zip -r $(NAME)-$(VER).zip $(NAME)-$(VER)
	rm -r $(NAME)-$(VER)
