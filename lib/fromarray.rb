# BSD 3-Clause License
# Copyright (c) 2020, Ruby Enterprise Edition
# All rights reserved.
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#  1. Redistributions of source code must retain the above copyright notice, this
#  list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright notice,
#  this list of conditions and the following disclaimer in the documentation
#  and/or other materials provided with the distribution.
#  3. Neither the name of the copyright holder nor the names of its
#  contributors may be used to endorse or promote products derived from
#  this software without specific prior written permission.
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

module Stream
  # A stream implemented based on an Array.
  # This class is immutable and thread-safe.
  # Author:: Mihai Andronache (amihaiemil@gmail.com)
  class FromArray
    def initialize(array)
      @array = array
    end

    # Return the number of elements in this stream.
    def count
      @array.length
    end

    # Filter out the elements which are not satisfying the given condition.
    # Example:
    #
    # stream = Stream::FromArray.new([1, 2, 3, 4, 5])
    # collected = stream.filter {|num| num % 2 == 0}.collect
    # puts collected # [2, 4]
    #
    # +condition+:: Ruby Block taking one parameter (the stream element) and
    #               returning a boolean check on it.
    def filter(&condition)
      filtered = []
      @array.each do |val|
        filtered.push(val) unless condition.call(val) == false
      end
      FromArray.new(filtered)
    end

    # Skip the first n elements of the stream.
    # +count+:: Number of elements to skip from the beginning of the stream.
    def skip(count)
      raise ArgumentError, 'count has to be positive' unless count.positive?

      skipped = []
      @array.each_with_index do |val, index|
        skipped.push(val) unless index + 1 <= count
      end
      FromArray.new(skipped)
    end

    # Collect the stream's data into an array and return it.
    def collect
      @array.dup
    end
  end
end
