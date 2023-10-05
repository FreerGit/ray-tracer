open! Core
module F = Format

type t =
  { x : float
  ; y : float
  ; z : float
  }

let mk x y z = { x; y; z }
let ( + ) u v = { x = u.x +. v.x; y = u.y +. v.y; z = u.z +. v.z }
let ( - ) u v = { x = u.x -. v.x; y = u.y -. v.y; z = u.z -. v.z }
let ( * ) a v = { x = a *. v.x; y = a *. v.y; z = a *. v.z }
let ( / ) v t = 1.0 /. t * v
let length_squared v = (v.x *. v.x) +. (v.y *. v.y) +. (v.z *. v.z)
let length v = sqrt @@ length_squared v
let unit v = v / length v
let dot u v = (u.x *. v.x) +. (u.y *. v.y) +. (u.z *. v.z)
