require 'spec_helper'
require 'arbdrone/nav_data'

class NavDrone
  include ARbDrone::NavData
end

describe ARbDrone::NavData do
  describe "#receive_data" do
    before :each do
      @drone  = NavDrone.new
      @drone.setup(0,0)
  
      @bootup_packet = "\x88wfUT\b\xCA\xCF\x01\x00\x00\x00\x00\x00\x00\x00\xFF\xFF\b\x00\xB0\x03\x00\x00" 
      @flying_packet ="\x88wfU5\x00\x80\x0F=\n\x00\x00\x00\x00\x00\x00\x00\x00\x94\x00\x00\x00\x02\x00&\x00\x00\x00\x00 \xA1D\x00\x00\xC2\xC2@C\x01\xC8\x05\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xE4\x9C\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x03\x00\x00\x00~v,\xBF\xDB'=?\xB8\x01d\xBC\xF9\x19=\xBF\xC5\x7F,\xBF\x98\x9B\x91\xBC\x04h\xB8\xBC\xB8\e\xDE\xBAM\xEF\x7F?\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\b\x00\xD9\xB1\n\x13\x02\x00(\x00D\b\xC0\a\xA8\vs\x06\x84\x06n\x06B\x06\x8E\x06,.\x00\x00\x00\x00\x00\x00\xAE\x0E\x00\x00\x98H\x02\x00x\x00\x01\x00\x03\x00.\x00\n\xCF3B\xF9\x05p\xB8\x9BB\xC9\xB5#B\xBC\x18w\xC4\xB0\x88\xEC;\bi\xEC\xBC<@8=\x00\x00\x00\x00\x00\x00\x00\x00\x80\x06\x00\x00\x04\x00\x10\x00LT\x04??\xB2q\xBD\x00\x00\x00\x00\x05\x00\f\x00\x00\xA0\x8CE\x000\x14\xC5\x06\x00$\x00N\a\x00\x00\xAA\xD0\xFF\xFF\xDC\xCF\xFF\xFF\xB4\x03\x00\x00\xDE\xEC\xFF\xFF\xED\xBB\x00\x00\x00*\x00\x00\x00x\x02\x00\a\x00\x10\x00\x00\x00\x00\x006\xB0Z@P\xEC\x0E\xC0\b\x00\x18\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\t\x00D\x00\x00\x00\x00\x00\xFF\xFF\xFF\xFF@\x01\x00\x00?\x01\x00\x00\x00\x80\xEBCcf<\xC0\v\x00\x00\x00\x00\x00\x00\x000\x00\x00\x00`w\x86\xBE\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\n\x008\x00\x05\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x05\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\v\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\f\x00,\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\r\x00\\\x00\x00\x00\x00\x00\x00\x00\x00\x00333?\xE1\xDA2\xBE\x00\x00\x00\x00rg\x84<\x00\x00\x00\x00v\xD7\xB8<C?\xDE\xBAP\xDB\x13\xC0\x05\x01\x00\x00\x15g\n\x13\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00u\x93@5\x7Fj\xB2\xB6`\xE5\\7\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0E\x00l\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0F\x00l\x01\xFF\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00X\x00\x00\x00H\x00\x00\x003\x00\x00\x00\x18\x00\x00\x00U\x00\x00\x00\x18\x00\x00\x00w\x00\x00\x00\x18\x00\x00\x00\x95\x00\x00\x00\x18\x00\x00\x00\x17\x00\x00\x006\x00\x00\x003\x00\x00\x006\x00\x00\x00U\x00\x00\x006\x00\x00\x00w\x00\x00\x006\x00\x00\x00\x95\x00\x00\x006\x00\x00\x00\x17\x00\x00\x00Z\x00\x00\x003\x00\x00\x00Z\x00\x00\x00U\x00\x00\x00Z\x00\x00\x00w\x00\x00\x00Z\x00\x00\x00\x9C\x00\x00\x00Q\x00\x00\x00\x17\x00\x00\x00w\x00\x00\x003\x00\x00\x00w\x00\x00\x00U\x00\x00\x00w\x00\x00\x00w\x00\x00\x00w\x00\x00\x00\x86\x00\x00\x00n\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00x\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x11\x00\b\x00\x87\x13\x00\x00\x12\x00(\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x1D\x00\x1F\x18M\x00\x00\xE4\x9C\x00\x00P\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x14\x00\f\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFF\xFF\b\x00\xB0|\x00\x00"
    end

    it 'should properly update the drone state' do
      @drone.receive_data @bootup_packet
      @drone.drone_state.should_not == 0
    end

    it 'should detect the bootup flag' do
      @drone.receive_data @bootup_packet
      @drone.in_bootstrap?.should be true
    end

    it 'should detect the flying flag' do
      @drone.receive_data @flying_packet
      @drone.is_flying?.should be true
    end
  end
end
