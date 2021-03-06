PS = push_swap
CH = checker

# Sources

CH_SRCS_NAME =	parsing.c \
				check.c \
				do_it.c \
				move1.c \
				move2.c \
				move3.c \
				main.c

PS_SRCS_NAME =	main.c \
				solve.c \
				sort.c \
				minisort.c \
				list.c \
				func.c \
				algo1.c \
				algo2.c \
				move1.c \
				move2.c \
				move3.c

INCS_NAME	=	push_swap.h \
				checker.h

LIB_NAME	=	libft.a

# Directories

PS_SRCS_DIR	=	./ps_srcs/
PS_OBJS_DIR	=	./ps_objs/
CH_SRCS_DIR	=	./ch_srcs/
CH_OBJS_DIR	=	./ch_objs/
INCS_DIR	=	./includes/
LIB_DIR		=	./libft/

# Files

PS_SRCS		=	$(addprefix $(PS_SRCS_DIR), $(PS_SRCS_NAME))
PS_OBJS		=	$(patsubst $(PS_SRCS_DIR)%.c, $(PS_OBJS_DIR)%.o, $(PS_SRCS))
CH_SRCS		=	$(addprefix $(CH_SRCS_DIR), $(CH_SRCS_NAME))
CH_OBJS		=	$(patsubst $(CH_SRCS_DIR)%.c, $(CH_OBJS_DIR)%.o, $(CH_SRCS))
INCS		=	$(addprefix $(INCS_DIR), $(INCS_NAME))
LIB			=	$(addprefix $(LIB_DIR), $(LIB_NAME))

# Compilation

CC			=	gcc
CPPFLAGS	=	-I $(INCS_DIR)
LIBH		=	-I $(LIB_DIR)includes/
CFLAGS		=	-Wall -Wextra -Werror -g $(CPPFLAGS) $(LIBH)

all: $(PS) $(CH)

$(LIB):
	@make -j -sC $(LIB_DIR)

$(PS): $(LIB) $(PS_OBJS)
	@$(CC) $(PS_OBJS) libft/libft.a -o $(PS)
	@echo push_swap OK

$(CH): $(LIB) $(CH_OBJS)
	@$(CC) $(CH_OBJS) libft/libft.a -o $(CH)
	@echo checker OK

$(PS_OBJS_DIR)%.o: $(PS_SRCS_DIR)%.c $(INCS)
	@mkdir -p $(PS_OBJS_DIR)
	@$(CC) $(CFLAGS) -o $@ -c $<

$(CH_OBJS_DIR)%.o: $(CH_SRCS_DIR)%.c $(INCS)
	@mkdir -p $(CH_OBJS_DIR)
	@$(CC) $(CFLAGS) -o $@ -c $<

cleanps:
	@rm -rf $(PS_OBJS_DIR)

cleanch:
	@rm -rf $(CH_OBJS_DIR)

fcleanps: cleanps
	@rm -f $(PS)
	@echo push_swap fclean OK

fcleanch: cleanch
	@rm -f $(CH)
	@echo checker fclean OK

librm:
	@make -sC libft fclean

clean: cleanps cleanch

fclean: librm fcleanps fcleanch

re: fclean all

.PHONY: all librm cleanps cleanch clean fcleanps fcleanch fclean re
