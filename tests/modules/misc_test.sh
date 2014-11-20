b.module.require misc

function b.test.if_all_dependencies_exist () {

  b.misc.has_dependencies? 'sed grep cut'
  b.unittest.assert_success $?

  b.misc.has_dependencies? 'sort echo'
  b.unittest.assert_success $?

  function run_dep_mod1 () { b.misc.has_dependencies? 'clears'; }
  b.unittest.assert_raise run_dep_mod1 RequiredAppNotInstalled

  function run_dep_mod2 () { b.misc.has_dependencies? 'sort11'; }
  b.unittest.assert_raise run_dep_mod2 RequiredAppNotInstalled
}


function b.test.if_function_exists () {
    local function_name='random_function_that_now_exists'
    unset -f ${function_name} 
    function random_function_that_now_exists () {
        echo "" > /dev/null 
    }
    b.misc.function_exists? ${function_name}
    
    
    function run_fail_1 () { b.misc.function_exists? ${function_name}_does_not_exist; }
    b.unittest.assert_raise run_fail_1  FunctionDoesNotExist
}
