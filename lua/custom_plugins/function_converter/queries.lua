local queries = [[
(variable_declarator 
   (identifier) @name 
   (arrow_function 
     (formal_parameters) @param 
     (statement_block) @body)  
   ) 

 (variable_declarator 
   (identifier) @name 
   (arrow_function 
     (formal_parameters) @param 
     (identifier) @body)  
   ) ]]
