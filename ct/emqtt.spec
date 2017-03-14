{node, emqttd, 'emqttd_ct@huangdan'}.
{node, emq_auth_mysql, 'emq_auth_mysql_ct@huangdan'}.

{init, [emqttd], [{node_start, [{monitor_master, true}, {erl_flags, "-setcookie SZYWCEDYCDGEWZXFQTBG -pa ${TOPSRCDIR}/deps/*/ebin -dir ${TOPSRCDIR}/deps/emqttd/test"}]}]}.
{init, [emq_auth_mysql], [{node_start, [{monitor_master, true}, {erl_flags, "-setcookie SZYWCEDYCDGEWZXFQTBG -pa ${TOPSRCDIR}/deps/*/ebin -dir ${TOPSRCDIR}/deps/emq_auth_mysql/test"}]}]}.

{suites, [emqttd], "../deps/emqttd/test", all}.
{suites, [emq_auth_mysql], "../deps/emq_auth_mysql/test", all}.

{create_priv_dir, master, auto_per_run}.
{create_priv_dir, all_nodes, auto_per_run}.

{auto_compile, [emqttd, emq_auth_mysql], true}.

{logdir, all_nodes, "./logs"}.
{logdir, master, "./logs/"}.

