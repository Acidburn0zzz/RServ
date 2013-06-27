##
# Copyright (C) 2013 Andrew Northall
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
# documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
# the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, 
# and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions 
# of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED 
# TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL 
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
# CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
# DEALINGS IN THE SOFTWARE.
##

class Control < RServ::Plugin
  
  def initialize
    @control = RServ::IRC::PsuedoClient.new("RServ", "rserv", "rserv.interlinked.me", "RServ Services", "SZ", ["#rserv", "#services"])
        
    $event.add(self, :on_input, "link::input")
  end
  
  def on_unload
    @control.quit
  end
  
  def on_input(line)
    if line =~ /:(\w{9}) PRIVMSG (#\w+) :(\w+)\S{0,1} (.*)$/i
      return unless @control.channels.include?($2)
      return unless $3.downcase == @control.nick.downcase
      c = $2
      user = $protocol.get_uid($1)
      if user.oper?
        command(c, user, $4)
      else
        msg(c, "Sorry, you are not an IRC operator.")
      end
    end
  end    
  
  def command(c, user, command)
    if command =~ /^eval (.*)$/i
      begin
        result = eval($1)
        msg(c, "=> #{result.to_s}")
      rescue => e
        msg(c, "!| #{e}")
        msg(c, "=> #{$1}")
        msg(c, "!| #{e}")
        msg(c, "!| #{e.backtrace.join("\n")}")
      end
    elsif command =~ /^load (\w+)$/i
      begin
        RServ::Plugin.load($1)
        msg(c, "Plugin #{$1} loaded successfully.")
      rescue LoadError => e
        msg(c, "Error loading plugin #{$1}: #{e}")
      end
    elsif command =~ /^unload (\w+)$/i
      begin
        RServ::Plugin.unload($1)
        msg(c, "Plugin #{$1} unloaded successfully.")
      rescue => e
        msg(c, "Error unloading plugin #{$1}: #{e}")
      end
    end
  end
  
  def msg(t, msg)
    @control.privmsg(t, msg)
  end
end