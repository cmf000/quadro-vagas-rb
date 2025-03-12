require 'rails_helper'

describe 'User add a tag', type: :request do
  it 'and should authenticated' do
    user = create(:user)
    job_posting = create(:job_posting)

    post job_posting_tags_path(job_posting), params: { tag_list: 'Rails' }

    expect(response).to redirect_to new_session_path
  end

  it 'successfully' do
    user = create(:user)
    job_posting = create(:job_posting)

    login_as(user)
    post job_posting_tags_path(job_posting), params: { tag_list: 'Rails' }

    expect(job_posting.reload.tag_list.first).to eq 'rails'
  end

  it 'must be unique for same job posting' do
    user = create(:user)
    job_posting = create(:job_posting)
    job_posting.tag_list.add('teste')
    job_posting.save

    login_as(user)
    post job_posting_tags_path(job_posting), params: { tag_list: 'teste' }

    expect(job_posting.reload.tag_list.size).to eq 1
    expect(flash[:alert]).to eq 'Tag já está em uso.'
  end

  it 'and maximum tags should be 3' do
    user = create(:user)
    job_posting = create(:job_posting)
    job_posting.tag_list.add('rails')
    job_posting.tag_list.add('remoto')
    job_posting.tag_list.add('ruby')
    job_posting.save

    login_as(user)
    post job_posting_tags_path(job_posting), params: { tag_list: 'teste' }

    expect(job_posting.reload.tag_list.size).to eq 3
    expect(flash[:alert]).to eq 'Essa vaga já possui o máximo de tags'
  end
end
