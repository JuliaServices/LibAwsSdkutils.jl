using CEnum

"""
Documentation not found.
"""
mutable struct aws_profile_property end

"""
Documentation not found.
"""
mutable struct aws_profile end

"""
Documentation not found.
"""
mutable struct aws_profile_collection end

"""
    aws_profile_source_type

The profile specification has rule exceptions based on what file the profile collection comes from.
"""
@cenum aws_profile_source_type::UInt32 begin
    AWS_PST_NONE = 0
    AWS_PST_CONFIG = 1
    AWS_PST_CREDENTIALS = 2
end

"""
    aws_profile_section_type

Documentation not found.
"""
@cenum aws_profile_section_type::UInt32 begin
    AWS_PROFILE_SECTION_TYPE_PROFILE = 0
    AWS_PROFILE_SECTION_TYPE_SSO_SESSION = 1
    AWS_PROFILE_SECTION_TYPE_COUNT = 2
end

"""
    aws_profile_collection_acquire(collection)

Increments the reference count on the profile collection, allowing the caller to take a reference to it.

Returns the same profile collection passed in.

### Prototype
```c
struct aws_profile_collection *aws_profile_collection_acquire(struct aws_profile_collection *collection);
```
"""
function aws_profile_collection_acquire(collection)
    ccall((:aws_profile_collection_acquire, libaws_c_sdkutils), Ptr{aws_profile_collection}, (Ptr{aws_profile_collection},), collection)
end

"""
    aws_profile_collection_release(collection)

Decrements a profile collection's ref count. When the ref count drops to zero, the collection will be destroyed. Returns NULL.

### Prototype
```c
struct aws_profile_collection *aws_profile_collection_release(struct aws_profile_collection *collection);
```
"""
function aws_profile_collection_release(collection)
    ccall((:aws_profile_collection_release, libaws_c_sdkutils), Ptr{aws_profile_collection}, (Ptr{aws_profile_collection},), collection)
end

"""
    aws_profile_collection_destroy(profile_collection)

!!! compat "Deprecated"

    This is equivalent to [`aws_profile_collection_release`](@ref).

### Prototype
```c
void aws_profile_collection_destroy(struct aws_profile_collection *profile_collection);
```
"""
function aws_profile_collection_destroy(profile_collection)
    ccall((:aws_profile_collection_destroy, libaws_c_sdkutils), Cvoid, (Ptr{aws_profile_collection},), profile_collection)
end

"""
    aws_profile_collection_new_from_file(allocator, file_path, source)

Create a new profile collection by parsing a file with the specified path

### Prototype
```c
struct aws_profile_collection *aws_profile_collection_new_from_file( struct aws_allocator *allocator, const struct aws_string *file_path, enum aws_profile_source_type source);
```
"""
function aws_profile_collection_new_from_file(allocator, file_path, source)
    ccall((:aws_profile_collection_new_from_file, libaws_c_sdkutils), Ptr{aws_profile_collection}, (Ptr{aws_allocator}, Ptr{aws_string}, aws_profile_source_type), allocator, file_path, source)
end

"""
    aws_profile_collection_new_from_merge(allocator, config_profiles, credentials_profiles)

Create a new profile collection by merging a config-file-based profile collection and a credentials-file-based profile collection

### Prototype
```c
struct aws_profile_collection *aws_profile_collection_new_from_merge( struct aws_allocator *allocator, const struct aws_profile_collection *config_profiles, const struct aws_profile_collection *credentials_profiles);
```
"""
function aws_profile_collection_new_from_merge(allocator, config_profiles, credentials_profiles)
    ccall((:aws_profile_collection_new_from_merge, libaws_c_sdkutils), Ptr{aws_profile_collection}, (Ptr{aws_allocator}, Ptr{aws_profile_collection}, Ptr{aws_profile_collection}), allocator, config_profiles, credentials_profiles)
end

"""
    aws_profile_collection_new_from_buffer(allocator, buffer, source)

Create a new profile collection by parsing text in a buffer. Primarily for testing.

### Prototype
```c
struct aws_profile_collection *aws_profile_collection_new_from_buffer( struct aws_allocator *allocator, const struct aws_byte_buf *buffer, enum aws_profile_source_type source);
```
"""
function aws_profile_collection_new_from_buffer(allocator, buffer, source)
    ccall((:aws_profile_collection_new_from_buffer, libaws_c_sdkutils), Ptr{aws_profile_collection}, (Ptr{aws_allocator}, Ptr{aws_byte_buf}, aws_profile_source_type), allocator, buffer, source)
end

