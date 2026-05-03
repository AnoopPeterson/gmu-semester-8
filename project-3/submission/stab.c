#include <stdio.h>
#include <stdlib.h>
#include "stab.h"
#define DEBUG 1
extern int lineno;

scope_ptr current_scope = NULL;
scope_ptr current_named_scope = NULL;

var_ptr search_for(char*name);

var_ptr new_node(char *name, int type, int immut) {
	var_ptr v = (var_ptr) malloc(sizeof(var_node));
	v->name = (char*)strdup(name);
	v->type = type;
	v->immutable = immut;
	v->is_param=0;
	v->next = NULL;
	v->ctr = 0;
	return v;
}

void new_var(char *name, int type, int immut, int is_param) {
	int i = check_type(name);
	if ((i==IS_INT_FUNCT)||(i==IS_BOOL_FUNCT)||(i==IS_VOID_FUNCT))
		printf("Duplicate function %s declared on line %d\n",name,lineno);
	var_ptr v = new_node(name,type,immut);

	if (current_scope) {
		if (is_param) v->is_param = is_param;
		else {
			v->ctr = current_named_scope->var_ctr;
			(current_named_scope->var_ctr)++;
			if ((type == IS_BOOL_ARRAY) || (type == IS_INT_ARRAY)) {
				(current_named_scope->var_ctr)++;
				/* need extra space for a 64 bit pointer */
			}
		}
		v->next = current_scope->vars;
		current_scope->vars = v;
	}
}

void update_funct(char *name, int type, int size) {
	scope_ptr s = current_scope->parent_scope;
	s->vars->type = type;
	s->vars->ctr = size;
}

var_ptr
search_scope(scope_ptr s,char *name) {
	if (s) {
		var_ptr v = s->vars;
		while (v) {
			if (strcmp(name,v->name) == 0) return v;
			v = v->next;
		}
	}
	return NULL;
}

int
check_dup_current(char*name) {
	if (search_scope(current_scope,name)) return 1;
	return 0;
}

var_ptr
search_for(char *name) {
	scope_ptr s = current_scope;
	while (s) {
		var_ptr v = search_scope(s,name);
		if (v != NULL) return v;
		s = s->parent_scope;
	}
	return NULL;
}

int
check_mutable(char *name) {
	var_ptr v  = search_for(name);
	if (v) return v->immutable;
	return -1;
}


int check_declared(char *name) {
	var_ptr v  = search_for(name);
	if (v) return 1;
	return 0;
}

int check_type(char *name) {
	var_ptr v  = search_for(name);
	if (v) return v->type;
	return 0;
}

int get_size(char*name) {
	var_ptr v = search_for(name);
	if (v) return v->ctr;
	return -1;
}

void
create_scope(char *name) {
	scope_ptr s = (scope_ptr)malloc(sizeof(scope_node));
	if (name)  s->name = (char*)strdup(name);
	else s->name = NULL;
	s->var_ctr = 0;
	s->vars = NULL;
	s->parent_scope = current_scope;
	current_scope = s;
	if (s->name) current_named_scope=s;
}

void
free_var_list(var_ptr v) {
	var_ptr t = v;
	while (t) {
		var_ptr old = t;   t = t->next;
		free(old->name);  free(old);
	}
}

void
free_scope(scope_ptr t) {
	free_var_list(t->vars);
	if (t->name) free(t->name);
}

void dump_scope(scope_ptr s) {
	printf("//Scope %s with %d vars:\n",s->name, s->var_ctr);
	var_ptr v = s->vars;
	while (v) {
		printf("//%s(%d, %d, %d)\t",v->name,v->type,v->is_param, v->ctr);
		v = v->next;
	}
	printf("\n");
}

void
exit_scope() {
	if (current_scope) {
		if (DEBUG) dump_scope(current_scope);
		scope_ptr t = current_scope;
		if (current_scope->name) current_named_scope = current_scope->parent_scope;
		current_scope = t->parent_scope;
		free_scope(t);
		free(t);
	}
}

/* ---- helpers for code generation ---- */
var_ptr lookup_var(char *name) { return search_for(name); }

int var_offset(char *name) {
	var_ptr v = search_for(name);
	if (!v) return -1;
	return v->ctr * 4;
}

int var_is_param(char *name) {
	var_ptr v = search_for(name);
	if (!v) return 0;
	return v->is_param;
}

int var_type(char *name) {
	var_ptr v = search_for(name);
	if (!v) return 0;
	return v->type;
}
