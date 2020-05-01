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
require 'test_helper'
require 'stream.rb'

module Stream
  class StreamTest < Minitest::Test
    # The Stream module can be created from an array
    def test_that_from_array_works
      refute_nil Stream.from_array([1, 2, 3])
    end

    # A Stream can be generated with the default limit of 100.
    def test_generates_hundred_elements
      assert(
        Stream.generate { 1 }.count == 100,
        'Default size of a generated Stream should be 100'
      )
    end

    # A Stream can be generated with a specified limit.
    def test_generates_with_limit
      assert(
        Stream.generate(15) { 1 }.count == 15,
        'Default size of a generated Stream should be 100'
      )
    end

    # Stream.generate should throw an exception if the given limit is
    # not a positive integer.
    def test_generates_with_negative_limit
      begin
        Stream.generate(-1) { 1 }
        assert(false, 'Exception was expected!')
      rescue ArgumentError => e
        assert(
          e.message == 'limit has to be a positive integer',
          'Unexpected ArgumentError message!'
        )
      end
    end

    # Stream.generate should throw an exception if the given limit is not
    # a positive integer.
    def test_generates_with_rational_limit
      begin
        Stream.generate(2.23) { 1 }
        assert(false, 'Exception was expected!')
      rescue ArgumentError => e
        assert(
          e.message == 'limit has to be a positive integer',
          'Unexpected ArgumentError message!'
        )
      end
    end
  end
end
