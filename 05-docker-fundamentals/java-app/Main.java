import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;

public class Main {

    private static final int PORT = 8080;

    public static void main(String[] args) throws IOException {
        HttpServer server = HttpServer.create(new InetSocketAddress(PORT), 0);

        server.createContext("/", exchange -> {
            String body = "<h1>Hello World from Java</h1><p>Served from a Docker container.</p>";
            exchange.getResponseHeaders().set("Content-Type", "text/html");
            exchange.sendResponseHeaders(200, body.getBytes().length);
            try (OutputStream out = exchange.getResponseBody()) {
                out.write(body.getBytes());
            }
        });

        server.start();
        System.out.println("Java app listening on port " + PORT);
    }
}
