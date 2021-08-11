package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"log"
	"net/http"
	"rsc.io/quote/v3"
	"time"
)

func main() {
	fmt.Println("starting http server ")
	r := mux.NewRouter()
	r.HandleFunc("/", helloworld)
	r.HandleFunc("/go", goquote)
	r.HandleFunc("/opt", opttruth)

	s := &http.Server{
		Handler:      r,
		Addr:         "0.0.0.0:8000",
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}

	log.Fatal(s.ListenAndServe())
}

func helloworld(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, quote.HelloV3())
}

func goquote(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, quote.GoV3())
}

func opttruth(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, quote.OptV3())
}
