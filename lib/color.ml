open! Core
open Vec3d
module Color = Vec3d

let to_pixel t =
  let factor = 255.99 in
  let r, g, b = factor * t in
  Pixel.create (int_of_float r, int_of_float g, int_of_float b)
;;

let ray_color Ray.{ dir; _ } =
  let _, y, _ = unit dir in
  let blend_factor = 0.5 *. (y +. 1.0) in
  Color.(((1.0 -. blend_factor) * (1.0, 1.0, 1.0)) + (blend_factor * (0.5, 0.7, 1.0)))
;;
