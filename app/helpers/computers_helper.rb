module ComputersHelper

  def list_init
    @list_counter = 0
  end

  def list
    @list_counter += 1
    "#{@list_counter}."
  end

  def sysinfo_link(text, bits)
    link_to text, sysinfo_path(bits: bits), download: ''
  end

end