"""
    aws_profile_collection_get_profile(profile_collection, profile_name)

Retrieves a reference to a profile with the specified name, if it exists, from the profile collection

### Prototype
```c
const struct aws_profile *aws_profile_collection_get_profile( const struct aws_profile_collection *profile_collection, const struct aws_string *profile_name);
```
"""
function aws_profile_collection_get_profile(profile_collection, profile_name)
    ccall((:aws_profile_collection_get_profile, libaws_c_sdkutils), Ptr{aws_profile}, (Ptr{aws_profile_collection}, Ptr{aws_string}), profile_collection, profile_name)
end

"""
    aws_profile_collection_get_section(profile_collection, section_type, section_name)

Documentation not found.
### Prototype
```c
const struct aws_profile *aws_profile_collection_get_section( const struct aws_profile_collection *profile_collection, const enum aws_profile_section_type section_type, const struct aws_string *section_name);
```
"""
function aws_profile_collection_get_section(profile_collection, section_type, section_name)
    ccall((:aws_profile_collection_get_section, libaws_c_sdkutils), Ptr{aws_profile}, (Ptr{aws_profile_collection}, aws_profile_section_type, Ptr{aws_string}), profile_collection, section_type, section_name)
end

"""
    aws_profile_collection_get_profile_count(profile_collection)

Returns the number of profiles in a collection

### Prototype
```c
size_t aws_profile_collection_get_profile_count(const struct aws_profile_collection *profile_collection);
```
"""
function aws_profile_collection_get_profile_count(profile_collection)
    ccall((:aws_profile_collection_get_profile_count, libaws_c_sdkutils), Csize_t, (Ptr{aws_profile_collection},), profile_collection)
end

"""
    aws_profile_collection_get_section_count(profile_collection, section_type)

Returns the number of elements of the specified section in a collection.

### Prototype
```c
size_t aws_profile_collection_get_section_count( const struct aws_profile_collection *profile_collection, const enum aws_profile_section_type section_type);
```
"""
function aws_profile_collection_get_section_count(profile_collection, section_type)
    ccall((:aws_profile_collection_get_section_count, libaws_c_sdkutils), Csize_t, (Ptr{aws_profile_collection}, aws_profile_section_type), profile_collection, section_type)
end

"""
    aws_profile_get_name(profile)

Returns a reference to the name of the provided profile

### Prototype
```c
const struct aws_string *aws_profile_get_name(const struct aws_profile *profile);
```
"""
function aws_profile_get_name(profile)
    ccall((:aws_profile_get_name, libaws_c_sdkutils), Ptr{aws_string}, (Ptr{aws_profile},), profile)
end

"""
    aws_profile_get_property(profile, property_name)

Retrieves a reference to a property with the specified name, if it exists, from a profile

### Prototype
```c
const struct aws_profile_property *aws_profile_get_property( const struct aws_profile *profile, const struct aws_string *property_name);
```
"""
function aws_profile_get_property(profile, property_name)
    ccall((:aws_profile_get_property, libaws_c_sdkutils), Ptr{aws_profile_property}, (Ptr{aws_profile}, Ptr{aws_string}), profile, property_name)
end

"""
    aws_profile_get_property_count(profile)

Returns how many properties a profile holds

### Prototype
```c
size_t aws_profile_get_property_count(const struct aws_profile *profile);
```
"""
function aws_profile_get_property_count(profile)
    ccall((:aws_profile_get_property_count, libaws_c_sdkutils), Csize_t, (Ptr{aws_profile},), profile)
end

"""
    aws_profile_property_get_value(property)

Returns a reference to the property's string value

### Prototype
```c
const struct aws_string *aws_profile_property_get_value(const struct aws_profile_property *property);
```
"""
function aws_profile_property_get_value(property)
    ccall((:aws_profile_property_get_value, libaws_c_sdkutils), Ptr{aws_string}, (Ptr{aws_profile_property},), property)
end

"""
    aws_profile_property_get_sub_property(property, sub_property_name)

Returns a reference to the value of a sub property with the given name, if it exists, in the property

### Prototype
```c
const struct aws_string *aws_profile_property_get_sub_property( const struct aws_profile_property *property, const struct aws_string *sub_property_name);
```
"""
function aws_profile_property_get_sub_property(property, sub_property_name)
    ccall((:aws_profile_property_get_sub_property, libaws_c_sdkutils), Ptr{aws_string}, (Ptr{aws_profile_property}, Ptr{aws_string}), property, sub_property_name)
end

