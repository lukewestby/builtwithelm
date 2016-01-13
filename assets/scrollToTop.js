window.installScrollToTop = function installScrollToTop(app) {
  var currentOffset = null;
  app.ports.currentOffset.subscribe(function (nextOffset) {
    if(currentOffset !== nextOffset) {
      currentOffset = nextOffset;
      window.scrollTo(0, 0);
    }
  });
};
