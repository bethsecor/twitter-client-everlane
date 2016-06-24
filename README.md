### Beth Secor's Twitter Client Project

#### Notes

- Tested with RSpec
- Twitter API calls recorded with VCR cassettes
- OAuth using `omniauth-twitter` gem
- No gem used for authorizing a request for friends list, see `TwitterService`

#### Issues/Improvements For the Future

- Some banner images do not load, need to figure out how to skip loading those.
- Use Webmock and a Sinatra app to mock Twitter API calls for testing.
- More tests! Service tests!
- Refactor `TwitterService` to generalize creation of Authorization header for calls to other endpoints.
