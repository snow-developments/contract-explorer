project(
  'llc.snow.contract-explorer',
  'vala', 'c',
  version: '0.1.0',
  meson_version: '>= 0.56.0'
)
i18n = import('i18n')

# Minimum Vala version
vala_version_required = '0.40.0'
vala = meson.get_compiler('vala')
cc = meson.get_compiler('c')

if not vala.version().version_compare('>= @0@'.format(vala_version_required))
  error('Valac >= @0@ required!'.format(vala_version_required))
endif

add_project_arguments(
  ['--vapidir', join_paths(meson.current_source_dir(), 'vapi')],
  language: 'vala'
)

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

# Dependencies
min_glib_version = '2.56.0'

glib_dep = dependency('glib-2.0', version: '>=' + min_glib_version)
gobject_dep = dependency('gobject-2.0', version: '>=' + min_glib_version)
# TODO: Add adwaita for fancyness
# adwaita_dep = dependency(
#   'libadwaita-1',
#   version: '>=1.0.0',
#   fallback: ['libadwaita', 'libadwaita_dep'],
#   default_options: [
#     'examples=false',
#     'introspection=enabled',
#     'tests=false',
#     'vapi=true',
#   ]
# )

# Configuration
config_data = configuration_data()
config_data.set('version', meson.project_version())
config_data.set('testdata_dir', join_paths(meson.project_source_root(), 'data', 'tests'))
config_data.set('app_name', meson.project_name())
config_data.set('gettext_package', meson.project_name())
config_data.set('locale_dir', join_paths(get_option('prefix'), get_option('localedir')))

# Configure subdirectories
subdir('data')
subdir('po')

# Create a new executable, list the files we want to compile, list the dependencies we need, and install
executable(
  meson.project_name(),
  'src/Application.vala',
  # 'src/MainWindow.vala',
  # 'src/Settings.vala',
  dependencies: [
    glib_dep,
    dependency('gee-0.8'),
    dependency('gtk+-3.0', version: '>=3.20.0'),
    dependency('granite', version: '>=5.0.0'),
    dependency('sqlite3'),
  ],
  install: true
)

