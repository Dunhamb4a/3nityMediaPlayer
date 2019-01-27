unit VssThisAppVersion;

interface
uses VssAppVersion, SysUtils;
var
  AppVersion : TVssAppVersion;

implementation

initialization
  AppVersion := nil;
finalization
  if AppVersion <> nil then
    FreeAndNil(AppVersion);
end.
