project_dir := justfile_directory()

# print available just recipes
[group('project-agnostic')]
default:
    @just --list --justfile {{justfile()}}

# evaluate and print all just variables
[group('project-agnostic')]
just-vars:
    @just --evaluate

# print system information such as OS and architecture
[group('project-agnostic')]
system-info:
    @echo "architecture: {{arch()}}"
    @echo "os: {{os()}}"
    @echo "os family: {{os_family()}}"

# build console macOS binary with ncurses support
[group('development')]
build-macos-console:
    (cd src && make -f Makefile.osx-ncurses clean install) || exit 1
    @echo
    @echo "Run the 'narsil' binary in the top-level project folder."

# build native macOS app
[group('development')]
build-macos-app:
    (cd src && make -f Makefile.osx clean install) || exit 1
    @echo
    @echo "Run the game via 'NarSil.app' in the top-level project folder"

# run NarSil as console macOS binary (ASCII mode)
[group('app')]
run-macos-console:
    # Options are explained at
    # https://github.com/NickMcConnell/NarSil/blob/f121c2e/src/main-gcu.c#L1465-L1491
    ./narsil -mgcu -- -n6 -right "60x27,*" -bottom "*x12"

# run NarSil as a native macOS app
[group('app')]
run-macos-app:
    open ./NarSil.app
