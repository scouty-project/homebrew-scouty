cask "scouty" do
  arch arm: "-arm64"

  version "1.0.0"
  sha256 arm:   "c3de0f4e38f3eb09df0ce87d4e4c17ff94492f325fc46f0bd642e7bbd3702fdd",
         intel: "f2cca1a7f43c5c8e847f48b5aaada48bf5613283d566f46e53644538c1bf148d"

  url "https://scoutyapp.it/download/desktop/Scouty-#{version}#{arch}.dmg"
  name "Scouty"
  desc "Scouting e statistiche di pallavolo"
  homepage "https://scoutyapp.it/"

  livecheck do
    url "https://scoutyapp.it/download/desktop/latest-mac.yml"
    strategy :electron_builder
  end

  depends_on :macos

  app "Scouty.app"

  # App non ancora firmata con un certificato Apple: senza questo macOS la blocca come
  # "danneggiata". Da togliere quando sara' firmata e notarizzata.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Scouty.app"],
                          writable_paths: ["Scouty.app"], writable_base: :appdir, must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/Scouty",
    "~/Library/Preferences/it.scoutyapp.desktop.plist",
    "~/Library/Saved Application State/it.scoutyapp.desktop.savedState",
  ]
end
