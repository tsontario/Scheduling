# An implementation of the first-come, first-serve algorithm for process scheduling.
# This is the most naive implementation of a scheduling algorithm, and assumes that there
# is only a ready queue for processes and no other blocking queues (IO, etc.). 

require_relative 'models/process.rb'

class FCFS
    def initialize
        @processes = Array.new
        @time = 0
        @running = nil
    end

    def add(process)
        if @running == nil
            burst = process.bursts.shift
            @running = {process: process, time_remaining: burst.length}
        else
            @processes.push(process)
        end
    end

    def step
        @time += 1
        # First, step the process if it's running
        if @running
            @running[:time_remaining] -= 1
            if @running[:time_remaining] == 0
                @running = nil
                puts "process #{@running} has finished at time #{@time}"
            end
        end

        if done
            puts "No more work to do"
            return
        end

        if @running == nil
            p = @processes.shift
            @running = {process: p, time_remaining: p.bursts.shift.length}  #running now contains a running process
        end
        
    end

    def state
        puts "Ready queue: #{@processes}"
        puts "Running queue: #{@running}"
    end

    private

    def done
        @processes.empty? && @running == nil
    end
end

# Running
scheduler = FCFS.new

processes = [
    SchedulerProcess.new([Burst.new("CPU", 8)]),
    SchedulerProcess.new([Burst.new("CPU", 4)]),
    SchedulerProcess.new([Burst.new("CPU", 1)])
]

processes.each { |p|
    scheduler.add(p)
}


15.times {
    scheduler.step
}