"""
    aws_profile_property_get_sub_property_count(property)

Returns how many sub properties the property holds

### Prototype
```c
size_t aws_profile_property_get_sub_property_count(const struct aws_profile_property *property);
```
"""
function aws_profile_property_get_sub_property_count(property)
    ccall((:aws_profile_property_get_sub_property_count, libaws_c_sdkutils), Csize_t, (Ptr{aws_profile_property},), property)
end

"""
    aws_get_credentials_file_path(allocator, override_path)

Computes the final platform-specific path for the profile credentials file. Does limited home directory expansion/resolution.

override\\_path, if not null, will be searched first instead of using the standard home directory config path

### Prototype
```c
struct aws_string *aws_get_credentials_file_path( struct aws_allocator *allocator, const struct aws_byte_cursor *override_path);
```
"""
function aws_get_credentials_file_path(allocator, override_path)
    ccall((:aws_get_credentials_file_path, libaws_c_sdkutils), Ptr{aws_string}, (Ptr{aws_allocator}, Ptr{aws_byte_cursor}), allocator, override_path)
end

"""
    aws_get_config_file_path(allocator, override_path)

Computes the final platform-specific path for the profile config file. Does limited home directory expansion/resolution.

override\\_path, if not null, will be searched first instead of using the standard home directory config path

### Prototype
```c
struct aws_string *aws_get_config_file_path( struct aws_allocator *allocator, const struct aws_byte_cursor *override_path);
```
"""
function aws_get_config_file_path(allocator, override_path)
    ccall((:aws_get_config_file_path, libaws_c_sdkutils), Ptr{aws_string}, (Ptr{aws_allocator}, Ptr{aws_byte_cursor}), allocator, override_path)
end

"""
    aws_get_profile_name(allocator, override_name)

Computes the profile to use for credentials lookups based on profile resolution rules

### Prototype
```c
struct aws_string *aws_get_profile_name(struct aws_allocator *allocator, const struct aws_byte_cursor *override_name);
```
"""
function aws_get_profile_name(allocator, override_name)
    ccall((:aws_get_profile_name, libaws_c_sdkutils), Ptr{aws_string}, (Ptr{aws_allocator}, Ptr{aws_byte_cursor}), allocator, override_name)
end

"""
Documentation not found.
"""
mutable struct aws_endpoints_ruleset end

"""
Documentation not found.
"""
mutable struct aws_partitions_config end

"""
Documentation not found.
"""
mutable struct aws_endpoints_parameter end

"""
Documentation not found.
"""
mutable struct aws_endpoints_rule_engine end

"""
Documentation not found.
"""
mutable struct aws_endpoints_resolved_endpoint end

"""
Documentation not found.
"""
mutable struct aws_endpoints_request_context end

"""
    aws_endpoints_parameter_type

Documentation not found.
"""
@cenum aws_endpoints_parameter_type::UInt32 begin
    AWS_ENDPOINTS_PARAMETER_STRING = 0
    AWS_ENDPOINTS_PARAMETER_BOOLEAN = 1
end

"""
    aws_endpoints_resolved_endpoint_type

Documentation not found.
"""
@cenum aws_endpoints_resolved_endpoint_type::UInt32 begin
    AWS_ENDPOINTS_RESOLVED_ENDPOINT = 0
    AWS_ENDPOINTS_RESOLVED_ERROR = 1
end

"""
    aws_endpoints_get_supported_ruleset_version()

Documentation not found.
### Prototype
```c
struct aws_byte_cursor aws_endpoints_get_supported_ruleset_version(void);
```
"""
function aws_endpoints_get_supported_ruleset_version()
    ccall((:aws_endpoints_get_supported_ruleset_version, libaws_c_sdkutils), aws_byte_cursor, ())
end

"""
    aws_endpoints_parameter_get_type(parameter)

Documentation not found.
### Prototype
```c
enum aws_endpoints_parameter_type aws_endpoints_parameter_get_type( const struct aws_endpoints_parameter *parameter);
```
"""
function aws_endpoints_parameter_get_type(parameter)
    ccall((:aws_endpoints_parameter_get_type, libaws_c_sdkutils), aws_endpoints_parameter_type, (Ptr{aws_endpoints_parameter},), parameter)
end

"""
    aws_endpoints_parameter_get_built_in(parameter)

Documentation not found.
### Prototype
```c
struct aws_byte_cursor aws_endpoints_parameter_get_built_in( const struct aws_endpoints_parameter *parameter);
```
"""
function aws_endpoints_parameter_get_built_in(parameter)
    ccall((:aws_endpoints_parameter_get_built_in, libaws_c_sdkutils), aws_byte_cursor, (Ptr{aws_endpoints_parameter},), parameter)
end

