package main

import (
	"log"
	"net/http"
	"os"
	"strings"

	"github.com/go-chi/chi"
)

var stdoutLogger = log.New(os.Stdout, "", log.LstdFlags)

func main() {
	r := chi.NewRouter()

	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("S6 overlay is awesome!"))
	})
	r.Get("/env", func(w http.ResponseWriter, r *http.Request) {
		env := os.Environ()
		envStr := strings.Join(env, "\n")
		w.Write([]byte(envStr))
	})

	r.Get("/health/alive", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("alive"))
	})
	r.Get("/health/ready", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("ready"))
	})
	stdoutLogger.Println("Server listening on port 8080")
	stdoutLogger.Println("  - Application env at: '/env'")
	stdoutLogger.Println("  - Health and Prob at: '/health/alive' and '/health/ready'")
	err := http.ListenAndServe(":8080", r)
	if err != nil {
		stdoutLogger.Fatalf("ListenAndServe error: %v", err)
	}
}
