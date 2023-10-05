open! Core
open Rays
module F = Format

(* let sample_image () =
   let image_width = 256 in
   let image_height = 256 in
   let render ~row ~col =
   let open Float in
   let r = float_of_int row / float_of_int (Int.( - ) image_height 1) in
   let g = float_of_int col / float_of_int (Int.( - ) image_width 1) in
   let b = 0.5 in
   let factor = 255.999 in
   let r = factor * r |> int_of_float in
   let g = factor * g |> int_of_float in
   let b = factor * b |> int_of_float in
   Pixel.create (r, g, b)
   in
   Image.create ~height:image_height ~width:image_width ~f:render
   ;; *)

let raytraced_image () =
  (* Image *)
  let aspect_ratio = 16.0 /. 9.0 in
  let image_width = 400 in
  let image_height = float_of_int image_width /. aspect_ratio |> int_of_float in
  (* Camera *)
  let focal_length = 1.0 in
  let viewport_height = 2.0 in
  let viewport_width = viewport_height *. float_of_int (image_width / image_height) in
  let camera_center = Vec3d.mk 0.0 0.0 0.0 in
  (* Calc vectors left to right and top to bottom *)
  let viewport_u = Vec3d.mk viewport_width 0. 0. in
  let viewport_v = Vec3d.mk 0. (-.viewport_height) 0. in
  (* Calc the delta vectors *)
  let pixel_delta_u = Vec3d.(viewport_u / float_of_int image_width) in
  let pixel_delta_v = Vec3d.(viewport_v / float_of_int image_height) in
  (* Calc the location of the upper left pixel *)
  let viewport_upper_left =
    Vec3d.(
      camera_center - Vec3d.mk 0. 0. focal_length - (viewport_u / 2.0) - (viewport_v / 2.0))
  in
  let pixel00_loc =
    Vec3d.(viewport_upper_left + (0.5 * (pixel_delta_u + pixel_delta_v)))
  in
  let render ~row ~col =
    let pixel_center =
      Vec3d.(
        pixel00_loc
        + (float_of_int col * pixel_delta_u)
        + (float_of_int row * pixel_delta_v))
    in
    let ray_direction = Vec3d.(pixel_center - camera_center) in
    let ray = Ray.{ origin = camera_center; dir = ray_direction } in
    let color = Color.ray_color ray in
    Color.to_pixel color
  in
  Image.create ~height:image_height ~width:image_width ~f:render
;;

let () =
  let ( / ) = Eio.Path.( / ) in
  let image = raytraced_image () in
  Eio_main.run
  @@ fun env ->
  Eio.Path.read_dir @@ (Eio.Stdenv.cwd env / "images") |> List.iter ~f:print_endline;
  let path = Eio.Stdenv.cwd env / "images/test.ppm" in
  Eio.Path.save ~create:(`Or_truncate 0o600) path (F.asprintf "%a" Image.pp_ppm image);
  print_endline "Saved to file"
;;
