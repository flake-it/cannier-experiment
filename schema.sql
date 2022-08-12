create table counters (
    id integer primary key check (id = 1),
    count_churn integer,
    count_features integer,
    count_baseline integer,
    count_shuffle integer
);

insert into counters values (1, 0, 0, 0, 0);

create table file (
    id integer primary key,
    file_name text,
    unique (file_name)
);

create table line (
    file_id integer,
    l_no integer,
    churn_l_no integer,
    unique (file_id, l_no),
    foreign key (file_id) references file (id)
);

create table item (
    id integer primary key,
    nodeid text,
    n_runs_features integer,
    n_runs_baseline integer,
    n_fail_baseline integer,
    n_runs_shuffle integer,
    n_fail_shuffle integer,
    n_runs_victim integer,
    unique (nodeid)
);

create table features (
    item_id integer,
    read_count integer,
    write_count integer,
    time_exec real,
    time_iowait real,
    n_switches integer,
    n_lines integer,
    n_lines_source integer,
    n_changes integer,
    n_threads integer,
    n_children integer,
    n_bytes integer,
    tree_depth integer,
    n_ext_mods integer,
    n_assert integer,
    hal_vol real,
    cyc_cmp integer,
    lloc integer,
    mnt_idx real,
    foreign key (item_id) references item (id)
);

create table dependency (
    victim_id integer,
    polluter_id integer,
    unique (victim_id, polluter_id),
    foreign key (victim_id) references item (id),
    foreign key (polluter_id) references item (id)
);