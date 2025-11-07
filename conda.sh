export CONDA_EXE=$MICROMAMBA

export _CE_M=''
export _CE_CONDA=''
export CONDA_PYTHON_EXE="$CONDA_EXE"

# 初始化 Shell（必须步骤）
eval "$("$CONDA_EXE" shell hook --shell bash )"
$CONDA_EXE shell hook --shell bash  --root-prefix="${MICROMAMBA_ENV}"
MAMBA_ROOT_PREFIX="${MICROMAMBA_ENV}"
__mamba_setup="$("$CONDA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX")"

__conda_exe() (
    "$CONDA_EXE" $_CE_M $_CE_CONDA "$@"
)

__conda_hashr() {
    if [ -n "${ZSH_VERSION:+x}" ]; then
        \rehash
    elif [ -n "${POSH_VERSION:+x}" ]; then
        :  # pass
    else
        \hash -r
    fi
}

__conda_activate() {
    if [ -n "${CONDA_PS1_BACKUP:+x}" ]; then
        PS1="$CONDA_PS1_BACKUP"
        \unset CONDA_PS1_BACKUP
    fi
    \local ask_conda
    eval "$("$CONDA_EXE" shell hook --shell bash )"
    $CONDA_EXE shell hook --shell bash  --root-prefix="${MICROMAMBA_ENV}"
    MAMBA_ROOT_PREFIX="${MICROMAMBA_ENV}"
    __mamba_setup="$("$CONDA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX")"
    ask_conda="$(PS1="${PS1:-}" __conda_exe shell activate --shell bash "$@")" || \return
    \eval "$ask_conda"
    __conda_hashr
}

__conda_reactivate() {
    \local ask_conda
    ask_conda="$(PS1="${PS1:-}" __conda_exe shell reactivate --shell bash)" || \return
    \eval "$ask_conda"
    __conda_hashr
}

conda() {
    \local cmd="${1-__missing__}"
    case "$cmd" in
        activate|deactivate)
            __conda_activate "$@"
            ;;
        install|update|upgrade|remove|uninstall)
            __conda_exe "$@" || \return
            __conda_reactivate
            ;;
        *)
            __conda_exe "$@"
            ;;
    esac
}

if [ -z "${CONDA_SHLVL+x}" ]; then
    \export CONDA_SHLVL=0
    if [ -n "${_CE_CONDA:+x}" ] && [ -n "${WINDIR+x}" ]; then
        PATH="$(\dirname "$CONDA_EXE")${PATH:+":${PATH}"}"
    else
        PATH="$(\dirname "$(\dirname "$CONDA_EXE")")/bin${PATH:+":${PATH}"}"
    fi
    \export PATH

    if [ -z "${PS1+x}" ]; then
        PS1=
    fi
fi