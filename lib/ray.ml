open! Core

type t =
  { origin : Point3d.t
  ; dir : Vec3d.t
  }

let at scale { origin; dir } = Vec3d.(origin + (scale * dir))
