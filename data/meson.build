config_data = configuration_data()
config_data.set('install_prefix', get_option('prefix'))
config_data.set('bin_dir', get_option('bindir'))
config_data.set('exec_name', meson.project_name())

i18n.merge_file(
    input: 'contract-explorer.metainfo.xml.in',
    output: 'llc.snow.contract-explorer.metainfo.xml',
    install: true,
    install_dir: get_option('datadir') / 'metainfo',
    po_dir: meson.project_source_root() / 'po' / 'extra',
    type: 'xml',
)

# configure_file(
#     input: meson.project_name() + '.service.in',
#     output: meson.project_name() + '.service',
#     configuration: config_data,
#     install: true,
#     install_dir: join_paths(get_option('datadir'), 'dbus-1', 'services')
# )

desktop_in = configure_file(
    input: 'contract-explorer.desktop.in',
    output: meson.project_name() + '.desktop.untranslated.in',
    configuration: config_data,
    install: false,
)

# Translate and install .desktop file
i18n.merge_file(
    input: desktop_in,
    output: meson.project_name() + '.desktop',
    po_dir: join_paths(meson.project_source_root(), 'po', 'extra'),
    type: 'desktop',
    install: true,
    install_dir: join_paths(get_option('datadir'), 'applications')
)

install_data(
    join_paths(meson.current_source_dir(),'schemas', meson.project_name() + '.gschema.xml'),
    install_dir: join_paths(get_option('datadir'), 'glib-2.0', 'schemas')
)

# TODO: Translate and install .appdata file
# i18n.merge_file(
#   input: join_paths('data', meson.project_name() + '.appdata.xml.in'),
#   output: meson.project_name() + '.appdata.xml',
#   po_dir: join_paths(meson.project_source_root(), 'po'),
#   install: true,
#   install_dir: join_paths(get_option('datadir'), 'metainfo')
# )

# Translate and install .contract file so Files will see it
contract_in = configure_file(
    input: 'contract-explorer.contract.in',
    output: meson.project_name() + '.contract.untranslated.in',
    configuration: config_data,
    install: false,
)

i18n.merge_file(
    input: contract_in,
    output: meson.project_name() + '.contract',
    po_dir: meson.project_source_root() / 'po' / 'extra',
    type: 'xml',
    install: true,
    install_dir: join_paths(get_option('datadir'), 'contractor')
)

# Install icons
install_data(
    join_paths('icons', 'scalable', meson.project_name() + '.svg'),
    install_dir: join_paths(get_option('datadir'), 'icons', 'scalable', 'apps')
)
