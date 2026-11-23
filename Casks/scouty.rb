cask "scouty" do
  arch arm: "-arm64", intel: ""

  version "1.0.0"
  sha256 arm:   "f4846f35ba2adbe51b37ec70f2b426c735b0c97af908e90ee250985054ae373b",
         intel: "437961d8fdd259e80051fcde405d14bc8e42496175219ef60d4dc710b79def1e"

  url "https://scoutyapp.it/download/desktop/Scouty-#{version}#{arch}.dmg"
  name "Scouty"
  desc "Scouting e statistiche di pallavolo"
  homepage "https://scoutyapp.it/"

  livecheck do
    url "https://scoutyapp.it/download/desktop/latest-mac.yml"
    strategy :electron_builder
  end

  auto_updates true

  app "Scouty.app"

  # App non ancora firmata con un certificato Apple: senza questo macOS la blocca come "danneggiata". Da togliere quando sara' firmata.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Scouty.app"]
  end

  zap trash: [
    "~/Library/Application Support/Scouty",
    "~/Library/Preferences/it.scoutyapp.desktop.plist",
    "~/Library/Saved Application State/it.scoutyapp.desktop.savedState",
  ]
end
