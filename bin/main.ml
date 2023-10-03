open! Core

(* open Rays *)
module F = Format

(* let sample_image () =
   Image.create ~height:1 ~width:1 ~f:(fun ~row ~col ->
   Pixel.create (row + 100, col + 50, 0))
   ;; *)

(* let ( / ) = Eio.Path.( / )

let () =
  (* let image = sample_image () in *)
  Eio_main.run
  @@ fun env ->
    Eio.Path.
  let path = Eio.Stdenv.cwd env / "../images/test.ppm" in
  Eio.Path.save ~create:(`Exclusive 0o600) path "0000fdsafds"
;; *)
