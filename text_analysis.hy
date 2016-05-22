#! /usr/bin/env hy

(import os re pprint [collections [Counter]])

(setv stop-words
      ["the" "that" "to" "as" "there" "has" "and" "or" "is" "not"
       "a" "of" "but" "in" "by" "on" "are" "it" "if" "was" "were"])

(defn list-text-files
  [dirpath]
  "Takes in a directory path and returns
   a list of text files in that directory."
  (list-comp (os.path.join dirpath files) ;; get the full file path
             (files (list (filter ;; keep files w/ .txt extension
                           (fn [f] (.endswith f ".txt"))
                           (os.listdir dirpath))))))

(defn read-text
  [file-path]
  "Takes in a text file path and
   returns the text a string."
  (.read (open file-path)))

(defn clean-text
  [text]
  "Takes in a text as a string.
   Returns the words as a list."
  (->> (.lower text)
       (re.sub r"[,\.\(\)_\*:?!'\"\[\];]" "") ;; remove punctuation
       (re.split r"[\s]") ;; split on single whitespace character
       (filter (fn [w] (not (empty? w)))) ;; filter out empty strings
       list))

(defn remove-stopwords
  [list-of-words]
  (list-comp words
             (words (list (filter (fn [w] (not (in w stop-words)))
                                  list-of-words)))))

(defn summarise-text
  [list-of-words filename]
  "Takes in a list of words. Returns
   the number of words and the 5 most
   frequent words in a dictionary."
  {"filename" filename
   "total-words" (len list-of-words)
   "most-frequent" (.most_common (Counter list-of-words) 5)})

(defn analyse-texts [dirpath]
  (setv text-files (list-text-files dirpath))
  (list (map (fn [f]
               (setv filename f)
               (-> f
                   read-text
                   clean-text
                   remove-stopwords
                   (summarise-text filename)))
             text-files)))

(defmain [&rest args]
  (-> args
      (get 1)
      analyse-texts
      pprint.pprint))
