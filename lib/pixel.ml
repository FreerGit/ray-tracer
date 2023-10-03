open! Core
module F = Format

type t = int

let create (r, g, b) =
  let r = (r land 255) lsl 16 in
  let g = (g land 255) lsl 8 in
  let b = b land 255 in
  r lor g lor b
;;

let zero = create (0, 0, 0)
let r t = t lsr 16
let g t = (t lsr 8) land 255
let b t = t land 255
let pp_ppm fmt t = F.fprintf fmt "%3d %3d %3d" (r t) (g t) (b t)
