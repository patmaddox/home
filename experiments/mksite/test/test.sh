#! /usr/bin/env atf-sh

## basic
atf_test_case test_basic

test_basic_head() {
}

test_basic_body() {
    if [ ! -d $(atf_get_srcdir)/test_basic/bin ]; then mkdir $(atf_get_srcdir)/test_basic/bin; fi
    cp $(atf_get_srcdir)/../Makefile $(atf_get_srcdir)/test_basic
    cp $(atf_get_srcdir)/../bin/mksite.sh $(atf_get_srcdir)/test_basic/bin/
    
    atf_check -s exit:0 -o ignore -x "make -C $(atf_get_srcdir)/test_basic"
    atf_check -s exit:0 -o match:'<h1>Hello World</h1>' -x "cat $(atf_get_srcdir)/test_basic/out/index.html"
}

## no id
atf_test_case test_no_id

test_no_id_head() {
}

test_no_id_body() {
    if [ ! -d $(atf_get_srcdir)/test_no_id/bin ]; then mkdir $(atf_get_srcdir)/test_no_id/bin; fi
    cp $(atf_get_srcdir)/../Makefile $(atf_get_srcdir)/test_no_id
    cp $(atf_get_srcdir)/../bin/mksite.sh $(atf_get_srcdir)/test_no_id/bin/

    atf_check -s exit:1 -o ignore -e inline:'src/no-id.md has no id\n' -x "make -C $(atf_get_srcdir)/test_no_id"
    atf_check -x "test ! -f $(atf_get_srcdir)/test_no_id/out/no-id.html"
}

## test cases
atf_init_test_cases() {
    atf_add_test_case test_basic
    atf_add_test_case test_no_id
}
