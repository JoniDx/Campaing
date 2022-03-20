task :change_membership => :environment do
   @admins = User.where(rol:"administrador")
   @admins.each do |admin|
        puts admin.membership 
        if admin.membership <= DateTime.now
            admin.update(is_active: false)
            @lideres = User.where(create_by:admin.id)
            @lideres.each do |lider|
                lider.update(is_active: false)
            end
        end
   end
end



# require 'rake'
# Rails.application.load_tasks 
# Rake::Task['change_membership'].invoke