"""
    aws_endpoints_parameter_get_default_string(parameter, out_cursor)

Documentation not found.
### Prototype
```c
int aws_endpoints_parameter_get_default_string( const struct aws_endpoints_parameter *parameter, struct aws_byte_cursor *out_cursor);
```
"""
function aws_endpoints_parameter_get_default_string(parameter, out_cursor)
    ccall((:aws_endpoints_parameter_get_default_string, libaws_c_sdkutils), Cint, (Ptr{aws_endpoints_parameter}, Ptr{aws_byte_cursor}), parameter, out_cursor)
end

"""
    aws_endpoints_parameter_get_default_boolean(parameter, out_bool)

Documentation not found.
### Prototype
```c
int aws_endpoints_parameter_get_default_boolean( const struct aws_endpoints_parameter *parameter, const bool **out_bool);
```
"""
function aws_endpoints_parameter_get_default_boolean(parameter, out_bool)
    ccall((:aws_endpoints_parameter_get_default_boolean, libaws_c_sdkutils), Cint, (Ptr{aws_endpoints_parameter}, Ptr{Ptr{Bool}}), parameter, out_bool)
end

"""
    aws_endpoints_parameter_get_is_required(parameter)

Documentation not found.
### Prototype
```c
bool aws_endpoints_parameter_get_is_required(const struct aws_endpoints_parameter *parameter);
```
"""
function aws_endpoints_parameter_get_is_required(parameter)
    ccall((:aws_endpoints_parameter_get_is_required, libaws_c_sdkutils), Bool, (Ptr{aws_endpoints_parameter},), parameter)
end

"""
    aws_endpoints_parameter_get_documentation(parameter)

Documentation not found.
### Prototype
```c
struct aws_byte_cursor aws_endpoints_parameter_get_documentation( const struct aws_endpoints_parameter *parameter);
```
"""
function aws_endpoints_parameter_get_documentation(parameter)
    ccall((:aws_endpoints_parameter_get_documentation, libaws_c_sdkutils), aws_byte_cursor, (Ptr{aws_endpoints_parameter},), parameter)
end

"""
    aws_endpoints_parameters_get_is_deprecated(parameter)

Documentation not found.
### Prototype
```c
bool aws_endpoints_parameters_get_is_deprecated(const struct aws_endpoints_parameter *parameter);
```
"""
function aws_endpoints_parameters_get_is_deprecated(parameter)
    ccall((:aws_endpoints_parameters_get_is_deprecated, libaws_c_sdkutils), Bool, (Ptr{aws_endpoints_parameter},), parameter)
end

"""
    aws_endpoints_parameter_get_deprecated_message(parameter)

Documentation not found.
### Prototype
```c
struct aws_byte_cursor aws_endpoints_parameter_get_deprecated_message( const struct aws_endpoints_parameter *parameter);
```
"""
function aws_endpoints_parameter_get_deprecated_message(parameter)
    ccall((:aws_endpoints_parameter_get_deprecated_message, libaws_c_sdkutils), aws_byte_cursor, (Ptr{aws_endpoints_parameter},), parameter)
end

"""
    aws_endpoints_parameter_get_deprecated_since(parameter)

Documentation not found.
### Prototype
```c
struct aws_byte_cursor aws_endpoints_parameter_get_deprecated_since( const struct aws_endpoints_parameter *parameter);
```
"""
function aws_endpoints_parameter_get_deprecated_since(parameter)
    ccall((:aws_endpoints_parameter_get_deprecated_since, libaws_c_sdkutils), aws_byte_cursor, (Ptr{aws_endpoints_parameter},), parameter)
end

"""
    aws_endpoints_ruleset_new_from_string(allocator, ruleset_json)

Documentation not found.
### Prototype
```c
struct aws_endpoints_ruleset *aws_endpoints_ruleset_new_from_string( struct aws_allocator *allocator, struct aws_byte_cursor ruleset_json);
```
"""
function aws_endpoints_ruleset_new_from_string(allocator, ruleset_json)
    ccall((:aws_endpoints_ruleset_new_from_string, libaws_c_sdkutils), Ptr{aws_endpoints_ruleset}, (Ptr{aws_allocator}, aws_byte_cursor), allocator, ruleset_json)
end

"""
    aws_endpoints_ruleset_acquire(ruleset)

Documentation not found.
### Prototype
```c
struct aws_endpoints_ruleset *aws_endpoints_ruleset_acquire(struct aws_endpoints_ruleset *ruleset);
```
"""
function aws_endpoints_ruleset_acquire(ruleset)
    ccall((:aws_endpoints_ruleset_acquire, libaws_c_sdkutils), Ptr{aws_endpoints_ruleset}, (Ptr{aws_endpoints_ruleset},), ruleset)
