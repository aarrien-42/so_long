# Normbre del ejecutable
NAME = so_long

# Directorios
SRC_DIR = srcs/
OBJ_DIR = objs/

OBJF = objs
INC = incs

# Ficheros
SRC_FILES = so_long events render load check map animate utils enemy
SRC = $(addprefix $(SRC_DIR), $(addsuffix .c, $(SRC_FILES)))
OBJ = $(addprefix $(OBJ_DIR), $(addsuffix .o, $(SRC_FILES)))

# Comandos
CC = gcc
CFLAGS = -Wall -Werror -Wextra -g -fsanitize=address -g3
MLX = -Lmlx -lmlx -framework OpenGL -framework AppKit
RM = rm -f
AR = ar rcs

.SILENT:

# REGLAS #
all: $(NAME)

bonus: all

# Compilar conjuntamente
$(NAME): $(OBJ)
	@$(MAKE) -C ./libft
	@echo "libft compiled!"
	@$(MAKE) -C ./mlx
	@echo "minilibx compiled!"
	@$(CC) $(CFLAGS) $(OBJ) -I $(INC) libft/libft.a mlx/libmlx.a $(MLX) -o $(NAME)
	@echo "so_long compiled!"

# Compilar objetos individualmente
$(OBJ_DIR)%.o: $(SRC_DIR)%.c | $(OBJF)
	@echo "Compiling: $<"
	@$(CC) $(CFLAGS) -Imlx -I $(INC) -c $< -o $@

# Crear directorio temporal para los obj
$(OBJF):
	@mkdir -p $(OBJ_DIR)

# Eliminar temporales
clean:
	@$(MAKE) -C libft/ clean
	@$(RM) -r $(OBJ_DIR)
	@echo "Objects and directory cleaned!"

# Eliminar temporales y ejecutable
fclean: clean
	@$(MAKE) -C libft fclean
	@$(RM) $(NAME) libft.a
	@echo "Executable cleaned!"

re: fclean all

norm:
	@norminette $(SRC_DIR) $(INC)

.PHONY: all clean fclean re
