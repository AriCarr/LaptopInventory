class DownloadsController < ApplicationController

  def sysinfo_64
    sysinfo('64')
  end

  def sysinfo_32
    sysinfo('32')
  end

  def sysinfo(bits)
    send_file "#{Rails.root}/public/HWiNFO#{bits}.exe", filename: "HWiNFO#{bits}.exe"
  end

end