end

"""
    aws_endpoints_ruleset_release(ruleset)

Documentation not found.
### Prototype
```c
struct aws_endpoints_ruleset *aws_endpoints_ruleset_release(struct aws_endpoints_ruleset *ruleset);
```
"""
function aws_endpoints_ruleset_release(ruleset)
    ccall((:aws_endpoints_ruleset_release, libaws_c_sdkutils), Ptr{aws_endpoints_ruleset}, (Ptr{aws_endpoints_ruleset},), ruleset)
end

"""
    aws_endpoints_ruleset_get_parameters(ruleset)

Documentation not found.
### Prototype
```c
const struct aws_hash_table *aws_endpoints_ruleset_get_parameters( struct aws_endpoints_ruleset *ruleset);
```
"""
function aws_endpoints_ruleset_get_parameters(ruleset)
    ccall((:aws_endpoints_ruleset_get_parameters, libaws_c_sdkutils), Ptr{aws_hash_table}, (Ptr{aws_endpoints_ruleset},), ruleset)
end

"""
    aws_endpoints_ruleset_get_version(ruleset)

Documentation not found.
### Prototype
```c
struct aws_byte_cursor aws_endpoints_ruleset_get_version(const struct aws_endpoints_ruleset *ruleset);
```
"""
function aws_endpoints_ruleset_get_version(ruleset)
    ccall((:aws_endpoints_ruleset_get_version, libaws_c_sdkutils), aws_byte_cursor, (Ptr{aws_endpoints_ruleset},), ruleset)
end

"""
    aws_endpoints_ruleset_get_service_id(ruleset)

Documentation not found.
### Prototype
```c
struct aws_byte_cursor aws_endpoints_ruleset_get_service_id( const struct aws_endpoints_ruleset *ruleset);
```
"""
function aws_endpoints_ruleset_get_service_id(ruleset)
    ccall((:aws_endpoints_ruleset_get_service_id, libaws_c_sdkutils), aws_byte_cursor, (Ptr{aws_endpoints_ruleset},), ruleset)
end

"""
    aws_endpoints_rule_engine_new(allocator, ruleset, partitions_config)

Create new rule engine for a given ruleset. In cases of failure NULL is returned and last error is set.

### Prototype
```c
struct aws_endpoints_rule_engine *aws_endpoints_rule_engine_new( struct aws_allocator *allocator, struct aws_endpoints_ruleset *ruleset, struct aws_partitions_config *partitions_config);
```
"""
function aws_endpoints_rule_engine_new(allocator, ruleset, partitions_config)
    ccall((:aws_endpoints_rule_engine_new, libaws_c_sdkutils), Ptr{aws_endpoints_rule_engine}, (Ptr{aws_allocator}, Ptr{aws_endpoints_ruleset}, Ptr{aws_partitions_config}), allocator, ruleset, partitions_config)
end

"""
    aws_endpoints_rule_engine_acquire(rule_engine)

Documentation not found.
### Prototype
```c
struct aws_endpoints_rule_engine *aws_endpoints_rule_engine_acquire( struct aws_endpoints_rule_engine *rule_engine);
```
"""
function aws_endpoints_rule_engine_acquire(rule_engine)
    ccall((:aws_endpoints_rule_engine_acquire, libaws_c_sdkutils), Ptr{aws_endpoints_rule_engine}, (Ptr{aws_endpoints_rule_engine},), rule_engine)
end

"""
    aws_endpoints_rule_engine_release(rule_engine)

Documentation not found.
### Prototype
```c
struct aws_endpoints_rule_engine *aws_endpoints_rule_engine_release( struct aws_endpoints_rule_engine *rule_engine);
```
"""
function aws_endpoints_rule_engine_release(rule_engine)
    ccall((:aws_endpoints_rule_engine_release, libaws_c_sdkutils), Ptr{aws_endpoints_rule_engine}, (Ptr{aws_endpoints_rule_engine},), rule_engine)
end

"""
    aws_endpoints_request_context_new(allocator)

Documentation not found.
### Prototype
```c
struct aws_endpoints_request_context *aws_endpoints_request_context_new( struct aws_allocator *allocator);
```
"""
function aws_endpoints_request_context_new(allocator)
    ccall((:aws_endpoints_request_context_new, libaws_c_sdkutils), Ptr{aws_endpoints_request_context}, (Ptr{aws_allocator},), allocator)
end

