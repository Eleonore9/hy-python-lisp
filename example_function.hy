#! /usr/bin/env hy

(import os)

;; (defn read-book [ebook]
;;   (with [f (open ebook)]
;;         (let [text (.read f)
;;               paragraphs (.split text "\n")
;;               words (.split paragraphs " ")]
;;           words)))

(defn list-text-files [dirpath]
      (list-comp files
                 (files (map (fn [f] (when (.endswith f ".txt")
                                       (+ dirpath f)))
                             (os.listdir dirpath)))))

(defn read-book [text-file]
  (.read (open text-file)))
