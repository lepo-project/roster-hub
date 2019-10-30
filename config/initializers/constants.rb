APIDOC = 'doc/apidoc.json'.freeze
CSV_BACKUP_DIR = 'backup'.freeze
CSV_FILE_PATH = 'storage/csv'.freeze
CSV_IMPORT_LOG = 'log/csv_import.log'.freeze
CSV_ZIP_FILE = 'oneroster.zip'.freeze
LIMIT = 100
OFFSET = 0
VERSION_OF_MANIFEST = '1.0'.freeze
VERSION_OF_ONEROSTER = '1.1'.freeze
# The order of the files in this array is important: Validations including associations are executed in this order.
ROSTER_FILES = %w[academicSessions categories demographics orgs resources courses users classes courseResources classResources enrollments lineItems results].freeze
# To include metadata to API responses, the metadata properties must be specified (type and description are for API documents).
METADATA = { users: { phoneticGivenName: { type: :string, description: 'Phonetic given name' }, phoneticFamilyName: { type: :string, description: 'Phonetic family name' } } }.freeze
# METADATA = {}.freeze
ZIP_MODE = true
INCLUDE_CLASSES = %w[].freeze
EXCLUDE_CLASSES = %w[].freeze
# Prescription: Set true for the case fullname is in familyName field and the delimiter is space character.
FULLNAME_IN_FAMILYNAME = false
