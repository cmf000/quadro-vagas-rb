require 'rails_helper'

describe 'User adds tags to job posting', type: :system do
  it 'successfully' do
    user = create(:user)
    create(:job_posting, title: 'Dev Rails Jr.')

    login_as(user)
    visit root_path
    click_on 'Dev Rails Jr.'
    click_on 'Add Tag'
    fill_in 'Tag', with: 'Sinatra'
    click_on 'Add'

    expect(page).to have_content('Tag adicionada com sucesso!')
    expect(page).to have_content('sinatra')
  end

  it 'must be unique for same job posting' do
    user = create(:user)
    job_posting = create(:job_posting, title: 'Dev Rails Jr.')
    job_posting.tag_list.add('Full-time')
    job_posting.save

    login_as(user)
    visit root_path
    click_on 'Dev Rails Jr.'
    click_on 'Add Tag'
    fill_in 'Tag', with: 'Full-time'
    click_on 'Add'

    expect(page).to have_content('Tag já está em uso.')
  end

  it 'and cant see add tags button if job_posting have 3 tags registered' do
    user = create(:user)
    job_posting = create(:job_posting, title: 'Dev Rails Jr.')
    job_posting.tag_list.add('Full-time')
    job_posting.tag_list.add('Level 1')
    job_posting.tag_list.add('Basic')
    job_posting.save

    login_as(user)
    visit root_path
    click_on 'Dev Rails Jr.'

    expect(page).not_to have_content('Add Tag')
  end

  it 'and cant access new tag page if job_posting already have 3 tags registered' do
    user = create(:user)
    job_posting = create(:job_posting, title: 'Dev Rails Jr.')
    job_posting.tag_list.add('Full-time')
    job_posting.tag_list.add('Level 1')
    job_posting.tag_list.add('Basic')
    job_posting.save

    login_as(user)
    visit new_job_posting_tag_path(job_posting)

    expect(current_path).to eq job_posting_path(job_posting)
    expect(page).to have_content('Essa vaga já possui o máximo de tags')
  end

  it 'and added tag must not be blank' do
    user = create(:user)
    job_posting = create(:job_posting, title: 'Dev Rails Jr.')

    login_as(user)
    visit root_path
    click_on 'Dev Rails Jr.'
    click_on 'Add Tag'
    fill_in 'Tag', with: ''
    click_on 'Add'

    expect(page).to have_content('Tag não pode ficar em branco')
    expect(job_posting.tag_list.count).to eq 0
  end
end