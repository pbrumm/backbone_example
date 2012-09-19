(function(){
  String.prototype.titleize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
  }      
  String.prototype.toCamel = function(){
    return this.replace(/(\-[a-z])/g, function($1){return $1.toUpperCase().replace('-','');}).titleize();
  }
  String.prototype.toUnderscore = function(){
    return this.replace(/([A-Z])/g, function($1){return "_"+$1.toLowerCase();});
  }
}).call(this); 