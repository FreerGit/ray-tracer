open! Core
open Vec3d
open Ray
(* module Color = Vec3d *)

(* This is a little wierd, i can't be bothered to impl. operators for another record
   so I simply mirror vec3d. Altough I should probably use r g b instead of x y z. *)
type t = Vec3d.t

let to_pixel t =
  let factor = 255.99 in
  let v = factor * t in
  Pixel.create (int_of_float v.x, int_of_float v.y, int_of_float v.z)
;;

let hit_sphere center radius ray =
  let oc = ray.origin - center in
  let a = length_squared ray.dir in
  let half_b = dot oc ray.dir in
  let c = length_squared oc -. (radius *. radius) in
  let discriminant = (half_b *. half_b) -. (a *. c) in
  if Float.( < ) discriminant 0. then -1.0 else (-.half_b -. sqrt discriminant) /. a
;;

let ray_color ray =
  let t = hit_sphere { x = 0.; y = 0.; z = -1. } 0.5 ray in
  if Float.( > ) t 0.
  then (
    let normal = unit @@ (at t ray - { x = 0.; y = 0.; z = -1. }) in
    0.5 * { x = normal.x +. 1.; y = normal.y +. 1.; z = normal.z +. 1. })
  else (
    let { y; _ } = unit ray.dir in
    let blend_factor = 0.5 *. (y +. 1.0) in
    ((1.0 -. blend_factor) * { x = 1.; y = 1.; z = 1.0 })
    + (blend_factor * { x = 0.5; y = 0.7; z = 1. }))
;;
