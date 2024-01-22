public class App : Gtk.Application {

    public App () {
        Object (
            application_id: "llc.snow.contract-explorer",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_height = 480;
        main_window.default_width = 640;
        main_window.title = "App Template";
        main_window.show_all ();
    }

    public static int main (string[] args) {
        var app = new App ();
        return app.run (args);
    }
}
