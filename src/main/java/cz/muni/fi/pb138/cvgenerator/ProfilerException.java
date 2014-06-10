package cz.muni.fi.pb138.cvgenerator;

/**
 * Created by Hany on 10.6.2014.
 */
public class ProfilerException extends Exception {
    public ProfilerException() {}

    public ProfilerException(String message) {
        super(message);
    }

    public ProfilerException(String message, Throwable cause) {
        super(message, cause);
    }

    public ProfilerException(Throwable cause) {
        super(cause);
    }
}
