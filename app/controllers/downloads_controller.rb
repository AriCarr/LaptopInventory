class DownloadsController < ApplicationController

  def sysinfo
    bits = params[:bits]
    send_file "#{Rails.root}/public/HWiNFO#{bits}.exe", filename: "HWiNFO#{bits}.exe" if bits == '32' || bits == '64'
  end

end
