class DownloadsController < ApplicationController

  def sysinfo
    send_file "#{Rails.root}/public/HWiNFO32.exe", filename: "HWiNFO32.exe"
  end

end