"""
    aws_endpoints_request_context_acquire(request_context)

Documentation not found.
### Prototype
```c
struct aws_endpoints_request_context *aws_endpoints_request_context_acquire( struct aws_endpoints_request_context *request_context);
```
"""
function aws_endpoints_request_context_acquire(request_context)
    ccall((:aws_endpoints_request_context_acquire, libaws_c_sdkutils), Ptr{aws_endpoints_request_context}, (Ptr{aws_endpoints_request_context},), request_context)
end

"""
    aws_endpoints_request_context_release(request_context)

Documentation not found.
### Prototype
```c
struct aws_endpoints_request_context *aws_endpoints_request_context_release( struct aws_endpoints_request_context *request_context);
```
"""
function aws_endpoints_request_context_release(request_context)
    ccall((:aws_endpoints_request_context_release, libaws_c_sdkutils), Ptr{aws_endpoints_request_context}, (Ptr{aws_endpoints_request_context},), request_context)
end

"""
    aws_endpoints_request_context_add_string(allocator, context, name, value)

Documentation not found.
### Prototype
```c
int aws_endpoints_request_context_add_string( struct aws_allocator *allocator, struct aws_endpoints_request_context *context, struct aws_byte_cursor name, struct aws_byte_cursor value);
```
"""
function aws_endpoints_request_context_add_string(allocator, context, name, value)
    ccall((:aws_endpoints_request_context_add_string, libaws_c_sdkutils), Cint, (Ptr{aws_allocator}, Ptr{aws_endpoints_request_context}, aws_byte_cursor, aws_byte_cursor), allocator, context, name, value)
end

"""
    aws_endpoints_request_context_add_boolean(allocator, context, name, value)

Documentation not found.
### Prototype
```c
int aws_endpoints_request_context_add_boolean( struct aws_allocator *allocator, struct aws_endpoints_request_context *context, struct aws_byte_cursor name, bool value);
```
"""
function aws_endpoints_request_context_add_boolean(allocator, context, name, value)
    ccall((:aws_endpoints_request_context_add_boolean, libaws_c_sdkutils), Cint, (Ptr{aws_allocator}, Ptr{aws_endpoints_request_context}, aws_byte_cursor, Bool), allocator, context, name, value)
end

"""
    aws_endpoints_rule_engine_resolve(engine, context, out_resolved_endpoint)

Documentation not found.
### Prototype
```c
int aws_endpoints_rule_engine_resolve( struct aws_endpoints_rule_engine *engine, const struct aws_endpoints_request_context *context, struct aws_endpoints_resolved_endpoint **out_resolved_endpoint);
```
"""
function aws_endpoints_rule_engine_resolve(engine, context, out_resolved_endpoint)
    ccall((:aws_endpoints_rule_engine_resolve, libaws_c_sdkutils), Cint, (Ptr{aws_endpoints_rule_engine}, Ptr{aws_endpoints_request_context}, Ptr{Ptr{aws_endpoints_resolved_endpoint}}), engine, context, out_resolved_endpoint)
end

"""
    aws_endpoints_resolved_endpoint_acquire(resolved_endpoint)

Documentation not found.
### Prototype
```c
struct aws_endpoints_resolved_endpoint *aws_endpoints_resolved_endpoint_acquire( struct aws_endpoints_resolved_endpoint *resolved_endpoint);
```
"""
function aws_endpoints_resolved_endpoint_acquire(resolved_endpoint)
    ccall((:aws_endpoints_resolved_endpoint_acquire, libaws_c_sdkutils), Ptr{aws_endpoints_resolved_endpoint}, (Ptr{aws_endpoints_resolved_endpoint},), resolved_endpoint)
end

"""
    aws_endpoints_resolved_endpoint_release(resolved_endpoint)

Documentation not found.
### Prototype
```c
struct aws_endpoints_resolved_endpoint *aws_endpoints_resolved_endpoint_release( struct aws_endpoints_resolved_endpoint *resolved_endpoint);
```
"""
function aws_endpoints_resolved_endpoint_release(resolved_endpoint)
    ccall((:aws_endpoints_resolved_endpoint_release, libaws_c_sdkutils), Ptr{aws_endpoints_resolved_endpoint}, (Ptr{aws_endpoints_resolved_endpoint},), resolved_endpoint)
end

"""
    aws_endpoints_resolved_endpoint_get_type(resolved_endpoint)

Documentation not found.
### Prototype
```c
enum aws_endpoints_resolved_endpoint_type aws_endpoints_resolved_endpoint_get_type( const struct aws_endpoints_resolved_endpoint *resolved_endpoint);
```
"""
function aws_endpoints_resolved_endpoint_get_type(resolved_endpoint)
    ccall((:aws_endpoints_resolved_endpoint_get_type, libaws_c_sdkutils), aws_endpoints_resolved_endpoint_type, (Ptr{aws_endpoints_resolved_endpoint},), resolved_endpoint)
