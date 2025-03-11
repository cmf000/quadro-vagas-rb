require 'rails_helper'
include ActionView::RecordIdentifier

describe 'admin views job type list', type: :system do
  it 'success' do
    job_type_1 = create(:job_type, name: 'Estágio', active: true)
    job_type_2 = create(:job_type, name: 'Pleno', active: true)
    job_type_3 = create(:job_type, name: 'Júnior', active: false)
    admin = create(:user, role: :admin)

    login_as(admin)
    visit job_types_path

    within "##{dom_id job_type_1}" do
      expect(page).to have_content 'Estágio'
      expect(page).to have_content 'Ativo'
      expect(page).to have_content 'Editar'
    end

    within "##{dom_id job_type_2}" do
      expect(page).to have_content 'Pleno'
      expect(page).to have_content 'Ativo'
      expect(page).to have_content 'Editar'
    end

    within "##{dom_id job_type_3}" do
      expect(page).to have_content 'Júnior'
      expect(page).to have_content 'Arquivado'
      expect(page).to have_content 'Editar'
    end
  end

  it 'user must be admin' do
    regular = create(:user, role: :regular)

    login_as(regular)
    visit job_types_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso não autorizado'
  end

  it 'user must be authenticated' do
    visit job_types_path

    expect(current_path).to eq new_session_path
  end
end
