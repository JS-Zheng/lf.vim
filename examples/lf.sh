lf()
{
    local tmp_dir="$(mktemp -d)"
    trap 'command rm -rf -- '"$tmp_dir" EXIT

    local lf_last_dir="$tmp_dir/lf_last_dir"

    # Use `command` to avoid using alias
    LF_LAST_DIR="$lf_last_dir" command lf "$@"

    # check if the file exists
    if [[ ! -f "$lf_last_dir" ]]; then
        return
    fi

    local dir="$(<"$lf_last_dir")"

    # check if a valid directory
    if [[ ! -d "$dir" ]]; then
        return
    fi

    # change the working directory if necessary
    if [[ "$dir" != "$PWD" ]]; then
        cd -- "$dir"
    fi
}
