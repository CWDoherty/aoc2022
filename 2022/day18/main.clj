(require '[clojure.string :as str])

(def input (slurp "input.txt"))
(def cubeCoords (str/split input #"\n"))

(defn get-adjacent [coord]
    (let [coord1 (list (- (nth coord 0) 1) (nth coord 1) (nth coord 2))
          coord2 (list (+ (nth coord 0) 1) (nth coord 1) (nth coord 2))
          coord3 (list (nth coord 0) (- (nth coord 1) 1) (nth coord 2))
          coord4 (list (nth coord 0) (+ (nth coord 1) 1) (nth coord 2))
          coord5 (list (nth coord 0) (nth coord 1) (- (nth coord 2) 1))
          coord6 (list (nth coord 0) (nth coord 1) (+ (nth coord 2) 1))]
    (list coord1 coord2 coord3 coord4 coord5 coord6)))

(defn get-exposed [coord]
    (let [adjacent (get-adjacent (map read-string (str/split coord #",")))]
    (- 6 (count
            (filter
                (fn [x] (.contains cubeCoords x))
                (map (fn [x] (str/join "," x)) adjacent))))))

(print "Part 1: ")
(println (apply + (map get-exposed cubeCoords)))
