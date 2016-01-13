window.installScrollToTop = function installScrollToTop(app) {
  var currentOffset = null;
  app.ports.currentOffset.subscribe(function (nextOffset) {
    if(currentOffset !== nextOffset) {
      currentOffset = nextOffset;
      setTimeout(function () {
        window.scrollTo(0, 0);
      }, 10);
    }
  });
};
