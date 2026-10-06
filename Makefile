##
## EPITECH PROJECT, 2026
## PGP
## File description:
## Makefile
##

SRC	= 	src/Main.hs		\
		src/Types.hs 	\
		src/Utils.hs		\
		src/Parsing.hs 	\
		src/Doc/Help.hs \
		src/Xor.hs


NAME =	my_pgp

all :	$(NAME)

$(NAME):	$(SRC)
	ghc -o $(NAME) $(SRC)

fclean:	clean
	rm -f $(NAME)
	rm -f *.o
	rm -f *.hi

re:	fclean $(NAME)

.PHONY: all clean fclean re
