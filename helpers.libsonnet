{
  strToList(file):: std.trace(file, std.split(file, '\n')),
  filterOutEmpty(coldCallers):: std.filter(function(x) std.length(x) > 0, coldCallers),
  wrapWithFrom(arr):: std.trace(std.toString(arr), std.map(function(x) ({ from: x }), arr)),
  wrapWithReplyTo(arr):: std.trace(std.toString(arr), std.map(function(x) ({ replyTo: x }), arr)),
  fromArray(file):: self.wrapWithFrom(self.filterOutEmpty(self.strToList(file))),
  replyToArray(file):: self.wrapWithReplyTo(self.filterOutEmpty(self.strToList(file))),
}
