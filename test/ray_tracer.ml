open Rays
module F = Format

let%expect_test _ =
  let p = Pixel.create (0, 0, 0) in
  F.printf "%a" Pixel.pp_ppm p;
  [%expect {| 0   0   0 |}]
;;

let%expect_test _ =
  let p = Pixel.create (25, 50, 75) in
  F.printf "%a" Pixel.pp_ppm p;
  [%expect {| 25  50  75 |}]
;;

let%expect_test _ =
  let image =
    Image.create ~height:2 ~width:3 ~f:(fun ~row ~col -> Pixel.create (row, col, 0))
  in
  F.printf "%a" Image.pp_ppm image;
  [%expect {|
    P3
    2 3
    255
      0   0   0
      0   1   0
      0   2   0
      1   0   0
      1   1   0
      1   2   0 |}]
;;
