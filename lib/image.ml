open! Core
module F = Format

type t = { pixels : Pixel.t array array }

let create ~height ~width ~f =
  let pixels = Array.make_matrix ~dimx:height ~dimy:width Pixel.zero in
  for row = 0 to height - 1 do
    for col = 0 to width - 1 do
      pixels.(row).(col) <- f ~row ~col
    done
  done;
  { pixels }
;;

let pp_ppm fmt { pixels } =
  let n_rows = Array.length pixels in
  let n_cols = Array.length pixels.(0) in
  F.fprintf fmt "P3@\n%d %d@\n255@\n" n_rows n_cols;
  for row = 0 to n_rows - 1 do
    for col = 0 to n_cols - 1 do
      F.fprintf fmt "%a@\n" Pixel.pp_ppm pixels.(row).(col)
    done
  done
;;
