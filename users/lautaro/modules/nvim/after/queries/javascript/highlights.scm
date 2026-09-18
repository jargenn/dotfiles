;; vim: ft=query
;; extends

(function_declaration
  name: (identifier) @AlabasterDefinition)

(variable_declarator
  name: (identifier) @AlabasterDefinition
  value: (arrow_function))

(variable_declarator
  name: (identifier) @AlabasterDefinition
  value: (function_expression))

(undefined) @AlabasterConstant
