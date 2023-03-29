#! /usr/bin/env atf-sh

## basic
atf_test_case test_basic

test_basic_head() {
}

test_basic_body() {
    copy_mksite test_basic
    atf_check -s exit:0 -o ignore -x "make -C $(atf_get_srcdir)/test_basic rebuild"
    atf_check -s exit:0 -o match:'<h1>Hello World</h1>' -x "cat $(atf_get_srcdir)/test_basic/out/index.html"
}

## no id
atf_test_case test_no_id

test_no_id_head() {
}

test_no_id_body() {
    copy_mksite test_no_id
    atf_check -s exit:0 -o match:'out\/no-id.html' -x "make -C $(atf_get_srcdir)/test_no_id rebuild"
    atf_check -s exit:0 -o match:'<h1>Hello World</h1>' -x "cat $(atf_get_srcdir)/test_no_id/out/no-id.html"
}

## custom path
atf_test_case test_custom_path

test_custom_path_head() {
}

test_custom_path_body() {
    copy_mksite test_custom_path
    atf_check -s exit:0 -o ignore -x "make -C $(atf_get_srcdir)/test_custom_path rebuild"
    atf_check -s exit:0 -o match:'<h1>Hello World</h1>' -o not-match:'foo' -x "cat $(atf_get_srcdir)/test_custom_path/out/foo/bar/baz.html"
}

## basic link
atf_test_case test_basic_link

test_basic_link_head() {
}

test_basic_link_body() {
    copy_mksite test_basic_link
    atf_check -s exit:0 -o ignore -x "make -C $(atf_get_srcdir)/test_basic_link rebuild"
    atf_check -s exit:0 -o match:'<a href="bar.html">link to bar</a>' -x "cat $(atf_get_srcdir)/test_basic_link/out/foo.html"
}

## relative link
atf_test_case test_relative_link

test_relative_link_head() {
}

test_relative_link_body() {
    copy_mksite test_relative_link
    atf_check -s exit:0 -o ignore -x "make -C $(atf_get_srcdir)/test_relative_link rebuild"
    atf_check -s exit:0 -o match:'<a href="../bar.html">link to bar</a>' -x "cat $(atf_get_srcdir)/test_relative_link/out/subdir/foo.html"
}

## update path
atf_test_case test_update_path

test_update_path_head() {
}

test_update_path_body() {
    copy_mksite test_update_path
    cp $(atf_get_srcdir)/test_update_path/2-bar.orig $(atf_get_srcdir)/test_update_path/src/2-bar.md

    atf_check -s exit:0 -o match:'out\/foo.html' -o match:'out\/bar.html' -o match:'out\/baz.html' -x "make -C $(atf_get_srcdir)/test_update_path rebuild"
    atf_check -s exit:0 -o match:'<a href="bar.html">link to bar</a>' -x "cat $(atf_get_srcdir)/test_update_path/out/foo.html"

    sleep 1 # I hate this
    printf '%b' '---\npath: new-bar\n---\n' > $(atf_get_srcdir)/test_update_path/src/2-bar.md
    cat $(atf_get_srcdir)/test_update_path/2-bar.orig >> $(atf_get_srcdir)/test_update_path/src/2-bar.md

    atf_check -s exit:0 -o match:'out\/foo.html' -o match:'out\/new-bar.html' -o not-match:'out\/baz.html' -x "make -C $(atf_get_srcdir)/test_update_path"
    atf_check -s exit:0 -o match:'<a href="new-bar.html">link to bar</a>' -x "cat $(atf_get_srcdir)/test_update_path/out/foo.html"
}

## test cases
atf_init_test_cases() {
    atf_add_test_case test_basic
    atf_add_test_case test_no_id
    atf_add_test_case test_custom_path
    atf_add_test_case test_basic_link
    atf_add_test_case test_relative_link
    atf_add_test_case test_update_path
}

## helpers
copy_mksite() {
    if [ ! -d $(atf_get_srcdir)/${1}/bin ]; then mkdir $(atf_get_srcdir)/${1}/bin; fi
    cp $(atf_get_srcdir)/../Makefile $(atf_get_srcdir)/${1}
    cp $(atf_get_srcdir)/../bin/mksite.sh $(atf_get_srcdir)/${1}/bin/
}
