# quickcheck 0.1.0

## Major breaking changes

- The default length for vector generators has been changed from 1 to a range
between 1 and 10.
- All parameters of the form `frac_` have been replaced with `any_`, which take
a logical value instead of a double value.

## Features

- New `character_letters` generates character vectors with only letters.
- New `character_numbers` generates character vectors with only numbers.
- New `character_alphanumeric` generates character vectors with letters and numbers.
- New `flat_list_of` generates lists of atomic scalars.
- New `data_frame_` generate data.frames.
- New `data_frame_of` generate data.frames.
- New `data.table_` generate data.tables.
- New `data.table_of` generate data.tables.
- New `anything` generates any R object.
- New `any_flat_homogeneous_list` generates flat lists with homogeneous elements.
- New `any_data_frame` generates any data.frames.
- New `any_data.table` generates any data.tables.
- New `any_undefined` generates undefined values.
- New `equal_length` generates equal length vectors.
- New `from_hedgehog` converts a hedgehog to a quickcheck generator.
- New `as_hedgehog` converts a quickcheck to a hedgehog generator.
- New `repeat_test` tests a property repeatedly.

# quickcheck 0.0.1

Initial version
