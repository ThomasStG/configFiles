
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
set -gx MAMBA_EXE "/Users/thomas/.micromamba/bin/micromamba"
set -gx MAMBA_ROOT_PREFIX "/Users/thomas/micromamba"
$MAMBA_EXE shell hook --shell fish --prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<
