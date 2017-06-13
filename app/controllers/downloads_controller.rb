class DownloadsController < ApplicationController

  def sysinfo
    send_file "#{Rails.root}/public/HWiNFO64.exe", filename: "HWiNFO64.exe"
  end

end
