function b.test.if_all_dependencies_exist () {

  b.depends_on 'sed grep cut'
  b.unittest.assert_success $?

  b.depends_on 'sort echo'
  b.unittest.assert_success $?

  function run_dep_mod1 () { b.depends_on 'clears'; }
  b.unittest.assert_raise run_dep_mod1 DependencyNotMetException

  function run_dep_mod2 () { b.depends_on 'sort11'; }
  b.unittest.assert_raise run_dep_mod2 DependencyNotMetException
}
