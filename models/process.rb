# A process represents a process to be run on the CPU. It is composed of a list of 
# bursts, which can be either IO or CPU bound. 

class SchedulerProcess
    attr_reader :bursts

    def initialize(bursts)
        @bursts = bursts
    end

end

class Burst
    attr_reader :type
    attr_reader :length

    def initialize(type, length)
        @type = type
        @length = length
    end

end