# You want latexmk to *always* run,
# because make does not have all the info.
# Also, include non-file targets in .PHONY
# so they are run regardless of any
# file of the given name existing.
.PHONY : main pkg maintex mainanstex doc clean all FORCE_MAKE

NAME = mathexam
VER= v2.1.0
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
main : pkg maintex mainanstex

all : main doc

pkg : $(NAME).sty

doc : $(NAME).pdf

# '$@' is a variable holding the name of the target, and
# '$<' is a variable holding the (first) dependency of a rule.
$(NAME).sty: $(NAME).dtx
	xetex $<

$(NAME).pdf : $(NAME).dtx FORCE_MAKE
	latexmk -xelatex $<

maintex : $(NAME)-main.tex FORCE_MAKE
	latexmk -xelatex -shell-escape -use-make $<

mainanstex : $(NAME)-main-answer.tex FORCE_MAKE
	latexmk -xelatex -shell-escape -use-make $<

clean :
	latexmk -c
	latexmk -c $(NAME).dtx
	rm -f $(NAME)-main.{nav,snm,vrb,xdv,dat} \
	  $(NAME)-main-answer.{nav,snm,vrb,xdv,dat}

distclean : 
	latexmk -CA
	latexmk -CA $(NAME).dtx
	rm $(NAME)-main.* $(NAME)-main-answer.* $(NAME).sty $(NAME).ins\
	  main.tex *.pdf *.vim
	

zip : pkg doc main
	mkdir -p $(NAME)-$(VER) 
	cp -r $(NAME).{dtx,sty,pdf} \
	  README.md $(NAME)-main.{tex,pdf} \
	  $(NAME)-main-answer.{tex,pdf} \
	  .latexmkrc Makefile $(NAME)-$(VER)
	cp -r tractrix.pdf $(NAME)-$(VER)/
	rm *.zip
	zip -r $(NAME)-$(VER).zip $(NAME)-$(VER)
	rm -r $(NAME)-$(VER)
