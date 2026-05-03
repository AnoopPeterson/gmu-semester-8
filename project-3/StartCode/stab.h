#include <string.h>
#define IS_INT 1
#define IS_INT_FUNCT  2
#define IS_INT_ARRAY  3
#define IS_BOOL  4
#define IS_BOOL_FUNCT  5
#define IS_BOOL_ARRAY  6
#define IS_VOID_FUNCT  7
#define IS_VOID 8

typedef struct vnode {
	char *name;
	int type;
	int ctr;   // needed for functions and arrays
	int is_param;   // 0 or the param counter
	struct vnode *next;
	int immutable;
}  var_node, *var_ptr;

typedef struct snode {
	char *name;
	int var_ctr;
	var_ptr vars;
	struct snode *parent_scope;
} scope_node, *scope_ptr;


void create_scope(char *);
void exit_scope();
void update_funct(char*,int,int);
void new_var(char*,int,int,int);
char *get_id_name(char*);
int check_mutable(char*);
int check_declared(char*);
int check_type(char*);
int check_dup_current(char*);
int get_size(char*);

