{% docs overview %}
## Overview
I am an analytics engineer at a rental property management company. Several new data sources have just become available from the source system and business analysts are eager to start using this data to make business decisions.

The data sources for this assessment include rental property listings, reviews, a calendar, and an amenity changelog.

{% enddocs %}

## Source Field Descriptions

#### amenities_changelog
* {% docs amenities_amenities %}Array of the amenities available as of the change.{% enddocs %}
* {% docs amenities_change_at %}When the amenities list changed.{% enddocs %}
* {% docs amenities_listing_id %}Unique ID for the listing to this which this rowapplies.{% enddocs %}

#### calendar
* {% docs calendar_available %}Contains ‘t’ if this property is available on this date. Contains ‘f’ if not.{% enddocs %}
* {% docs calendar_date %}Date of availability this row describes.{% enddocs %}
* {% docs calendar_listing_id %}Unique ID for the listing to this which this row applies.{% enddocs %}
* {% docs calendar_maximum_nights %}The maximum number of nights that may be booked consecutively for this property{% enddocs %}
* {% docs calendar_minimum_nights %}The minimum number of nights that must be booked consecutively for this property.{% enddocs %}
* {% docs calendar_price %}The USD price to rent this property on DATE{% enddocs %}
* {% docs calendar_reservation_id %}Unique ID for that DATE’s reservation. Foreign key. If NULL, there was no reservation on that date.{% enddocs %}

#### generated_reviews
* {% docs reviews_id %}Auto-incrementing ID for the dummy reviews data.{% enddocs %}
* {% docs reviews_listing_id %}Unique ID for the listing to this which this row applies.{% enddocs %}
* {% docs reviews_review_date %}Generated score of the review, integer 1 to 5.{% enddocs %}
* {% docs reviews_review_score %}Generated date of the review.{% enddocs %}

#### listings
* {% docs listings_id %}Unique ID for this listing. Primary Key.{% enddocs %}
* {% docs listings_name %}Display name of listing.{% enddocs %}
* {% docs listings_host_id %}Unique ID for the Host who owns this property.{% enddocs %}
* {% docs listings_host_name %}Display name of Host.{% enddocs %}
* {% docs listings_host_since %}When the Host signed up.{% enddocs %}
* {% docs listings_host_location %}Where the Host is based.{% enddocs %}
* {% docs listings_amenities %}(Parseable as JSON) Array of amenities available for guests.{% enddocs %}
* {% docs listings_price %}The price of this listing as of the start of the date range in CALENDAR.{% enddocs %}
* {% docs listings_number_of_reviews %}The number of reviews this listing has ever received.{% enddocs %}
* {% docs listings_first_review %}The date of the first review this listing received.{% enddocs %}
* {% docs listings_last_review %}The date of the most recent review this listing received.{% enddocs %}
* {% docs listings_review_scores_rating %}The average review score of this listing.{% enddocs %}
* {% docs listings_host_verifications %}(Parseable as JSON) Array of methods the Host can use to{% enddocs %}
* {% docs listings_neighborhood %}The neighborhood where this listing is located.{% enddocs %}
* {% docs listings_property_type %}Description of the type of property.{% enddocs %}
* {% docs listings_room_type %}Description of the type of room.{% enddocs %}
* {% docs listings_accommodates %}Number of guests this room can accommodate.{% enddocs %}
* {% docs listings_bathrooms_text %}Number and types of bathrooms available.{% enddocs %}
* {% docs listings_bedrooms %}Number of bedrooms available for use.{% enddocs %}
* {% docs listings_beds %}Number of beds available for use.{% enddocs %}