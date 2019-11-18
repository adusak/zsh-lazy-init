# Lazy load any tool, with multiple entrypoints
# Usage: add_lazy init_function_name entrypoint1 entrypoint2 
# Example: add_lazy pre_nvm nvm npm node gulp yarn

join_by() { local IFS="$1"; shift; echo "$*"; }
typeset -A entrypoint_init_mapping
typeset -A entrypoint_group_mapping
add_lazy() {
    function_name=$1; shift 1; entrypoints=("$@") # init arguments
    for entrypoint in $entrypoints; do
        entrypoint_group_mapping["${entrypoint}"]=$(join_by , $entrypoints) # create mapping command -> command group where commands are separated by ,
        entrypoint_init_mapping["${entrypoint}"]=$function_name # create mapping command -> init function
        $entrypoint() { # declare function for each command
            local group=$entrypoint_group_mapping["${0}"]
            a=(); while read -rd,; do a+=("$REPLY"); done <<<"$group,"; # Split commands to arrays
            for command in $a ; do 
                unset -f $command # each commanf from group must be unset so the pre-function is not initiated again
            done
            $entrypoint_init_mapping["${0}"] # launch the init funnction
            $0 $@
        }
    done
}
