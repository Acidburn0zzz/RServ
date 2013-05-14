#Copyright (C) 2013 Andrew Northall
#
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
#to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
#and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
#DEALINGS IN THE SOFTWARE.

module RServ
  
  # Command class. Has three attributes:
  #   * command => the command (e.g. privmsg)
  #   * prefix => bit before (e.g. a hostmask)
  #   * params => bits after in an array
  class Command
    attr_reader :command, :prefix, :params
    alias :to_s :command
    alias :origin :prefix
    alias :uid :prefix
    alias :sid :prefix
    
    def initialize(command, params, prefix = nil)
      @command = command
      @prefix = prefix
      @params = params
    end
  end
end
