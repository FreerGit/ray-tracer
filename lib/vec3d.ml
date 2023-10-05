open! Core
module F = Format

type t = float * float * float

let ( + ) (v11, v12, v13) (v21, v22, v23) = v11 +. v21, v12 +. v22, v13 +. v23
let ( - ) (v11, v12, v13) (v21, v22, v23) = v11 -. v21, v12 -. v22, v13 -. v23
let ( * ) a (v1, v2, v3) = a *. v1, a *. v2, a *. v3
let ( / ) (v1, v2, v3) a = v1 /. a, v2 /. a, v3 /. a
let length_squared (v1, v2, v3) = (v1 *. v1) +. (v2 *. v2) +. (v3 *. v3)
let length v = sqrt @@ length_squared v
let unit v = v / length v
