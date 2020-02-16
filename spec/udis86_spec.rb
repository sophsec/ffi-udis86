require 'ffi/udis86/version'

require 'spec_helper'

describe UDis86 do
  it "should have a VERSION constant" do
    expect(UDis86.const_defined?('VERSION')).to eq(true)
  end

  describe "types" do
    it "should define syntices" do
      expect(SYNTAX[:att]).to eq(:ud_translate_att)
      expect(SYNTAX[:intel]).to eq(:ud_translate_intel)
    end

    it "should define mappings from :ud_type to register names" do
      ud_type = UDis86.enum_type(:ud_type)

      UDis86::REGS.each do |type,name|
        expect(:"ud_r_#{name}").to eq(type)
        expect(ud_type[ud_type[type]]).to eq(type)
      end
    end
  end
end
