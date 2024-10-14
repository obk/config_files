# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

eval "$(oh-my-posh init bash --config 'https://raw.githubusercontent.com/obk/config_files/refs/heads/master/obk.omp.json')"
ff() {
    echo "Cleaning all DNF cache options..."
    sudo dnf update -y
    sudo dnf clean dbcache
    sudo dnf clean metadata
    sudo dnf clean packages
    sudo dnf clean all
    echo "All DNF cache options cleaned successfully!"
    echo "Flatpak part"
    flatpak update -y
    flatpak uninstall --unused
    sudo rm -rfv /var/tmp/flatpak-cache-*
}
alias stats='glances'
