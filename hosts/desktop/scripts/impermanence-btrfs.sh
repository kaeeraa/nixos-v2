set -euo pipefail

device="/dev/mapper/cryptroot"
mountPoint="/btrfs_tmp"
rootSubvolume="root"
oldRootsSubvolume="old_roots"
templateSubvolume="root-template"

cleanup() {
  umount "$mountPoint" 2>/dev/null || true
  rmdir "$mountPoint" 2>/dev/null || true
}

deleteSubvolumeTree() {
  local subvolumePath="$1"
  local nestedSubvolumes=()
  local nestedSubvolume

  while IFS= read -r nestedSubvolume; do
    [ -n "$nestedSubvolume" ] || continue
    nestedSubvolumes+=("$nestedSubvolume")
  done < <(
    btrfs subvolume list -o "$subvolumePath" |
      sed -n 's/^.* path //p' |
      sort -r
  )

  for nestedSubvolume in "${nestedSubvolumes[@]}"; do
    btrfs subvolume delete "$mountPoint/$nestedSubvolume"
  done

  btrfs subvolume delete "$subvolumePath"
}

archiveCurrentRoot() {
  local currentRoot="$mountPoint/$rootSubvolume"
  local oldRootsDirectory="$mountPoint/$oldRootsSubvolume"
  local timestamp

  mkdir -p "$oldRootsDirectory"
  timestamp="$(date '+%Y-%m-%d_%H-%M-%S')_$$"
  mv "$currentRoot" "$oldRootsDirectory/$timestamp"
}

createFreshRoot() {
  local templatePath="$mountPoint/$templateSubvolume"
  local newRootPath="$mountPoint/$rootSubvolume"

  if [ -d "$templatePath" ]; then
    btrfs subvolume snapshot "$templatePath" "$newRootPath"
  else
    btrfs subvolume create "$newRootPath"
  fi
}

pruneOldRoots() {
  local oldRootsDirectory="$mountPoint/$oldRootsSubvolume"

  [ -d "$oldRootsDirectory" ] || return 0

  find "$oldRootsDirectory" -mindepth 1 -maxdepth 1 -type d -mtime +30 -print0 |
    while IFS= read -r -d $'\0' oldRoot; do
      deleteSubvolumeTree "$oldRoot"
    done
}

trap cleanup EXIT

mkdir -p "$mountPoint"
mount -t btrfs -o subvol=/ "$device" "$mountPoint"

if [ -d "$mountPoint/$rootSubvolume" ]; then
  archiveCurrentRoot
fi

createFreshRoot
pruneOldRoots
