var _user$project$Native_Hacks = (function() {
  function tryCatch(fun, string) {
    try {
      return { ctor: 'Ok', _0: fun(string) };
    } catch (e) {
      console.error(e);
      return { ctor: 'Err', _0: e.toString() };
    }
  }

  return {
    tryCatch: F2(tryCatch)
  };
})();
