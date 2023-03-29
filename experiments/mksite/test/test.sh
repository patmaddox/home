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

## test cases
atf_init_test_cases() {
    atf_add_test_case test_basic
}
