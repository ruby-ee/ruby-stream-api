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
require 'fromarray.rb'

module Stream
  # Unit tests for class FromArray
  class FromArrayTest < Minitest::Test

    # FromArray can be instantiated with an array.
    def test_instantiates
      refute_nil FromArray.new([1, 2, 3])
      refute_nil FromArray.new(['1', '2', '3'])
    end

    # FromArray can return its count
    def test_returns_count
      assert(
        FromArray.new([1, 2, 3]).count == 3
      )
      assert(
        FromArray.new([]).count.zero?
      )
    end

    # FromArray can collect its values into a new array.
    # The arrays should be equal since there is no
    # intermediary operation performed.
    def test_collects_no_modifications
      seed = [1, 2, 3]
      stream = FromArray.new(seed)
      assert(
        seed == stream.collect,
        'The seed and collected array should be the equal!'
      )
      assert(
        !seed.equal?(stream.collect),
        'The seed and collected array should not be the same!'
      )
    end

    # FromArray raises ArgumentError if the given count to skip
    # is <=0
    def test_skip_argument_error_count_negative
      stream = FromArray.new([1, 2, 3])
      begin
        stream.skip(-1)
      rescue ArgumentError => e
        assert(
          e.message == 'count has to be positive',
          'Unexpected ArgumentError message!'
        )
      end
    end

    # FromArray returns self after skipping some elements.
    def test_skip_returns_self
      stream = FromArray.new([1, 2, 3])
      assert(
        !stream.skip(1).equal?(stream),
        'Method skip should return a new instance of the modified stream'
      )
    end

    # FromArray can skip the first element.
    def test_skip_first_element
      stream = FromArray.new([1, 2, 3])
      collected = stream.skip(1).collect
      assert(
        collected == [2, 3],
        'Expected ' + [2, 3].to_s + ' but got ' + collected.to_s
      )
    end

    # FromArray can skip more than 1 element.
    def test_skip_more_elements
      stream = FromArray.new([1, 2, 3])
      collected = stream.skip(2).collect
      assert(
        collected == [3],
        'Expected ' + [3].to_s + ' but got ' + collected.to_s
      )
    end

    # FromArray can skip all the elements.
    def test_skips_all_elements
      stream = FromArray.new([1, 2, 3])
      collected = stream.skip(3).collect
      assert(
        collected == [],
        'Expected ' + [].to_s + ' but got ' + collected.to_s
      )
    end

    # FromArray can skip all the elements because the given
    # count is greater than the stream's size.
    def test_skips_all_elements_count_gt_size
      stream = FromArray.new([1, 2, 3])
      collected = stream.skip(4).collect
      assert(
        collected == [],
        'Expected ' + [].to_s + ' but got ' + collected.to_s
      )
    end

    # FromArray can filter out elements which are not satisfying the
    # condition.
    def test_filter_elements
      stream = FromArray.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      collected = stream.filter { |num| num % 2 == 0 }.collect
      collected.each do |val|
        assert(val.even?)
      end
    end

    # FromArray filters out no elements because all of them are satisfying
    # the condition.
    def test_filters_no_elements
      stream = FromArray.new([2, 4, 6, 8])
      collected = stream.filter { |num| num % 2 == 0 }.collect
      assert(stream.collect == collected)
    end

    # FromArray filters out all elements because none of are satisfying
    # the condition.
    def test_filters_all_elements
      stream = FromArray.new([2, 4, 6, 8])
      assert(stream.filter { |num| num % 2 != 0 }.count == 0)
    end

    # Filtering a stream should return a new instance rather than modifying
    # the current one.
    def test_filter_returns_new_instance
      stream = FromArray.new([2, 4, 6, 8])
      assert(!stream.filter(&:odd?).equal?(stream))
      assert(stream.collect == [2, 4, 6, 8])
    end

    # FromArray can map its elements using a given function.
    def test_map_elements
      stream = FromArray.new([1, 2, 3])
      strings = stream.map { |num| num.to_s }.collect
      strings.each do |val|
        assert(val.is_a?(String))
      end
    end

    # FromArray can map its single element.
    def test_maps_one_element
      stream = FromArray.new([1])
      strings = stream.map { |num| num.to_s }.collect
      strings.each do |val|
        assert(val.is_a?(String))
      end
    end

    # FromArray.map works when the stream is empty.
    def test_maps_no_elements
      stream = FromArray.new([])
      collected = stream.map { |val| val.to_s }.collect
      assert(collected.empty?)
    end
  end
end
