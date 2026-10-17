# .cmake-format.py
# https://cmake-format.readthedocs.io/en/latest/configuration.html
# https://cmake-format.readthedocs.io/en/latest/format-usage.html

with section("format"):
    tab_size = 2
    use_tabchars = False
    line_width = 80

    # Put closing parens on a dedicated line for multi-line calls.
    dangle_parens = True

    # Insert a space after control and function names.
    separate_ctrl_name_with_space = True
    separate_fn_name_with_space = True
    
with section("markup"):
    enable_markup = True
