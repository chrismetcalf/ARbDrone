require 'spec_helper'
require 'arbdrone/control'

class UDPSocket
  # Override UDPSocket for tests so we don't actually
  # generate any network traffic.
  def bind(*args); end
  def connect(*args); end
  def send(data, flags = 0); end
end

describe ARbDrone::Control do
  before :each do
    @drone  = ARbDrone::Control.new
    @socket = @drone.instance_variable_get(:@socket)
  end

  after :each do
    @drone  = nil
    @socket = nil
  end

  it 'should set the correct default drone IP and port' do
    sock = UDPSocket.new
    flexmock(UDPSocket).should_receive(:new).once.and_return(sock)
    flexmock(sock).should_receive(:connect).once.with('192.168.0.1', 5556)
    ARbDrone::Control.new
  end

  describe '#next_seq' do
    it 'should default the sequence number to 1' do
      drone = ARbDrone::Control.new
      drone.next_seq.should == 1
    end

    it 'should increment the sequence number on subsequent calls' do
      drone = ARbDrone::Control.new
      drone.next_seq.should == 1
      drone.next_seq.should == 2
      drone.next_seq.should == 3
    end
  end

  describe '#send_cmd' do
    it 'should append a newline after each statement' do
      flexmock(@socket).should_receive(:send).once.with("AT*FAKE=1,\n", 0)
      @drone.send_cmd('AT*FAKE')
    end
  end

  describe '#ref' do
    before :each do
      @flags  = 1 << 18
      @flags |= 1 << 20
      @flags |= 1 << 22
      @flags |= 1 << 24
      @flags |= 1 << 28

      # Reset the sequence number on each iteration.
      @drone.seq = nil
    end

    it 'should set the constant bits in the input' do
      @drone.ref(0).should == ['AT*REF', @flags]
    end

    it 'should preserve input bits' do
      input = 1 << 8
      flags = @flags | input
      @drone.ref(input).should == ['AT*REF', flags]
    end

    it 'should increment the sequence number on subsequent calls' do
      @drone.ref(0).should == ['AT*REF', @flags]
      @drone.ref(0).should == ['AT*REF', @flags]
      @drone.ref(0).should == ['AT*REF', @flags]
    end
  end

  describe "#pcmd" do
    before :each do
      # Reset the sequence number on each iteration.
      @drone.seq = nil
    end

    it 'should format the arguments' do
      @drone.pcmd(1, -0.9, -0.5, 0.2, 0.7).should == ['AT*PCMD', '1,-1083808154,-1090519040,1045220557,1060320051']
    end

    it 'should limit inputs that exceed the min/max' do
      @drone.pcmd(1, -1.9, -1.5, 1.2, 1.7).should == ['AT*PCMD', '1,-1082130432,-1082130432,1065353216,1065353216']
    end
  end

  describe '#minmax' do
    it 'should appropriately cap minimum values' do
      @drone.minmax(-1.0, 0, -1.5).should == [-1.0]
    end

    it 'should appropriately cap maximum values' do
      @drone.minmax(0, 1.0, 1.5).should == [1.0]

    end

    it 'should preserve valid values' do
      @drone.minmax(-1.0, 1.0, 0.5).should == [0.5]
    end

    it 'should process multiple values' do
      @drone.minmax(-1.0, 1.0, -1.5, -0.5, 1.5).should == [-1.0, -0.5, 1.0]
    end
  end

  describe '#takeoff' do
    before :each do
      # Reset the sequence number on each iteration.
      @drone.seq = nil
    end

    it 'should generate the correct command' do
      flexmock(@socket).should_receive(:send).once.with("AT*REF=1,290718208\n", 0)
      @drone.takeoff
    end
  end

  describe '#land' do
    before :each do
      @drone.seq = nil
    end

    it 'should generate the correct command' do
      flexmock(@socket).should_receive(:send).once.with("AT*REF=1,290717696\n", 0)
      @drone.land
    end
  end

  describe '#steer' do
    it 'should generate the correct command' do
      flexmock(@drone).should_receive(:pcmd).once.with(1, 0.5, 0.2, -0.1, -0.3).and_return ['AT*PCMD', '1,0,0,0,0']
      @drone.steer 0.5, 0.2, -0.1, -0.3
    end
  end

  describe '#hover' do
    it 'should generate the correct command' do
      flexmock(@socket).should_receive(:send).once.with("AT*PCMD=1,0,0,0,0,0\n", 0)
      @drone.hover
    end
  end

  describe '#reset_trim' do
    it 'should generate the correct command' do
      flexmock(@socket).should_receive(:send).once.with("AT*FTRIM=1,\n", 0)
      @drone.reset_trim
    end
  end

  describe '#heartbeat' do
    it 'should generate the correct command' do
      flexmock(@socket).should_receive(:send).once.with("AT*COMWDG=1,\n", 0)
      @drone.heartbeat
    end
  end

  describe '#blink' do
    it 'should generate the correct command' do
      flexmock(@socket).should_receive(:send).once.with("AT*LED=1,2,3,4\n", 0)
      @drone.blink 2,3,4
    end
  end

  describe '#dance' do
    it 'should generate the correct command' do
      flexmock(@socket).should_receive(:send).once.with("AT*ANIM=1,2,3\n", 0)
      @drone.dance 2,3
    end
  end

  describe '#set_option' do
    it 'should enclose variable names and values in double-quotes' do
      flexmock(@socket).should_receive(:send).once.with("AT*CONFIG=1,\"name\",\"value\"\n", 0)
      @drone.set_option('name', 'value')
    end
  end
end
