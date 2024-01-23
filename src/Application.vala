using GLib;

public class App : Gtk.Application {
    private Gee.Map<string, Gee.ArrayList<string>> contractsByMime = Gee.Map.empty ();
    private Gee.ArrayList<string> otherContracts = new Gee.ArrayList<string> ();

    public App () {
        Object (
            application_id: "llc.snow.contract-explorer",
            flags: ApplicationFlags.FLAGS_NONE
        );

        var contracts = tryGetContracts();
        foreach (var contract in contracts) {
            var mime = getMimeType (contract);
            if (mime == null) {
                this.otherContracts.add (contract);
                continue;
            }
            stdout.printf (mime + "\n");
            stdout.flush ();
            // if (contractsByMime.has_key (mime)) {
            //     var items = contractsByMime.get (mime);
            //     items.add (contract);
            // } else {
            //     var items = new Gee.ArrayList<string> ();
            //     items.add (contract);
            //     contractsByMime.set (mime, items);
            // }
        }
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_height = 480;
        main_window.default_width = 640;
        main_window.title = _("Contracts");

        var source_list = new Granite.Widgets.SourceList ();
        var root = source_list.root;
        foreach (string type in contractsByMime.keys) {
            // TODO: Get the human-redable name from the MIME database
            root.add (new Granite.Widgets.SourceList.ExpandableItem (type));
        }
        main_window.add (source_list);

        main_window.show_all ();
    }

    private Gee.List<string> tryGetContracts () {
        var contracts = new Gee.ArrayList<string> ();
        try {
            var globalContractsFolder = Path.DIR_SEPARATOR_S + Path.build_filename ("usr", "share", "contractor");
            var userContractsFolder = Environment.get_home_dir () + Path.DIR_SEPARATOR_S + Path.build_filename (".local", "share", "contractor");
            string[] paths = { globalContractsFolder, userContractsFolder };

            foreach (var path in paths)
                if (FileUtils.test (path, FileTest.EXISTS))
                    contracts.add_all (listContracts (path));
        } catch (Error error) {
            stderr.printf (error.message);
        }
        return contracts;
    }

    private Gee.List<string> listContracts(string directory) throws FileError {
        var result = new Gee.ArrayList<string> ();
        var dir = Dir.open (directory);
        string? name = null;
	    while ((name = dir.read_name ()) != null) {
	        string path = Path.build_filename (directory, name);
	        if (FileUtils.test (path, FileTest.IS_DIR)) continue;
	        // TODO: Validate the file's base MIME type (text/plain)
	        if (Path.get_basename (path).has_suffix (".contract")) result.add (path);
        }
        return result;
    }

    private string? getMimeType(string path) {
        try {
            var info = File.new_for_path (path).query_info ("standard::", 0);
            var contentType = info.get_content_type ();
            if (contentType == null) return null;
            return ContentType.get_mime_type (contentType);
        } catch (Error error) {
            stderr.printf (error.message);
            return null;
        }
    }

    public static int main (string[] args) {
        var app = new App ();
        return app.run (args);
    }
}
