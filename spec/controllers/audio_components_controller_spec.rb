require 'spec_helper'

describe AudioComponentsController do

  describe "GET 'download'" do
    before do
      sign_in(User.make!)
      @ac = AudioComponent.make!
    end

    describe 'success' do
      before do
        get :download, :id => @ac.id
      end

      it "is successful" do
        response.should be_success
      end

      it "assigns @ac" do
        assigns[:ac].should == @ac
      end

      it 'calls send_file' do
        controller.stub!(:render)
        controller.should_receive(:send_file)
        get :download, :id => @ac.id
      end
    end

    describe 'failure' do
      before do
        AudioComponent.stub!(:find).and_return(nil)
        get :download, :id => @ac.id 
      end

      it 'redirects to root path' do
        response.should redirect_to root_path
      end

      it 'sets the flash' do
        flash[:alert].should_not be_nil
      end
    end
  end
end
