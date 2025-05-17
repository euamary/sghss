
# Create basic roles
Role.find_or_create_by!(name: 'admin', description: 'Administrator with full access')
Role.find_or_create_by!(name: 'user', description: 'Regular user with basic access')
Role.find_or_create_by!(name: 'patient', description: 'Regular user with patient access')
Role.find_or_create_by!(name: 'doctor', description: 'Regular user with doctor access')
Role.find_or_create_by!(name: 'nurse', description: 'Regular user with nurse access')
Role.find_or_create_by!(name: 'technicians', description: 'Regular user with technicians access')

# Create basic company types
Role.find_or_create_by!(name: 'hospital')
Role.find_or_create_by!(name: 'clinic')
Role.find_or_create_by!(name: 'laboratory')
Role.find_or_create_by!(name: 'home_care')
