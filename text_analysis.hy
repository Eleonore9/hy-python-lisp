#! /usr/bin/env hy

(import os re [collections [Counter]])

(setv stop-words
      ["the" "that" "to" "as" "there" "has" "and" "or" "is" "not"
       "a" "of" "but" "in" "by" "on" "are" "it" "if" "was" "were"])

(defn list-text-files
  [dirpath]
  "Takes in a directory path and returns
   a list of text files in that directory."
  (list-comp files
             (files (map
                     (fn [f] (when (.endswith f ".txt")
                               (+ dirpath f)))
                     (os.listdir dirpath)))))

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
  [list-of-words]
  "Takes in a list of words. Returns
   the number of words and the 5 most
   frequent words in a dictionary."
  {(keyword "total-words") (len list-of-words)
   (keyword "most-frequent") (.most_common (Counter list-of-words) 5)})

(defmain [&rest args]
  (let [text-files (list-text-files (str (get args 1)))]
    (print (get args 1))
    ;; (map (fn [f]
    ;;        (-> f
    ;;            read-text
    ;;            clean-text
    ;;            summarise-text))
    ;;      text-files)
    ))
