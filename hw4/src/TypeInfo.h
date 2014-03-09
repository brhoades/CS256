#define UNDEFINED -1
#define FUNCTION 0
#define INT 1
#define STR 2
#define INT_OR_STR 3
#define BOOL 4
#define INT_OR_BOOL 5
#define STR_OR_BOOL 6
#define ANY 7
#define ARITH 8
#define LOG 0b10000
#define REL 0b100000

#define NOT_APPLICABLE -1

typedef struct {
  int type;
  int numParams;
  int returnType;
} TYPE_INFO;
