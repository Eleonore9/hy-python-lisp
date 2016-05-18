#! /usr/bin/env hy

(defn read-book [ebook]
  (with [f (open ebook)]
        (let [text (.read f)
              paragraphs (.split text "\n")
              words (.split paragraphs " ")]
          words)))

(read-book "data/test_ebook.txt")

;; (with [f (open "data/test_ebook.txt")]
;;   (print (.read f)))
