require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do

  let(:my_topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:sponsored_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_price ) }

  describe "GET show" do
    it "returns http success" do
      get :show, params: {topic_id: sponsored_post.topic.id, id: sponsored_post.id}
    end
  end

  it "renders the #show view" do
    get :show, params: {topic_id: my_topic.id, id: sponsored_post.id}
  end

  it "assigns sponsored_post to @post" do
    get :show, params: {topic_id: my_topic.id, id: sponsored_post.id}
  end

  describe "GET new" do
    it "returns http succes" do
      get :new, params: {topic_id: my_topic.id}
    end

    it "renders the #new view" do
      get :new, params: {topic_id: my_topic.id}
    end

    it "initializes @standard_post" do
      get :new, params: {topic_id: my_topic.id}
    end
  end

  describe "POST create" do
    it "increases the number of Post by 1" do
     expect{post :create, params: { topic_id: my_topic.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_price } } }.to change(SponsoredPost,:count).by(1)
    end

    it "assigns the new post to @post" do
      post :create, params: { topic_id: my_topic.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_price } }
    end

    it "redirects to the new post" do
      post :create, params: { topic_id: my_topic.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_price } }
      expect(response).to redirect_to [my_topic, SponsoredPosts.last]
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, params: { topic_id: my_topic.id, id: sponsored_post.id }
      expect(response).to have_http_status(:success)
    end
    it "renders the #edit view" do
      get :edit, topic_id: my_topic.id, id: sponsored_post.id
      expect(response).to render_template :edit
    end

    it "assigns post to be updated to @sponsored_post" do
      get :edit, params: { topic_id: my_topic.id, id: sponsored_post.id }
      post_instance = assigns(:sponsored_post)

       expect(post_instance.id).to eq sponsored_post.id
       expect(post_instance.title).to eq sponsored_post.title
       expect(post_instance.body).to eq sponsored_post.body
       expect(post_instance.price).to eq sponsored_post.price
    end
  end

  describe "PUT update" do
    it "updates post with expected attributes" do
       new_title = RandomData.random_sentence
       new_body = RandomData.random_paragraph
       new_price = RandomData.random_price

       put :update, params: { topic_id: my_topic.id, id: sponsored_post.id, sponsored_post: {title: new_title, body: new_body, price: new_price } }

       updated_post = assigns(:sponsored_post)
       expect(updated_post.id).to eq sponsored_post.id
       expect(updated_post.title).to eq new_title
       expect(updated_post.body).to eq new_body
       expect(updated_post.price).to eq new_price
    end

    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = RandomData.random_price

      put :update, params: { topic_id: my_topic.id, id: sponsored_post.id, sponsored_post: {title: new_title, body: new_body, price: new_price } }
      expect(response).to redirect_to [my_topic, sponsored_post]
    end
  end

  describe "DELETE destroy" do
    it "deletes the sponsored post" do
      delete :destroy, params: { topic_id: my_topic.id, id: sponsored_post.id }
       count = SponsoredPosts.where({id: sponsored_post.id}).size
       expect(count).to eq 0
    end

    it "redirects to topic show" do
       delete :destroy, params: { topic_id: my_topic.id, id: sponsored_post.id }
       expect(response).to redirect_to sponsored_post_topic
     end
  end

end
