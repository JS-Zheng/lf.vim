lf()
{
    local tmp="$(mktemp)"
    # pass `LF_LAST_DIR` to a `lf` instance
    # use `command` to avoid using alias
    LF_LAST_DIR="$tmp" command lf "$@"

    # check if the file exists
    if [[ ! -f "$tmp" ]]; then
        return
    fi

    local dir="$(cat "$tmp")"
    command rm -f "$tmp"

    # check if a valid directroy
    if [[ ! -d "$dir" ]]; then
        return
    fi

    # change the working directory if necessary
    if [[ "$dir" != "$(pwd)" ]]; then
        cd -- "$dir"
    fi
}
