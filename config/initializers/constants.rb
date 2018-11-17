APIDOC = 'doc/apidoc.json'
BACKUP_DIR = 'backup'
CSV_FILE_PATH = 'storage/csv'
CSV_IMPORT_LOG = 'storage/csv/CsvImport.log'
CSV_ZIP_FILE = 'oneroster.zip'
LIMIT = 100
VERSION_OF_MANIFEST='1.0'
VERSION_OF_ONEROSTER='1.1'
OFFSET = 0
# The order of the files in this array is important: Validations including associations are executed in this order.
ROSTER_FILES = ['academicSessions','categories','demographics','orgs','resources','courses','users','classes','courseResources','classResources','enrollments','lineItems','results']
ZIP_MODE = true
INCLUDE_CLASSES = %w[]
EXCLUDE_CLASSES = %w[]
# Prescription: Set true for the case fullname is in familyName field and the delimiter is space character.
FULLNAME_IN_FAMILYNAME = true