end

"""
    aws_endpoints_resolved_endpoint_get_url(resolved_endpoint, out_url)

Documentation not found.
### Prototype
```c
int aws_endpoints_resolved_endpoint_get_url( const struct aws_endpoints_resolved_endpoint *resolved_endpoint, struct aws_byte_cursor *out_url);
```
"""
function aws_endpoints_resolved_endpoint_get_url(resolved_endpoint, out_url)
    ccall((:aws_endpoints_resolved_endpoint_get_url, libaws_c_sdkutils), Cint, (Ptr{aws_endpoints_resolved_endpoint}, Ptr{aws_byte_cursor}), resolved_endpoint, out_url)
end

"""
    aws_endpoints_resolved_endpoint_get_properties(resolved_endpoint, out_properties)

Documentation not found.
### Prototype
```c
int aws_endpoints_resolved_endpoint_get_properties( const struct aws_endpoints_resolved_endpoint *resolved_endpoint, struct aws_byte_cursor *out_properties);
```
"""
function aws_endpoints_resolved_endpoint_get_properties(resolved_endpoint, out_properties)
    ccall((:aws_endpoints_resolved_endpoint_get_properties, libaws_c_sdkutils), Cint, (Ptr{aws_endpoints_resolved_endpoint}, Ptr{aws_byte_cursor}), resolved_endpoint, out_properties)
end

"""
    aws_endpoints_resolved_endpoint_get_headers(resolved_endpoint, out_headers)

Documentation not found.
### Prototype
```c
int aws_endpoints_resolved_endpoint_get_headers( const struct aws_endpoints_resolved_endpoint *resolved_endpoint, const struct aws_hash_table **out_headers);
```
"""
function aws_endpoints_resolved_endpoint_get_headers(resolved_endpoint, out_headers)
    ccall((:aws_endpoints_resolved_endpoint_get_headers, libaws_c_sdkutils), Cint, (Ptr{aws_endpoints_resolved_endpoint}, Ptr{Ptr{aws_hash_table}}), resolved_endpoint, out_headers)
end

"""
    aws_endpoints_resolved_endpoint_get_error(resolved_endpoint, out_error)

Documentation not found.
### Prototype
```c
int aws_endpoints_resolved_endpoint_get_error( const struct aws_endpoints_resolved_endpoint *resolved_endpoint, struct aws_byte_cursor *out_error);
```
"""
function aws_endpoints_resolved_endpoint_get_error(resolved_endpoint, out_error)
    ccall((:aws_endpoints_resolved_endpoint_get_error, libaws_c_sdkutils), Cint, (Ptr{aws_endpoints_resolved_endpoint}, Ptr{aws_byte_cursor}), resolved_endpoint, out_error)
end

"""
    aws_partitions_get_supported_version()

Documentation not found.
### Prototype
```c
struct aws_byte_cursor aws_partitions_get_supported_version(void);
```
"""
function aws_partitions_get_supported_version()
    ccall((:aws_partitions_get_supported_version, libaws_c_sdkutils), aws_byte_cursor, ())
end

"""
    aws_partitions_config_new_from_string(allocator, json)

Documentation not found.
### Prototype
```c
struct aws_partitions_config *aws_partitions_config_new_from_string( struct aws_allocator *allocator, struct aws_byte_cursor json);
```
"""
function aws_partitions_config_new_from_string(allocator, json)
    ccall((:aws_partitions_config_new_from_string, libaws_c_sdkutils), Ptr{aws_partitions_config}, (Ptr{aws_allocator}, aws_byte_cursor), allocator, json)
end

"""
    aws_partitions_config_acquire(partitions)

Documentation not found.
### Prototype
```c
struct aws_partitions_config *aws_partitions_config_acquire(struct aws_partitions_config *partitions);
```
"""
function aws_partitions_config_acquire(partitions)
    ccall((:aws_partitions_config_acquire, libaws_c_sdkutils), Ptr{aws_partitions_config}, (Ptr{aws_partitions_config},), partitions)
end

"""
    aws_partitions_config_release(partitions)

Documentation not found.
### Prototype
```c
struct aws_partitions_config *aws_partitions_config_release(struct aws_partitions_config *partitions);
```
"""
function aws_partitions_config_release(partitions)
    ccall((:aws_partitions_config_release, libaws_c_sdkutils), Ptr{aws_partitions_config}, (Ptr{aws_partitions_config},), partitions)
