class DownloadsController < ApplicationController

  def sysinfo_64
    send_file "#{Rails.root}/public/HWiNFO64.exe", filename: "HWiNFO64.exe"
  end

  def sysinfo_32
    send_file "#{Rails.root}/public/HWiNFO64.exe", filename: "HWiNFO32.exe"
  end

end
