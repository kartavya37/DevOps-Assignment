package main

import (
	"fmt"
	"log"
	"net/http"
)

const port = ":8080"

func handler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/html")
	fmt.Fprint(w, "<h1>Hello World from Docker multi-stage build</h1>")
}

func main() {
	http.HandleFunc("/", handler)
	log.Printf("listening on %s", port)
	log.Fatal(http.ListenAndServe(port, nil))
}