end

"""
    aws_resource_name

Documentation not found.
"""
struct aws_resource_name
    partition::aws_byte_cursor
    service::aws_byte_cursor
    region::aws_byte_cursor
    account_id::aws_byte_cursor
    resource_id::aws_byte_cursor
end

"""
    aws_resource_name_init_from_cur(arn, input)

Given an ARN "Amazon Resource Name" represented as an in memory a structure representing the parts

### Prototype
```c
int aws_resource_name_init_from_cur(struct aws_resource_name *arn, const struct aws_byte_cursor *input);
```
"""
function aws_resource_name_init_from_cur(arn, input)
    ccall((:aws_resource_name_init_from_cur, libaws_c_sdkutils), Cint, (Ptr{aws_resource_name}, Ptr{aws_byte_cursor}), arn, input)
end

"""
    aws_resource_name_length(arn, size)

Calculates the space needed to write an ARN to a byte buf

### Prototype
```c
int aws_resource_name_length(const struct aws_resource_name *arn, size_t *size);
```
"""
function aws_resource_name_length(arn, size)
    ccall((:aws_resource_name_length, libaws_c_sdkutils), Cint, (Ptr{aws_resource_name}, Ptr{Csize_t}), arn, size)
end

"""
    aws_byte_buf_append_resource_name(buf, arn)

Serializes an ARN structure into the lexical string format

### Prototype
```c
int aws_byte_buf_append_resource_name(struct aws_byte_buf *buf, const struct aws_resource_name *arn);
```
"""
function aws_byte_buf_append_resource_name(buf, arn)
    ccall((:aws_byte_buf_append_resource_name, libaws_c_sdkutils), Cint, (Ptr{aws_byte_buf}, Ptr{aws_resource_name}), buf, arn)
end

"""
    aws_sdkutils_errors

Documentation not found.
"""
@cenum aws_sdkutils_errors::UInt32 begin
    AWS_ERROR_SDKUTILS_GENERAL = 15360
    AWS_ERROR_SDKUTILS_PARSE_FATAL = 15361
    AWS_ERROR_SDKUTILS_PARSE_RECOVERABLE = 15362
    AWS_ERROR_SDKUTILS_ENDPOINTS_UNSUPPORTED_RULESET = 15363
    AWS_ERROR_SDKUTILS_ENDPOINTS_PARSE_FAILED = 15364
    AWS_ERROR_SDKUTILS_ENDPOINTS_RESOLVE_INIT_FAILED = 15365
    AWS_ERROR_SDKUTILS_ENDPOINTS_RESOLVE_FAILED = 15366
    AWS_ERROR_SDKUTILS_ENDPOINTS_EMPTY_RULESET = 15367
    AWS_ERROR_SDKUTILS_ENDPOINTS_RULESET_EXHAUSTED = 15368
    AWS_ERROR_SDKUTILS_PARTITIONS_UNSUPPORTED = 15369
    AWS_ERROR_SDKUTILS_PARTITIONS_PARSE_FAILED = 15370
    AWS_ERROR_SDKUTILS_END_RANGE = 16383
end

"""
    aws_sdkutils_log_subject

Documentation not found.
"""
@cenum aws_sdkutils_log_subject::UInt32 begin
    AWS_LS_SDKUTILS_GENERAL = 15360
    AWS_LS_SDKUTILS_PROFILE = 15361
    AWS_LS_SDKUTILS_ENDPOINTS_PARSING = 15362
    AWS_LS_SDKUTILS_ENDPOINTS_RESOLVE = 15363
    AWS_LS_SDKUTILS_ENDPOINTS_GENERAL = 15364
    AWS_LS_SDKUTILS_PARTITIONS_PARSING = 15365
    AWS_LS_SDKUTILS_LAST = 16383
end

"""
    aws_sdkutils_library_init(allocator)

Documentation not found.
### Prototype
```c
void aws_sdkutils_library_init(struct aws_allocator *allocator);
```
"""
function aws_sdkutils_library_init(allocator)
    ccall((:aws_sdkutils_library_init, libaws_c_sdkutils), Cvoid, (Ptr{aws_allocator},), allocator)
end

"""
    aws_sdkutils_library_clean_up()

Documentation not found.
### Prototype
```c
void aws_sdkutils_library_clean_up(void);
```
"""
function aws_sdkutils_library_clean_up()
    ccall((:aws_sdkutils_library_clean_up, libaws_c_sdkutils), Cvoid, ())
end

"""
Documentation not found.
"""
const AWS_C_SDKUTILS_PACKAGE_ID = 15

